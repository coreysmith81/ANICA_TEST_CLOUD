Report 50016 "Table Creator For PDA files"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = where("ANICA Inactive"=const(false),Blocked=const(false));
            RequestFilterFields = "No.";
            column(ReportForNavId_8129; 8129)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For Progress Bar
                begin
                    CurRec := CurRec + 1;
                    if (TotalRec <> 0) then
                        Window.Update(1,ROUND(CurRec * 10000 / TotalRec,1));
                end;
                
                
                //Item section, all non JBG items with telxon vendor code 1000 and 2000
                //The JBG Items will be imported from the nonstock table separately
                
                VItemNo := '';
                VUPCCode := '';
                VCheckUPC := '';
                VDesc := '';
                VDesc2 := '';
                VTelxVD := '';
                VComCde := '';
                VTextPrice := '';
                VUOM := '';
                VPrice := 0;
                VTextPack := '';
                VPackDescription := '';
                VPack := 0;
                VItemCatCode := '';
                VLastDateUpdated := 0D;
                VIsFound := false;
                VFirstTwo := '';
                
                //Item checks
                if Item."ANICA Inactive" = true then
                    CurrReport.Skip;
                
                if Item.Blocked = true then
                    CurrReport.Skip;
                
                if (Item."Telxon Vendor Code" <> '1000') and (Item."Telxon Vendor Code" <> '3000') and (Item."Telxon Vendor Code" <> '2000') then
                    CurrReport.Skip;
                
                //Get values to put into PDA Export Table
                VItemNo := Item."No.";
                
                //Skip any items with a letter in the item number. JBG items will be added from Nonstock table later.
                if (CopyStr(VItemNo,1,1) <> '0') and (CopyStr(VItemNo,1,1) <> '1') and (CopyStr(VItemNo,1,1) <> '2') and
                   (CopyStr(VItemNo,1,1) <> '3') and (CopyStr(VItemNo,1,1) <> '4') and (CopyStr(VItemNo,1,1) <> '5') and
                   (CopyStr(VItemNo,1,1) <> '6') and (CopyStr(VItemNo,1,7) <> '7') and (CopyStr(VItemNo,1,1) <> '8') and
                   (CopyStr(VItemNo,1,1) <> '9') then
                    CurrReport.Skip;
                
                VDesc := Item.Description;
                VDesc2 := Item."Description 2";
                VTelxVD := Item."Telxon Vendor Code";
                VComCde := Item."Commodity Code";
                VUOM := Item."Catalog UOM";
                VCheckUPC := Item."UPC for SMS";
                VItemCatCode := Item."Item Category Code";
                
                //CS 11-07-13: taking this out because is grabs pack and pack description from UPC table.
                /*//2-15-11 LCC Add Pack and Pack Size
                ItemUOM.SETCURRENTKEY(ItemUOM."Item No.",ItemUOM.Code);
                ItemUOM.SETRANGE(ItemUOM."Item No.",Item."No.");
                ItemUOM.SETRANGE(ItemUOM.Code,Item."Base Unit of Measure");
                
                IF ItemUOM.FIND('-') THEN
                    BEGIN
                        VPack := ItemUOM.Pack;
                        VPackDescription := ItemUOM."Pack Description";
                    END;
                */
                
                //CS 07-11-13: Changing to a look up, rather than secondary data item so it will look at all UPC table records.
                //Lookup item in Item UPC table to get the remaining needed info.
                LookupItemUPCTable;
                
                //Write a record for each UPC, if a valid one is found.
                if VIsFound = true then
                    WritePDATableRecord;
                
                //At this point, the item record is created with the active UPC from the Item card. Next section recreates the record with the
                //++other UPCs from the UPC Table.
                
                //CS 09-06-13: Adding a record for each UPC in the UPC table. Hoping to prevent the majority of the 'item not found'
                if (VItemCatCode = 'GROC') or (VItemCatCode = 'MEAT') or (VItemCatCode = 'PROD') then
                    GetOtherUPCs;

            end;

            trigger OnPostDataItem()
            begin
                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                //For progress bar
                begin
                    Clear(Window);
                    Window.Open('Processing Item Table @1@@@@@@@@');
                    TotalRec := Count;
                    CurRec := 0;
                end;

                //VOrderNumber := 0;
            end;
        }
        dataitem("Nonstock Item";"Nonstock Item")
        {
            DataItemTableView = where("ANICA Inactive"=const(false),"Manufacturer Code"=filter('G'));
            RequestFilterFields = "Entry No.";
            column(ReportForNavId_7742; 7742)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For Progress Bar
                begin
                    CurRec := CurRec + 1;
                    if (TotalRec <> 0) then
                        Window.Update(1,ROUND(CurRec * 10000 / TotalRec,1));
                end;


                //Non-stock section, JBG Items Only

                VItemNo := '';
                VUPCCode := '';
                VCheckUPC := '';
                VDesc := '';
                VDesc2 := '';
                VTelxVD := '';
                VComCde := '';
                VTextPrice := '';
                VUOM := '';
                VPrice := 0;
                VTextPack := '';
                VPackDescription := '';
                VPack := 0;
                VItemCatCode := '';
                VLastDateUpdated := 0D;
                VIsFound := false;


                //Item checks
                if "Nonstock Item"."ANICA Inactive" = true then
                    CurrReport.Skip;

                if "Nonstock Item"."Item No." = '' then
                    CurrReport.Skip;

                //Only get JBG Items
                if "Nonstock Item"."Manufacturer Code" <> 'G' then
                    CurrReport.Skip;

                //Get Item Info
                VItemNo := "Nonstock Item"."Vendor Item No.";
                VSequenceNo := "Nonstock Item"."Entry No.";
                VDesc := "Nonstock Item".Description;
                VDesc2 := '                              ';
                VTelxVD := '3000';
                //VTelxVD := VTelxVD;
                VComCde := "Nonstock Item"."Commodity Code";
                VUOM := "Nonstock Item"."Unit of Measure";
                VCheckUPC := "Nonstock Item"."UPC Code for SMS";
                VItemCatCode := "Nonstock Item"."Item Category Code";

                //Lookup Nonstock UPC Table for the rest of the values.
                LookupNonstockUPCTable;

                //Write a record for each UPC, if a valid one is found.
                if VIsFound = true then
                    WritePDATableRecord;

                //+++At this point, the item record is created with the active UPC from the NS Item card. Next section recreates the record with the
                //+++++other UPCs from the NS UPC Table.

                //CS 09-11-13: Adding a record for each UPC in the NS UPC table. Hoping to prevent the majority of the 'item not found'
                GetOtherNSUPCs;
            end;

            trigger OnPostDataItem()
            begin
                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                //For progress bar
                begin
                    Clear(Window);
                    Window.Open('Processing Nonstock Table @1@@@@@@@@');
                    TotalRec := Count;
                    CurRec := 0;
                end;
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
                    field(VZoneSelect;VZoneSelect)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Select the Zone';
                        OptionCaption = 'Zone 1, Zone 3, Zone N, OPEN';
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
        //To get Zone for Target Lookups
        case VZoneSelect of
        0:VTarget := 'Z01';
        1:VTarget := 'Z03';
        2:VTarget := 'Z0N';
        3:VTarget := ''; //Last was For English Bay.
        4:VTarget := '';
        end;

        //Mainly used to get Name for files that are created.
        case VZoneSelect of
        0:VZone := 'ZONE1';
        1:VZone := 'ZONE3';
        2:VZone := 'ZONEN';
        3:VZone := 'ZONE6'; //Last was for English Bay.
        4:VZone := '';
        end;


        UPCFile.DeleteAll;
        ItemFile.DeleteAll;
    end;

    var
        ItemUOM: Record "Item Unit of Measure";
        UPCFile: Record "PDA Export Table (SKU)";
        ItemFile: Record "PDA Export Table (Item No.)";
        PDAExportCreator: Report "PDA Item File Creator (SKU)";
        ItemUPC: Record "Item UPC Table";
        NonstockUPC: Record "Nonstock UPC Table";
        ItemTarget: Record "Item Target Retail";
        NonstockTarget: Record "Nonstock Target Retail";
        VItemNo: Text[20];
        VDesc: Text[50];
        VDesc2: Text[50];
        VTelxVD: Text[10];
        VComCde: Text[10];
        VPrice: Decimal;
        VUOM: Text[10];
        VUPC: Code[20];
        VItemCatCode: Code[10];
        VLastDateUpdated: Date;
        VLineOUtput: Text[200];
        VFileOUtput: File;
        VFileName: Text[60];
        VTextPrice: Text[16];
        VZero: Text[1];
        VSpace: Text[1];
        VTExtUPC: Text[20];
        VZone: Code[10];
        VZoneSelect: Option;
        VLength: Integer;
        VUPCCode: Code[20];
        VUPCCode12: Code[12];
        VPack: Decimal;
        VPackDescription: Text[30];
        VTextPack: Text[20];
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        VOrderNumber: Integer;
        VCheckUPC: Code[20];
        VSequenceNo: Code[20];
        VIsFound: Boolean;
        VFirstTwo: Code[10];
        VLetterCheck: Integer;
        VTarget: Code[10];
        VNewTargetPriority: Integer;
        VNewTargetRetail: Decimal;
        VTargetRetail: Decimal;


    procedure WritePDATableRecord()
    begin
        //Make UPC codes consistent
        //Get length of UPC Code
        VLength := StrLen(VUPCCode);
        case VLength of
            1:VUPCCode := '000000000000' + VUPCCode;
            2:VUPCCode := '00000000000' + VUPCCode;
            3:VUPCCode := '0000000000' + VUPCCode;
            4:VUPCCode := '000000000' + VUPCCode;
            5:VUPCCode := '00000000' + VUPCCode;
            6:VUPCCode := '0000000' + VUPCCode;
            7:VUPCCode := '000000' + VUPCCode;
            8:VUPCCode := '00000' + VUPCCode;
            9:VUPCCode := '0000' + VUPCCode;
            10:VUPCCode := '000' + VUPCCode;
            11:VUPCCode := '00' + VUPCCode;
            12:VUPCCode := '0' + VUPCCode;
            else VUPCCode := CopyStr(VUPCCode,1,13);
        end;

        VUPCCode12 := CopyStr(VUPCCode,2,13);

        ItemFile.SetCurrentkey("Item Number");
        ItemFile.SetRange("Item Number",VItemNo);

        if not ItemFile.Find('-') then
            begin
                ItemFile.Init;
                ItemFile."Item Number" := VItemNo;
                ItemFile.Insert(true);
                ItemFile.SKU := VUPCCode;
                ItemFile.Vendor := VTelxVD;
                ItemFile.Description := VDesc + VDesc2;
                ItemFile.Type := VComCde;
                ItemFile.Price := ROUND(VPrice,0.01);
                ItemFile.UOM := VUOM;
                ItemFile.Pack := VPack;
                ItemFile.Space := ' ';
                ItemFile."Pack Description" := VPackDescription;
                ItemFile.Modify(true);
            end;


        UPCFile.SetCurrentkey(SKU);
        UPCFile.SetRange(SKU,VUPCCode);

        if UPCFile.Find('-') then
            begin
                if UPCFile.Vendor <> '1000' then
                    begin
                        UPCFile.SKU := VUPCCode;
                        UPCFile."Item Number" := VItemNo;
                        UPCFile.Description := VDesc + VDesc2;
                        UPCFile.Vendor := VTelxVD;
                        UPCFile.Type := VComCde;
                        UPCFile.Price := ROUND(VPrice,0.01);
                        UPCFile.UOM := VUOM;
                        UPCFile.Pack := VPack;
                        UPCFile.Space := ' ';
                        UPCFile."Pack Description" := VPackDescription;
                        UPCFile.Modify(true);
                    end;
            end
        else
            begin
                UPCFile.Init;
                UPCFile.SKU := VUPCCode;
                UPCFile.Insert(true);
                UPCFile."Item Number" := VItemNo;
                UPCFile.Vendor := VTelxVD;
                UPCFile.Description := VDesc + VDesc2;
                UPCFile.Type := VComCde;
                UPCFile.Price := ROUND(VPrice,0.01);
                UPCFile.UOM := VUOM;
                UPCFile.Pack := VPack;
                UPCFile.Space := ' ';
                UPCFile."Pack Description" := VPackDescription;
                UPCFile.Modify(true);
            end;

        Clear(UPCFile);
    end;


    procedure GetZone() VSendZone: Code[10]
    begin
        VSendZone := VZone;
    end;


    procedure LookupItemUPCTable()
    begin
        ItemUPC.SetCurrentkey("Item No.",UPC);
        ItemUPC.SetRange("Item No.",VItemNo);

        if ItemUPC.Find('-') then

        repeat
            //Ignor blank UPCs, and find the UPC record that matches the item's UPC
            if (ItemUPC.UPC <> '') and (ItemUPC.UPC = VCheckUPC) then
                begin
                    VIsFound := true;

                    //Get UPC code table data
                    VUPCCode := ItemUPC.UPC;
                    VPack := ItemUPC."Pack Divider";
                    VPackDescription := ItemUPC."Pack Descrip";
                    VLastDateUpdated := ItemUPC."Last Date Updated";

                    //Get pricing, Std fixed retail, or Target, or floating

                    //First take std fixed if it exists
                    if Item."Std Fixed Retail" <> 0 then
                        VPrice := Item."Std Fixed Retail";

                    //Next check if there is a target retail
                    LookupItemTarget;

                    //IF there still is no price, use the floating retail
                    if VPrice = 0 then
                        VPrice := Item."Std Floating Retail";
                end
        until (ItemUPC.Next = 0) or (VIsFound = true);

        Clear(ItemUPC);
    end;


    procedure LookupNonstockUPCTable()
    begin
        NonstockUPC.SetCurrentkey("Nonstock Entry No.",UPC);
        NonstockUPC.SetRange("Nonstock Entry No.",VSequenceNo);

        if NonstockUPC.Find('-') then

            repeat
                //Ignore records with blank UPC, and find record with UPC that matches NS record.
                if (NonstockUPC.UPC <> '') and (NonstockUPC.UPC = VCheckUPC) then
                    begin
                        VIsFound := true;

                        //Get UPC Code Data
                        VUPCCode := NonstockUPC.UPC;
                        VPack := NonstockUPC."Pack Divider";
                        VPackDescription := NonstockUPC."Pack Desc";
                        VLastDateUpdated := NonstockUPC."Last Date Updated";

                        if VPrice = 0 then
                            LookupNonstockTarget;
                    end;

            until (NonstockUPC.Next = 0) or (VIsFound = true);
    end;


    procedure GetOtherUPCs()
    begin
        ItemUPC.SetCurrentkey("Item No.",UPC);
        ItemUPC.SetRange("Item No.",VItemNo);

        if ItemUPC.Find('-') then

            repeat
                //Ignor blank UPCs, and find any UPC record that matches the item's active UPC
                if (ItemUPC.UPC <> '') and (ItemUPC.UPC <> VCheckUPC) then
                    begin

                        //Get UPC and Pack info for this UPC.
                        VUPCCode := ItemUPC.UPC;
                        VPack := ItemUPC."Pack Divider";
                        VPackDescription := ItemUPC."Pack Descrip";
                        //VLastDateUpdated := ItemUPC."Last Date Updated";

                        //Get pricing, Std fixed retail, or Target, or floating

                        //Reset Price so the new UPC Table record will be taken here.
                        VPrice := 0;

                        //First take std fixed if it exists
                        if Item."Std Fixed Retail" <> 0 then
                            VPrice := Item."Std Fixed Retail";

                        //Then see if there is a target retail
                        LookupItemTarget;

                        //IF there still is no price, use the floating retail
                        if VPrice = 0 then
                            VPrice := Item."Std Floating Retail";

                        //Write record for this UPC
                        WriteAdditionalPDATableRecord;
                    end
            until (ItemUPC.Next = 0);

        Clear(ItemUPC);
    end;


    procedure GetOtherNSUPCs()
    begin
        NonstockUPC.SetCurrentkey("Nonstock Entry No.",UPC);
        NonstockUPC.SetRange("Nonstock Entry No.",VSequenceNo);

        if NonstockUPC.Find('-') then

            repeat

                //Ignore records with blank UPC, and find record with UPC that matches NS record.
                if (NonstockUPC.UPC <> '') and (NonstockUPC.UPC <> VCheckUPC) then
                    begin

                        //Get UPC Code Data
                        VUPCCode := NonstockUPC.UPC;
                        VPack := NonstockUPC."Pack Divider";
                        VPackDescription := NonstockUPC."Pack Desc";
                        VLastDateUpdated := NonstockUPC."Last Date Updated";

                        //Lookup Nonstock Target Retail
                        LookupNonstockTarget;

                        //Write record for this NS UPC
                        WriteAdditionalPDATableRecord;

                    end;

            until (NonstockUPC.Next = 0);
    end;


    procedure WriteAdditionalPDATableRecord()
    begin
        //Make UPC codes consistent
        //Get length of UPC Code
        VLength := StrLen(VUPCCode);
        case VLength of
            1:VUPCCode := '000000000000' + VUPCCode;
            2:VUPCCode := '00000000000' + VUPCCode;
            3:VUPCCode := '0000000000' + VUPCCode;
            4:VUPCCode := '000000000' + VUPCCode;
            5:VUPCCode := '00000000' + VUPCCode;
            6:VUPCCode := '0000000' + VUPCCode;
            7:VUPCCode := '000000' + VUPCCode;
            8:VUPCCode := '00000' + VUPCCode;
            9:VUPCCode := '0000' + VUPCCode;
            10:VUPCCode := '000' + VUPCCode;
            11:VUPCCode := '00' + VUPCCode;
            12:VUPCCode := '0' + VUPCCode;
            else VUPCCode := CopyStr(VUPCCode,1,13);
        end;

        VUPCCode12 := CopyStr(VUPCCode,2,13);

        //Writing only additional records for the UPC sorted table. Item sorted table entries are not necessary.
        UPCFile.SetCurrentkey(SKU);
        UPCFile.SetRange(SKU,VUPCCode);

        if not UPCFile.Find('-') then
            begin
                UPCFile.Init;
                UPCFile.SKU := VUPCCode;
                UPCFile.Insert(true);
                UPCFile."Item Number" := VItemNo;
                UPCFile.Vendor := VTelxVD;
                UPCFile.Description := VDesc + VDesc2;
                UPCFile.Type := VComCde;
                UPCFile.Price := ROUND(VPrice,0.01);
                UPCFile.UOM := VUOM;
                UPCFile.Pack := VPack;
                UPCFile.Space := ' ';
                UPCFile."Pack Description" := VPackDescription;
                UPCFile.Modify(true);
            end;

        Clear(UPCFile);
    end;


    procedure LookupItemTarget()
    begin
        Clear(VTargetRetail);

        //CS 03-22-2017: Look up Item No./UPC/Target combo to see if the retail exists.
        ItemTarget.SetCurrentkey("Item No.",UPC,Target);
        ItemTarget.SetRange("Item No.",VItemNo);
        ItemTarget.SetRange(UPC,VUPCCode);
        ItemTarget.SetRange(Target,VTarget);

        if ItemTarget.Find('-') then
            VTargetRetail := ItemTarget.Retail;

        if VTargetRetail <> 0 then
            VPrice := VTargetRetail
        else
            VPrice := 0;

        Clear(ItemTarget);
    end;


    procedure LookupNonstockTarget()
    begin

        Clear(VTargetRetail);

        //CS 03-22-2017: Look up Item No./UPC/Target combo to see if the retail exists.
        NonstockTarget.SetCurrentkey("Entry No.",UPC,Target);
        NonstockTarget.SetRange("Entry No.",VSequenceNo);
        NonstockTarget.SetRange(UPC,VUPCCode);
        NonstockTarget.SetRange(Target,VTarget);

        if NonstockTarget.Find('-') then
            VTargetRetail := NonstockTarget.Retail;

        if VTargetRetail <> 0 then
            VPrice := VTargetRetail
        else
            VPrice := 0;

        Clear(NonstockTarget);
    end;
}

