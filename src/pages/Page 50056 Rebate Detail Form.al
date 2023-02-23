Page 50056 "Rebate Detail Form"
{
    PageType = List;
    SourceTable = "Rebates Detail";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = true;
                }
            }
        }
    }

    actions
    {
    }
}

