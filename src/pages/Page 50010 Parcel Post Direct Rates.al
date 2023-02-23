Page 50010 "Parcel Post Direct Rates"
{
    PageType = Card;
    SourceTable = "Parcel Post Direct Rates";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Commodity Code"; Rec."Commodity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Sea or Anch"; Rec."Sea or Anch")
                {
                    ApplicationArea = Basic;
                }
                field("Priority Type"; Rec."Priority Type")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Rate per dollar"; Rec."Rate per dollar")
                {
                    ApplicationArea = Basic;
                }
                field("Last User"; Rec."Last User")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date"; Rec."Last Date")
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

