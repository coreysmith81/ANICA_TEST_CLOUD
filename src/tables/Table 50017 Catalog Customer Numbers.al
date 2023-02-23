Table 50017 "Catalog Customer Numbers"
{

    fields
    {
        field(1;Customer;Code[10])
        {
            Description = 'Our customer number';
            TableRelation = Customer."No.";
        }
        field(2;"Catalog Vendor";Code[10])
        {
            Description = 'From Manufacturer table';
        }
        field(3;"Vendor's customer number";Code[20])
        {
            Description = 'Same';
        }
    }

    keys
    {
        key(Key1;Customer,"Catalog Vendor")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

