Table 50028 "Rebates Detail"
{
    DataCaptionFields = "Customer No.", "Store No.";
    DrillDownPageID = "Rebate Detail Lookup";
    LookupPageID = "Rebate Detail Lookup";

    fields
    {
        field(1; "Sequence No."; Integer)
        {
        }
        field(2; "Customer No."; Integer)
        {
        }
        field(3; "Store No."; Code[10])
        {
        }
        field(4; Date; Date)
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Processed; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Sequence No.", "Store No.", "Customer No.")
        {
            Clustered = true;
        }
        key(Key2; "Store No.", "Customer No.")
        {
        }
        key(Key3; "Customer No.", "Store No.")
        {
        }
        key(Key4; Processed, "Store No.", "Customer No.")
        {
            SumIndexFields = Amount;
        }
        key(Key5; "Customer No.", Date)
        {
        }
        key(Key6; "Store No.", Date)
        {
        }
    }

    fieldgroups
    {
    }
}

