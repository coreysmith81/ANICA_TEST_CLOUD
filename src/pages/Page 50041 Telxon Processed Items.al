Page 50041 "Telxon Processed Items"
{
    PageType = List;
    SourceTable = "Telxon Input File";
    SourceTableView = sorting("Sales Order No.", "Vendor No.", "Order Item No.")
                      order(descending)
                      where(Processed = filter(True));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Processed Date"; Rec."Processed Date")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Caption = 'Order Date';
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = Basic;
                }
                field("WIC Code"; Rec."WIC Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Store; Rec.Store)
                {
                    ApplicationArea = Basic;
                }
                field("Sales Order Quantity"; Rec."Sales Order Quantity")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                }
                field("Order Item No."; Rec."Order Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = Basic;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic;
                }
                field("Telxon Vendor"; Rec."Telxon Vendor")
                {
                    ApplicationArea = Basic;
                }
                field("Store Use"; Rec."Store Use")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Number"; Rec."Customer Number")
                {
                    ApplicationArea = Basic;
                }
                field("Order Type"; Rec."Order Type")
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Import Error"; Rec."Import Error")
                {
                    ApplicationArea = Basic;
                }
                field("Error Remark"; Rec."Error Remark")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Less 1000 lbs"; Rec."Allow Less 1000 lbs")
                {
                    ApplicationArea = Basic;
                }
                field("Allow HAZ Less 100 lbs"; Rec."Allow HAZ Less 100 lbs")
                {
                    ApplicationArea = Basic;
                }
                field("Batch Name"; Rec."Batch Name")
                {
                    ApplicationArea = Basic;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Basic;
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ApplicationArea = Basic;
                }
                field("Import Item No."; Rec."Import Item No.")
                {
                    ApplicationArea = Basic;
                }
                field("Import Quantity"; Rec."Import Quantity")
                {
                    ApplicationArea = Basic;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field("Shipping Code"; Rec."Shipping Code")
                {
                    ApplicationArea = Basic;
                }
                field("FOB Code"; Rec."FOB Code")
                {
                    ApplicationArea = Basic;
                }
                field("Drop Ship"; Rec."Drop Ship")
                {
                    ApplicationArea = Basic;
                }
                field("Pick code"; Rec."Pick code")
                {
                    ApplicationArea = Basic;
                }
                field("Inventory Fill Amount"; Rec."Inventory Fill Amount")
                {
                    ApplicationArea = Basic;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gross Weight"; Rec."Gross Weight")
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

