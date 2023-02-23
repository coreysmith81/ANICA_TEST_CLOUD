Page 50068 "Item UPC Lookup"
{
    PageType = List;
    SourceTable = "Item UPC Table";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(UPC; Rec.UPC)
                {
                    ApplicationArea = Basic;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Pack Descrip"; Rec."Pack Descrip")
                {
                    ApplicationArea = Basic;
                }
                field("Pack Divider"; Rec."Pack Divider")
                {
                    ApplicationArea = Basic;
                }
                field("Price Multiplier"; Rec."Price Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field(Retail; Rec.Retail)
                {
                    ApplicationArea = Basic;
                }
                field("Catalogue Select"; Rec."Catalogue Select")
                {
                    ApplicationArea = Basic;
                }
                field("MSA UPC"; Rec."MSA UPC")
                {
                    ApplicationArea = Basic;
                }
                field("Do Not Update SMS Retail"; Rec."Do Not Update SMS Retail")
                {
                    ApplicationArea = Basic;
                }
                field("Print Shelf Tag"; Rec."Print Shelf Tag")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Updated"; Rec."Last Date Updated")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Last User"; Rec."Last User")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Modified by User';
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

