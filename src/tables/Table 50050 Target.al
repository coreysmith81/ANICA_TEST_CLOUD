Table 50050 Target
{

    fields
    {
        field(1;Target;Code[10])
        {
        }
        field(2;Description;Text[30])
        {
        }
        field(3;Priority;Integer)
        {
        }
        field(4;"SMS Update";Boolean)
        {
        }
        field(5;"Intermec Update";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;Target,Priority)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;Target,Description,Priority)
        {
        }
    }
}

