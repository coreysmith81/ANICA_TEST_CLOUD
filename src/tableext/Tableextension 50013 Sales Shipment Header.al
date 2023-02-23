tableextension 50013 "Sales Shipment Header" extends "Sales Shipment Header"
{
	fields
	{
	field(50005; "ISM Total Parcel Post"; Decimal) { }
	field(50006; "ISM Special Handling"; Boolean) { }
	field(50008; "ISM Total Pieces"; Integer) { }
	field(50009; "ISM Total Weight"; Decimal) { }
	field(50010; "ISM Bypass Airline"; Text[30]) { }
	field(50011; "ISM Bypass Time"; Time) { }
	field(50012; "Ice Cream Boxes"; Integer) { }
	field(50016; "ISM Freight Bill No. 2"; Text[10]) { }
	field(50017; "ISM Freight Bill No. 3"; Text[10]) { }
	field(50021; "Repack Boxes"; Integer) { }
}
    var
        myInt: Integer;
}
