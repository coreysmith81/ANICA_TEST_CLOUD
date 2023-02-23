Table 50005 "Commodity Code"
{
    LookupPageID = "Commodity Codes";

    fields
    {
        field(1; "Commodity Code"; Code[10])
        {
        }
        field(2; Group; Code[10])
        {
            TableRelation = Group.Group;
        }
        field(3; Description; Text[60])
        {
        }
        field(4; Margin; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;
        }
        field(7; "Not Rounding"; Boolean)
        {
        }
        field(8; "SMS Sub Department"; Integer)
        {
            TableRelation = "SMS Subdepartments"."Sub Department";
        }
    }

    keys
    {
        key(Key1; "Commodity Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

