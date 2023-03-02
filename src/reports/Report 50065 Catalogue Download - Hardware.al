Report 50065 "Catalogue Download - Hardware"
{
    // //ANICA 12/9/08 Remove zero hazardous retail check - per Bill K.
    // //6/14/10 Skip inactive items - per Gina.

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
                DataItemTableView = sorting("No.") order(ascending);
                column(ReportForNavId_8129; 8129)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Clear Variables
                    VRetail := 0;
                    PrintRetail := '';
                    PrintPrice := '';
                    PrintPack := '';
                    VPack := 0;
                    VPackDesc := '';
                    PrintCatTitle := '';
                    PUOM := '      ';

                    //Skip non 1000 catalogue items
                    if Item."Telxon Vendor Code" <> '1000' then CurrReport.Skip;

                    //Skip Non-stock and blocked items
                    if Item."Created From Nonstock Item" = true
                    then CurrReport.Skip;
                    if Item.Blocked = true
                    then CurrReport.Skip;
                    if Item."ANICA Inactive" = true then CurrReport.Skip;
                    if CheckNextCatCode <> Item."Catalog Group Code" then
                    begin
                    PrintCatTitle := "Catalog Group Codes".Description;
                    WriteCategoryRecord;
                    end;


                    //Take blanks off descrip and pad with ....
                    VDesc1 := Item.Description;
                    P := StrLen(VDesc1);
                    if P > 0 then VCheckChar := CopyStr(VDesc1,P,1) else VCheckChar := ' ';
                    if (P > 0) and (VCheckChar = ' ') then
                    begin
                      while (VCheckChar = ' ') and (P > 0) do
                      begin
                      VDesc1 := CopyStr(VDesc1,1,P);
                      VCheckChar := CopyStr(VDesc1,P,1);
                      P := P - 1;
                      end;
                    end;
                    if (CopyStr(VDesc1,1,1) = ' ') and (StrLen(VDesc1) = 1) then VDesc1 := '.';
                    VDesc1 := PadStr(VDesc1,30,'.');
                    VDesc2 := Item."Description 2";
                    P := StrLen(VDesc2);
                    if P > 0 then VCheckChar := CopyStr(VDesc2,P,1) else VCheckChar := ' ';
                    if (P > 0) and (VCheckChar = ' ') then
                    begin
                       while (VCheckChar = ' ') and (P > 0) do
                       begin
                       VDesc2 := CopyStr(VDesc2,1,P);
                       VCheckChar := CopyStr(VDesc2,P,1);
                       P := P - 1;
                       end;
                    end;
                    if (CopyStr(VDesc2,1,1) = ' ') and (StrLen(VDesc2) = 1) then VDesc2 := ''
                    else VDesc2 := PadStr(VDesc2,30,'.');

                    //Select the correct retail
                    //CS 03-22-17: Changed to Targets.
                    if Item."Std Fixed Retail" <> 0 then
                        VRetail := Item."Std Fixed Retail"
                    else
                        begin
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
                        end;

                    if VRetail = 0 then
                        VRetail := Item."Std Floating Retail";


                    VRetail := ROUND(VRetail,0.01);

                    //Zero the retail if the item is hazardous
                    //ANICA 12/9/08 Remove check - per Bill K.
                    //IF Item."Hazardous Code" = TRUE THEN VRetail := 0;
                    //IF Item."Pick Type" = 1 THEN VRetail := 0;

                    PrintRetail := Format(VRetail,6,'<Integer><Decimal,3>');
                    PrintRetail := PrintRetail;

                    LookupItemUnitOfMeasure;
                    VPack := ROUND(VPack,1.0);
                    VTemp := Format(VPack,10,'<Integer>');
                    //Get rid of spaces
                    VPackCode := VTemp;
                    PrintPack := VPackCode + '/' + VPackDesc;
                    PrintPack := PadStr(PrintPack,9,'.');

                    if Item."Catalog UOM" <> '' then
                    PUOM := CopyStr(Item."Catalog UOM",1,6)
                    else
                    PUOM := CopyStr(Item."Base Unit of Measure",1,6);
                    PUOM := PadStr(PUOM,6);

                    //Item.VALIDATE("Unit Price");
                    VPrice := Item."Unit Price";
                    VPrice := ROUND(VPrice,0.01);
                    PrintPrice := Format(VPrice,6,'<Integer><Decimal,3>');

                    PrintItemNo := CopyStr(Item."No.",1,9);

                    WriteLineRecord;

                    //Get the catalogue code to see if we are at the end of the group
                    CheckNextCatCode := Item."Catalog Group Code";
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
            VFileName := 'CatalogImport_NonGroc.TXT';
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
        Window: Dialog;
        VLineOutputFile: File;
        VOutputFileLine: Text[120];
        Vitem: Code[30];
        ItemUOMRecord: Record "Item Unit of Measure";
        ItemRecord: Record Item;
        TargetRetail: Record "Item Target Retail";
        VDesc1: Text[50];
        VDesc2: Text[50];
        VCheckChar: Text[30];
        P: Integer;
        PrintRetail: Text[30];
        PrintPrice: Text[30];
        PrintPack: Code[20];
        PrintItemNo: Code[10];
        PrintCatTitle: Code[30];
        PUOM: Text[30];
        VRetail: Decimal;
        VPack: Decimal;
        VPackDesc: Code[10];
        VPrice: Decimal;
        VTemp: Text[30];
        CheckNextCatCode: Code[10];
        VPackCode: Code[10];
        VFileName: Text[25];
        VFullFileName: Text[100];
        SelectionCode: Option;
        VCapCode: Code[10];
        PZone: Code[10];
        Text19017895: label 'Enter Output File Name';
        Text19006986: label 'Report Selection Criteria';
        Text19004150: label 'Enter zone desired:';
        VTarget: Code[10];


    procedure WriteLineRecord()
    begin
        //First Line
        VOutputFileLine := '$' + PrintRetail + ' ' + PUOM + VDesc1 + '..' + PrintPack + ' '
              + PrintItemNo + ' ____ $' + PrintPrice;
        VLineOutputFile.Write(VOutputFileLine);
        //Second Line
        //Check to see if it is blank
        if Item."Description 2" <> '' then
        begin
        VOutputFileLine := '.             ' + VDesc2 + '...........' + '                                              ';
        VLineOutputFile.Write(VOutputFileLine);
        end;
    end;


    procedure WriteCategoryRecord()
    begin
        VOutputFileLine := '*******         ' + PrintCatTitle;
        VLineOutputFile.Write(VOutputFileLine);
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
}

