Page 50006 "Member Statuses"
{
    PageType = Card;
    SourceTable = "Member Status";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Department Code"; Rec.
                "Department Code")
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

