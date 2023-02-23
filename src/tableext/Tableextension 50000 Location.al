tableextension 50000 Location extends Location
{
    fields
    {
        field(50000; "Department Code"; Code[10]) { }
        field(50001; "Dimension Set ID"; Integer) { }
        field(50002; "test"; Code[10]) { }
    }

    var
        myInt: Integer;
}