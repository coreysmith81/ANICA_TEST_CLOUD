Table 50003 "Sales Line Freight"
{
    DrillDownPageID = "Sales Line Freights";
    LookupPageID = "Sales Line Freights";

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type") //Changed from Option
        {
            //OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order";
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Line No."; Integer)
        {
        }
        field(5; "Leg Sequence"; Integer)
        {
        }
        field(6; "Leg Name"; Text[30])
        {
        }
        field(7; "Freight Account"; Code[10])
        {
        }
        field(8; "Estimated Freight"; Decimal)
        {
        }
        field(9; "Calculation Type"; Option)
        {
            OptionMembers = "Parcel Post Direct","Air Freight",Barge,"Warehouse Parcel Post","Steam Ship or Truck";
        }
        field(10; "Estimated Freight Per Unit"; Decimal)
        {
        }
        field(11; "Freight to Invoice"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Sell-to Customer No.", "Document No.", "Line No.", "Leg Sequence")
        {
            Clustered = true;
            SumIndexFields = "Estimated Freight", "Freight to Invoice", "Estimated Freight Per Unit";
        }
        key(Key2; "Document Type", "Sell-to Customer No.", "Document No.", "Freight Account")
        {
            SumIndexFields = "Estimated Freight", "Freight to Invoice", "Estimated Freight Per Unit";
        }
    }

    fieldgroups
    {
    }
}

