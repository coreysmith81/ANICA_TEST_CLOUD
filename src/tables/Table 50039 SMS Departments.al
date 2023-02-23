Table 50039 "SMS Departments"
{
    LookupPageID = "SMS Departments";

    fields
    {
        field(1; "SMS Department"; Integer)
        {
        }
        field(2; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "SMS Department")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

