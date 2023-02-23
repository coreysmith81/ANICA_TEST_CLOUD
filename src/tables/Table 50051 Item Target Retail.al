Table 50051 "Item Target Retail"
{
    LookupPageID = "Target Retail Lookup";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; UPC; Code[20])
        {
        }
        field(3; Target; Code[10])
        {
            NotBlank = true;
            TableRelation = Target.Target;
        }
        field(4; Retail; Decimal)
        {
        }
        field(5; "Package Retail"; Decimal)
        {
            Description = 'For Random Weight Items';
        }
        field(6; "Date Created"; Date)
        {
        }
        field(7; "Last Modified"; Date)
        {
        }
        field(8; "Last User"; Code[30])
        {
        }
        field(9; Priority; Integer)
        {
            CalcFormula = lookup(Target.Priority where(Target = field(Target)));
            FieldClass = FlowField;
        }
        field(10; Description; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Description = 'A lookup to the Item Table';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Item No.", UPC, Target)
        {
            Clustered = true;
        }
        key(Key2; Retail)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Item No.", UPC, Target, Retail, Priority)
        {
        }
    }

    trigger OnInsert()
    begin
        "Date Created" := Today;
        "Last Modified" := Today;
        "Last User" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Modified" := Today;
        "Last User" := UserId;
    end;
}

