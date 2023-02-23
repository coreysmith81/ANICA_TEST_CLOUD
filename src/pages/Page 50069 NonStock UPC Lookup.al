Page 50069 "NonStock UPC Lookup"
{
    PageType = List;
    SourceTable = "Nonstock UPC Table";

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
                field("Nonstock Entry No."; Rec."Nonstock Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field("Pack Desc"; Rec."Pack Desc")
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

