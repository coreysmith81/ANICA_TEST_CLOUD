Page 50003 "Sales Line Freights"
{
    AutoSplitKey = true;
    PageType = Card;
    SourceTable = "Sales Line Freight";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Leg Name"; Rec."Leg Name")
                {
                    ApplicationArea = Basic;
                }
                field("Freight Account"; Rec."Freight Account")
                {
                    ApplicationArea = Basic;
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ApplicationArea = Basic;
                }
                field("Estimated Freight"; Rec."Estimated Freight")
                {
                    ApplicationArea = Basic;
                }
                field("Estimated Freight Per Unit"; Rec."Estimated Freight Per Unit")
                {
                    ApplicationArea = Basic;
                }
                field("Freight to Invoice"; Rec."Freight to Invoice")
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

