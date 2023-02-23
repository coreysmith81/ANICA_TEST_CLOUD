Page 50073 "JBG Price Weekly Lookup"
{
    PageType = List;
    SourceTable = "JBG Price Weekly Table";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("JBG Item No"; Rec."JBG Item No")
                {
                    ApplicationArea = Basic;
                }
                field("Store Number"; Rec."Store Number")
                {
                    ApplicationArea = Basic;
                }
                field("Target Retail"; Rec."Target Retail")
                {
                    ApplicationArea = Basic;
                }
                field("Import Date"; Rec."Import Date")
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

