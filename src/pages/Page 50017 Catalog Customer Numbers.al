Page 50017 "Catalog Customer Numbers"
{
    PageType = Card;
    SourceTable = "Catalog Customer Numbers";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = Basic;
                    Lookup = true;
                }
                field("Catalog Vendor"; Rec."Catalog Vendor")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor's customer number"; Rec."Vendor's customer number")
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

