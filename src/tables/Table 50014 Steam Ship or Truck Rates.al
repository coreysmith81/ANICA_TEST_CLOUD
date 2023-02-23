Table 50014 "Steam Ship or Truck Rates"
{

    fields
    {
        field(1;"Freight Code";Code[10])
        {
            TableRelation = "Freight Code"."Freight Code";
        }
        field(3;Carrier;Code[10])
        {
            TableRelation = Carrier.Code;
        }
        field(4;Origin;Code[10])
        {
            TableRelation = "Origins/Destinations"."Origin/Destination";
        }
        field(5;Destination;Code[10])
        {
            TableRelation = "Origins/Destinations"."Origin/Destination";
        }
        field(10;"Rate per Pound";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Freight Code",Carrier,Origin,Destination)
        {
            Clustered = true;
        }
        key(Key2;Carrier,"Freight Code",Origin,Destination)
        {
        }
    }

    fieldgroups
    {
    }
}

