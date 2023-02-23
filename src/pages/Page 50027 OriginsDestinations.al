Page 50027 "Origins/Destinations"
{
    PageType = Card;
    SourceTable = "Origins/Destinations";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Origin/Destination"; Rec."Origin/Destination")
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

