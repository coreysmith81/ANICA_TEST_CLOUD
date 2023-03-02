Report 50114 "Rebate Detail Edit Report"
{
    // //This program reports errors in the rebate input table
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Rebate Detail Edit Report.rdlc';


    dataset
    {
        dataitem("Rebates Detail"; "Rebates Detail")
        {
            DataItemTableView = sorting(Processed, "Store No.", "Customer No.") order(ascending) where(Processed = const(false));
            RequestFilterFields = "Store No.", Date;
            RequestFilterHeading = 'Filter On Store Number Desired';
            column(ReportForNavId_6931; 6931)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(UserId; UserId)
            {
            }
            column(Rebates_Detail__Sequence_No__; "Sequence No.")
            {
            }
            column(Rebates_Detail__Customer_No__; "Customer No.")
            {
            }
            column(Rebates_Detail__Store_No__; "Store No.")
            {
            }
            column(Rebates_Detail_Date; Date)
            {
            }
            column(Rebates_Detail_Amount; Amount)
            {
            }
            column(PError; PError)
            {
            }
            column(ANICA__Inc_Caption; ANICA__Inc_CaptionLbl)
            {
            }
            column(Rebate_Detail_Edit_ReportCaption; Rebate_Detail_Edit_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Error_MessageCaption; Error_MessageCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Store_NumberCaption; Store_NumberCaptionLbl)
            {
            }
            column(Customer_NumberCaption; Customer_NumberCaptionLbl)
            {
            }
            column(Sequence_No_Caption; Sequence_No_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Used table filter to exclude processed lines
                VSkipRecord := true;

                if VCheckAmounts = true then begin
                    if "Rebates Detail".Amount >= VCheckLimit then begin
                        VSkipRecord := false;
                        PError := 'Amount Exceeds ' + Format(VCheckLimit, 0, '<Integer><Decimal,3>');
                    end;
                end;

                //Check zero Amounts
                if VCheckZero = true then begin
                    if "Rebates Detail".Amount = 0 then begin
                        VSkipRecord := false;
                        PError := 'Amount is zero';
                    end;
                end;

                //Edit store number
                CustomerRecord.SetCurrentkey("No.");
                CustomerRecord.SetRange("No.", "Rebates Detail"."Store No.");
                if not CustomerRecord.Find('+') then begin
                    VSkipRecord := false;
                    PError := 'Store Number is Invalid';
                end;
                CustomerRecord.SetRange("No.");//clear filter

                //Edit Customer Number
                RebatesCustomers.SetCurrentkey("Rebate Store No.", "Rebate Customer No.");
                RebatesCustomers.SetRange("Rebate Store No.", "Rebates Detail"."Store No.");
                RebatesCustomers.SetRange("Rebate Customer No.", "Rebates Detail"."Customer No.");
                if not RebatesCustomers.Find('+') then begin
                    VSkipRecord := false;
                    PError := 'Customer Number is Invalid';
                end;
                RebatesCustomers.SetRange("Rebate Store No.");//clear filters
                RebatesCustomers.SetRange("Rebate Customer No.");

                if VSkipRecord = true then CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(VCheckAmounts; VCheckAmounts)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Look for Amounts That Exceed a Set Amount';
                    }
                    field(VCheckLimit; VCheckLimit)
                    {
                        ApplicationArea = Basic;
                    }
                    field(VCheckZero; VCheckZero)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Check for Zero Amounts';
                    }
                }
            }
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
        Text19001108: label 'Look For Amounts That Exceed a Set Amount';
        Text19030651: label 'Set Amount to Check';
        Text19051034: label 'Check For Zero Amounts';
        ANICA__Inc_CaptionLbl: label 'ANICA, Inc.';
        Rebate_Detail_Edit_ReportCaptionLbl: label 'Rebate Detail Edit Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Error_MessageCaptionLbl: label 'Error Message';
        AmountCaptionLbl: label 'Amount';
        DateCaptionLbl: label 'Date';
        Store_NumberCaptionLbl: label 'Store Number';
        Customer_NumberCaptionLbl: label 'Customer Number';
        Sequence_No_CaptionLbl: label 'Sequence No.';
}

