Report 50164 "Commodity Code Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Commodity Code Listing.rdlc';

    dataset
    {
        dataitem("Commodity Code";"Commodity Code")
        {
            DataItemTableView = sorting("Commodity Code") order(ascending);
            RequestFilterFields = "Commodity Code";
            column(ReportForNavId_8848; 8848)
            {
            }
            column(Today;Today)
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(UserId;UserId)
            {
            }
            column(Commodity_Code__Commodity_Code_;"Commodity Code")
            {
            }
            column(Commodity_Code_Group;Group)
            {
            }
            column(Commodity_Code_Description;Description)
            {
            }
            column(Commodity_Code_Margin;Margin)
            {
            }
            column(Commodity_CodesCaption;Commodity_CodesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Commodity_Code__Commodity_Code_Caption;FieldCaption("Commodity Code"))
            {
            }
            column(Commodity_Code_GroupCaption;FieldCaption(Group))
            {
            }
            column(Commodity_Code_DescriptionCaption;FieldCaption(Description))
            {
            }
            column(Commodity_Code_MarginCaption;FieldCaption(Margin))
            {
            }
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
        Commodity_CodesCaptionLbl: label 'Commodity Codes';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}

