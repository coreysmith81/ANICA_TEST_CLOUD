Table 50001 "Shipping Instruction Lines"
{

    fields
    {
        field(1;"Shipping Instruction Code";Code[10])
        {
        }
        field(2;"Line No.";Integer)
        {
            FieldClass = Normal;
        }
        field(3;Instruction;Text[60])
        {
        }
    }

    keys
    {
        key(Key1;"Shipping Instruction Code","Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

