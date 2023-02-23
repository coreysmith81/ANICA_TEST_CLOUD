Table 50044 "JBG Price Weekly Table"
{

    fields
    {
        field(1;"JBG Item No";Code[6])
        {
        }
        field(2;"Cap Code";Code[3])
        {
        }
        field(3;"Store Number";Code[4])
        {
        }
        field(4;"Target Retail";Decimal)
        {
        }
        field(5;"Import Date";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Import Date","JBG Item No","Store Number")
        {
            Clustered = true;
        }
        key(Key2;"Import Date","JBG Item No","Cap Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"JBG Item No","Store Number","Target Retail","Import Date")
        {
        }
    }
}

