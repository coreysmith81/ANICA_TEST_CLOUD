Table 50024 "Air Rate Type"
{
    LookupPageID = "Air Rates";

    fields
    {
        field(1; "Air Rate Type"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Air Rate Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

