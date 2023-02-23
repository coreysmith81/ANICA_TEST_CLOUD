Table 50016 "SMS Subdepartments"
{
    LookupPageID = "SMS Subdepartments";

    fields
    {
        field(1; "Sub Department"; Integer)
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "SMS Department"; Integer)
        {
            TableRelation = "SMS Departments"."SMS Department";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
        }
    }

    keys
    {
        key(Key1; "Sub Department")
        {
            Clustered = true;
        }
        key(Key2; "SMS Department")
        {
        }
    }

    fieldgroups
    {
    }
}

