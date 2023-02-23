Table 50052 "Nonstock Target Retail"
{
    LookupPageID = "Target Retail Lookup";

    fields
    {
        field(1; "Entry No."; Code[20])
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
    }

    keys
    {
        key(Key1; "Entry No.", UPC, Target)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", UPC, Target, Retail)
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

