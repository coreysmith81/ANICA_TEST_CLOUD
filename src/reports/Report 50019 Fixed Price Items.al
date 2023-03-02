Report 50019 "Fixed Price Items"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Fixed Price Items.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.") order(ascending) where(Blocked = const(false), "Fixed Price Code" = const(true));
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
            column(ITEMS_WITH_FIXED_PRICESCaption; ITEMS_WITH_FIXED_PRICESCaptionLbl)
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
        ITEMS_WITH_FIXED_PRICESCaptionLbl: label 'ITEMS WITH FIXED PRICES';
        PAGECaptionLbl: label 'PAGE';
}

