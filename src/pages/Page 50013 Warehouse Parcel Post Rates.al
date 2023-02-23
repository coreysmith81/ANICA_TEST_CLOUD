Page 50013 "Warehouse Parcel Post Rates"
{
    PageType = Card;
    SourceTable = "Warehouse Parcel Post Rates";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Parcel Post Zone"; Rec."Parcel Post Zone")
                {
                    ApplicationArea = Basic;
                }
                field("Priority Type"; Rec."Priority Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Rate per pound"; Rec."Rate per pound")
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

