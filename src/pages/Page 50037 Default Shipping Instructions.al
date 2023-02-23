Page 50037 "Default Shipping Instructions"
{
    PageType = List;
    SourceTable = "Default Shipping Table";
    SourceTableView = sorting("FOB Code", "Store No.", "Vendor No.", "Shipping Instruction")
                      order(ascending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("FOB Code"; Rec."FOB Code")
                {
                    ApplicationArea = Basic;
                }
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Customer List";
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Vendor List";
                }
                field("Shipping Instruction"; Rec."Shipping Instruction")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Shipping Instructions";
                }
                field("Drop Ship Location"; Rec."Drop Ship Location")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Locations with Warehouse List";
                }
                field("Freight Code"; Rec."Freight Code")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Shipping Instructions";
                }
            }
        }
    }

    actions
    {
    }
}

