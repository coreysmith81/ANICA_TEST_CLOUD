Report 50093 "Catalogue Download - Publisher"
{
    // For each item selected based on the selection code:
    // 1. See if a UPC exists in the item UPC table.  If non are marked for catalogue, select the first code.
    //      We do not use the UPC pack or retail information.
    // 2. If a UPC table entry does not exist, see if there is an UPC for SMS value on the item card.
    // 3. If there is a fixed retail, use it
    // 3. If no retail has been selected, look at the zone retail table for that zone.
    // 4. If no retail has been selected, use floating retail
    // 5. If a UPC has not been found, use the UPC on the item card
    // 6. Alway use the pack info from the item unit of measure
    // 
    // ANICA 12/9/08 Remove zero hazardous retail check - per Bill K.
    // 6/14/10 Skip Inactive items - per Gina.

    ProcessingOnly = true;
    ShowPrintStatus = false;

    dataset
    {
        dataitem("Catalog Group Codes";"Catalog Group Codes")
        {
            RequestFilterFields = "Catalog Group Codes";
            column(ReportForNavId_6811; 6811)
            {
            }
            dataitem(Item;Item)
            {
                DataItemLink = "Catalog Group Code"=field("Catalog Group Codes");
                DataItemTableView = sorting(Description) order(ascending);
                column(ReportForNavId_8129; 8129)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Clear Variables
                    VUPC := '';
                    VRetail := 0;
                    VRetailZone1 := 0;
                    VRetailZone3 := 0;
                    VRetailZoneN := 0;
                    PrintRetail := '';
                    PrintPrice := '';
                    PrintPack := '';
                    VPack := 0;
                    VPackDesc := '';
                    PrintCatCode := '';
                    PrintCatTitle := '';
                    PUOM := '      ';

                    //Skip non 1000 catalogue items
                    if Item."Telxon Vendor Code" <> '1000' then
                        CurrReport.Skip;

                    //Skip Non-stock and blocked items
                    if Item."Created From Nonstock Item" = true
                        then CurrReport.Skip;

                    if Item.Blocked = true then
                        CurrReport.Skip;

                    if Item."ANICA Inactive" = true then
                        CurrReport.Skip;

                    if CheckNextCatCode <> Item."Catalog Group Code" then
                        begin
                            PrintCatTitle := "Catalog Group Codes".Description;
                            WriteCategoryRecord;
                        end;

                    PrintCatCode := "Catalog Group Codes"."Catalog Group Codes";
                    PrintCatTitle := "Catalog Group Codes".Description;

                    VDesc1 := Item.Description + ' ' + Item."Description 2";

                    //Find the UPC from the item UPC table
                    LookupItemUPC;

                    //If a UPC has not been selected, get the UPC off the item card
                    if VUPC = '' then VUPC := Item."UPC for SMS";

                    //NOTE: The bar code formula only works for 11 digit bar codes
                    //  We need to reformat any with leading characters
                    //    01/09/11 CS: Changed it to where it will write records with UPC < 10, but only for Hardware section
                    if (SelectionCode = 5) or (SelectionCode = 6) or (SelectionCode = 7) or (SelectionCode = 8) then
                        begin
                            if StrLen(VUPC) < 10 then
                                VUPC := '';
                        end

                    else
                        //10/29/14 CS: Gina requested to have this particular group code be allowed to have no UPC.
                        if (StrLen(VUPC) < 10) and (Item."Catalog Group Code" <> 'Y001') then
                            CurrReport.Skip;

                    //01/06/12 CS: Changes this to  longer than 12 from 11, to account for items that needed leading digits.
                    //Fix strings longer than 12
                    repeat
                        begin
                            if StrLen(VUPC) > 11 then
                                VUPC := CopyStr(VUPC,2,StrLen(VUPC)-1);
                        end
                    until StrLen(VUPC) <= 11;

                    //Select the correct retail
                    //If a standard fixed retail exists, use it
                    if Item."Std Fixed Retail" <> 0 then
                        VRetail := Item."Std Fixed Retail";

                    //IF no retail has been selected, then lookup the Target retails
                    if VRetail = 0 then
                        //CS 11-1-16: Replaced function that looks up Zone retail table, with one that looks up target retail table.
                        LookupTargetRetail;

                    //If no retail exists, then use floating retail
                    if VRetail = 0 then
                        VRetail := Item."Std Floating Retail";

                    //If no retail has been found, reject the entry
                    if VRetail = 0 then
                        CurrReport.Skip;

                    VRetail := ROUND(VRetail,0.01);
                    PrintRetail := Format(VRetail,6,'<Integer><Decimal,3>');

                    //IGet the pack from the item unit of measure
                    LookupItemUnitOfMeasure;
                    VPack := ROUND(VPack,1.0);
                    VTemp := Format(VPack,0,'<Integer>');

                    //Get rid of spaces
                    VPackCode := VTemp;
                    PrintPack := VPackCode + '/' + VPackDesc;

                    //Not used for Publisher, but left in case we want to add in the future LCC 9-2-11
                    if Item."Catalog UOM" <> '' then
                        PUOM := CopyStr(Item."Catalog UOM",1,6)
                    else
                        PUOM := CopyStr(Item."Base Unit of Measure",1,6);

                    //Item.VALIDATE("Unit Price");
                    VPrice := Item."Unit Price";
                    VPrice := ROUND(VPrice,0.01);
                    PrintPrice := Format(VPrice,6,'<Integer><Decimal,3>');

                    VSMSSubdept := Format("SMS Subdepartment");

                    WriteLineRecord;

                    //Get the catalogue code to see if we are at the end of the group
                    //CheckNextCatCode := Item."Catalog Group Code";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                case SelectionCode of
                0:if "Download Selection" <> true then CurrReport.Skip;
                1:if "Groc Select 1" <> true then CurrReport.Skip;
                2:if "Groc Select 2" <> true then CurrReport.Skip;
                3:if "Groc Select 3" <> true then CurrReport.Skip;
                4:if "Groc Select 4" <> true then CurrReport.Skip;
                5:if "Purch Select 1" <> true then CurrReport.Skip;
                6:if "Purch Select 2" <> true then CurrReport.Skip;
                7:if "Purch Select 3" <> true then CurrReport.Skip;
                8:if "Purch Select 4" <> true then CurrReport.Skip;
                else if "Download Selection" <> true then CurrReport.Skip
                end;
            end;

            trigger OnPreDataItem()
            begin
                case SelectionCode of
                0:SetCurrentkey("Sort Order","Catalog Group Codes");
                1:SetCurrentkey("Groc Sort 1","Catalog Group Codes");
                2:SetCurrentkey("Groc Sort 2","Catalog Group Codes");
                3:SetCurrentkey("Groc Sort 3","Catalog Group Codes");
                4:SetCurrentkey("Groc Sort 4","Catalog Group Codes");
                5:SetCurrentkey("Purch Sort 1","Catalog Group Codes");
                6:SetCurrentkey("Purch Sort 2","Catalog Group Codes");
                7:SetCurrentkey("Purch Sort 3","Catalog Group Codes");
                8:SetCurrentkey("Purch Sort 4","Catalog Group Codes");
                else SetCurrentkey("Sort Order","Catalog Group Codes")
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
                    field("Enter Output File Name";VFileName)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Report Selection Criteria";SelectionCode)
                    {
                        ApplicationArea = Basic;
                        OptionCaption = 'Default,Grocery 1,Grocery 2,Grocery 3,Grocery 4,Purchasing 1,Purchasing 2,Purchasing 3,Purchasing 4';
                    }
                    field("Select Desired Zone";VTarget)
                    {
                        ApplicationArea = Basic;
                        TableRelation = Target;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //For testing set the file name
            VFileName := 'CatalogImport.TXT';
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if VFileName = '' then
        begin
        Message('Need to Enter File Name in Options');
        CurrReport.Quit;
        end;

        VFullFileName := '\\filestore\Company\AWS Conversion to Publisher\' + VFileName;
        VLineOutputFile.Create(VFullFileName);
        VLineOutputFile.TextMode(true);
        Window.Open('Processing Record #1##########');
        repeat
        Window.Update(1,"Catalog Group Codes"."Catalog Group Codes");
        until "Catalog Group Codes".Next = 0;
    end;

    var
        ItemUPCTable: Record "Item UPC Table";
        Window: Dialog;
        VLineOutputFile: File;
        VOutputFileLine: Text[255];
        Vitem: Text[30];
        ItemUOMRecord: Record "Item Unit of Measure";
        ItemRecord: Record Item;
        TargetRetail: Record "Item Target Retail";
        VDesc1: Text[255];
        VDesc2: Text[50];
        VCheckChar: Text[30];
        P: Integer;
        PrintRetail: Text[30];
        PrintPrice: Text[30];
        PrintPack: Text[30];
        PrintItemNo: Text[30];
        PrintCatTitle: Text[30];
        PrintCatCode: Text[30];
        PUOM: Text[30];
        VRetail: Decimal;
        VRetailZone1: Decimal;
        VRetailZone3: Decimal;
        VRetailZoneN: Decimal;
        VPack: Decimal;
        VPackDesc: Text[30];
        VPrice: Decimal;
        VTemp: Text[30];
        CheckNextCatCode: Code[10];
        VPackCode: Text[30];
        VFileName: Text[255];
        VFullFileName: Text[255];
        SelectionCode: Option;
        VCatalogSelect: Boolean;
        PZone: Option;
        VUPC: Text[30];
        VSMSSubdept: Text[30];
        Text19017895: label 'Enter Output File Name';
        Text19006986: label 'Report Selection Criteria';
        Text19004150: label 'Enter zone desired:';
        VTarget: Code[10];


    procedure WriteLineRecord()
    begin
        //CS 12/1/11: Added Category Description to this output.
        VOutputFileLine := '~' + PrintCatCode + '~|~' + PrintCatTitle + '~|~' + VDesc1 + '~|~' +  Item."No." + '~|~' + VPackCode + '~|~' +
            VPackDesc + '~|~' +    PrintPack  + '~|~' + PrintRetail  + '~|~' + PrintPrice + '~|~' +  VUPC + '~|~' + VSMSSubdept + '~';
        VLineOutputFile.Write(VOutputFileLine);
    end;


    procedure WriteCategoryRecord()
    begin
        VOutputFileLine := PrintCatTitle;
        //VLineOutputFile.WRITE(VOutputFileLine);
    end;


    procedure LookupItemUPC()
    begin
        //Select the first UPC if found
        //Override this with another UPC if it is marked 'catalogue select'
        VCatalogSelect := true;//So the first found UPC is selected
        VUPC := '';
        ItemUPCTable.SetCurrentkey ("Item No.");
        ItemUPCTable.SetRange("Item No.",Item."No.");
        if ItemUPCTable.Find('-') then
        repeat
        begin
        //Test catalog select field, only override the first record if another record has catalogue select
        //   checked, the last one will override
        if ItemUPCTable."Catalogue Select" = true then VCatalogSelect := true;
          if VCatalogSelect = true then
          begin
          VUPC := ItemUPCTable.UPC;
          end;
        VCatalogSelect := false;//Reset
        end
        until ItemUPCTable.Next = 0;
        ItemUPCTable.SetRange("Item No.");//clear filter
    end;


    procedure LookupItemUnitOfMeasure()
    begin
        ItemUOMRecord.SetCurrentkey(ItemUOMRecord."Item No.",ItemUOMRecord.Code);
        ItemUOMRecord.SetRange("Item No.",Item."No.");
        ItemUOMRecord.SetRange(ItemUOMRecord.Code,Item."Base Unit of Measure");
        if ItemUOMRecord.Find('-') then
        begin
        VPack := ItemUOMRecord.Pack;
        VPackDesc := ItemUOMRecord."Pack Description";
        end;
    end;


    procedure LookupTargetRetail()
    begin
        //CS 11-06-18: Added a clause for ZALL to make sure it grabs that if there is one. Otherwise it takes the selected Target.
        TargetRetail.SetCurrentkey("Item No.",UPC,Target);
        TargetRetail.SetRange("Item No.",Item."No.");
        TargetRetail.SetRange(UPC,Item."UPC for SMS");
        TargetRetail.SetRange(Target,'ZALL');

        if TargetRetail.Find('-') then
            VRetail := TargetRetail.Retail
        else
            begin
                TargetRetail.SetCurrentkey("Item No.",UPC,Target);
                TargetRetail.SetRange("Item No.",Item."No.");
                TargetRetail.SetRange(UPC,Item."UPC for SMS");
                TargetRetail.SetRange(Target,VTarget);

                if TargetRetail.Find('-') then
                    VRetail := TargetRetail.Retail
                else
                    VRetail := 0
            end;

        Clear(TargetRetail);

        //CS 04-10-17: TEMPORARY SPECIAL CASE FOR GROC SALE ITEMS -- IF Catagory Group Code is 'Y001' THEN just lookup Item No. and Target Combo.
        if (Item."Catalog Group Code" = 'Y001') and (Item."UPC for SMS"='') then
            begin
                TargetRetail.SetCurrentkey("Item No.",UPC,Target);
                TargetRetail.SetRange("Item No.",Item."No.");
                TargetRetail.SetRange(Target,VTarget);

                if TargetRetail.Find('-') then
                    VRetail := TargetRetail.Retail
                else
                    VRetail := 0;

                Clear(TargetRetail);
            end;
    end;
}

