Table 50000 "Shipping Instructions"
{
    DrillDownPageID = "Shipping Instructions";
    LookupPageID = "Shipping Instructions";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Instructions; Boolean)
        {
            CalcFormula = exist("Shipping Instruction Lines" where("Shipping Instruction Code" = field(Code)));
            FieldClass = FlowField;
        }
        field(3; Legs; Boolean)
        {
            CalcFormula = exist("Shipping Legs" where("Shipping Instruction Code" = field(Code)));
            FieldClass = FlowField;
        }
        field(4; Description; Text[30])
        {
        }
        field(5; "Kent Instruction"; Boolean)
        {
        }
        field(6; "Force Retail"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ANICA 1-30-09 Add delete routine for legs and instructions//
        /*
        //Mass delete Values
        BargeRateTable.SETCURRENTKEY("Barge Zone","Freight Code",Carrier);
        BargeRateTable.SETRANGE("Barge Zone",ZBargeZone);
        IF BargeRateTable.FIND('-') THEN
        BEGIN
        REPEAT
        //MESSAGE('Barge record %1 %2 %3', BargeRateTable."Barge Zone", BargeRateTable.Carrier  ,BargeRateTable."Rate per pound");
           IF BargeRateTable.Carrier = 'AADEFAULT' THEN
           BEGIN
           BargeRateTable.DELETE(TRUE);
           END;
        UNTIL BargeRateTable.NEXT = 0;
        END;
        BargeRateTable.SETRANGE("Barge Zone");//clear filter
        
           */

    end;
}

