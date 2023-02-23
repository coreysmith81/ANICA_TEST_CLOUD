Table 50015 "Parcel Post Code"
{
    LookupPageID = "Parcel Post Codes";

    fields
    {
        field(1; "Parcel Post Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Parcel Post Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

