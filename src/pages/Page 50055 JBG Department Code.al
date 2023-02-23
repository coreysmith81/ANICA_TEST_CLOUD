Page 50055 "JBG Department Code"
{
    PageType = Card;
    SourceTable = "JBG Department Codes";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic;
                }
                field("Department Description"; Rec."Department Description")
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

