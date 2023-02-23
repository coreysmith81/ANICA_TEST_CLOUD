tableextension 50027 "Item Cross Reference" extends "Item Cross Reference"
{
    fields
    {
        field(50000; Discontinued; Boolean) { }
        field(50001; "Cross_Ref Pack"; Decimal) { }
        field(50002; "Cross_Ref UPC"; Code[20]) { }
        field(50003; "Cross_Ref UOM"; Code[10]) { }
        field(50004; "Item No. Pack Descr"; Text[30]) { }
        field(50005; "Item No. Pack"; Decimal) { }
        field(50006; "Item No. UPC"; Code[20]) { }
        field(50007; "Cross_Ref Pack Descr"; Text[30]) { }
        field(50008; "Cross_Ref Desc"; Text[30]) { }
        field(50009; "Cross_Ref Inactive"; Boolean) { }
        field(50010; "Item Inactive"; Boolean) { }
        field(50011; "ANICA Cross Type"; Option) { OptionMembers = ,DIRECT,PACK,DISCO,"SET SUB",SEASONAL; }
        field(50012; "Date Added"; Date) { }
    }
    var
        myInt: Integer;
}