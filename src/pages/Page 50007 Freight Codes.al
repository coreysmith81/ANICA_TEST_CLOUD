Page 50007 "Freight Codes"
{
    PageType = Card;
    SourceTable = "Freight Code";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Freight Code"; Rec."Freight Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Air Rate Type"; Rec."Air Rate Type")
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

