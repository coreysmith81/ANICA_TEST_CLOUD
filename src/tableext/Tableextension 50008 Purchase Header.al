tableextension 50008 "Purchase Header" extends "Purchase Header"
{
	fields
	{
	field(50003; Approved; Option) { OptionMembers = ,"On hold",Approved; } 
	field(50004; "ANICA Confirmed"; Option) { OptionMembers = ,Phone,Fax,EDI,Special,Email,Other; } 
	field(50005; "Shipping Instruction Code"; Code[10]) { }
	field(50006; "Count Received"; Decimal) { }
	field(50007; "ANICA Date Received"; Date) { }
	field(50008; "Received By"; Code[10]) { }
	field(50009; Discrepancies; Boolean) { }
	field(50010; "Pick Ticket Printed"; Integer) { }
	field(50011; "Batch Post"; Boolean) { }
	field(50012; "Freight Amount"; Decimal) { }
	field(50013; "Batch ID"; Code[10]) { }
	field(50014; "Backorder Checkmark"; Boolean) { }
	field(50015; "Pick Type"; Option) { OptionMembers =  ,Hazardous,"Freeze/Chill",Dry,Other,"Phone Cards",Tobacco,Oils,"Pick Type 2",Snacks,Pop; } 
	field(50016; "Approval User"; Code[20]) { }
	field(50017; "Last User"; Code[20]) { }
	field(50018; "Date Modified"; Date) { }
	field(50019; "Special Note"; Text[50]) { }
}
    var
        myInt: Integer;
}
