Table 50034 "ANICA-JBG Commodity Codes"
{
    LookupPageID = "JBG Commodity Groups";


    fields
    {
        field(1; "JBG Commodity Group"; Code[10])
        {
        }
        field(2; "ANICA Commodity Code"; Code[10])
        {
            TableRelation = "Commodity Code"."Commodity Code" where("Commodity Code" = field("ANICA Commodity Code"));

            trigger OnValidate()
            begin
                //>ANICA 5-23-11
                //Add Commodity Code Description to table
                if CommodityTable.Get("ANICA Commodity Code") then begin
                    "ANICA Description" := CommodityTable.Description;
                end;
            end;
        }
        field(3; "JBG Description"; Text[60])
        {
        }
        field(4; "ANICA Description"; Text[60])
        {
        }
        field(5; "Pick Type"; Option)
        {
            OptionMembers = " ",Hazardous,Freeze,Dry,Other,"Phone Cards",Pick6,Oils,"Pick Type 2",Snacks,Pop,JBG2740,Chill,Batteries,Firearms,"NR Hazardous",Pick16,"USPS Direct",Tobacco;
        }
        field(7; "Date Added"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "JBG Commodity Group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CommodityTable: Record "Commodity Code";
}

