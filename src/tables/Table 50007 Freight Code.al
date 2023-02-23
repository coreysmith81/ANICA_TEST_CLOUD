Table 50007 "Freight Code"
{
    LookupPageID = "Freight Codes";

    fields
    {
        field(1; "Freight Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Air Rate Type"; Code[10])
        {
            TableRelation = "Air Rate Type"."Air Rate Type";
        }
    }

    keys
    {
        key(Key1; "Freight Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

