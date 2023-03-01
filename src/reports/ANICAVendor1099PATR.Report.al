Report 50189 "ANICA Vendor 1099 PATR"
{
    // Based on report 10119 1099 DIV
    //   This requires a lot of layout work to change from 2 to 3 items per page and line up with the IRS forms.
    //   Use .4 cm for line height and be sure to change the VendorNo variable to '3' to get 3 forms per page.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ANICA Vendor 1099 PATR.rdlc';

    Caption = 'ANICA Vendor 1099 PATR';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Vendor Filter';
            column(ReportForNavId_3182; 3182)
            {
            }
            column(Void;Void)
            {
            }
            column(CompanyAddress1;CompanyAddress[1])
            {
            }
            column(CompanyAddress2;CompanyAddress[2])
            {
            }
            column(GetAmtPATR01;GetAmt('PATR-01'))
            {
            }
            column(CompanyAddress3;CompanyAddress[3])
            {
            }
            column(CompanyAddress4;CompanyAddress[4])
            {
            }
            column(CompanyAddress5;CompanyAddress[5])
            {
            }
            column(CompanyInfoFederalIDNo;CompanyInfo."Federal ID No.")
            {
            }
            column(FederalIDNo_Vendor;"Federal ID No.")
            {
            }
            column(Name_Vendor;Name)
            {
            }
            column(Name2_Vendor;"Name 2")
            {
            }
            column(Address_Vendor;Address)
            {
            }
            column(Address2_Vendor;"Address 2")
            {
            }
            column(Address3_Vendor;"Address 3")
            {
            }
            column(No_Vendor;"No.")
            {
            }
            column(PageGroupNo;PageGroupNo)
            {
            }
            column(AddressLine2;AddressLine2)
            {
            }
            column(AddressLine3;AddressLine3)
            {
            }
            dataitem("Integer";"Integer")
            {
                DataItemTableView = sorting(Number);
                MaxIteration = 1;
                column(ReportForNavId_5444; 5444)
                {
                }
                column(FormCounter;FormCounter)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    FormCounter := FormCounter + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(Amounts);
                Clear(Void);
                /* Special handling for Test Printing */
                if TestPrint then begin
                  if FirstVendor then begin
                    Name := PadStr('x',MaxStrLen(Name),'X');
                    Address := PadStr('x',MaxStrLen(Address),'X');
                    "Address 3" := PadStr('x',MaxStrLen("Address 3"),'X');
                    Void := 'X';
                    "No." := PadStr('x',MaxStrLen("No."),'X');
                    "Federal ID No." := PadStr('x',MaxStrLen("Federal ID No."),'X');
                  end else
                    CurrReport.Break;  /* The End */
                end else begin   /* not Test Printing */
                  PrintThis := false;
                  /* Check through all payments during calendar year */
                  PaymentEntry.SetCurrentkey("Document Type","Vendor No.","Posting Date");
                  PaymentEntry.SetRange("Document Type",1); /*Payment*/
                  PaymentEntry.SetRange("Vendor No.","No.");
                  PaymentEntry.SetRange("Posting Date",PeriodDate[1],PeriodDate[2]);
                  if PaymentEntry.Find('-') then
                    repeat
                      ProcessInvoices(PaymentEntry);
                    until PaymentEntry.Next = 0;
                
                  /* any printable amounts on this form? */
                  for i := 1 to LastLineNo do
                    if FormBox.Get(Codes[i]) then
                      if FormBox."Minimum Reportable" < 0.0 then begin
                        if Amounts[i] <> 0.0 then begin
                          Amounts[i] := -Amounts[i];
                          PrintThis := true;
                        end;
                      end else begin   /* ie Minimum Reportable >= 0.0 */
                        if Amounts[i] >= FormBox."Minimum Reportable" then
                          if Amounts[i] <> 0.0 then
                            PrintThis := true;
                      end;
                  /* special handling for 1099-DIV only */
                  // IF FormBox.GET(Codes[11]) THEN BEGIN
                  // IF Amounts[11] + Amounts[10] >= FormBox."Minimum Reportable" THEN
                  // PrintThis := TRUE;
                  // END;
                
                  if not PrintThis then
                    CurrReport.Skip;
                
                  /* Format City/State/ZIP address line */
                  if StrLen(City + ', ' + County + '  ' + "Post Code") > MaxStrLen("Address 3") then
                    "Address 3" := City
                  else
                    if (City <> '') and (County <> '') then
                      "Address 3" := City + ', ' + County + '  ' + "Post Code"
                    else
                      "Address 3" := DelChr(City + ' ' + County + ' ' + "Post Code",'<>');
                
                    //CS 01-09-19: Adding this section so that the address lays out right on the 1099 when there is an Address2.
                    if "Address 2" = '' then
                        begin
                            AddressLine2 := '';
                            AddressLine3 := Address;
                        end
                    else
                        begin
                            AddressLine2 := Address;
                            AddressLine3 := "Address 2";
                        end;
                
                end;
                
                //ANICA Change VendorNo = 3 below to print 3 forms per page (very important)
                if VendorNo = 3 then begin
                  PageGroupNo += 1;
                  VendorNo := 0;
                end;
                VendorNo += 1;

            end;

            trigger OnPreDataItem()
            begin
                VendorNo := 0;
                PageGroupNo := 0;
                
                /* Create date range which covers the entire calendar year */
                PeriodDate[1] := Dmy2date(1,1,Year);
                PeriodDate[2] := Dmy2date(31,12,Year);
                
                /* Fill in the Codes used on this particular 1099 form */
                Clear(Codes);
                Clear(LastLineNo);
                
                //ANICA Change DIV-01 etc. to PATR-
                //Renumber codes to 1 through 9
                Codes[1] := 'PATR-01';
                Codes[2] := 'PATR-02';
                Codes[3] := 'PATR-03';
                Codes[4] := 'PATR-04';
                Codes[5] := 'PATR-05';
                Codes[6] := 'PATR-06';
                Codes[7] := 'PATR-07';
                Codes[8] := 'PATR-08';
                Codes[9] := 'PATR-09';
                
                //ANICA change last lineno to 9
                LastLineNo := 9;
                
                /* Initialize Company Address. As side effect, will read CompanyInfo record */
                FormatCompanyAddress(CompanyAddress,CompanyInfo,TestPrint);
                /* Initialize flag used for Test Printing only*/
                FirstVendor := true;

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Year;Year)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Calendar Year';

                        trigger OnValidate()
                        begin
                            if (Year < 1980) or (Year > 2060) then
                              Error('You must enter a valid year, eg 1993');
                        end;
                    }
                    field(TestPrint;TestPrint)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Test Print';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            TestPrint := false;   /*always default to false*/
            //ANICA added -1 for prior year
            Year := Date2dmy(WorkDate,3)-1;   /*default to current working year*/

        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        /*
         Programmers Note:
            You can add an option on the Request Panel called TestPrint, which
            is fully implemented in the code.  If you add this boolean to the
            Request Panel, you may also want to add the following to the report
            description, under Options:
        
         Test Print...: Enter Yes to print a pattern of X's which you can use
                        to align the form on the printer. Enter No to print the
                        actual Forms 1099.
        */

    end;

    var
        CompanyInfo: Record "Company Information";
        FormBox: Record "IRS 1099 Form-Box";
        TempAppliedEntry: Record "Vendor Ledger Entry" temporary;
        EntryAppMgt: Codeunit "Entry Application Management";
        PeriodDate: array [2] of Date;
        Year: Integer;
        TestPrint: Boolean;
        Void: Code[1];
        CompanyAddress: array [5] of Text[50];
        FirstVendor: Boolean;
        PrintThis: Boolean;
        "Address 3": Text[30];
        PaymentEntry: Record "Vendor Ledger Entry";
        Codes: array [20] of Code[10];
        Amounts: array [20] of Decimal;
        LastLineNo: Integer;
        Invoice1099Amount: Decimal;
        i: Integer;
        FormCounter: Integer;
        VendorNo: Integer;
        PageGroupNo: Integer;
        AddressLine2: Text[60];
        AddressLine3: Text[60];


    procedure ProcessInvoices(PaymentEntry: Record "Vendor Ledger Entry")
    begin
        /* search for invoices paid off by this payment */
        EntryAppMgt.GetAppliedVendEntries(TempAppliedEntry,PaymentEntry,true);
        with TempAppliedEntry do begin
          /* search for invoices with 1099 amounts */
          SetFilter("Document Type",'%1|%2',"document type"::Invoice,"document type"::"Credit Memo");
          SetFilter("IRS 1099 Amount",'<>0');
          //ANICA change code from DIV- to PATR-
          SetRange("IRS 1099 Code",'PATR-','PATR-99');
          if Find('-') then
            repeat
              Calculate1099Amount(TempAppliedEntry,PaymentEntry,"Amount to Apply");
            until Next = 0;
        end;

    end;


    procedure Calculate1099Amount(InvoiceEntry: Record "Vendor Ledger Entry";PaymentEntry: Record "Vendor Ledger Entry";AppliedAmount: Decimal)
    begin
        InvoiceEntry.CalcFields(Amount);
        Invoice1099Amount := -AppliedAmount * InvoiceEntry."IRS 1099 Amount" / InvoiceEntry.Amount;
        UpdateLines(InvoiceEntry."IRS 1099 Code",Invoice1099Amount);
    end;


    procedure UpdateLines("Code": Code[10];Amount: Decimal): Integer
    begin
        i := 1;
        while (Codes[i] <> Code) and (i <= LastLineNo) do
          i := i + 1;
        
        if (Codes[i] = Code) and (i <= LastLineNo) then
          Amounts[i] := Amounts[i] + Amount
        else
          Error('Invoice %1 on vendor %2 has unknown 1099 dividend code  %3',
            TempAppliedEntry."Entry No.",TempAppliedEntry."Vendor No.",Code);
        exit(i);   /*returns code index found*/

    end;


    procedure GetAmt("Code": Code[10]): Decimal
    begin
        if TestPrint then
          exit(9999999.99); /*test value*/
        
        i := 1;
        while (Codes[i] <> Code) and (i <= LastLineNo) do
          i := i + 1;
        
        if (Codes[i] = Code) and (i <= LastLineNo) then
          exit(Amounts[i]);
        
        Error('Dividend code %1 has not been setup in the initialization',Code);

    end;


    procedure FormatCompanyAddress(var CompanyAddress: array [5] of Text[50];var CompanyInfo: Record "Company Information";TestPrint: Boolean)
    begin
        with CompanyInfo do
          if TestPrint then begin
            for i := 1 to ArrayLen(CompanyAddress) do
              CompanyAddress[i] := PadStr('x',MaxStrLen(CompanyAddress[i]),'X');
          end else begin
            Get;

            Clear(CompanyAddress);
            CompanyAddress[1] := UpperCase(Name);
            CompanyAddress[2] := UpperCase(Address);
            CompanyAddress[3] := UpperCase("Address 2");
            if StrLen(City + ', ' + County + '  ' + "Post Code") > MaxStrLen(CompanyAddress[4]) then begin
              CompanyAddress[4] := UpperCase(City);
              CompanyAddress[5] := UpperCase(County) + '  ' + "Post Code";
              if CompressArray(CompanyAddress) = ArrayLen(CompanyAddress) then begin
                CompanyAddress[3] := CompanyAddress[4];  // lose address 2 to add phone no.
                CompanyAddress[4] := CompanyAddress[5];
              end;
              CompanyAddress[5] := "Phone No.";
            end else
              if (City <> '') and (County <> '') then begin
                CompanyAddress[4] := UpperCase(City) + ', ' + UpperCase(County) + '  ' + "Post Code";
                CompanyAddress[5] := "Phone No.";
              end else begin
                CompanyAddress[4] := DelChr(City + ' ' + County + ' ' + "Post Code",'<>');
                CompanyAddress[5] := "Phone No.";
              end;
            CompressArray(CompanyAddress);
          end;
    end;
}

