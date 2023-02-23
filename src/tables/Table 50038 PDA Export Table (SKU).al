Table 50038 "PDA Export Table (SKU)"
{

    fields
    {
        field(1;SKU;Code[20])
        {
        }
        field(2;"Item Number";Text[20])
        {
        }
        field(3;Description;Text[60])
        {
        }
        field(4;Vendor;Code[10])
        {
        }
        field(5;Type;Code[10])
        {
        }
        field(6;Price;Decimal)
        {
        }
        field(7;UOM;Code[10])
        {
        }
        field(8;Pack;Decimal)
        {
        }
        field(9;Space;Text[1])
        {
        }
        field(10;"Pack Description";Text[30])
        {
        }
    }

    keys
    {
        key(Key1;SKU)
        {
            Clustered = true;
        }
        key(Key2;"Item Number")
        {
        }
    }

    fieldgroups
    {
    }
}

