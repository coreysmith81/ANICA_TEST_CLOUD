Page 50014 "Steam Ship or Truck Rates"
{
    PageType = List;
    SourceTable = "Steam Ship or Truck Rates";

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
                field("Rate per Pound"; Rec."Rate per Pound")
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

