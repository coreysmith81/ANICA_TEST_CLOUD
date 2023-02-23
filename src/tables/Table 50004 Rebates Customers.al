Table 50004 "Rebates Customers"
{
    DataCaptionFields = "Rebate Customer No.";
    DrillDownPageID = "Rebate Customer List";
    LookupPageID = "Rebate Customer List";

    fields
    {
        field(1; "Rebate Customer No."; Integer)
        {
        }
        field(2; "Rebate Store No."; Code[10])
        {
            TableRelation = Customer."No." where("Customer Posting Group" = const('ANICA'));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(3; "Customer Name"; Text[30])
        {
        }
        field(4; Address; Text[30])
        {
        }
        field(5; "Address 2"; Text[30])
        {
        }
        field(6; City; Text[30])
        {
        }
        field(7; State; Text[2])
        {
        }
        field(8; "Zip Code"; Text[10])
        {
        }
        field(12; "Total Purchases $"; Decimal)
        {
            CalcFormula = sum("Rebates Detail".Amount where(Processed = const(false),
                                                             "Customer No." = field("Rebate Customer No."),
                                                             "Store No." = field("Rebate Store No.")));
            FieldClass = FlowField;
        }
        field(13; "First Name"; Text[30])
        {
        }
        field(14; "Last Name"; Text[30])
        {
        }
        field(15; "Risk Level"; Text[2])
        {
        }
        field(16; "Customer Group"; Text[5])
        {
        }
    }

    keys
    {
        key(Key1; "Rebate Store No.", "Rebate Customer No.")
        {
            Clustered = true;
        }
        key(Key2; "Rebate Store No.", "Customer Name")
        {
        }
    }

    fieldgroups
    {
    }
}

