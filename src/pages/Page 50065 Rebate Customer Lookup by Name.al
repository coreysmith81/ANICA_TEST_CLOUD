Page 50065 "Rebate Customer Lookup by Name"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Rebates Customers";
    SourceTableView = sorting("Rebate Store No.", "Customer Name")
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
        CurrPage.LookupMode := true;
    end;
}

