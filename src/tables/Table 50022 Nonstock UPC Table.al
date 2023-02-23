Table 50022 "Nonstock UPC Table"
{
    LookupPageID = "NonStock UPC Lookup";

    fields
    {
        field(1; "Nonstock Entry No."; Code[20])
        {
        }
        field(2; UPC; Code[20])
        {
        }
        field(3; "Pack Desc"; Text[30])
        {
        }
        field(4; "Pack Divider"; Decimal)
        {
            InitValue = 1;
        }
        field(5; "Price Multiplier"; Decimal)
        {
            InitValue = 1;
        }
        field(9; "Date Created"; Date)
        {
        }
        field(10; "Last Date Updated"; Date)
        {
        }
        field(16; "Do Not Update SMS Retail"; Boolean)
        {
        }
        field(18; "Print Shelf Tag"; Boolean)
        {
        }
        field(22; Comment; Text[35])
        {
        }
        field(23; "Last User"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Nonstock Entry No.", UPC)
        {
            Clustered = true;
        }
        key(Key2; UPC)
        {
        }
        key(Key3; "Nonstock Entry No.", "Last Date Updated")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date Created" := Today;
        "Last Date Updated" := Today;
        "Last User" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Date Updated" := Today;
        "Last User" := UserId;
    end;
}

