Table 50002 "Shipping Legs"
{

    fields
    {
        field(1;"Shipping Instruction Code";Code[10])
        {
        }
        field(2;"Line No.";Decimal)
        {
        }
        field(3;Leg;Text[30])
        {
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(4;"Calculation Type";Option)
        {
            OptionMembers = "Parcel Post Direct","Air Freight",Barge,"Warehouse Parcel Post","Steam Ship or Truck";
        }
        field(5;"Freight Account";Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(6;Carrier;Code[10])
        {
            TableRelation = Carrier.Code;
        }
        field(7;Origin;Code[10])
        {
            TableRelation = "Origins/Destinations"."Origin/Destination";
        }
        field(8;Destination;Code[10])
        {
            TableRelation = "Origins/Destinations"."Origin/Destination";
        }
        field(9;"Sea or Anch";Option)
        {
            OptionMembers = Seattle,Anchorage,Bypass;
        }
        field(10;Priority;Boolean)
        {
        }
        field(11;"Priority Type";Option)
        {
            OptionMembers = " ",Priority,Tobacco,"Priority L48";
        }
    }

    keys
    {
        key(Key1;"Shipping Instruction Code","Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Shipping Instruction Code","Calculation Type","Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

