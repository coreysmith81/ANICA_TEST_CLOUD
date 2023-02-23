Table 50019 "Default Shipping Table"
{

    fields
    {
        field(1;"FOB Code";Code[3])
        {
        }
        field(2;"Store No.";Code[7])
        {
            TableRelation = Customer."No." where ("Customer Posting Group"=filter(<>'BETHEL'));
        }
        field(3;"Vendor No.";Code[7])
        {
            TableRelation = Vendor."No.";
        }
        field(4;"Shipping Instruction";Code[3])
        {
            TableRelation = "Shipping Instructions".Code;
        }
        field(5;"Drop Ship Location";Code[10])
        {
            TableRelation = Location;
        }
        field(6;"Freight Code";Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"FOB Code","Store No.","Vendor No.","Shipping Instruction")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

