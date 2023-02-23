tableextension 50003 "Cust. Ledger Entry"
 extends "Cust. Ledger Entry"

{
    fields
    {
        field(50000; "Store Use"; Decimal) { }
        field(50001; "Snow Machines"; Decimal) { }
        field(50002; "Convert Store Use"; Boolean) { }
    }

    var
        myInt: Integer;
}