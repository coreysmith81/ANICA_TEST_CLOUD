Page 50045 "SMS Departments"
{
    PageType = Card;
    SourceTable = "SMS Departments";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("SMS Department"; Rec."SMS Department")
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

