Table 50013 "Warehouse Parcel Post Rates"
{

    fields
    {
        field(1;"Parcel Post Zone";Code[10])
        {
            TableRelation = "Parcel Post Code"."Parcel Post Code";
        }
        field(2;Priority;Boolean)
        {
        }
        field(10;"Rate per pound";Decimal)
        {
            DecimalPlaces = 2:4;
        }
        field(11;"Priority Type";Option)
        {
            OptionMembers = " ",Priority,Tobacco,"Priority L48";
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
        key(Key1;"Parcel Post Zone","Priority Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        "Last User" := UserId;
        "Last Date" := Today;
        Modify;
    end;
}

