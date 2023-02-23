Page 50019 "Purch Catalog Group Code"
{
    PageType = Card;
    SourceTable = "Catalog Group Codes";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Catalog Group Codes"; Rec."Catalog Group Codes")
                {
                    ApplicationArea = Basic;
                }
                field("Purch Sort 1"; Rec."Purch Sort 1")
                {
                    ApplicationArea = Basic;
                }
                field("Purch Select 1"; Rec."Purch Select 1")
                {
                    ApplicationArea = Basic;
                }
                field("Purch Sort 2"; Rec."Purch Sort 2")
                {
                    ApplicationArea = Basic;
                }
                field("Purch Select 2"; Rec."Purch Select 2")
                {
                    ApplicationArea = Basic;
                }
                field("Purch Sort 3"; Rec."Purch Sort 3")
                {
                    ApplicationArea = Basic;
                }
                field("Purch Select 3"; Rec."Purch Select 3")
                {
                    ApplicationArea = Basic;
                }
                field("Purch Sort 4"; Rec."Purch Sort 4")
                {
                    ApplicationArea = Basic;
                }
                field("Purch Select 4"; Rec."Purch Select 4")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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

