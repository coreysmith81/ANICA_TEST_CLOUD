Report 50185 "Rebate Detail Customer Report"
{
    // //This program reports errors in the rebate input table
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Rebate Detail Customer Report.rdlc';


    dataset
    {
        dataitem("Rebates Detail";"Rebates Detail")
        {
            DataItemTableView = sorting("Store No.","Customer No.") order(ascending);
            RequestFilterFields = "Store No.",Date,"Customer No.";
            RequestFilterHeading = 'Filter On Store Number Desired';
            column(ReportForNavId_6931; 6931)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(UserId;UserId)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(Rebates_Detail__Sequence_No__;"Sequence No.")
            {
            }
            column(Rebates_Detail__Customer_No__;"Customer No.")
            {
            }
            column(Rebates_Detail__Store_No__;"Store No.")
            {
            }
            column(Rebates_Detail_Date;Date)
            {
            }
            column(Rebates_Detail_Amount;Amount)
            {
            }
            column(VName;VName)
            {
            }
            column(VTotalAmt;VTotalAmt)
            {
            }
            column(ANICA__Inc_Caption;ANICA__Inc_CaptionLbl)
            {
            }
            column(Rebate_Detail_Edit_ReportCaption;Rebate_Detail_Edit_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(AmountCaption;AmountCaptionLbl)
            {
            }
            column(DateCaption;DateCaptionLbl)
            {
            }
            column(Store_NumberCaption;Store_NumberCaptionLbl)
            {
            }
            column(Customer_NumberCaption;Customer_NumberCaptionLbl)
            {
            }
            column(Sequence_No_Caption;Sequence_No_CaptionLbl)
            {
            }
            column(Customer_NameCaption;Customer_NameCaptionLbl)
            {
            }
            column(Total_AmountCaption;Total_AmountCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Used table filter to exclude processed lines
                VSkipRecord := true;

                //IF VCheckAmounts = TRUE THEN
                //BEGIN
                //  IF "Rebates Detail".Amount >= VCheckLimit THEN
                //  BEGIN
                //  VSkipRecord := FALSE;
                //  PError := 'Amount Exceeds ' + FORMAT(VCheckLimit,0,'<Integer><Decimal,3>');
                //  END;
                //END;

                //Check zero Amounts
                //IF VCheckZero = TRUE THEN
                //BEGIN
                //  IF "Rebates Detail".Amount = 0 THEN
                //  BEGIN
                //  VSkipRecord := FALSE;
                //  PError := 'Amount is zero';
                //  END;
                //END;

                //Edit store number
                CustomerRecord.SetCurrentkey("No.");
                CustomerRecord.SetRange("No.","Rebates Detail"."Store No.");
                if not CustomerRecord.Find('+') then
                begin
                VSkipRecord := false;
                PError := 'Store Number is Invalid';
                end;
                CustomerRecord.SetRange("No.");//clear filter

                //Edit Customer Number
                RebatesCustomers.SetCurrentkey("Rebate Store No.","Rebate Customer No.");
                RebatesCustomers.SetRange("Rebate Store No.","Rebates Detail"."Store No.");
                RebatesCustomers.SetRange("Rebate Customer No.","Rebates Detail"."Customer No.");
                if not RebatesCustomers.Find('+') then
                begin
                VSkipRecord := false;
                PError := 'Customer Number is Invalid';
                end;
                VName := RebatesCustomers."Customer Name";
                RebatesCustomers.SetRange("Rebate Store No.");//clear filters
                RebatesCustomers.SetRange("Rebate Customer No.");

                //IF VSkipRecord = TRUE THEN CurrReport.SKIP;
                VTotalAmt := VTotalAmt + "Rebates Detail".Amount;
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

        trigger OnOpenPage()
        begin
            VCheckLimit := 200;
        end;
    }

    labels
    {
    }

    var
        CustomerRecord: Record Customer;
        RebatesCustomers: Record "Rebates Customers";
        PError: Text[30];
        VSkipRecord: Boolean;
        VCheckLimit: Decimal;
        VCheckZero: Boolean;
        VCheckAmounts: Boolean;
        VTotalAmt: Decimal;
        VName: Text[30];
        ANICA__Inc_CaptionLbl: label 'ANICA, Inc.';
        Rebate_Detail_Edit_ReportCaptionLbl: label 'Rebate Detail Edit Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        AmountCaptionLbl: label 'Amount';
        DateCaptionLbl: label 'Date';
        Store_NumberCaptionLbl: label 'Store Number';
        Customer_NumberCaptionLbl: label 'Customer Number';
        Sequence_No_CaptionLbl: label 'Sequence No.';
        Customer_NameCaptionLbl: label 'Customer Name';
        Total_AmountCaptionLbl: label 'Total Amount';
}

