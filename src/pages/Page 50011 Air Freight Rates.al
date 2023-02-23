Page 50011 "Air Freight Rates"
{
    PageType = List;
    SourceTable = "Air Freight Rates"
;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Air Rate Type"; Rec."Air Rate Type")
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
                field("Rate per pound"; Rec."Rate per pound")
                {
                    ApplicationArea = Basic;
                }
                field("Low Flat Rate"; Rec."Low Flat Rate")
                {
                    ApplicationArea = Basic;
                }
                field("High Flat Rate"; Rec."High Flat Rate")
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

