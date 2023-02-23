Table 50025 "Origins/Destinations"
{
    LookupPageID = "Origins/Destinations";

    fields
    {
        field(1; "Origin/Destination"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Origin/Destination")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

