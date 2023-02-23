Page 50036 "Void Rebate Check Form"
{
    PageType = Card;
    SourceTable = "Void Rebate Check Table";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Check No."; Rec."Check No.")
                {
                    ApplicationArea = Basic;
                }
                field("Void Date"; Rec."Void Date")
                {
                    ApplicationArea = Basic;
                    NotBlank = true;
                }
                field("AP Credit Processed"; Rec."AP Credit Processed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

