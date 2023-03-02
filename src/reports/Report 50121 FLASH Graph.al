Report 50121 "FLASH Graph"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FLASH Graph.rdlc';
    UseRequestPage = true;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Posting Date", "G/L Account No.", Description) order(ascending);
            column(ReportForNavId_7069; 7069)
            {
            }
            column(UserId; UserId)
            {
            }
            column(VReportHeading; VReportHeading)
            {
            }
            column(VPrintHeading; VPrintHeading)
            {
            }
            column(VReportTotal; VReportTotal)
            {
            }
            column(VPrintHeading_Control1000000021; VPrintHeading)
            {
            }
            column(VMonthTotal; VMonthTotal)
            {
            }
            column(VGrandTotal; VGrandTotal)
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }
            column(VShowTotal; VShowTotal)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VShowTotal := false;

                //Get total before this record
                VReportTotal := VMonthTotal;
                VPrintHeading := VHeading;

                //Get the month as an integer
                VMonth := Date2dmy("G/L Entry"."Posting Date", 2);

                //See if this is a new month
                if VMonth <> VCheckMonth then VShowTotal := true;
                //Reset after reporting the month total
                if VShowTotal = true then VMonthTotal := 0;

                //Get totals
                VMonthTotal := VMonthTotal - "G/L Entry".Amount;
                VGrandTotal := VGrandTotal - "G/L Entry".Amount;

                //Get the check for the next rcord
                VCheckMonth := VMonth;
                VHeading := Format("G/L Entry"."Posting Date", 0, ' <MONTH TEXT> <YEAR4>');

                //Don't print first record
                if VFirstRecord = true then begin
                    VFirstRecord := false;
                    VShowTotal := false;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("G/L Entry"."Posting Date", '%1..%2', VStartDate, VEndDate);
                SetFilter("G/L Entry"."G/L Account No.", '%1|%2|%3', '401-12', '401-20', '401-32');

                VReportHeading := 'From ' + Format(VStartDate, 0, '<Month,2>/<Day,2>/<Year>') + 'Through '
                   + Format(VEndDate, 0, '<Month,2>/<Day,2>/<Year>');

                VShowTotal := false;
                VFirstRecord := true;
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
                    field(VStartDate; VStartDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Start Date';
                    }
                    field(VEndDate; VEndDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter End Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        VMonth: Integer;
        VCheckMonth: Integer;
        VMonthTotal: Decimal;
        VGrandTotal: Decimal;
        VShowTotal: Boolean;
        VFirstRecord: Boolean;
        VReportTotal: Decimal;
        VPrintHeading: Text[100];
        VHeading: Text[100];
        VReportHeading: Text[100];
        VStartDate: Date;
        VEndDate: Date;
        VFilterText: Text[255];
        Text19059010: label 'Enter Start Date';
        Text19009647: label 'Enter End Date';
        Grocery_Sales_for_Flash_GraphCaptionLbl: label 'Grocery Sales for Flash Graph';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Grand_TotalCaptionLbl: label 'Grand Total';
}

