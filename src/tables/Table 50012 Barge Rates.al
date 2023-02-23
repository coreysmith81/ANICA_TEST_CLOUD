Table 50012 "Barge Rates"
{

    fields
    {
        field(1;"Barge Zone";Code[10])
        {
            TableRelation = "Barge Zone".Code;
        }
        field(2;"Freight Code";Code[10])
        {
            TableRelation = "Freight Code"."Freight Code";
        }
        field(3;Carrier;Code[10])
        {
            TableRelation = Carrier.Code;
        }
        field(10;"Rate per pound";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Barge Zone","Freight Code",Carrier)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

