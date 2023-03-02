Report 50125 "Ditomaso Price Sheet Export"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item;Item)
        {
            column(ReportForNavId_8129; 8129)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "ANICA Inactive" = true then
                    CurrReport.Skip;

                //Have to add ("Catalog Group Code" <> 'P205') to add the "Produce Seasonal" items.
                if ("Catalog Group Code" <> 'D300') and ("Catalog Group Code" <> 'P250') and ("Catalog Group Code" <> 'P270') and
                    ("Catalog Group Code" <> 'P240') and ("Catalog Group Code" <> 'P205') and ("Catalog Group Code" <> 'P275') then
                    CurrReport.Skip;

                VCatGroupCode := "Catalog Group Code";
                VDescription := Description;
                VItemNo := "No.";
                VPLUCode := "UPC for SMS";
                //V9thDigit := COPYSTR(VPLUCode,9,1);
                VFirst8Digits := CopyStr(VPLUCode,1,8);

                if (StrLen(VPLUCode) = 12) and (VFirst8Digits = '00000000') then
                    begin
                        VPLUCode := CopyStr(VPLUCode,9,4);
                    end
                else
                    VPLUCode := '****';

                //CS 06-21-12: Changed this to "Unit Price" from "Unit Cost", per Greg.
                VUnitCost := "Unit Price";

                //CS 11-4-16: Switching to looking up in the Target Retail table.
                //GetZoneRetail;

                //CS 11-4-16: Using Target Retail table now.
                VUPC := "UPC for SMS";
                GetTargetRetail;

                GetIUOM;

                GetCatCodeDescription;


                VLineOUtput := VItemNo + '|' + VDescription + '|' + VPackDescription + '|' + VPackCombo + '|' + VPLUCode + '|' +
                     Format(VRetail) + '|' + Format(VUnitCost) + '|' + '____' + '|' + VCatGroupCode + '|' + VCatGroupCodeDescription;
                VFileOUtput.Write(VLineOUtput);
            end;

            trigger OnPostDataItem()
            begin
                Message('The Export File Is At %1',VFileName);
            end;

            trigger OnPreDataItem()
            begin
                VFileName := '\\filestore\Purchasing\Grocery\Produce\Ditomaso\' + 'DitomasoExport' + '.txt';
                //VFileName := '\\filestore\Purchasing\Grocery\Produce\Charlies\' + 'CharliesExport' + '.txt';

                VFileOUtput.Create(VFileName);
                VFileOUtput.TextMode(true);

                SetCurrentkey("Vendor No.");
                SetRange("Vendor No.", 'DITO002');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Select Target";VTarget)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Select Target';
                        OptionCaption = 'Zone 1, Zone 3, Zone N';
                        TableRelation = Target;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        //CASE VZoneSelect OF
        //0:VZone := 'Zone1';
        //1:VZone := 'Zone3';
        //2:VZone := 'ZoneN';
        //END;

        //CASE VCapCodeSelect OF
        //0:VCapCode := '912';
        //1:VCapCode := '075';
        //END;
    end;

    var
        TargetRetail: Record "Item Target Retail";
        ItemUOM: Record "Item Unit of Measure";
        CatGroupCode: Record "Catalog Group Codes";
        VLineOUtput: Text[200];
        VFileOUtput: File;
        VFileName: Text[100];
        VZoneRetail: Decimal;
        VDescription: Text[30];
        VPack: Decimal;
        VPackDescription: Text[30];
        VPackCombo: Text[30];
        VItemNo: Text[30];
        VPLUCode: Text[30];
        VUnitCost: Decimal;
        VZone: Code[10];
        VZoneSelect: Option;
        VCapCode: Code[10];
        VCapCodeSelect: Option;
        V9thDigit: Text[30];
        VFirst8Digits: Text[30];
        VCatGroupCode: Code[10];
        VCatGroupCodeDescription: Text[30];
        VTarget: Code[10];
        VUPC: Code[20];
        VRetail: Decimal;


    procedure GetZoneRetail()
    begin
        //ItemZoneRetail.SETCURRENTKEY("Item No.","Cap Code");
        //ItemZoneRetail.SETRANGE("Item No.",VItemNo);
        //ItemZoneRetail.SETRANGE("Cap Code",VCapCode);

        //IF ItemZoneRetail.FIND('+') THEN
        //    BEGIN
        //        CASE VZone OF
        //            'ZONE1':VZoneRetail := ItemZoneRetail."Fixed Retail Zone 1/2";
        //            'ZONE3':VZoneRetail := ItemZoneRetail."Fixed Retail Zone 3";
        //            'ZONEN':VZoneRetail := ItemZoneRetail."Fixed Retail Zone N";
        //        END
        //    END;
    end;


    procedure GetIUOM()
    begin
        ItemUOM.SetCurrentkey("Item No.",Code);
        ItemUOM.SetRange("Item No.",VItemNo);

        if ItemUOM.Find('-') then
            begin
                VPack := ItemUOM.Pack;
                VPackDescription := ItemUOM."Pack Description";
                VPackCombo := Format(VPack) + '/' + VPackDescription;
            end;
    end;


    procedure GetCatCodeDescription()
    begin
        CatGroupCode.SetCurrentkey("Catalog Group Codes");
        CatGroupCode.SetRange("Catalog Group Codes",VCatGroupCode);

        if CatGroupCode.Find('+') then
            VCatGroupCodeDescription := CatGroupCode.Description;
    end;


    procedure GetTargetRetail()
    begin
        TargetRetail.SetCurrentkey("Item No.",UPC,Target);
        TargetRetail.SetRange("Item No.",VItemNo);
        //TargetRetail.SETRANGE(UPC,VUPC);
        TargetRetail.SetRange(Target,VTarget);

        if TargetRetail.Find('-') then
            VRetail := TargetRetail.Retail
        else
            VRetail := 0;

        Clear(TargetRetail);
    end;
}

