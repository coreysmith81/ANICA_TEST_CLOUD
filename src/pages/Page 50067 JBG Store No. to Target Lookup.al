Page 50067 "JBG Store No. to Target Lookup"
{
    PageType = List;
    SourceTable = "JBG Store No. to Target";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("JBG Store No."; Rec."JBG Store No.")
                {
                    ApplicationArea = Basic;
                }
                field(Target; Rec.Target)
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

