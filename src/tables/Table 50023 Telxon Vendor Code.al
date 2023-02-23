Table 50023 "Telxon Vendor Code"
{
    LookupPageID = "Telxon Vendor Codes";

    fields
    {
        field(1; "Vendor Code"; Code[10])
        {
        }
        field(2; Name; Text[30])
        {
        }
        field(3; Manufacturer; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Vendor Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

