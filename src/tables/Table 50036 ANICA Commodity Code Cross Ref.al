Table 50036 "ANICA Commodity Code Cross Ref"
{

    fields
    {
        field(1;"Old ANICA Commodity Code";Code[10])
        {
        }
        field(2;"New ANICA Commodity Code";Code[10])
        {
        }
        field(3;Description;Text[60])
        {
        }
    }

    keys
    {
        key(Key1;"Old ANICA Commodity Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

