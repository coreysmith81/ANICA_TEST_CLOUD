tableextension 50011 "Gen. Journal Line" extends "Gen. Journal Line"
{
	fields
	{
	field(50000; "Vendor Invoice No."; Code[20]) { }
	field(50001; "Payment Discount"; Decimal) { }
	field(50002; "Freight Amount"; Decimal) { }
}
    var
        myInt: Integer;
}
