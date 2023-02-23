Table 50026 Group
{
    LookupPageID = "Groups";

    fields
    {
        field(1; Group; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "SMS Department"; Integer)
        {
            TableRelation = "SMS Departments"."SMS Department";
        }
    }

    keys
    {
        key(Key1; Group)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

