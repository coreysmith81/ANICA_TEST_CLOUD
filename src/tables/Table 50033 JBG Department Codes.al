Table 50033 "JBG Department Codes"
{
    LookupPageID = "JBG Department Code";

    fields
    {
        field(1; "Department Code"; Code[10])
        {
            //TableRelation = "Nonstock UPC Table".Field30; //It was this way in NAV, but there is no field 30 in NS UPC Table.
        }
        field(2; "Department Description"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Department Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

