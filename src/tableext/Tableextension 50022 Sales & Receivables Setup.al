tableextension 50022 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
	fields
	{
	field(50000; "Freight Insurance Acc. No."; Code[20]) { }
	field(50001; "Freight Insurance Rate"; Decimal) { }
	field(50002; "Reserve Acc. No."; Code[20]) { }
	field(50003; "Reserve Department Code"; Code[10]) { }
	field(50004; "Air Freight Minimum"; Decimal) { }
	field(50005; "Air Freight Min - Co Stores"; Decimal) { }
	field(50006; "Order Minimum"; Decimal) { }
	field(50007; "JBG Haz Weight Min"; Decimal) { }
	field(50008; "Store Use Fee"; Decimal) { }
	field(50009; "Tobacco Tax Acc. No."; Code[10]) { }
}
    var
        myInt: Integer;
}
