Report 50099 "Credit Report"
{
    // //06/01/09 Removed the check for zero balances because it affected the Credit Comparison report - per Bill K.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Credit Report.rdlc';


    dataset
    {
        dataitem(Customer;Customer)
        {
            CalcFields = "Outstanding Orders (LCY)","Shipped Not Invoiced (LCY)";
            DataItemTableView = sorting("Credit Report") order(ascending) where("Customer Posting Group"=filter(<>'BETHEL'),"Member Code"=filter(<>'INACTIVE'));
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
            column(Customer__Credit_Report_;"Credit Report")
            {
                OptionMembers = " ",MEMBERS,"NON-MEMBERS","Z-ANICA STORES";
            }
            column(Customer__Credit_Report__Control24;"Credit Report")
            {
                OptionMembers = " ",MEMBERS,"NON-MEMBERS","Z-ANICA STORES";
            }
            column(Customer_Name;Name)
            {
            }
            column(Customer__Store_Deposit_;"Store Deposit")
            {
            }
            column(Customer__Balance__LCY__;"Balance (LCY)")
            {
            }
            column(Outstanding_Orders__LCY______Shipped_Not_Invoiced__LCY__;"Outstanding Orders (LCY)" + "Shipped Not Invoiced (LCY)")
            {
            }
            column(Customer__Credit_Limit__LCY__;"Credit Limit (LCY)")
            {
            }
            column(Over;Over)
            {
            }
            column(Available;Available)
            {
            }
            column(Customer__Store_Deposit__Control26;"Store Deposit")
            {
            }
            column(Customer__Balance__LCY___Control27;"Balance (LCY)")
            {
            }
            column(Outstanding_Orders__LCY______Shipped_Not_Invoiced__LCY___Control28;"Outstanding Orders (LCY)" + "Shipped Not Invoiced (LCY)")
            {
            }
            column(Customer__Credit_Limit__LCY___Control29;"Credit Limit (LCY)")
            {
            }
            column(Over_Control30;Over)
            {
            }
            column(Available_Control31;Available)
            {
            }
            column(TotalDep;TotalDep)
            {
            }
            column(TotalAcct;TotalAcct)
            {
            }
            column(TotalUnbill;TotalUnbill)
            {
            }
            column(TotalLimit;TotalLimit)
            {
            }
            column(TotalOver;TotalOver)
            {
            }
            column(TotalAvail;TotalAvail)
            {
            }
            column(ANICACaption;ANICACaptionLbl)
            {
            }
            column(STORE_DAILY_CREDIT_STATUSCaption;STORE_DAILY_CREDIT_STATUSCaptionLbl)
            {
            }
            column(PAGECaption;PAGECaptionLbl)
            {
            }
            column(Village_StoreCaption;Village_StoreCaptionLbl)
            {
            }
            column(Memb__Dep_Caption;Memb__Dep_CaptionLbl)
            {
            }
            column(Acct__Bal_Caption;Acct__Bal_CaptionLbl)
            {
            }
            column(UnbilledCaption;UnbilledCaptionLbl)
            {
            }
            column(Cred__LimitCaption;Cred__LimitCaptionLbl)
            {
            }
            column(OverCaption;OverCaptionLbl)
            {
            }
            column(AvailableCaption;AvailableCaptionLbl)
            {
            }
            column(Sub_TotalsCaption;Sub_TotalsCaptionLbl)
            {
            }
            column(TOTALSCaption;TOTALSCaptionLbl)
            {
            }
            column(Customer_No_;"No.")
            {
            }
            column(VCheckForZeroBalance;VCheckForZeroBalance)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Credit Report" = 0 then
                     CurrReport.Skip;
                Over := 0.0;
                Available := 0.0;
                OvSh := "Credit Limit (LCY)" - "Balance (LCY)" - "Outstanding Orders (LCY)" - "Shipped Not Invoiced (LCY)";
                   if OvSh < 0.0 then
                      Over := -OvSh
                   else
                      Available := OvSh;

                //If all balances are zero, do not print (this check is done in the report section)
                VCheckForZeroBalance := "Store Deposit" + "Balance (LCY)" + "Outstanding Orders (LCY)"
                   + "Shipped Not Invoiced (LCY)" + "Credit Limit (LCY)";

                TotalDep := TotalDep + "Store Deposit";
                TotalAcct := TotalAcct + "Balance (LCY)";
                TotalUnbill := TotalUnbill + "Outstanding Orders (LCY)" + "Shipped Not Invoiced (LCY)";
                TotalLimit := TotalLimit + "Credit Limit (LCY)";
                TotalOver := TotalOver + Over;
                TotalAvail := TotalAvail + Available;

                if Customer."Credit Report" <> 3 then
                begin
                WriteLineRecord;
                end;
            end;

            trigger OnPreDataItem()
            begin
                  CurrReport.CreateTotals(Over);
                  CurrReport.CreateTotals(Available);
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
        D := Today;
        Day := Date2dmy(D,1);
        Mon := Date2dmy(D,2);
        Year := Date2dmy(D,3);
        DayofWeek := Date2dwy(D,1);

        //Create a file for the access database monthly credit comparion report
        if Day <= 4 then
        begin
        VFileName := 'CreditComp';
        TDay := Format(Day,2,'<Integer>');
        TMon := Format(Mon,2,'<Integer>');
        TYear := Format(Year,4,'<Integer>');
        TDay2 := ConvertStr(TDay,' ','0');
        TMon2 := ConvertStr(TMon,' ','0');
        VFullFileName := '\\filestore\EDI\Credit\'
            + VFileName + TMon2 + TDay2 + TYear + '.txt';
        VLineOutputFile.Create(VFullFileName);
        VLineOutputFile.TextMode(true);
        end;
    end;

    var
        Unbilled: Decimal;
        Over: Decimal;
        Available: Decimal;
        TotalDep: Decimal;
        TotalAcct: Decimal;
        TotalUnbill: Decimal;
        TotalLimit: Decimal;
        TotalOver: Decimal;
        TotalAvail: Decimal;
        OvSh: Decimal;
        VCredLim: Option;
        VFileName: Text[25];
        VLineOutputFile: File;
        VFullFileName: Text[130];
        VOutputFileLine: Text[130];
        WMembDep: Text[14];
        WAcctBal: Text[14];
        WUnbilled: Text[14];
        WCredLimit: Text[14];
        WOver: Text[14];
        WAvailable: Text[13];
        WToday: Text[8];
        PMembDep: Decimal;
        PAcctBal: Decimal;
        PUnbilled: Decimal;
        PCredLimit: Decimal;
        POver: Decimal;
        PAvailable: Decimal;
        FileLen: Integer;
        Day: Integer;
        D: Date;
        DayofWeek: Integer;
        WAvailOver: Text[14];
        RAvail: Text[14];
        Mon: Integer;
        Year: Integer;
        TDay: Text[2];
        TMon: Text[2];
        TYear: Text[4];
        TDay2: Text[2];
        TMon2: Text[2];
        VCheckForZeroBalance: Decimal;
        ANICACaptionLbl: label 'ANICA';
        STORE_DAILY_CREDIT_STATUSCaptionLbl: label 'STORE DAILY CREDIT STATUS';
        PAGECaptionLbl: label 'PAGE';
        Village_StoreCaptionLbl: label 'Village Store';
        Memb__Dep_CaptionLbl: label 'Memb. Dep.';
        Acct__Bal_CaptionLbl: label 'Acct. Bal.';
        UnbilledCaptionLbl: label 'Unbilled';
        Cred__LimitCaptionLbl: label 'Cred. Limit';
        OverCaptionLbl: label 'Over';
        AvailableCaptionLbl: label 'Available';
        Sub_TotalsCaptionLbl: label 'Sub Totals';
        TOTALSCaptionLbl: label 'TOTALS';


    procedure WriteLineRecord()
    begin
        //First Line
        Unbilled := Customer."Outstanding Orders (LCY)" + Customer."Shipped Not Invoiced (LCY)";
        PMembDep := ROUND(Customer."Store Deposit",0.01);
        WMembDep := Format(PMembDep,14,'<Integer><Decimal,3>');
        PAcctBal := ROUND(Customer."Balance (LCY)",0.01);
        WAcctBal := Format(PAcctBal,14,'<Sign><Integer><Decimal,3>');
        PUnbilled := ROUND(Unbilled,0.01);
        WUnbilled := Format(PUnbilled,14,'<Integer><Decimal,3>');
        PCredLimit := ROUND(Customer."Credit Limit (LCY)",0.01);
        WCredLimit := Format(PCredLimit,14,'<Integer><Decimal,3>');
        POver := ROUND(Over,0.01);
        WOver := Format(POver,14,'<Sign><Integer><Decimal,3>');
        PAvailable := ROUND(Available,0.01);
        WAvailable := Format(PAvailable,13,'<Integer><Decimal,3>');
        RAvail := '-' + WAvailable;
        WToday := Format(Today,8,'<Month,2>/<Day,2>/<Year>');
        Customer.Name := PadStr(Customer.Name,30,' ');
        if POver = 0 then WAvailOver := RAvail
        else WAvailOver := WOver;
        if Day <= 4 then
        begin
        VOutputFileLine := WToday + Customer."No." + WMembDep + WAcctBal + WUnbilled + WCredLimit + WAvailOver;
        VLineOutputFile.Write(VOutputFileLine);
        end;
    end;
}

