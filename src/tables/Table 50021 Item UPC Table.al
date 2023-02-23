Table 50021 "Item UPC Table"
{
    LookupPageID = "Item UPC Lookup";

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(2; UPC; Code[20])
        {
        }
        field(3; "Pack Descrip"; Text[30])
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
        field(24; "Catalogue Select"; Boolean)
        {
        }
        field(25; "MSA UPC"; Boolean)
        {
            Description = 'MSA Reporting';
        }
        field(26; Retail; Decimal)
        {
            FieldClass = Normal;
            TableRelation = "Item Target Retail".Retail where("Item No." = field("Item No."),
            UPC = field(UPC));
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Item No.", UPC)
        {
            Clustered = true;
        }
        key(Key2; UPC)
        {
        }
        key(Key3; "Item No.", "Date Created")
        {
        }
        key(Key4; "Item No.", "MSA UPC")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Item No.", UPC, "Pack Descrip", "Pack Divider")
        {
        }
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

