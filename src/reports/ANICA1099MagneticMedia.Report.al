Report 50190 "ANICA 1099 Magnetic Media"
{
    // ANICA The PATR Patronage Dividend does not exist in the stock report.  Many changes are made to change the DIV reporting to PATR since we don't have dividends
    // 
    // ANICA Also change the global variable codeunit MagMediaManagement to ANICA Magnetic Media Mngmnt and add LastPATRNo as an integer.
    // 
    // ANICA Optional, on the request page, add code to change the year to last year

    Caption = 'Vendor 1099 Magnetic Media';
    ProcessingOnly = true;

    dataset
    {
        dataitem("T Record";"Integer")
        {
            DataItemTableView = sorting(Number);
            MaxIteration = 1;
            column(ReportForNavId_8300; 8300)
            {
            }

            trigger OnAfterGetRecord()
            begin
                WriteTRec;
            end;
        }
        dataitem("A Record";"Integer")
        {
            DataItemTableView = sorting(Number);
            MaxIteration = 4;
            column(ReportForNavId_2737; 2737)
            {
            }
            dataitem(Vendor;Vendor)
            {
                DataItemTableView = sorting("No.");
                RequestFilterFields = "No.";
                RequestFilterHeading = 'Vendor Filter';
                column(ReportForNavId_3182; 3182)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    MagMediaManagement.ClearAmts;
                    Clear(DirectSales);

                    // Check through all payments during calendar year
                    ProcessVendorInvoices("No.",PeriodDate);

                    WriteThis := MagMediaManagement.AnyAmount(FormType,EndLine);

                    if not WriteThis then
                      CurrReport.Skip;
                    PayeeNum := PayeeNum + 1;
                    PayeeTotal := PayeeTotal + 1;

                    "Post Code" := MagMediaManagement.StripNonNumerics("Post Code");

                    case FormType of
                      1:
                        begin // MISC
                          // Following is a special case for 1099-MISC only
                          Line9 := MagMediaManagement.UpdateLines(InvoiceEntry,FormType,EndLine,'MISC-09',0.0);
                          if MagMediaManagement.DirectSalesCheck(Line9) then
                            DirectSales := '1'
                          else
                            DirectSales := ' ';
                          WriteMiscBRec;
                        end;
                      2:
                        //<ANICA
                        // DIV
                        //WriteDivBRec;
                        // PATR
                        WritePATRBRec;
                        //>ANICA
                      3:
                        // INT
                        WriteIntBRec;
                      4:
                        //CS 02-21-21 for NEC codes
                        // NEC
                        WriteNECBRec;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    MagMediaManagement.ClearTotals;
                end;
            }
            dataitem("C Record";"Integer")
            {
                DataItemTableView = sorting(Number);
                MaxIteration = 1;
                column(ReportForNavId_1308; 1308)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not AnyRecs[FormType] then
                      CurrReport.Skip;

                    case FormType of
                      1:
                        // MISC
                        WriteMISCCRec;
                      2:
                        //<ANICA
                        // DIV
                        //WriteDIVCRec;
                        // PATR
                        WritePATRCRec;
                        //>ANICA
                      3:
                        // INT
                        WriteINTCRec;
                      4:
                        // NEC
                        WriteNECCRec;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                VendorFiltered: Record Vendor;
            begin
                // 1 iteration per 1099 type

                Clear(PayeeNum);
                FormType := FormType + 1;
                InvoiceEntry.Reset;
                case FormType of
                  1:
                    begin // MISC
                      InvoiceEntry.SetRange("IRS 1099 Code",'MISC-','MISC-99');
                      EndLine := LastMISCNo;
                      ReturnType := 'A ';
                    end;
                  2:
                    //<ANICA
                    //BEGIN // DIV
                    //  InvoiceEntry.SETRANGE("IRS 1099 Code",'DIV-','DIV-99');
                    //  EndLine := LastDIVNo;
                    //  ReturnType := '1 ';
                    //END;
                    begin // PATR
                      InvoiceEntry.SetRange("IRS 1099 Code",'PATR-','PATR-99');
                      EndLine := LastPATRNo;
                      ReturnType := '7 ';
                    end;
                    //>ANICA
                  3:
                    begin // INT
                      InvoiceEntry.SetRange("IRS 1099 Code",'INT-','INT-99');
                      EndLine := LastINTNo;
                      ReturnType := '6 ';
                    end;
                  4:
                    begin // NEC
                      InvoiceEntry.SetRange("IRS 1099 Code",'NEC-','NEC-99');
                      EndLine := LastNECNo;
                      ReturnType := 'NE';
                    end;

                end;

                VendorFiltered.CopyFilters(Vendor);
                if VendorFiltered.FindSet then
                  repeat
                    ProcessVendorInvoices(VendorFiltered."No.",PeriodDate);
                  until VendorFiltered.Next = 0;

                AnyRecs[FormType] := MagMediaManagement.AnyAmount(FormType,EndLine);
                MagMediaManagement.AmtCodes(CodeNos,FormType,EndLine);
                if AnyRecs[FormType] then begin
                  WriteARec;
                  ARecNum := ARecNum + 1;
                end else
                  CurrReport.Skip;
            end;
        }
        dataitem("F Record";"Integer")
        {
            DataItemTableView = sorting(Number);
            MaxIteration = 1;
            column(ReportForNavId_7115; 7115)
            {
            }

            trigger OnAfterGetRecord()
            begin
                WriteFRec;
            end;

            trigger OnPostDataItem()
            begin
                IRSData.SEEK(296);  // payee totals
                IRSData.TextMode := false;
                PayeeTotalStr := CopyStr(MagMediaManagement.FormatAmount(PayeeTotal,7),1,MaxStrLen(PayeeTotalStr));

                for i := 1 to StrLen(PayeeTotalStr) do begin
                  BinaryWriteChr := PayeeTotalStr[i];
                  IRSData.Write(BinaryWriteChr);
                end;
            end;

            trigger OnPreDataItem()
            begin
                if not AnyRecs[FormType] then
                  CurrReport.Skip;
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
                              Error(Text007);
                        end;
                    }
                    field(TransCode;TransCode)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Transmitter Control Code';

                        trigger OnValidate()
                        begin
                            if TransCode = '' then
                              Error(Text005);
                        end;
                    }
                    group("Transmitter Information")
                    {
                        Caption = 'Transmitter Information';
                        field("TransmitterInfo.Name";TransmitterInfo.Name)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Transmitter Name';
                        }
                        field("TransmitterInfo.Address";TransmitterInfo.Address)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Street Address';
                        }
                        field("TransmitterInfo.City";TransmitterInfo.City)
                        {
                            ApplicationArea = Basic;
                            Caption = 'City';
                        }
                        field("TransmitterInfo.County";TransmitterInfo.County)
                        {
                            ApplicationArea = Basic;
                            Caption = 'State';
                        }
                        field("TransmitterInfo.""Post Code""";TransmitterInfo."Post Code")
                        {
                            ApplicationArea = Basic;
                            Caption = 'ZIP Code';
                        }
                        field("TransmitterInfo.""Federal ID No.""";TransmitterInfo."Federal ID No.")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Employer ID';
                        }
                        field(ContactName;ContactName)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contact Name';

                            trigger OnValidate()
                            begin
                                if ContactName = '' then
                                  Error(Text002);
                            end;
                        }
                        field(ContactPhoneNo;ContactPhoneNo)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contact Phone No.';

                            trigger OnValidate()
                            begin
                                if ContactPhoneNo = '' then
                                  Error(Text001);
                            end;
                        }
                        field(ContactEmail;ContactEmail)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contact E-Mail';
                        }
                    }
                    field(bTestFile;bTestFile)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Test File';

                        trigger OnValidate()
                        begin
                            bTestFileOnAfterValidate;
                        end;
                    }
                    group("Vendor Information")
                    {
                        Caption = 'Vendor Information';
                        field(VendIndicator;VendIndicator)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Vendor Indicator';
                            OptionCaption = 'Vendor Software,In-House Software';
                        }
                        field(VendorInfoName;VendorInfo.Name)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Vendor Name';

                            trigger OnValidate()
                            begin
                                if VendorInfo.Name = '' then
                                  Error(Text006);
                            end;
                        }
                        field(VendorInfoAddress;VendorInfo.Address)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Vendor Street Address';

                            trigger OnValidate()
                            begin
                                if VendorInfo.Address = '' then
                                  Error(Text006);
                            end;
                        }
                        field(VendorInfoCity;VendorInfo.City)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Vendor City';

                            trigger OnValidate()
                            begin
                                if VendorInfo.City = '' then
                                  Error(Text006);
                            end;
                        }
                        field(VendorInfoCounty;VendorInfo.County)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Vendor State';

                            trigger OnValidate()
                            begin
                                if VendorInfo.County = '' then
                                  Error(Text006);
                            end;
                        }
                        field(VendorInfoPostCode;VendorInfo."Post Code")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Vendor ZIP Code';

                            trigger OnValidate()
                            begin
                                if VendorInfo."Post Code" = '' then
                                  Error(Text006);
                            end;
                        }
                        field(VendContactName;VendContactName)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Vendor Contact Name';

                            trigger OnValidate()
                            begin
                                if VendContactName = '' then
                                  Error(Text004);
                            end;
                        }
                        field(VendContactPhoneNo;VendContactPhoneNo)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Vendor Contact Phone No.';

                            trigger OnValidate()
                            begin
                                if VendContactPhoneNo = '' then
                                  Error(Text003);
                            end;
                        }
                        field(VendorInfoEMail;VendorInfo."E-Mail")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Vendor E-Mail';

                            trigger OnValidate()
                            begin
                                if VendorInfo."E-Mail" = '' then
                                  Error(Text006);
                            end;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            Year := Date2dmy(WorkDate,3);   /*default to current working year*/
            
            //<ANICA Change year to last year
            Year := Year - 1;
            //>ANICA
            
            CompanyInfo.Get;
            MagMediaManagement.EditCompanyInfo(CompanyInfo);
            TransmitterInfo := CompanyInfo;
            MagMediaManagement.EditCompanyInfo(CompanyInfo);

        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        TestFile := ' ';
        PriorYear := ' ';
        SequenceNo := 0;

        //< ANICA 2-20-10  Temporarily fill these values
        TransCode := '37A17';
        ContactPhoneNo := '2067670333103';
        ContactName := 'LINDA AUSTIN';
        ContactEmail := 'LAUSTIN@ANICAINC.COM';
        VendIndicator := 1;
        //>ANICA
    end;

    trigger OnPostReport()
    begin
        IRSData.Close;
        if FileName = '' then
          FileMgt.DownloadHandler(ServerTempFileName,'','',FileMgt.GetToFilterText('',ServerTempFileName),ClientFileNameTxt)
        else
          FileMgt.CopyServerFile(ServerTempFileName,FileName,true);
        FileMgt.DeleteServerFile(ServerTempFileName);
    end;

    trigger OnPreReport()
    var
        FileMgt: Codeunit "File Management";
    begin
        if TransCode = '' then
          Error(Text005);
        if ContactPhoneNo = '' then
          Error(Text001);
        if ContactName = '' then
          Error(Text002);
        //<ANICA LCC 3-17-16 These fields are not necessary for inhouse software
        //IF VendContactName = '' THEN
        //  ERROR(Text004);
        //IF VendContactPhoneNo = '' THEN
        //  ERROR(Text003);
        //IF VendorInfo.Name = '' THEN
        //  ERROR(Text006);
        //IF VendorInfo.Address = '' THEN
        //  ERROR(Text006);
        //IF VendorInfo.City = '' THEN
        //  ERROR(Text006);
        //IF VendorInfo.County = '' THEN
        //  ERROR(Text006);
        //IF VendorInfo."Post Code" = '' THEN
        //  ERROR(Text006);
        //IF VendorInfo."E-Mail" = '' THEN
        //  ERROR(Text006);
        //>ANICA

        FormType := 0;

        // Create date range which covers the entire calendar year
        PeriodDate[1] := Dmy2date(1,1,Year);
        PeriodDate[2] := Dmy2date(31,12,Year);

        Clear(PayeeNum);
        Clear(ARecNum);

        LastMISCNo := 17;
        //<ANICA;
        //LastDIVNo := 15;
        LastPATRNo := 15;
        //CS 02-11-21: adding for NEC codes
        LastNECNo := 1;
        //>ANICA
        LastINTNo := 13;

        MagMediaManagement.Run;

        Window.Open(
          'Exporting...\\' +
          'Table    #1####################');

        ServerTempFileName := FileMgt.ServerTempFileName('');
        Clear(IRSData);
        IRSData.TextMode := true;
        IRSData.WriteMode := true;
        IRSData.Create(ServerTempFileName);
        Window.Update(1,'IRSTAX');
    end;

    var
        IRSData: File;
        CompanyInfo: Record "Company Information";
        TransmitterInfo: Record "Company Information";
        VendorInfo: Record "Company Information" temporary;
        TempAppliedEntry: Record "Vendor Ledger Entry" temporary;
        EntryAppMgt: Codeunit "Entry Application Management";
        FileMgt: Codeunit "File Management";
        PeriodDate: array [2] of Date;
        Year: Integer;
        DirectSales: Text[1];
        ReturnType: Text[2];
        CodeNos: Text[12];
        WriteThis: Boolean;
        AnyRecs: array [4] of Boolean;
        InvoiceEntry: Record "Vendor Ledger Entry";
        LastINTNo: Integer;
        LastMISCNo: Integer;
        LastDIVNo: Integer;
        LastPATRNo: Integer;
        LastNECNo: Integer;
        EndLine: Integer;
        Invoice1099Amount: Decimal;
        i: Integer;
        FormType: Integer;
        Line9: Integer;
        ServerTempFileName: Text;
        TestFile: Text[1];
        PriorYear: Text[1];
        TransCode: Code[5];
        ContactName: Text[40];
        ContactPhoneNo: Text[30];
        ContactEmail: Text[35];
        VendContactName: Text[40];
        VendContactPhoneNo: Text[30];
        MagMediaManagement: Codeunit UnknownCodeunit50001;
        PayeeNum: Integer;
        PayeeTotal: Integer;
        PayeeTotalStr: Text[8];
        ARecNum: Integer;
        bTestFile: Boolean;
        Window: Dialog;
        BinaryWriteChr: Char;
        VendIndicator: Option "Vendor Software","In-House Software";
        SequenceNo: Integer;
        Text001: label 'You must enter the phone number of the person to be contacted if IRS/MCC encounters problems with the file or transmission.';
        Text002: label 'You must enter the name of the person to be contacted if IRS/MCC encounters problems with the file or transmission.';
        Text003: label 'You must enter the phone number of the person to be contacted if IRS/MCC has any software questions.';
        Text004: label 'You must enter the name of the person to be contacted if IRS/MCC has any software questions.';
        Text005: label 'You must enter the Transmitter Control Code assigned to you by the IRS.';
        Text006: label 'You must enter all software vendor address information.';
        Text007: label 'You must enter a valid year, eg 1993.';
        ClientFileNameTxt: label 'IRSTAX.txt';
        FileName: Text;


    procedure ProcessVendorInvoices(VendorNo: Code[20];PeriodDate: array [2] of Date)
    begin
        // search for invoices paid off by this payment
        EntryAppMgt.GetAppliedVendorEntries(TempAppliedEntry,VendorNo,PeriodDate,true);
        with TempAppliedEntry do begin
          // search for invoices with 1099 amounts
          SetFilter("Document Type",'%1|%2',"document type"::Invoice,"document type"::"Credit Memo");
          SetFilter("IRS 1099 Amount",'<>0');
          case FormType of
            1:
              SetRange("IRS 1099 Code",'MISC-','MISC-99');
            2:
              //<ANICA
              //SETRANGE("IRS 1099 Code",'DIV-','DIV-99')
              SetRange("IRS 1099 Code",'PATR-','PATR-99');
              //>ANICA
            3:
              SetRange("IRS 1099 Code",'INT-','INT-99');
            4:
              SetRange("IRS 1099 Code",'NEC-','NEC-99');
          end;
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
        MagMediaManagement.UpdateLines(InvoiceEntry,FormType,EndLine,InvoiceEntry."IRS 1099 Code",Invoice1099Amount);
    end;


    procedure WriteTRec()
    begin
        // T Record - 1 per transmission, 750 length
        IncrementSequenceNo;
        IRSData.Write(StrSubstNo('T') +
          StrSubstNo('#1##',CopyStr(Format(Year),1,4)) +
          StrSubstNo(PriorYear) + // Prior Year Indicator
          StrSubstNo('#1#######',MagMediaManagement.StripNonNumerics(TransmitterInfo."Federal ID No.")) +
          StrSubstNo('#1###',TransCode) + // Transmitter Control Code
          StrSubstNo('  ') + // replacement character
          StrSubstNo('     ') + // blank 5
          StrSubstNo(TestFile) +
          StrSubstNo(' ') + // Foreign Entity Code
          StrSubstNo('#1##############################################################################',
            TransmitterInfo.Name) +
          StrSubstNo('#1################################################',CompanyInfo.Name) +
          StrSubstNo('                              ') + // 2nd Payer Name
          StrSubstNo('#1######################################',CompanyInfo.Address) +
          StrSubstNo('#1######################################',CompanyInfo.City) +
          StrSubstNo('#1',CopyStr(CompanyInfo.County,1,2)) +
          StrSubstNo('#1#######',MagMediaManagement.StripNonNumerics(CompanyInfo."Post Code")) +
          StrSubstNo('               ') + // blank 15
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(PayeeTotal,8)) + // Payee total
          StrSubstNo('#1######################################',ContactName) +
          StrSubstNo('#1#############',ContactPhoneNo) +
          StrSubstNo('#1################################################',ContactEmail) + // 359-408
          StrSubstNo('  ') + // Tape file indicator
          StrSubstNo('#1####','      ') + // place for media number (not required)
          StrSubstNo('                                                  ') +
          StrSubstNo('                                 ') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('          ') +
          StrSubstNo('%1',CopyStr(Format(VendIndicator),1,1)) +
          StrSubstNo('#1######################################',VendorInfo.Name) +
          StrSubstNo('#1######################################',VendorInfo.Address) +
          StrSubstNo('#1######################################',VendorInfo.City) +
          StrSubstNo('#1',CopyStr(VendorInfo.County,1,2)) +
          StrSubstNo('#1#######',MagMediaManagement.StripNonNumerics(VendorInfo."Post Code")) +
          StrSubstNo('#1######################################',VendContactName) +
          StrSubstNo('#1#############',VendContactPhoneNo) +
          StrSubstNo('#1##################',VendorInfo."E-Mail") + // 20 chars
          StrSubstNo('                          '));
    end;


    procedure WriteARec()
    begin
        // A Record - 1 per Payer per 1099 type, 750 length
        IncrementSequenceNo;
        IRSData.Write(StrSubstNo('A') +
          StrSubstNo('#1##',CopyStr(Format(Year),1,4)) +
          StrSubstNo('      ') + // 6 blanks
          StrSubstNo('#1#######',MagMediaManagement.StripNonNumerics(CompanyInfo."Federal ID No.")) + // TIN
          StrSubstNo('#1##','    ') + // Payer Name Control
          StrSubstNo(' ') +
          StrSubstNo(ReturnType) +
          StrSubstNo('#1##############',CodeNos) + // Amount Codes  16
          StrSubstNo('        ') + // 8 blanks
          StrSubstNo(' ') + // Foreign Entity Code
          StrSubstNo('#1######################################',CompanyInfo.Name) +
          StrSubstNo('                                        ') + // 2nd Payer Name
          //ANICA Changed the next line to a value of 0
          StrSubstNo('0') + // Transfer Agent Indicator
          StrSubstNo('#1######################################',CompanyInfo.Address) +
          StrSubstNo('#1######################################',CompanyInfo.City) +
          StrSubstNo('#1',CompanyInfo.County) +
          StrSubstNo('#1#######',MagMediaManagement.StripNonNumerics(CompanyInfo."Post Code")) +
          StrSubstNo('#1#############',CompanyInfo."Phone No.") +
          StrSubstNo('                                                  ') + // blank 50
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('          ') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                           '));
    end;


    procedure WriteMiscBRec()
    var
        MISC03Amount: Decimal;
    begin
        IncrementSequenceNo;

        //ANICA LCC 3-18-16 We cannot adde the new FATCA field to the vendor so I removed the next line
        //IF NOT Vendor."FATCA filing requirement" THEN
          MISC03Amount := MagMediaManagement.GetAmt('MISC-03',FormType,EndLine);

        IRSData.Write(StrSubstNo('B') +
          StrSubstNo('#1##',CopyStr(Format(Year),1,4)) + //(2-5)
          StrSubstNo(' ') + // correction indicator (6)
          StrSubstNo('    ') + // name control (7-10)
          StrSubstNo(' ') + // Type of TIN  (11)
          StrSubstNo('#1#######',MagMediaManagement.StripNonNumerics(Vendor."Federal ID No.")) + // TIN (12-20)
          StrSubstNo('#1##################',Vendor."No.") + // Payer's Payee Account #  (21-40)
          StrSubstNo('              ') + // Blank 14 (41-54)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-01',FormType,EndLine),12)) + // Payment 1 (55-66)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-02',FormType,EndLine),12)) + //           (67-78)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MISC03Amount,12)) +                                          //           (79-90)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-04',FormType,EndLine),12)) + //           (91-102)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-05',FormType,EndLine),12)) + //           (103-114)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-06',FormType,EndLine),12)) + //           (115-126)
        //  STRSUBSTNO('#1##########',MagMediaManagement.FormatMoneyAmount(
        //      MagMediaManagement.GetAmt('MISC-07',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + //           (127-138)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-08',FormType,EndLine),12)) +  //                 (139-150)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + //           (151-162)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-10',FormType,EndLine),12)) + // crop insurance  Payment A  //      (163-174)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-13',FormType,EndLine),12)) + // golden parachute  Payment B  //      (175-186)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-14',FormType,EndLine),12)) + // gross legal services Payment C //      (187-198)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-15-A',FormType,EndLine),12)) + // 409A deferral  //      (199-210)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-15-B',FormType,EndLine),12)) + // 409A Income  //      (211-222)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +    //      (223-234)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +     //      (235-246)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + //added for 2021 Tax Year (247-258)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + //added for 2021 Tax Year (259-270)
          StrSubstNo('                ') + // blank 16 (271-286)
          StrSubstNo(' ') + // Foreign Country Indicator (287)
          StrSubstNo('#1######################################',Vendor.Name) + //(288-327)
          StrSubstNo('#1######################################',Vendor."Name 2") + //(328-367)
          StrSubstNo('#1######################################',Vendor.Address) + //(368-407)
          StrSubstNo('                                        ') + // blank 40 (408-447)
          StrSubstNo('#1######################################',Vendor.City) + //(448-487)
          StrSubstNo('#1',Vendor.County) + //(488-489)
          StrSubstNo('#1#######',Vendor."Post Code") + // (490-498)
          StrSubstNo(' ') + //(499)
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('                                    ') +   //(508-543)
          StrSubstNo(' ') + // Second TIN Notice (Optional) (544)
          StrSubstNo('  ') + // Blank (545-546)
          StrSubstNo(DirectSales) + // Direct Sales Indicator (547)
          //ANICA LCC 3-18-16 We cannot adde the new FATCA field to the vendor so I revised the next line
          //STRSUBSTNO(FORMAT(Vendor."FATCA filing requirement",0,2)) + // FATCA Filing Requirement Indicator (548)
          StrSubstNo(' ') + // FATCA Filing Requirement Indicator placeholder (548)
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('              ') + // Blank (549-662)
          StrSubstNo('                                                  ') +
          StrSubstNo('          ') + // Special Data Entries (663-722)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('MISC-16',FormType,EndLine),12)) + // State Income Tax Withheld (723-734)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + // Local Income Tax Withheld (735-746)
          StrSubstNo('  ') + // Combined Federal/State Code (747-748)
          StrSubstNo('  '));  // Blank (749-750)
    end;


    procedure WriteNECBRec()
    var
        MISC03Amount: Decimal;
    begin
        IncrementSequenceNo;

        //ANICA LCC 3-18-16 We cannot adde the new FATCA field to the vendor so I removed the next line
        //IF NOT Vendor."FATCA filing requirement" THEN
         // MISC03Amount := MagMediaManagement.GetAmt('MISC-03',FormType,EndLine);

        IRSData.Write(StrSubstNo('B') +
          StrSubstNo('#1##',CopyStr(Format(Year),1,4)) +
          StrSubstNo(' ') + // correction indicator
          StrSubstNo('    ') + // name control
          StrSubstNo(' ') + // Type of TIN
          StrSubstNo('#1#######',MagMediaManagement.StripNonNumerics(Vendor."Federal ID No.")) + // TIN
          StrSubstNo('#1##################',Vendor."No.") + // Payer's Payee Account #
          StrSubstNo('              ') + // Blank 14
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('NEC-01',FormType,EndLine),12)) + // Non-Employee Compensation (NEC-01 Tax code)

          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + //added for 2021 Tax Year (247-258)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + //added for 2021 Tax Year (259-270)
          StrSubstNo('                ') + // blank 16 (271-286)
          StrSubstNo(' ') + // Foreign Country Indicator
          StrSubstNo('#1######################################',Vendor.Name) +
          StrSubstNo('#1######################################',Vendor."Name 2") +
          StrSubstNo('#1######################################',Vendor.Address) +
          StrSubstNo('                                        ') + // blank 40
          StrSubstNo('#1######################################',Vendor.City) +
          StrSubstNo('#1',Vendor.County) +
          StrSubstNo('#1#######',Vendor."Post Code") +
          StrSubstNo(' ') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('                                    ') +
          StrSubstNo(' ') + // Second TIN Notice (Optional) (544)
          StrSubstNo('  ') + // Blank (545-546)
          StrSubstNo(DirectSales) + // Direct Sales Indicator (547)
          StrSubstNo(' ') + // FATCA Filing Requirement Indicator placeholder (548)
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('              ') + // Blank (549-662)
          StrSubstNo('                                                  ') +
          StrSubstNo('          ') + // Special Data Entries (663-722)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('  ') + // Combined Federal/State Code (747-748)
          StrSubstNo('  '));
    end;

    local procedure WritePATRBRec()
    begin
        //ALL ANICA Code Added here
        IncrementSequenceNo();
        IRSData.Write(StrSubstNo('B') +
                      StrSubstNo('#1##',CopyStr(Format(Year),1,4)) +
                      StrSubstNo(' ') +       //  correction indicator
                      StrSubstNo('    ') + // name control
                      StrSubstNo(' ') + // Type of TIN
                      StrSubstNo('#1#######',MagMediaManagement.StripNonNumerics(Vendor."Federal ID No.")) +   // TIN
                      StrSubstNo('#1##################',Vendor."No.") + // Payer's Payee Account #
                      StrSubstNo('              ') +  // Blank 14
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(            // ordinary dividends
                                 MagMediaManagement.GetAmt('PATR-01',FormType,EndLine),12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetAmt('PATR-02',FormType,EndLine),12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetAmt('PATR-03',FormType,EndLine),12)) + // total capital gains
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetAmt('PATR-04',FormType,EndLine),12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetAmt('PATR-05',FormType,EndLine),12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetAmt('PATR-06',FormType,EndLine),12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetAmt('PATR-07',FormType,EndLine),12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetAmt('PATR-08',FormType,EndLine),12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetAmt('PATR-09',FormType,EndLine),12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + //added for 2021 Tax Year (247-258)
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + //added for 2021 Tax Year (259-270)
                      StrSubstNo('                ') + // blank 16 (271-286)
                      StrSubstNo(' ') +  // Foreign Country Indicator
                      StrSubstNo('#1######################################',Vendor.Name) +
                      StrSubstNo('#1######################################',Vendor."Name 2") +
                      StrSubstNo('#1######################################',Vendor.Address) +
                      StrSubstNo('                                        ') +  // blank 40
                      StrSubstNo('#1######################################',Vendor.City) +
                      StrSubstNo('#1',Vendor.County) +
                      StrSubstNo('#1#######',Vendor."Post Code") +
                      StrSubstNo(' ') +
                      StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) +   // sequence number for all rec types
                      StrSubstNo('                                    ') +
                      StrSubstNo(' ') +  // second TIN notice
                      StrSubstNo('  ') + // blank 2
                      StrSubstNo('                                        ') +  // foreign country 40
                      StrSubstNo('                                                  ') +
                      StrSubstNo('                          ') +
                      StrSubstNo('                                                  ') +
                      StrSubstNo('          ') +
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + // State W/H
                      StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + // Local W/H
                      StrSubstNo('  ') +          // combined Fed/State code
                      StrSubstNo('  '));          // blank 2
    end;


    procedure WriteDivBRec()
    begin
        IncrementSequenceNo;
        IRSData.Write(StrSubstNo('B') +
          StrSubstNo('#1##',CopyStr(Format(Year),1,4)) +
          StrSubstNo(' ') + // correction indicator
          StrSubstNo('    ') + // name control
          StrSubstNo(' ') + // Type of TIN
          StrSubstNo('#1#######',MagMediaManagement.StripNonNumerics(Vendor."Federal ID No.")) + // TIN
          StrSubstNo('#1##################',Vendor."No.") + // Payer's Payee Account #
          StrSubstNo('              ') + // Blank 14
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(// ordinary dividends
              MagMediaManagement.GetAmt('DIV-01-A',FormType,EndLine) +
              MagMediaManagement.GetAmt('DIV-01-B',FormType,EndLine) +
              MagMediaManagement.GetAmt('DIV-05',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('DIV-01-B',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(// total capital gains
              MagMediaManagement.GetAmt('DIV-02-B',FormType,EndLine) +
              MagMediaManagement.GetAmt('DIV-02-C',FormType,EndLine) +
              MagMediaManagement.GetAmt('DIV-02-D',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('DIV-02-B',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('DIV-02-C',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('DIV-02-D',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(// non-taxable dist. 6
              MagMediaManagement.GetAmt('DIV-03',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(// fed W/H 7
              MagMediaManagement.GetAmt('DIV-04',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(// investment. expenses 8
              MagMediaManagement.GetAmt('DIV-05',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('DIV-06',FormType,EndLine),12)) + // Foreign Taxc Paid A
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('DIV-08',FormType,EndLine),12)) + // cash liquidation B
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('DIV-09',FormType,EndLine),12)) + // non-cash liquidation C
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo(' ') + // Foreign Country Indicator
          StrSubstNo('#1######################################',Vendor.Name) +
          StrSubstNo('#1######################################',Vendor."Name 2") +
          StrSubstNo('                                        ') + // blank 40
          StrSubstNo('#1######################################',Vendor.Address) +
          StrSubstNo('                                        ') + // blank 40
          StrSubstNo('#1######################################',Vendor.City) +
          StrSubstNo('#1',Vendor.County) +
          StrSubstNo('#1#######',Vendor."Post Code") +
          StrSubstNo(' ') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('                                    ') +
          StrSubstNo(' ') + // Second TIN Notice (Optional) (544)
          StrSubstNo('  ') + // Blank (545-546)
          StrSubstNo('                                        ') + // Foreign Country or U.S. Possession (547-586)
          //ANICA LCC 3-18-16 We cannot adde the new FATCA field to the vendor so I revised the next line
          //STRSUBSTNO(FORMAT(Vendor."FATCA filing requirement",0,2)) + // FATCA Filing Requirement Indicator (587)
          StrSubstNo(' ') + // FATCA Filing Requirement Indicator placeholder (587)
          StrSubstNo('                                                  ') +
          StrSubstNo('                         ') + // Blank (588-662)
          StrSubstNo('                                                  ') +
          StrSubstNo('          ') + // Special Data Entries (663-722)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + // State Income Tax Withheld (723-734)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + // Local Income Tax Withheld (735-746)
          StrSubstNo('  ') + // Combined Federal/State Code (747-748)
          StrSubstNo('  ')); // Blank (749-750)
    end;


    procedure WriteIntBRec()
    begin
        IncrementSequenceNo;
        IRSData.Write(StrSubstNo('B') +
          StrSubstNo('#1##',CopyStr(Format(Year),1,4)) +
          StrSubstNo(' ') + // correction indicator
          StrSubstNo('    ') + // name control
          StrSubstNo(' ') + // Type of TIN
          StrSubstNo('#1#######',MagMediaManagement.StripNonNumerics(Vendor."Federal ID No.")) + // TIN
          StrSubstNo('#1##################',Vendor."No.") + // Payer's Payee Account #
          StrSubstNo('              ') + // Blank 14
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-01',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-02',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-03',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-04',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-05',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-06',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-08',FormType,EndLine) +
              MagMediaManagement.GetAmt('INT-09',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-09',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-10',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-11',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetAmt('INT-13',FormType,EndLine),12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) +
          StrSubstNo(' ') + // Foreign Country Indicator
          StrSubstNo('#1######################################',Vendor.Name) +
          StrSubstNo('#1######################################',Vendor."Name 2") +
          StrSubstNo('                                        ') + // blank 40
          StrSubstNo('#1######################################',Vendor.Address) +
          StrSubstNo('                                        ') + // blank 40
          StrSubstNo('#1######################################',Vendor.City) +
          StrSubstNo('#1',Vendor.County) +
          StrSubstNo('#1#######',Vendor."Post Code") +
          StrSubstNo(' ') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('                                    ') +
          StrSubstNo(' ') + // Second TIN Notice (Optional) (544)
          StrSubstNo('  ') + // Blank (545-546)
          StrSubstNo('                                        ') + // Foreign Country or U.S. Possession (547-586)
          StrSubstNo('             ') + // CUSIP Number (587-599)
          //ANICA LCC 3-18-16 We cannot adde the new FATCA field to the vendor so I revised the next line
          //STRSUBSTNO(FORMAT(Vendor."FATCA filing requirement",0,2)) + // FATCA Filing Requirement Indicator (600)
          StrSubstNo(' ') + // FATCA Filing Requirement Indicator placeholder (600)
          StrSubstNo('                                                  ') +
          StrSubstNo('            ') + // Blank (601-662)
          StrSubstNo('                                                  ') +
          StrSubstNo('          ') + // Special Data Entries (663-722)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + // State Income Tax Withheld (723-734)
          StrSubstNo('#1##########',MagMediaManagement.FormatMoneyAmount(0,12)) + // Local Income Tax Withheld (735-746)
          StrSubstNo('  ') + // Combined Federal/State Code (747-748)
          StrSubstNo('  ')); // Blank (749-750)
    end;


    procedure WriteMISCCRec()
    begin
        // C Record - 1 per Payer per 1099 type
        IncrementSequenceNo;
        IRSData.Write(StrSubstNo('C') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(PayeeNum,8)) +
          StrSubstNo('      ') + // Blank 6
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-01',FormType,EndLine),18)) + // Payment 1
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-02',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-03',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-04',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-05',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-06',FormType,EndLine),18)) +
        //  STRSUBSTNO('#1################',MagMediaManagement.FormatMoneyAmount(
        //      MagMediaManagement.GetTotal('MISC-07',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-08',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-10',FormType,EndLine),18)) + // crop insurance  Payment A
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-13',FormType,EndLine),18)) + // golden parachute  Payment B
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-14',FormType,EndLine),18)) + // gross legal services Payment C
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-15-A',FormType,EndLine),18)) + // 409A deferral
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('MISC-15-B',FormType,EndLine),18)) + // 409A Income
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                              ') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                           '));
    end;


    procedure WriteNECCRec()
    begin
        // C Record - 1 per Payer per 1099 type
        IncrementSequenceNo;
        IRSData.Write(StrSubstNo('C') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(PayeeNum,8)) +
          StrSubstNo('      ') + // Blank 6
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('NEC-01',FormType,EndLine),18)) + // Non Employee Compensation

          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                              ') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                           '));
    end;

    local procedure WritePATRCRec()
    begin
        //ANICA This is all ANICA added
        // C Record - 1 per Payer per 1099 type
        IncrementSequenceNo();
        IRSData.Write(StrSubstNo('C') +
                      StrSubstNo('#1######',MagMediaManagement.FormatAmount(PayeeNum,8)) +
                      StrSubstNo('      ') +   // Blank 6
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetTotal('PATR-01',FormType,EndLine),18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetTotal('PATR-02',FormType,EndLine) +
                                 MagMediaManagement.GetTotal('PATR-03',FormType,EndLine) +
                                 MagMediaManagement.GetTotal('PATR-04',FormType,EndLine) +
                                 MagMediaManagement.GetTotal('PATR-05',FormType,EndLine) +
                                 MagMediaManagement.GetTotal('PATR-06',FormType,EndLine),18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetTotal('PATR-07',FormType,EndLine),18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetTotal('PATR-08',FormType,EndLine),18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
                                 MagMediaManagement.GetTotal('PATR-09',FormType,EndLine),18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
                      StrSubstNo('              ') +
                      StrSubstNo('                                                  ') +
                      StrSubstNo('                                                  ') +
                      StrSubstNo('                                                  ') +
                      StrSubstNo('                                ') +
                      StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) +   // sequence number for all rec types
                      StrSubstNo('                                                  ') +
                      StrSubstNo('                                                  ') +
                      StrSubstNo('                                                  ') +
                      StrSubstNo('                                                  ') +
                      StrSubstNo('                                           '));
    end;


    procedure WriteDIVCRec()
    begin
        // C Record - 1 per Payer per 1099 type
        IncrementSequenceNo;
        IRSData.Write(StrSubstNo('C') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(PayeeNum,8)) +
          StrSubstNo('      ') + // Blank 6
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(// ordinary dividends
              MagMediaManagement.GetTotal('DIV-01-A',FormType,EndLine) +
              MagMediaManagement.GetTotal('DIV-01-B',FormType,EndLine) +
              MagMediaManagement.GetTotal('DIV-05',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('DIV-01-B',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(// total capital gains
              MagMediaManagement.GetTotal('DIV-02-B',FormType,EndLine) +
              MagMediaManagement.GetTotal('DIV-02-C',FormType,EndLine) +
              MagMediaManagement.GetTotal('DIV-02-D',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('DIV-02-B',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('DIV-02-C',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('DIV-02-D',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(// non-taxable dist. 6
              MagMediaManagement.GetTotal('DIV-03',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(// fed W/H 7
              MagMediaManagement.GetTotal('DIV-04',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(// investment. expenses 8
              MagMediaManagement.GetTotal('DIV-05',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('DIV-06',FormType,EndLine),18)) + // Foreign Taxc Paid A
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('DIV-08',FormType,EndLine),18)) + // cash liquidation B
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('DIV-09',FormType,EndLine),18)) + // non-cash liquidation C
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                              ') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                           '));
    end;


    procedure WriteINTCRec()
    begin
        // C Record - 1 per Payer per 1099 type
        IncrementSequenceNo;
        IRSData.Write(StrSubstNo('C') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(PayeeNum,8)) +
          StrSubstNo('      ') + // Blank 6
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('INT-01',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('INT-02',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('INT-03',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('INT-04',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('INT-05',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('INT-06',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('INT-08',FormType,EndLine) +
              MagMediaManagement.GetTotal('INT-09',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(
              MagMediaManagement.GetTotal('INT-09',FormType,EndLine),18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('#1################',MagMediaManagement.FormatMoneyAmount(0,18)) +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                              ') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                           '));
    end;


    procedure WriteFRec()
    begin
        // F Record - 1
        IncrementSequenceNo;
        IRSData.Write(StrSubstNo('F') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(ARecNum,8)) + // number of A recs.
          StrSubstNo('#1########',MagMediaManagement.FormatAmount(0,10)) + // 21 zeros
          StrSubstNo('#1#########',MagMediaManagement.FormatAmount(0,11)) +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                   ') +
          StrSubstNo('#1######',MagMediaManagement.FormatAmount(SequenceNo,8)) + // sequence number for all rec types
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                                  ') +
          StrSubstNo('                                           '));
    end;


    procedure IncrementSequenceNo()
    begin
        SequenceNo := SequenceNo + 1;
    end;

    local procedure bTestFileOnAfterValidate()
    begin
        if bTestFile then
          TestFile := 'T';
    end;


    procedure InitializeRequest(NewFileName: Text)
    begin
        FileName := NewFileName;
    end;
}

