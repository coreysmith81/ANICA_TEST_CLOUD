tableextension 50021 "Requisition Line" extends "Requisition Line"
{
    fields
    {
        field(50000; Approved; Option) { OptionMembers = ,"On Hold",Approved; }
        field(50001; "Shipping Instruction Code"; Code[10]) { }
        field(50003; "Approval User"; Code[20]) { }
    }
    var
        myInt: Integer;
}