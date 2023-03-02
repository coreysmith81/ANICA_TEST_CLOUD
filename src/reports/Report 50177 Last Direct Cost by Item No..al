Report 50177 "Last Direct Cost by Item No."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Last Direct Cost by Item No..rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            column(ReportForNavId_8129; 8129)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__Last_Direct_Cost_; "Last Direct Cost")
            {
            }
            column(Last_Direct_Cost_by_Item_No_Caption; Last_Direct_Cost_by_Item_No_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(Item_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Item__Last_Direct_Cost_Caption; FieldCaption("Last Direct Cost"))
            {
            }

            trigger OnPreDataItem()
            begin
                SetCurrentkey("MSA Reporting");
                SetRange("MSA Reporting", true);
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

    var
        Last_Direct_Cost_by_Item_No_CaptionLbl: label 'Last Direct Cost by Item No.';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}

