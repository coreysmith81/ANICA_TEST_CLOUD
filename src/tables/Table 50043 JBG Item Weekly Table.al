Table 50043 "JBG Item Weekly Table"
{

    fields
    {
        field(1;NCoGroup;Text[4])
        {
        }
        field(2;"Vendor Item No";Code[10])
        {
        }
        field(3;Pack;Integer)
        {
        }
        field(4;"Pack Descrip";Text[10])
        {
        }
        field(5;Description;Text[30])
        {
        }
        field(6;"Gross Weight";Decimal)
        {
        }
        field(7;Blank;Text[1])
        {
        }
        field(8;"Post Indicator";Code[1])
        {
        }
        field(9;Hazardous;Code[1])
        {
        }
        field(10;FoodNFood;Code[1])
        {
        }
        field(11;"Unit Price";Decimal)
        {
        }
        field(12;"Price Allow";Decimal)
        {
        }
        field(13;Target;Decimal)
        {
        }
        field(14;UPC;Text[12])
        {
        }
        field(15;Change;Code[1])
        {
        }
        field(16;Dept;Code[4])
        {
        }
        field(17;Vendor;Code[6])
        {
        }
        field(18;Discontinued;Code[1])
        {
        }
        field(19;"Import Date";Date)
        {
        }
        field(20;"Target Retail";Decimal)
        {
            TableRelation = "JBG Price Weekly Table"."Target Retail" where ("JBG Item No"=field("Vendor Item No"));
        }
        field(21;"Zone 3";Decimal)
        {
        }
        field(22;"Zone N";Decimal)
        {
        }
        field(23;"Cap 075";Decimal)
        {
        }
        field(24;"Percent Change";Decimal)
        {
        }
        field(25;"Price Change";Decimal)
        {
        }
        field(26;"Warehouse Dept.";Code[3])
        {
        }
    }

    keys
    {
        key(Key1;"Import Date","Vendor Item No")
        {
            Clustered = true;
        }
        key(Key2;UPC)
        {
        }
        key(Key3;"Vendor Item No")
        {
        }
        key(Key4;"Percent Change")
        {
        }
        key(Key5;NCoGroup)
        {
        }
    }

    fieldgroups
    {
    }
}

