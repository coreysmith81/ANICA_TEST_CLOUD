tableextension 50006 "Sales Header" extends "Sales Header"

{
    fields
    {
        field(50000; "Shipping Instruction Code"; Code[10]) { }
        field(50001; "Insurance Rate"; Decimal) { }
        field(50002; "Sales Order Type"; Option) { OptionMembers = Barge,Supplemental,Seasonal,Promotional,Fuel,"Store Use"; }
        field(50003; Approved; Option) { OptionMembers = ,"On hold",Approved; }
        field(50004; FreightAmount; Decimal) { }
        field(50005; "ISM Total Parcel Post"; Decimal) { }
        field(50006; "ISM Special Handling"; Boolean) { }
        field(50007; TotalFreightAmount; Decimal) { }
        field(50008; "ISM Total Pieces"; Integer) { }
        field(50009; "ISM Total Weight"; Decimal) { }
        field(50010; "ISM Bypass Airline"; Text[30]) { }
        field(50011; "ISM Bypass Time"; Time) { }
        field(50012; "Ice Cream Boxes"; Integer) { }
        field(50013; "Batch Post"; Boolean) { }
        field(50014; "SalesLines#"; Integer) { }
        field(50015; "Batch ID"; Code[10]) { }
        field(50016; "ISM Freight Bill No. 2"; Text[10]) { }
        field(50017; "ISM Freight Bill No. 3"; Text[10]) { }
        field(50018; "Outstanding Amount"; Decimal) { }
        field(50019; "Ready to Invoice"; Boolean) { }
        field(50021; "Repack Boxes"; Integer) { } //ISM info
        field(50022; "Approval User"; Code[20]) { }
        field(50023; "Last User"; Code[20]) { }
        field(50024; "Date Changed"; Date) { }
        field(50025; "Release Date"; Date) { } //9/24/14: Added per Gina to hold date SO was created.
        field(50034; "Order Created Date"; Date) { }
        field(50035; "Special Notes"; Text[50]) { }

    }

    var
        myInt: Integer;
}
