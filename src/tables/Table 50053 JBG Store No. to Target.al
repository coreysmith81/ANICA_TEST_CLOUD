Table 50053 "JBG Store No. to Target"
{

    fields
    {
        field(1;"JBG Store No.";Code[10])
        {
        }
        field(2;Target;Code[10])
        {
            TableRelation = Target.Target;
        }
    }

    keys
    {
        key(Key1;"JBG Store No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

