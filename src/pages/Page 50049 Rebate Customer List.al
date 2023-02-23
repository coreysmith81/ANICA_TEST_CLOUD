Page 50049 "Rebate Customer List"
{
    PageType = List;
    SourceTable = "Rebates Customers";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Rebate Store No."; Rec."Rebate Store No.")
                {
                    ApplicationArea = Basic;
                }
                field("Rebate Customer No."; Rec."Rebate Customer No.")
                {
                    ApplicationArea = Basic;
                    Lookup = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Customer Group"; Rec."Customer Group")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = Basic;
                }
                field("Zip Code"; Rec."Zip Code")
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

