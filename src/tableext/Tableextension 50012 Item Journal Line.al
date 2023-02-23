tableextension 50012 "Item Journal Line" extends "Item Journal Line"
{
    fields
    {
        field(50000; Store; Code[10]) { }
        field(50001; "Telxon Vendor No."; Code[10]) { }
        field(50002; "Order Type 2"; Option) { OptionMembers = Barge,Supplemental,Seasonal,Promotional,Fuel,Equipment; }
        field(50003; "Telxon Item No."; Code[20]) { }
        field(50004; "Shelf/Bin No."; Code[10]) { }
        field(50005; "Telxon Variant Code"; Code[10]) { }
        field(50006; "Vendor No."; Code[20]) { } //ANICA from Item Table
        field(50007; "Inventory Count Order"; Integer) { }
    }
    var
        myInt: Integer;
}
