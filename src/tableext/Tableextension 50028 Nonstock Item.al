tableextension 50028 "Nonstock Item" extends "Nonstock Item"
{
    fields
    {
        field(50000; "Price Files Created"; Boolean) { }
        field(50001; "Telxon Catalog Code"; Code[10]) { }
        field(50002; Pack; Decimal) { }
        field(50003; "Pack Description"; Text[10]) { }
        field(50004; "Commodity Code"; Code[10]) { }
        field(50005; "Parcel Post Code"; Code[10]) { }
        field(50006; "Freight Code"; Code[10]) { }
        field(50007; "Hazardous Code"; Boolean) { }
        field(50008; "Vendor Retail"; Decimal) { }
        field(50009; "Store Landed Cost"; Decimal) { }
        field(50010; "Floating Retail"; Decimal) { }
        field(50011; "Discount Code"; Code[10]) { }
        field(50012; "Minimum Order Qty"; Integer) { }
        field(50013; "Price Factor"; Decimal) { }
        field(50014; "Stock Activity Code"; Code[10]) { }
        field(50015; "Superceding No."; Text[20]) { }
        field(50016; "Vendor Merch Type"; Text[20]) { }
        field(50017; "Vendor Pack"; Integer) { }
        field(50018; "Vendor Price Code"; Code[10]) { }
        field(50019; "Vendor UOM"; Text[10]) { }
        field(50020; "Pick Type"; Option) { OptionMembers = ,Hazardous,Freeze,Dry,Other,"Phone Cards",Pick6,Oils,"Pick Type 2",Snacks,Pop,JBG2740,Chill,Batteries,Ammo,"NR Hazardous",Pick16,Pick17,Tobacco; }
        field(50021; "Standard Fixed Retail"; Decimal) { }
        field(50022; "FOB Code"; Code[10]) { }
        field(50023; "UPC Code"; Code[20]) { }
        field(50024; "Change Indicator"; Text[1]) { }
        field(50025; "Vendor Department"; Text[4]) { }
        field(50026; "Wholesaler Vendor No."; Text[6]) { }
        field(50027; "Do Not Update JBG Retails"; Boolean) { }
        field(50028; "Print Shelf Tag"; Boolean) { }
        field(50029; "Do Not Update SMS"; Boolean) { }
        field(50030; "JBG Commodity Group"; Code[4]) { }
        field(50031; "WIC Flag"; Boolean) { }
        field(50034; "UPC Code for SMS"; Code[20]) { }
        field(50035; "Last User"; Code[20]) { }
        field(50036; "SMS Subdepartment"; Integer) { }
        field(50037; "ANICA Inactive"; Boolean) { }
    }
    var
        myInt: Integer;
}
