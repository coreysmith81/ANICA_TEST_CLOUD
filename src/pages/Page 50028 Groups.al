Page 50028 Groups
{
    PageType = Card;
    SourceTable = "Group";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Group; Rec.Group)
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

