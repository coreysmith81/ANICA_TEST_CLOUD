Page 50001 "Shipping Instruction Lines"
{
    AutoSplitKey = true;
    PageType = Card;
    SourceTable = "Shipping Instruction Lines";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Instruction; Rec.Instruction)
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

