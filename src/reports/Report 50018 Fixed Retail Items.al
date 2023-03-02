Report 50018 "Fixed Retail Items"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Fixed Retail Items.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.") order(ascending) where(Blocked = const(false), "Do Not Update JBG Retails" = const(true));
            RequestFilterFields = "No.", "Drop Ship Item", "Created From Nonstock Item";
            column(ReportForNavId_8129; 8129)
            {
            }
            column(Today; Today)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__Unit_Price_; "Unit Price")
            {
            }
            column(Item__Std_Fixed_Retail_; "Std Fixed Retail")
            {
            }
            column(ITEMS_WITH_FIXED_RETAILSCaption; ITEMS_WITH_FIXED_RETAILSCaptionLbl)
            {
            }
            column(PAGECaption; PAGECaptionLbl)
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(Item_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Item__Unit_Price_Caption; FieldCaption("Unit Price"))
            {
            }
            column(Item__Std_Fixed_Retail_Caption; FieldCaption("Std Fixed Retail"))
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
        ItemLedger: Record "Item Ledger Entry";
        Prtflg: Boolean;
        Nonstocks: Record "Nonstock Item";
        PrtDate: Date;
        ValueEntry: Record "Value Entry";
        ITEMS_WITH_FIXED_RETAILSCaptionLbl: label 'ITEMS WITH FIXED RETAILS';
        PAGECaptionLbl: label 'PAGE';
}

