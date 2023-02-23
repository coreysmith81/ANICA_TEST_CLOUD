tableextension 50009 "Purchase Line" extends "Purchase Line"
{
	fields
	{
	field(50015; Approved; Option) { OptionMembers = ,"On hold",Approved; } 
	field(50016; "Freight"; Boolean) { }
	field(50017; "Date Modified"; Date) { }
	field(50018; "Last User"; Code[20]) { }
}
    var
        myInt: Integer;
}