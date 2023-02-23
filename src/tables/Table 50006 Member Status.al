Table 50006 "Member Status"
{
    DrillDownPageID = "Member Statuses";
    LookupPageID = "Member Statuses";

    fields
    {
        field(1; "Member Status"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Account No."; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Department Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Member Status")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

