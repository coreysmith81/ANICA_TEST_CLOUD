Page 50009 Carriers
{
    PageType = Card;
    SourceTable = Carrier;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Pivot Pounds (Air Freight)"; Rec."Pivot Pounds (Air Freight)")
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

