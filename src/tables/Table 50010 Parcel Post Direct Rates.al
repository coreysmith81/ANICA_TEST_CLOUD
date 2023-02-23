Table 50010 "Parcel Post Direct Rates"
{

    fields
    {
        field(1;"Commodity Code";Code[10])
        {
            TableRelation = "Commodity Code"."Commodity Code";
        }
        field(2;"Sea or Anch";Option)
        {
            OptionMembers = Seattle,Anchorage,Bypass;
        }
        field(3;Priority;Boolean)
        {
        }
        field(10;"Rate per dollar";Decimal)
        {
        }
        field(11;"Priority Type";Option)
        {
            OptionMembers = " ",Priority,Tobacco;
        }
        field(12;"Last User";Code[50])
        {

            trigger OnValidate()
            begin
                "Last User" := UserId;
                Modify;
            end;
        }
        field(13;"Last Date";Date)
        {

            trigger OnValidate()
            begin
                "Last Date" := Today;
                Modify;
            end;
        }
    }

    keys
    {
        key(Key1;"Commodity Code","Sea or Anch","Priority Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //"Last User" := USERID;
        //"Last Date" := TODAY;
        //MODIFY;
    end;

    trigger OnModify()
    begin
        "Last User" := UserId;
        "Last Date" := Today;
        Modify;
    end;
}

