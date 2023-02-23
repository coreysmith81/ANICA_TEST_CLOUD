Page 50005 "Commodity Codes"
{
    PageType = Card;
    SourceTable = "Commodity Code";

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("SMS Sub Department"; Rec."SMS Sub Department")
                {
                    ApplicationArea = Basic;
                }
                field(Group; Rec.Group)
                {
                    ApplicationArea = Basic;
                }
                field(Margin; Rec.Margin)
                {
                    ApplicationArea = Basic;
                }
                field("Not Rounding"; Rec."Not Rounding")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}

