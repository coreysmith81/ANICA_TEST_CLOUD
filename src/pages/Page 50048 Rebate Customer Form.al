Page 50048 "Rebate Customer Form"
{
    PageType = List;
    SourceTable = "Rebates Customers";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Rebate Store No."; Rec."Rebate Store No.")
                {
                    ApplicationArea = Basic;
                }
                field("Rebate Customer No."; Rec."Rebate Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = Basic;
                }
                field("Zip Code"; Rec."Zip Code")
                {
                    ApplicationArea = Basic;
                }
                field("Total Purchases $"; Rec.
                "Total Purchases $")
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

