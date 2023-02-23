Page 50072 "Commodity Code Cross Reference"
{
    PageType = Card;
    SourceTable = "ANICA Commodity Code Cross Ref";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Old ANICA Commodity Code"; Rec."Old ANICA Commodity Code")
                {
                    ApplicationArea = Basic;
                }
                field("New ANICA Commodity Code"; Rec."New ANICA Commodity Code")
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

