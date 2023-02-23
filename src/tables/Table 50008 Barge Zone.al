Table 50008 "Barge Zone"
{
    LookupPageID = "Barge Zones";


    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

