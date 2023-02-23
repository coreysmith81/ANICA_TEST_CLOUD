Table 50011 "Air Freight Rates"
{

    fields
    {
        field(1;"Customer No.";Code[10])
        {
            TableRelation = Customer."No.";
        }
        field(3;"Air Rate Type";Code[10])
        {
            TableRelation = "Air Rate Type"."Air Rate Type";
        }
        field(4;Carrier;Code[10])
        {
            TableRelation = Carrier.Code;
        }
        field(5;Origin;Code[10])
        {
            TableRelation = "Origins/Destinations"."Origin/Destination";
        }
        field(6;Destination;Code[10])
        {
            TableRelation = "Origins/Destinations"."Origin/Destination";
        }
        field(10;"Low Flat Rate";Decimal)
        {
        }
        field(11;"High Flat Rate";Decimal)
        {
        }
        field(12;"Rate per pound";Decimal)
        {
        }
        field(13;"Customer Filter";Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(14;"Carrier Filter";Code[10])
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1;"Customer No.","Air Rate Type",Carrier,Origin,Destination)
        {
            Clustered = true;
        }
        key(Key2;Carrier,Origin,Destination,"Air Rate Type")
        {
        }
    }

    fieldgroups
    {
    }
}

