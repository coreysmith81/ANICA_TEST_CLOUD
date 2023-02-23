Table 50037 "Tobacco Tax Return - Sales"
{

    fields
    {
        field(1;"Invoice No.";Code[10])
        {
        }
        field(2;"Business Name";Text[60])
        {
        }
        field(3;"Customer Number";Code[10])
        {
        }
        field(4;"Invoice Date";Date)
        {
        }
        field(5;"Number of Cigarettes";Decimal)
        {
        }
        field(6;"OTP Wholesale Price";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Invoice No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

