tableextension 50015 "Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Estimated Freight"; Decimal) { }
        field(50001; "Retail Price Per Unit"; Decimal) { }
        field(50002; "Store Use"; Boolean) { }
        field(50003; "Estimated Margin"; Decimal) { }
        field(50004; "Actual Margin"; Decimal) { }
        field(50005; "Freight Code"; Code[6]) { }
        field(50006; Pack; Decimal) { }
        field(50007; "Pack Description"; Text[10]) { }
        field(50008; "Lost Sales Qty"; Decimal) { }
        field(50009; "Snow Machine"; Boolean) { }
        field(50011; "Calculated Freight Line"; Boolean) { }
        field(50012; "Calculated Insurance Line"; Boolean) { }
        field(50013; "Calculated Reserve Line"; Boolean) { }
        field(50014; "Calculated Fee Line"; Boolean) { }
        field(50015; "Estimated Freight Per Unit"; Decimal) { }
        field(50016; "Invoiced Freight"; Decimal) { }
        field(50020; "Vendor UPC Code"; Code[20]) { }
        field(50021; "Calculated Tobacco Tax Line"; Boolean) { }
        field(50030; "No Insurance"; Boolean) { }
        field(50050; "Purchase2 Order No."; Code[20]) { }
    }
    keys
    {
        key(Key10; "Description") { }
    }
    var
        myInt: Integer;
}
