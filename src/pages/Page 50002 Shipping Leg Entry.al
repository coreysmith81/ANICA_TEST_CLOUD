Page 50002 "Shipping Leg Entry"
{
    AutoSplitKey = true;
    PageType = Card;
    SourceTable = "Shipping Legs";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Leg; Rec.Leg)
                {
                    ApplicationArea = Basic;
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ApplicationArea = Basic;
                }
                field("Freight Account"; Rec."Freight Account")
                {
                    ApplicationArea = Basic;
                }
                field(Carrier; Rec.Carrier)
                {
                    ApplicationArea = Basic;
                }
                field(Origin; Rec.Origin)
                {
                    ApplicationArea = Basic;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = Basic;
                }
                field("Sea or Anch"; Rec."Sea or Anch")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Priority Type"; Rec."Priority Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Shipping Instruction Code"; Rec."Shipping Instruction Code")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
            }
        }
    }

    actions
    {
    }
}

