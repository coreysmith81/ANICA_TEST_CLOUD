Report 50044 "ANICA Vendor 1099 NEC"
{
    // Based on Report 10112 1099 MISC
    // Only layout changes were to change the left margin to .6 inches and the section height to 13.9CM
    // 
    // ANICA 1-13-16 LCC Removed reference to vendor field FATCA, not in our vendor file
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ANICA Vendor 1099 NEC.rdlc';

    Caption = 'ANICA Vendor 1099 NEC';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Vendor Filter';
            column(ReportForNavId_34; 34)
            {
            }
            column(VoidBox;VoidBox)
            {
            }
            column(CompanyAddress1;CompanyAddress[1])
            {
            }
            column(GetAmtNEC01;GetAmt('NEC-01'))
            {
            }
            column(CompanyAddress2;CompanyAddress[2])
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
            column(FATCA;FATCA)
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
            column(Box9;Box9)
            {
            }
            column(Address3_Vendor;"Address 3")
            {
            }
            column(No_Vendor;"No.")
            {
            }
            column(Address2_Vendor;"Address 2")
            {
            }
            column(PageGroupNo;PageGroupNo)
            {
            }
            column(Year;Year)
            {
            }
            dataitem("Integer";"Integer")
            {
                DataItemTableView = sorting(Number);
                MaxIteration = 1;
                column(ReportForNavId_32; 32)
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
            var
                CodeIndex: Integer;
            begin
                Clear(Amounts);
                Clear(VoidBox);
                Clear(Box9);
                Clear(FATCA);

                // Special handling for Test Printing
                if TestPrint then begin
                  if FirstVendor then begin
                    Name := PadStr('x',MaxStrLen(Name),'X');
                    Address := PadStr('x',MaxStrLen(Address),'X');
                    "Address 3" := PadStr('x',MaxStrLen("Address 3"),'X');
                    VoidBox := 'X';
                    Box9 := 'X';
                    FATCA := 'X';
                    "No." := PadStr('x',MaxStrLen("No."),'X');
                    "Federal ID No." := PadStr('x',MaxStrLen("Federal ID No."),'X');
                  end else
                    CurrReport.Break;  // The End
                end else begin   // not Test Printing
                  PrintThis := false;
                  // Check through all payments during calendar year
                  ProcessVendorInvoices("No.",PeriodDate);

                  // any printable amounts on this form?
                  for i := 1 to LastLineNo do
                    if FormBox.Get(Codes[i]) then begin
                      if FormBox."Minimum Reportable" < 0.0 then
                        if Amounts[i] <> 0.0 then begin
                          Amounts[i] := -Amounts[i];
                          PrintThis := true;
                        end;
                      if FormBox."Minimum Reportable" >= 0.0 then
                        if Amounts[i] <> 0.0 then
                          if Amounts[i] >= FormBox."Minimum Reportable" then
                            PrintThis := true;
                    end;
                  if not PrintThis then
                    CurrReport.Skip;

                  // Format City/State/ZIP address line
                  if StrLen(City + ', ' + County + '  ' + "Post Code") > MaxStrLen("Address 3") then
                    "Address 3" := City
                  else
                    if (City <> '') and (County <> '') then
                      "Address 3" := City + ', ' + County + '  ' + "Post Code"
                    else
                      "Address 3" := DelChr(City + ' ' + County + ' ' + "Post Code",'<>');

                  // following is special case for 1099-MISC only
                  //Line9 := UpdateLines('MISC-09',0.0);
                  //IF FormBox.GET(Codes[Line9]) THEN
                  //  IF Amounts[Line9] >= FormBox."Minimum Reportable" THEN
                  //    Box9 := 'X';

                  //ANICA LCC 1-13-16 we do not have this field on the vendor file
                  //IF "FATCA filing requirement" THEN BEGIN
                  //  FATCA := 'X';
                  //  CodeIndex := UpdateLines('MISC-03',0.0);
                  //  Amounts[CodeIndex] := 0;
                  //END;
                  //>>ANICA
                end;

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

                // Create date range which covers the entire calendar year
                PeriodDate[1] := Dmy2date(1,1,Year);
                PeriodDate[2] := Dmy2date(31,12,Year);

                // Fill in the Codes used on this particular 1099 form
                Clear(Codes);
                Clear(LastLineNo);
                Codes[1] := 'NEC-01';
                LastLineNo := 1;

                // Initialize Company Address. As side effect, will read CompanyInfo record
                FormatCompanyAddress;
                // Initialize flag used for Test Printing only
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
                              Error('You must enter a valid year, eg 1998');
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
            //ANICA added -1 for the prior year
            Year := Date2dmy(WorkDate,3)-1;   /*default to current working year*/

        end;
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        FormBox: Record "IRS 1099 Form-Box";
        TempAppliedEntry: Record "Vendor Ledger Entry" temporary;
        EntryAppMgt: Codeunit "Entry Application Management";
        PeriodDate: array [2] of Date;
        Year: Integer;
        TestPrint: Boolean;
        VoidBox: Code[1];
        FATCA: Code[1];
        Box9: Code[1];
        CompanyAddress: array [5] of Text[50];
        FirstVendor: Boolean;
        PrintThis: Boolean;
        "Address 3": Text[30];
        Codes: array [20] of Code[10];
        Amounts: array [20] of Decimal;
        LastLineNo: Integer;
        Invoice1099Amount: Decimal;
        i: Integer;
        Line9: Integer;
        FormCounter: Integer;
        IRS1099Div: Report "Vendor 1099 Div";
        PageGroupNo: Integer;
        VendorNo: Integer;


    procedure ProcessVendorInvoices(VendorNo: Code[20];PeriodDate: array [2] of Date)
    begin
        // search for invoices paid off by this payment
        EntryAppMgt.GetAppliedVendorEntries(TempAppliedEntry,VendorNo,PeriodDate,true);
        with TempAppliedEntry do begin
          // search for invoices with 1099 amounts
          SetFilter("Document Type",'%1|%2',"document type"::Invoice,"document type"::"Credit Memo");
          SetFilter("IRS 1099 Amount",'<>0');
          SetRange("IRS 1099 Code",'NEC-01');
          if FindSet then
            repeat
              Calculate1099Amount(TempAppliedEntry,"Amount to Apply");
            until Next = 0;
        end;
    end;


    procedure Calculate1099Amount(InvoiceEntry: Record "Vendor Ledger Entry";AppliedAmount: Decimal)
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
          Error('Invoice %1 on vendor %2 has unknown 1099 miscellaneous code  %3',
            TempAppliedEntry."Entry No.",TempAppliedEntry."Vendor No.",Code);
        exit(i);   // returns code index found
    end;


    procedure GetAmt("Code": Code[10]): Decimal
    begin
        if TestPrint then
          exit(9999999.99); // test value

        i := 1;
        while (Codes[i] <> Code) and (i <= LastLineNo) do
          i := i + 1;

        if (Codes[i] = Code) and (i <= LastLineNo) then
          exit(Amounts[i]);

        Error('Misc. code %1 has not been setup in the initialization',Code);
    end;


    procedure FormatCompanyAddress()
    begin
        IRS1099Div.FormatCompanyAddress(CompanyAddress,CompanyInfo,TestPrint);
    end;
}

