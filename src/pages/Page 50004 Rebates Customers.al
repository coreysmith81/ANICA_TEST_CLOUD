Page 50004 "Rebates Customers"
{
    PageType = Card;
    SourceTable = "Rebates Customers";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Rebate Customer No."; Rec."Rebate Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Rebate Store No."; Rec."Rebate Store No.")
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

