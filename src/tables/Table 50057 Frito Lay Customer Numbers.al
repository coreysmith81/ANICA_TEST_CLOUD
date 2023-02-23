Table 50057 "Frito Lay Customer Numbers"
{

    fields
    {
        field(1;"Customer No.";Code[10])
        {
            FieldClass = Normal;
            TableRelation = Customer."No.";
        }
        field(2;"SAP No.";Code[10])
        {
        }
        field(3;"CIS No.";Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Customer No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

