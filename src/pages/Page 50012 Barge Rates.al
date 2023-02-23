Page 50012 "Barge Rates"
{
    PageType = List;
    SourceTable = "Barge Rates";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Barge Zone"; Rec."Barge Zone")
                {
                    ApplicationArea = Basic;
                }
                field("Freight Code"; Rec."Freight Code")
                {
                    ApplicationArea = Basic;
                }
                field(Carrier; Rec.Carrier)
                {
                    ApplicationArea = Basic;
                }
                field("Rate per pound"; Rec."Rate per pound")
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

