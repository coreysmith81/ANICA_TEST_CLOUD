Table 50049 "MSA Reporting - PUR"
{

    fields
    {
        field(1; "Customer No."; Code[10])
        {
        }
        field(2; "Customer Shipping No."; Code[10])
        {
        }
        field(3; "Customer Shipping No. Ext."; Code[10])
        {
        }
        field(4; "Item No."; Code[10])
        {
        }
        field(5; "Invoice No."; Code[10])
        {
        }
        field(6; Date; Code[10])
        {
        }
        field(7; Quantity; Decimal)
        {
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Item No.", "Invoice No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

