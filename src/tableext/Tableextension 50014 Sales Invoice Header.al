tableextension 50014 "Sales Invoice Header" extends "Sales Invoice Header"
{
	fields
	{
	field(50000; "Shipping Instruction Code"; Code[10]) { }
	field(50001; "Insurance Rate"; Decimal) { }
	field(50002; "Sales Order Type"; Option) { OptionMembers = Barge,Supplemental,Seasonal,Promotional,Fuel,Equipment; }
	field(50012; "Ice Cream Boxes"; Integer) { }
	field(50019; "Ready to Invoice"; Boolean) { }
	field(50021; "Repack Boxes"; Integer) { }
	field(50022; "Approval User"; Code[20]) { }
	field(50023; "Last User"; Code[20]) { }
	field(50024; "Date Changed"; Date) { }
	field(50025; "Release Date"; Date) { } //CS 9-24-14: Added Per Gina to keep the order release date.
	field(50034; "Order Created Date"; Date) { }
	field(50035; "Special Note"; Text[50]) { }
}
    var
        myInt: Integer;
}
