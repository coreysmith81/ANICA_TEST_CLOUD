Page 50035 "Item Cross Reference ANICA"
{
    Caption = 'Item Cross References';
    Editable = true;
    PageType = List;
    SourceTable = "Item Reference";
    SourceTableView = sorting("Reference No.") //changed from "Cross-Reference No."
                      order(ascending)
                      where("Reference Type" = const(" ")); //changed from "Cross-Reference Type"

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Cross-Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = Basic;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cross_Ref Desc"; Rec."Cross_Ref Desc")
                {
                    ApplicationArea = Basic;
                }
                field("ANICA Cross Type"; Rec."ANICA Cross Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date Added"; Rec."Date Added")
                {
                    ApplicationArea = Basic;
                }
                field("Cross_Ref Pack"; Rec."Cross_Ref Pack")
                {
                    ApplicationArea = Basic;
                }
                field("Cross_Ref Pack Descr"; Rec."Cross_Ref Pack Descr")
                {
                    ApplicationArea = Basic;
                }
                field("Cross_Ref UPC"; Rec."Cross_Ref UPC")
                {
                    ApplicationArea = Basic;
                }
                field("Cross_Ref Inactive"; Rec."Cross_Ref Inactive")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Item Decription';
                }
                field("Item No. Pack"; Rec."Item No. Pack")
                {
                    ApplicationArea = Basic;
                }
                field("Item No. Pack Descr"; Rec."Item No. Pack Descr")
                {
                    ApplicationArea = Basic;
                }
                field("Item No. UPC"; Rec."Item No. UPC")
                {
                    ApplicationArea = Basic;
                }
                field("Item Inactive"; Rec."Item Inactive")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Discontinued; Rec.Discontinued)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Cross-Reference Type"; Rec."Reference Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                //Removed
                // field("Discontinue Bar Code"; Rec."Discontinue Bar Code")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
            }
        }
    }

    actions
    {
    }
}

