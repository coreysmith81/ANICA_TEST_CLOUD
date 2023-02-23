Page 50071 "Customer Targets Lookup"
{
    PageType = List;
    SourceTable = "Customer Target";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
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

