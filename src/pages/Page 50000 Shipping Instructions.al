Page 50000 "Shipping Instructions"
{
    PageType = List;
    SourceTable = "Shipping Instructions"
;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Kent Instruction"; Rec."Kent Instruction")
                {
                    ApplicationArea = Basic;
                }
                field("Force Retail"; Rec."Force Retail")
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

