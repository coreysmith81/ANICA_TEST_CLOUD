Table 50042 "Store Bank Account Numbers"
{

    fields
    {
        field(1;"Account No.";Code[20])
        {
        }
        field(2;"Store Name";Text[30])
        {
        }
        field(3;"Store Number";Code[5])
        {
        }
        field(4;"Navision Customer No.";Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

