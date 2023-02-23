Page 50046 "SMS Subdepartments"
{
    PageType = Card;
    SourceTable = "SMS Subdepartments";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Sub Department"; Rec."Sub Department")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("SMS Department"; Rec."SMS Department")
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

