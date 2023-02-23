Table 50054 "Customer Target"
{
    LookupPageID = "Customer Targets Lookup";

    fields
    {
        field(1; "Customer No."; Code[10])
        {
            TableRelation = Customer."No.";
        }
        field(2; Target; Code[10])
        {
            TableRelation = Target.Target;
        }
        field(3; Priority; Integer)
        {
            CalcFormula = lookup(Target.Priority where(Target = field(Target)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Customer No.", Target)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(dropdown; "Customer No.", Target, Priority)
        {
        }
    }
}

