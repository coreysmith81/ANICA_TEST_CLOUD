Table 50018 "Catalog Group Codes"
{
    DrillDownPageID = "Catalog Group Code";
    LookupPageID = "Catalog Group Code";

    fields
    {
        field(1; "Catalog Group Codes"; Code[10])
        {
            Description = 'Used for catalog printing';
        }
        field(2; Description; Text[60])
        {
        }
        field(3; "Download Selection"; Boolean)
        {
        }
        field(4; "Sort Order"; Code[10])
        {
        }
        field(5; "Groc Sort 1"; Code[10])
        {
        }
        field(6; "Groc Select 1"; Boolean)
        {
        }
        field(7; "Groc Sort 2"; Code[10])
        {
        }
        field(8; "Groc Select 2"; Boolean)
        {
        }
        field(9; "Groc Sort 3"; Code[10])
        {
        }
        field(10; "Groc Select 3"; Boolean)
        {
        }
        field(11; "Groc Sort 4"; Code[10])
        {
        }
        field(12; "Groc Select 4"; Boolean)
        {
        }
        field(13; "Purch Sort 1"; Code[10])
        {
        }
        field(14; "Purch Select 1"; Boolean)
        {
        }
        field(15; "Purch Sort 2"; Code[10])
        {
        }
        field(16; "Purch Select 2"; Boolean)
        {
        }
        field(17; "Purch Sort 3"; Code[10])
        {
        }
        field(18; "Purch Select 3"; Boolean)
        {
        }
        field(19; "Purch Sort 4"; Code[10])
        {
        }
        field(20; "Purch Select 4"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Catalog Group Codes")
        {
            Clustered = true;
        }
        key(Key2; "Sort Order", "Catalog Group Codes")
        {
        }
        key(Key3; "Groc Sort 1", "Catalog Group Codes")
        {
        }
        key(Key4; "Groc Sort 2", "Catalog Group Codes")
        {
        }
        key(Key5; "Groc Sort 3", "Catalog Group Codes")
        {
        }
        key(Key6; "Groc Sort 4", "Catalog Group Codes")
        {
        }
        key(Key7; "Purch Sort 1", "Catalog Group Codes")
        {
        }
        key(Key8; "Purch Sort 2", "Catalog Group Codes")
        {
        }
        key(Key9; "Purch Sort 3", "Catalog Group Codes")
        {
        }
        key(Key10; "Purch Sort 4", "Catalog Group Codes")
        {
        }
    }

    fieldgroups
    {
    }
}

