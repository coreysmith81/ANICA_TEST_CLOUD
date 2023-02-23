Page 50023 "Telxon Vendor Codes"
{
    PageType = Card;
    SourceTable = "Telxon Vendor Code";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Vendor Code"; Rec."Vendor Code")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Manufacturer; Rec.Manufacturer)
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

