Page 50064 "Rebate Customers Lookup by No."
{
    Editable = false;
    PageType = Card;
    SourceTable = "Rebates Customers";
    SourceTableView = sorting("Rebate Store No.", "Rebate Customer No.")
                      order(ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Rebate Store No."; Rec."Rebate Store No.")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                    Editable = true;
                    Lookup = false;
                }
                field("Rebate Customer No."; Rec."Rebate Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := false;
    end;
}

