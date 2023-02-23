Page 50076 "Margin Category Lookup"
{
    PageType = List;
    SourceTable = "Margin Category";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Margin Category"; Rec."Margin Category")
                {
                    ApplicationArea = Basic;
                }
                field(Margin; Rec.Margin)
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

