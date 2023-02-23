Page 50026 "Air Rates"
{
    PageType = Card;
    SourceTable = "Air Rate Type";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Air Rate Type"; Rec."Air Rate Type")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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

