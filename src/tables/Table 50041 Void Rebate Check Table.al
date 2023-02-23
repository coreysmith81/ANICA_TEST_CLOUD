Table 50041 "Void Rebate Check Table"
{

    fields
    {
        field(1;"Check No.";Code[20])
        {
        }
        field(2;"Void Date";Date)
        {
        }
        field(3;"AP Credit Processed";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Check No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

