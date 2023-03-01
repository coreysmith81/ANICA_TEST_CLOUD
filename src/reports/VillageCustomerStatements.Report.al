Report 50028 "Village Customer Statements"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Village Customer Statements.rdlc';

    dataset
    {
        dataitem(Customer;Customer)
        {
            CalcFields = "Net Change (LCY)";
            DataItemTableView = sorting("No.") order(ascending) where("Global Dimension 1 Code"=filter('ANICA'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.","Customer Posting Group","Member Code","Date Filter";
            column(ReportForNavId_6836; 6836)
            {
            }
            column(Today;Today)
            {
            }
            column(Time;Time)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(FilterString;FilterString)
            {
            }
            column(Customer_Name;Name)
            {
            }
            column(BalanceToPrint;BalanceToPrint)
            {
            }
            column(Customer_Name_Control26;Name)
            {
            }
            column(ALASKA_NATIVE_INDUSTRIES_COOPERATIVE_ASSOCIATIONCaption;ALASKA_NATIVE_INDUSTRIES_COOPERATIVE_ASSOCIATIONCaptionLbl)
            {
            }
            column(PAGECaption;PAGECaptionLbl)
            {
            }
            column(POSTING_DATECaption;POSTING_DATECaptionLbl)
            {
            }
            column(DOCUMENT_NO_Caption;DOCUMENT_NO_CaptionLbl)
            {
            }
            column(DESCRIPTIONCaption;DESCRIPTIONCaptionLbl)
            {
            }
            column(SALESCaption;SALESCaptionLbl)
            {
            }
            column(STORE_USECaption;STORE_USECaptionLbl)
            {
            }
            column(BANK_DEPOSITSCaption;BANK_DEPOSITSCaptionLbl)
            {
            }
            column(SJE_sCaption;SJE_sCaptionLbl)
            {
            }
            column(SNOW_MACHINESCaption;SNOW_MACHINESCaptionLbl)
            {
            }
            column(BAL_FORWDCaption;BAL_FORWDCaptionLbl)
            {
            }
            column(Customer_No_;"No.")
            {
            }
            dataitem("Cust. Ledger Entry";"Cust. Ledger Entry")
            {
                CalcFields = "Store Use","Snow Machines";
                DataItemLink = "Customer No."=field("No.");
                DataItemTableView = sorting("Customer No.","Posting Date","Currency Code") order(ascending);
                PrintOnlyIfDetail = false;
                column(ReportForNavId_8503; 8503)
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Posting_Date_;"Cust. Ledger Entry"."Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Document_No__;"Cust. Ledger Entry"."Document No.")
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry__Description;"Cust. Ledger Entry".Description)
                {
                }
                column(Saleable;Saleable)
                {
                }
                column(NonSale;NonSale)
                {
                }
                column(SJE;SJE)
                {
                }
                column(Payment;Payment)
                {
                }
                column(SnowMach;SnowMach)
                {
                }
                column(TotSale;TotSale)
                {
                }
                column(TotNonS;TotNonS)
                {
                }
                column(TotSJE;TotSJE)
                {
                }
                column(TotPymt;TotPymt)
                {
                }
                column(TotSnowM;TotSnowM)
                {
                }
                column(TOTALSCaption;TOTALSCaptionLbl)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_;"Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_;"Customer No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Saleable := 0;
                    SJE := 0;
                    NonSale := 0;
                    Payment := 0;
                    SnowMach := 0;
                    VDoc := '';
                    VDoc := CopyStr("Cust. Ledger Entry"."Document No.",1,1);

                    CalcFields("Cust. Ledger Entry"."Amount (LCY)");

                    if "Cust. Ledger Entry"."Document Type" = 1 then
                    begin
                    Payment := "Cust. Ledger Entry"."Amount (LCY)";
                    end;
                    if "Cust. Ledger Entry"."Document Type" = 0 then
                    begin
                    if VDoc = 'G' then SJE := "Cust. Ledger Entry"."Amount (LCY)";
                    end;
                    if "Cust. Ledger Entry"."Document Type" = 2 then
                    begin
                    if VDoc = 'E' then SJE := "Cust. Ledger Entry"."Amount (LCY)"
                      else
                      Saleable := "Cust. Ledger Entry"."Amount (LCY)";
                    if "Cust. Ledger Entry"."Store Use" <> 0 then
                        begin
                        NonSale := "Cust. Ledger Entry"."Store Use";
                        Saleable := "Cust. Ledger Entry"."Amount (LCY)" - "Cust. Ledger Entry"."Store Use";
                        end;
                    if "Cust. Ledger Entry"."Snow Machines" <> 0 then
                        begin
                        SnowMach := "Cust. Ledger Entry"."Snow Machines";
                        Saleable := "Cust. Ledger Entry"."Amount (LCY)" - "Cust. Ledger Entry"."Snow Machines";
                        end;
                    end;
                    TotSale := TotSale + Saleable;
                    TotNonS := TotNonS + NonSale;
                    TotSJE := TotSJE + SJE;
                    TotPymt := TotPymt + Payment;
                    TotSnowM := TotSnowM + SnowMach;
                    PrintDetail := true;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date",FromDate,ToDate);
                    Saleable := 0;
                    SJE := 0;
                    NonSale := 0;
                    Payment := 0;
                    SnowMach := 0;
                    VDoc := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SetRange(Customer."Date Filter",0D,FromDate -1);

                CalcFields(Customer."Net Change");
                BalanceToPrint := Customer."Net Change";
                SetRange(Customer."Date Filter");
                PrintDetail := false;
            end;

            trigger OnPreDataItem()
            begin
                Customer.SetRange(Customer."Date Filter");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        FilterString := CopyStr(Customer.GetFilters,1,MaxStrLen(FilterString));
        //DateFilter := Customer.GETFILTER("Cust. Ledger Entry"."Posting Date");
        FromDate := Customer.GetRangeMin("Date Filter");
        ToDate := Customer.GetRangemax("Date Filter");
    end;

    var
        NonSale: Decimal;
        Payment: Decimal;
        Saleable: Decimal;
        VDoc: Code[20];
        SJE: Decimal;
        TotSale: Decimal;
        TotNonS: Decimal;
        TotPymt: Decimal;
        TotSJE: Decimal;
        FilterString: Text[120];
        SnowMach: Decimal;
        TotSnowM: Decimal;
        FromDate: Date;
        BalanceToPrint: Decimal;
        DateFilter: Text[100];
        ToDate: Date;
        PrintDetail: Boolean;
        ALASKA_NATIVE_INDUSTRIES_COOPERATIVE_ASSOCIATIONCaptionLbl: label 'ALASKA NATIVE INDUSTRIES COOPERATIVE ASSOCIATION';
        PAGECaptionLbl: label 'PAGE';
        POSTING_DATECaptionLbl: label 'POSTING DATE';
        DOCUMENT_NO_CaptionLbl: label 'DOCUMENT NO.';
        DESCRIPTIONCaptionLbl: label 'DESCRIPTION';
        SALESCaptionLbl: label 'SALES';
        STORE_USECaptionLbl: label 'STORE USE';
        BANK_DEPOSITSCaptionLbl: label 'BANK DEPOSITS';
        SJE_sCaptionLbl: label 'SJE''s';
        SNOW_MACHINESCaptionLbl: label 'SNOW MACHINES';
        BAL_FORWDCaptionLbl: label 'BAL FORWD';
        TOTALSCaptionLbl: label 'TOTALS';
}

