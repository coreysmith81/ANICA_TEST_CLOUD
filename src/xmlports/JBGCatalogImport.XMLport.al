XmlPort 50033 "JBG Catalog Import"
{
    // 
    // This program is run weekly to import the JBG item and price update files.  The program updates the Item file,
    //     Nonstock Item File and both Item and Non Stock UPC tables.
    // 
    // 
    // The JBG Import file for this program is wrmstItm
    // 
    // The post indicator values at location 65 in the wrmsitem import file are; 2 Freeze/Chill, 3 Hazardous, 4 Location 2740, 6 WIC,
    //       8 Closeout and 9 Not shippable off the road system
    // 
    // //CS 12/8/11 : Modified coding so that only items that have had actual changes have their SMS flags cleared.

    Direction = Import;
    Format = FixedText;

    schema
    {
        textelement(Root)
        {
            tableelement("Nonstock Item";"Nonstock Item")
            {
                AutoSave = false;
                AutoUpdate = true;
                XmlName = 'NonstockItem';
                textelement(NCoGroup)
                {
                    Width = 4;
                }
                textelement(VVendorItemNo)
                {
                    Width = 6;
                }
                textelement(iPack)
                {
                    Width = 4;

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate(VPack,iPack);
                    end;
                }
                textelement(VPackDescription)
                {
                    Width = 10;
                }
                textelement(VDescription)
                {
                    Width = 30;
                }
                textelement(iGrossWeight)
                {
                    Width = 10;

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate(VGrossWeight,iGrossWeight);
                    end;
                }
                textelement(NPostIndicator)
                {
                    Width = 1;
                }
                textelement(VHazardousCode)
                {
                    Width = 1;
                }
                textelement(NFoodNFood)
                {
                    Width = 1;
                }
                textelement(iUnitPrice)
                {
                    Width = 11;

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate(VUnitPrice,iUnitPrice);
                    end;
                }
                textelement(iPriceAllow)
                {
                    Width = 8;

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate(NPriceAllow,iPriceAllow);
                    end;
                }
                textelement(iTarget)
                {
                    Width = 8;

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate(NTarget,iTarget);
                    end;
                }
                textelement(VUPC)
                {
                    Width = 12;
                }
                textelement(VChange)
                {
                    Width = 1;
                }
                textelement(VDept)
                {
                    Width = 4;
                }
                textelement(VVendor)
                {
                    Width = 6;
                }
                textelement(VDiscont)
                {
                    Width = 1;
                }
                textelement(VWarehouseDept)
                {
                    Width = 3;
                }

                trigger OnAfterInsertRecord()
                begin
                    //For Status Box
                    begin
                      Window.Update(1,VVendorItemNo);
                    end;
                    
                    
                    CheckItem := false; //Indicates whether a nonstock item has a related item number, true if the related item exists
                    VStockItemNo := '';  //Item number related to the nonstock item
                    VLookupItemNo := '';  //To look up the related item record
                    VCommCode := ''; //CS 4-29-14: uncommented this
                    VCross := false;
                    VExistingNonStockUPC := '';//used to determine if the existing UPC is blank and should be updated from the import
                    
                    //Updated 2-3-12 CS: took out the SKIP statement so that the item cards will still be updated with this program.
                    // otherwise we will have item cards that do not match what's coming in the updates.
                    //Added 8-17-11 LCC Items from the ANC warehouse that are in Bellvue as well are marked D
                    //  We do not want to import these.  If they already exist, mark them as inactive
                    if VChange = 'D' then
                        begin
                            MakeInactive;
                            //CurrDataport.SKIP;
                        end;
                    
                    //If a nontock item already exists, update it with the new information, otherwise create a new nonstock item
                    with "Nonstock Item" do
                        begin
                            //Assign variables to fields
                            VMfrCode := 'G';
                            UpdateNonStockNumber;//Also checks for NO JBG update flag
                    
                            if ItemExists = false then
                                begin
                                    Init;
                                    Insert(true);
                                end;
                    
                            //Lookup item category based on JBG dept codes
                            case VDept of
                                '0015' : VCategoryCode := 'PROD';
                                '0021' : VCategoryCode := 'MEAT';
                                else VCategoryCode := 'GROC';
                            end;
                    
                            "Item Category Code" := VCategoryCode;
                            //VALIDATE("Item Category Code");
                    
                            //Constants
                            "Unit of Measure" := 'CASE';
                            "Vendor No." := 'JBGO001';
                            "Manufacturer Code" := 'G';
                            "Last Date Modified" := Today;
                            "Parcel Post Code" := 'ZONE 1/2';
                            "Freight Code" := '310';
                            "Telxon Catalog Code" := '3000';
                    
                            //CS 12/06/11 : Added so that only items that have changed will have their flags cleared. *****
                            if VChange = 'Y' then
                                begin
                                    //Clear the price file created flags so the SMS update will consider all items
                                    "Price Files Created" := false;
                                    Modify(true);
                                end;
                    
                            //Values from the Gottstein update file
                            "Vendor Item No." := VVendorItemNo;
                            Description := VDescription;
                            "Unit Price" := VUnitPrice;
                            "Negotiated Cost" := VUnitPrice;
                            "Gross Weight" := VGrossWeight;
                            Pack := VPack;
                            "Pack Description" := VPackDescription;
                    
                            //5-6-10 LCC Do Not Apply the UPC Update if the code is not blank, otherwise keep the current code
                            if VExistingNonStockUPC = '' then
                                "UPC Code for SMS" := VUPC
                            else
                                "UPC Code for SMS" := VExistingNonStockUPC;
                    
                            //5-6-10 Always add the UPC for new items
                            if ItemExists = false then
                                "UPC Code for SMS" := VUPC;
                    
                            "Vendor Department" := VDept;
                            "Wholesaler Vendor No." := VVendor;
                    
                            //Hazmat section
                            if NPostIndicator = '3' then
                                begin
                                    "Hazardous Code" := true;
                                    "FOB Code" := 'HAZ';
                                    "Pick Type" := 1;
                                end
                            else
                                begin
                                    "Hazardous Code" := false;
                                    //The FOB Code is used for Default Shipping Instruction Lookup
                                    "FOB Code" := 'ANC';
                                    "Pick Type" := 0;
                                end;
                    
                            //2-21-11 LCC New Post indicator for HABA location 2740 (unless hazardous which 3 overrides the location)
                            if NPostIndicator = '4' then
                                "Pick Type" := 11;
                    
                            //10-19-2022 CS: Adding Freeze Pick Type (2) to necessary items
                            if VPickType = 2 then
                                begin
                                    "Pick Type" := 2;
                                end;
                    
                            //5-10-07 LCC Removed WIC Flag Update
                            //5-22-14 CS: Uncommented because there is no other place that the WIC flag is updated. Assumption is
                            //  That JBG's file is now correct in respect to the '6' Post indicator.
                            //5-23-14 CS: Adding in that if Post Indicator is '6', then Subdepartment should be set to 11.
                            if NPostIndicator = '6' then
                                begin
                                    "WIC Flag" := true;
                                    "SMS Subdepartment" := 11;
                                end
                            else
                                "WIC Flag" := false;
                    
                            //5-3-11 LCC Changed to Marke Closeout items 8 as inactive
                            if NPostIndicator = '8' then
                                "Nonstock Item"."ANICA Inactive" := true;
                    
                            //Indicate new items that have changed and reset prior changes
                            //Vchange is the change indicator per the Gottstein update file
                            if VChange = 'Y' then
                                "Change Indicator" := 'C'
                            else "Change Indicator" := '';
                    
                            //Mark discontinued items
                            if VDiscont = '1' then
                                begin
                                    "Change Indicator" := 'D';
                                    "Nonstock Item"."ANICA Inactive" := true;
                                end;
                    
                            //Get the JBG Commodity group from the JBG file and get our corresponding commodity code
                            //The JBG Commodity code is also kept on the nonstock item card
                            "JBG Commodity Group" := NCoGroup;
                    
                            //CS 4-29-14: Replace Commodity Code even if not blank to begin with.
                            //IF "Commodity Code" = '' THEN
                                //BEGIN
                                    JBGComGrp.SetCurrentkey(JBGComGrp."JBG Commodity Group");
                                    JBGComGrp.SetRange(JBGComGrp."JBG Commodity Group",NCoGroup);
                    
                                    if JBGComGrp.Find('-') then
                                        begin
                                            "Commodity Code" := JBGComGrp."ANICA Commodity Code";
                                            VCommCode := JBGComGrp."ANICA Commodity Code";
                                            //CS 10-19-22: Adding Pick Type. This is for getting JBG Freeze items marked as such on item cards
                                            //  so that they can be split onto separate SOs.
                                            VPickType := JBGComGrp."Pick Type";
                                        end;
                                //END;
                    
                            //New 5-24-10 LCC, lookup the SMS subdepartment based on the Commodity group
                            //  Update only on new items or if blank
                            CommodityTable.SetRange(CommodityTable."Commodity Code","Commodity Code");
                    
                            if CommodityTable.Find('-') then
                            begin
                                if "WIC Flag" = true then
                                    begin
                                        //CS 05-23-14: "SMS Subdepartment" for WIC items will be set above. (search:  'IF NPostIndicator = '6'')
                                        //CS 04/12/13: As a stop-gap, existing items marked as WIC will not be overwritten.
                                        //IF ItemExists = FALSE THEN
                                        //    "SMS Subdepartment" := 0 //so that it will look up regular SMS SubDept later in code.
                                        //ELSE
                                        //    "SMS Subdepartment" := VSubDept;//existing subdepartment
                                    end
                                else
                                    begin
                                        if ItemExists = false then
                                            "SMS Subdepartment" := CommodityTable."SMS Sub Department"
                                        else if VSubDept = 0 then
                                            "SMS Subdepartment" := CommodityTable."SMS Sub Department"
                                        else
                                            "SMS Subdepartment" := VSubDept;//existing subdepartment
                                    end
                            end;
                    
                            //Update the No. Series Line Table for the Item Just Created,
                            if ItemExists = false then
                                begin
                                    NoSeriesLine.SetCurrentkey(NoSeriesLine."Series Code");
                                    NoSeriesLine.SetRange(NoSeriesLine."Series Code",'NONSTOCK');
                                       if NoSeriesLine.Find('-') then
                                          begin
                                              NoSeriesLine."Starting No." := "Nonstock Item"."Entry No.";
                                              NoSeriesLine."Last No. Used" := "Nonstock Item"."Entry No.";
                                              NoSeriesLine.Modify(true);
                                          end;
                                end;
                    
                            "Nonstock Item".Modify(true);
                        end; //End Do
                    
                    //Update the related nonstock UPC table
                    UpdateNonStockUPC;
                    
                    //If the related item record exists update price, etc.
                    if CheckItem = true then
                        begin
                            VLookupItemNo := VStockItemNo;
                            LookupItemFile;
                        end;
                    
                    //======================================================================================
                    //CS 07/09/13:
                    //BEGINING OF CROSS-REFERENCE SECTION.  COMMENTING OUT, PER GINA
                    //======================================================================================
                    /*
                    VCrossItemNo := '';
                    
                    //Check to see if this JBG item has a warehouse cross reference
                    CheckCrossRefNo := VVendorItemNo;
                    
                    LookupCrossReference;
                    
                    //Read the Cross Reference Table to get item cross up to 6 crosses
                    P := 1;
                    WHILE P < 7 DO
                        BEGIN
                            CheckCrossRefNo := VCrossItemNo;
                    
                            LookupCrossReference;
                    
                            P := P + 1;
                        END;
                    
                    //If you found a cross, update the item
                    IF VCrossItemNo <> '' THEN
                        BEGIN
                            //Clear the discontinued and post indicators so the cross item is not marked as inactive if the JBG item was
                            NPostIndicator := '0';
                            VDiscont := ' ';
                            VLookupItemNo := VCrossItemNo;
                            VCross := TRUE;//So we can only print cross items in the spreadsheet file
                            LookupItemFile;
                        END;
                    */
                    //======================================================================================
                    //CS 07/09/13:
                    //END OF CROSS-REFERENCE SECTION.  COMMENTING OUT, PER GINA
                    //======================================================================================

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        //Setup a file for an export with the crosses that were updated
        VFullFileName := '\\filestore\Purchasing\JBG Price File\_JBGUpdateCrosses.txt';
    end;

    trigger OnPostXmlPort()
    begin
        NoSeriesLine.SetCurrentkey(NoSeriesLine."Series Code");
        NoSeriesLine.SetRange(NoSeriesLine."Series Code",'NONSTOCK');

        if NoSeriesLine.Find('-') then
            begin
                NoSeriesLine."Starting No." := IncStr(NoSeriesLine."Starting No.");
                NoSeriesLine.Modify(true);
            end;

        //Close spreadsheet file
        VLineOutputFile.Close;

        //For Status Box
        Window.Close;
        Clear(Window);
    end;

    trigger OnPreXmlPort()
    begin
        //Get the file per the request
        currXMLport.Filename(VFullFileName);

        //Insert a tab to a variable for delimiting the output file
        VTab := '|';

        VLineOutputFile.Create(VFullFileName);
        VLineOutputFile.TextMode(true);

        //Print headings
        VOutPutFileLine := 'Import Item No' + VTab + 'Import UPC' + VTab + 'Import Description' + VTab +
               'Crossed Item' + VTab + 'Cross UPC' + VTab + 'Cross Descr' + VTab + 'New Unit Price';
        VLineOutputFile.Write(VOutPutFileLine);

        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
        end;
    end;

    var
        ItemUPCTable: Record "Item UPC Table";
        NonStockUPCTable: Record "Nonstock UPC Table";
        VUnitPrice: Decimal;
        VGrossWeight: Decimal;
        VMfrCode: Code[5];
        VVendorNo: Code[20];
        VUOM: Code[10];
        VNonStocksSeqNo: Code[20];
        VPack: Decimal;
        NPriceAllow: Decimal;
        NTarget: Decimal;
        NMastRetail: Decimal;
        CheckItem: Boolean;
        VStockItemNo: Code[20];
        CheckCrossRefNo: Code[20];
        VCrossItemNo: Code[20];
        VLookupItemNo: Code[20];
        VCheckMargin: Decimal;
        VCheckUpdatePrice: Boolean;
        VCheckJBGMargin: Decimal;
        ItemExists: Boolean;
        VExistingNonStockUPC: Code[15];
        NoSeriesLine: Record "No. Series Line";
        ItemUOM: Record "Item Unit of Measure";
        NonStocks: Record "Nonstock Item";
        ItemRecord: Record Item;
        ItemRecord2: Record Item;
        CommodityTable: Record "Commodity Code";
        VChgInd: Text[1];
        VCommCode: Text[10];
        JBGComCde: Code[4];
        JBGComGrp: Record "ANICA-JBG Commodity Codes";
        VFullFileName: Text[255];
        VOutPutFileLine: Text[255];
        VLineOutputFile: File;
        VPrintUnitPrice: Text[30];
        VTab: Text[1];
        VReturnErase: Boolean;
        VCategoryCode: Code[10];
        VFileName: Text[255];
        VCross: Boolean;
        P: Integer;
        NewItemUPC: Code[20];
        VSubDept: Integer;
        Window: Dialog;
        VPickType: Integer;


    procedure UpdateNonStockNumber()
    begin
        VSubDept := 0;
        NonStocks.LockTable;
        ItemExists := true;  //Indicate whether the nonstock items exists, or a new nonstock item needs to be created

        //See if the nonstock item already exists
        NonStocks.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        NonStocks.SetRange("Vendor Item No.",VVendorItemNo);
        NonStocks.SetRange("Manufacturer Code", VMfrCode);
        if NonStocks.Find('+') then
            begin
                //Item already exists section
                "Nonstock Item"."Entry No." := NonStocks."Entry No.";
                "Nonstock Item"."Item No." := NonStocks."Item No.";

                //CS 12/8/11 : initialize SMS flags based on previous version of record.
                "Nonstock Item"."Price Files Created" := NonStocks."Price Files Created";

                //Get the existing UPC code to use in checking the UPC Update
                VExistingNonStockUPC := NonStocks."UPC Code for SMS";
                VSubDept := NonStocks."SMS Subdepartment";

                //See if an existing nonstock item has a related item to be updated
                if NonStocks."Item No." = '' then
                    CheckItem := false
                else
                    begin
                        CheckItem := true;
                        VStockItemNo := NonStocks."Item No.";
                    end;

                //Updated 2-3-12 CS: took out the SKIP statement so that the item cards will still be updated with this program.
                // otherwise we will have item cards that do not match what's coming in the updates.
                //2-9-11 LCC moved this section before the ELSE clause, was not working
                //If Do Not Update JBG Retails has been checked, skip this import
                if NonStocks."Do Not Update JBG Retails" = true then
                    begin
                        //Update the Commodity code on both cards
                        NonStocks."JBG Commodity Group" := NCoGroup;
                        NonStocks.Modify(true);

                        if CheckItem = true then
                            begin
                                ItemRecord.SetCurrentkey("No.");
                                ItemRecord.SetRange("No.",VStockItemNo);
                                if ItemRecord.Find('+') then
                                    begin
                                        ItemRecord."ANICA Inactive" := false;
                                        ItemRecord."JBG Commodity Group" := NCoGroup;
                                        //If the nonstock card is marked do not update, do the same with the related item
                                        ItemRecord."Do Not Update JBG Retails" := true;
                                        ItemRecord.Modify(true);
                                    end;
                            end;
                        ItemRecord.SetRange("No.");//clear filter
                        currXMLport.Skip;
                    end;
            end
        else
            begin
                //Item doesn't exist section
                //Set the key to entry no and lear filters so you can get the next available number
                NonStocks.SetCurrentkey("Entry No.");
                NonStocks.SetRange("Vendor Item No.");
                NonStocks.SetRange("Manufacturer Code");

                //Get the next available nonstock item entry no to add the new item
                  if NonStocks.Find('+') then
                      VNonStocksSeqNo := NonStocks."Entry No."
                  else
                      VNonStocksSeqNo := 'NS00000000';

                "Nonstock Item"."Entry No." := IncStr(VNonStocksSeqNo);
                ItemExists := false;
            end;
    end;


    procedure LookupItemFile()
    begin
        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",VLookupItemNo);

        if ItemRecord.Find('+') then
            begin
                if ItemRecord.Blocked = true then
                    currXMLport.Skip;

                //Make a spreadsheet of items that have been crossed, only changed items
                //IF (VChange = 'Y') AND (VCross = TRUE) THEN
                if VCross = true then
                    begin
                        VPrintUnitPrice := Format(VUnitPrice,6,'<Integer><Decimal,3>');
                        VOutPutFileLine := VVendorItemNo + VTab + VUPC  + VTab + VDescription  + VTab + VCrossItemNo + VTab +
                            ItemRecord."UPC for SMS" + VTab + ItemRecord.Description + VTab + VPrintUnitPrice + VTab;
                        VOutPutFileLine := CopyStr(VOutPutFileLine,1,255);//limit size of record
                        VLineOutputFile.Write(VOutPutFileLine);
                    end;

                if VUnitPrice = 0 then
                    currXMLport.Skip;

                //Skip drop ship items on cross
                if ItemRecord."Drop Ship Item" = true then
                    currXMLport.Skip;

                //If the fixed price code is set, do not update
                VCheckUpdatePrice := true;

                if ItemRecord."Fixed Price Code" = true then
                    VCheckUpdatePrice := false;

                //Check for an adequate margin
                if VUnitPrice = 0 then
                    Error('Zero Division VUnitPrice Item Record Unit Price Item No %1 %2 %3',
                        VUnitPrice, ItemRecord."Unit Price", ItemRecord."No.");

                if ItemRecord."Unit Price" = 0 then
                    Error('Zero Division VUnitPrice Item Record Unit Price Item No %1 %2 %3',
                          VUnitPrice, ItemRecord."Unit Price", ItemRecord."No.");

                //IF the new Gottstein price results in less margin, the existing price is retained.
                VCheckMargin := ((ItemRecord."Unit Price" - ItemRecord."ANICA Landed Cost")/ItemRecord."Unit Price");
                VCheckJBGMargin := ((VUnitPrice - ItemRecord."ANICA Landed Cost")/VUnitPrice);

                if VCheckJBGMargin < VCheckMargin then
                    VCheckUpdatePrice := false;

                if VCheckUpdatePrice = true then
                    begin
                        ItemRecord."Unit Price" := VUnitPrice;
                        ItemRecord.Modify(true);
                    end;

                //2-21-11 LCC New Post indicator for HABA location 2740 (unless hazardous which 3 overrides the location)
                if NPostIndicator = '4' then
                    ItemRecord."Pick Type" := 11;

                //Hazmat section
                if NPostIndicator = '3' then
                    begin
                        ItemRecord."Hazardous Code" := true;
                        ItemRecord."FOB Code" := 'HAZ';
                        ItemRecord."Pick Type" := 1;
                    end
                else
                    begin
                        ItemRecord."Hazardous Code" := false;
                    end;

                //10-19-2022 CS: Adding Freeze Pick Type (2) to necessary items
                if VPickType = 2 then
                    begin
                        ItemRecord."Pick Type" := 2;
                    end;

                //Discontinued check
                if VDiscont = '1' then
                    ItemRecord."ANICA Inactive" := true
                else
                    ItemRecord."ANICA Inactive" := false;

                //5-3-11 LCC if the post indicator is 8 closeout, then the item is inactive
                if NPostIndicator = '8' then
                    ItemRecord."ANICA Inactive" := true;

                //Category Code Section
                ItemRecord."Item Category Code" := VCategoryCode;
                ItemRecord."Gen. Prod. Posting Group" := VCategoryCode;
                ItemRecord."Inventory Posting Group" := VCategoryCode;

                //set constants
                ItemRecord."Freight Code" := '310';
                ItemRecord."Search Description" := ItemRecord.Description;
                //Values from the JBG Import file

                //LCC Removed 5-11-10
                //5-22-14 CS: Uncommented because there is no other place that the WIC flag is updated. Assumption is
                //... that JBG's file is now correct in respect to the '6' Post indicator.
                //5-23-14 CS: Added in that if Post Indicator is 6, then SMS Subdepartment will be set to 11. Per Gina
                if NPostIndicator = '6' then
                    begin
                        ItemRecord."WIC Item" := true;
                        ItemRecord."SMS Subdepartment" := 11;
                    end;

                //LCC Removed 10-29-09
                //ItemRecord."Vendor UPC Code" := VUPC;
                ItemRecord."Last Date Modified" := Today;
                ItemRecord."JBG Commodity Group" := NCoGroup;
                //CS 04-29-14: Added this so that the Item card is updated as well.
                ItemRecord."Commodity Code" := VCommCode;

                //CS 06-04-14: I don't see anywhere where the SMS Subdepartment is updated on the Item card. So adding this to do so.
                ItemRecord."SMS Subdepartment" := VSubDept;

                //CS 12/06/11 : Added so that only items that have changed will have their flags cleared. *****
                if VChange = 'Y' then
                    begin
                        //Clear the price file created flags so the SMS update will consider all items
                        ItemRecord."Price Files Created" := false;
                        ItemRecord.Modify(true);
                    end;

                //Change descriptions only on created by nonstock items
                if ItemRecord."Created From Nonstock Item" = true then
                    begin
                        ItemRecord."Gross Weight" := VGrossWeight;
                        //LCC 10-29-09 stop updating the item description
                        //ItemRecord.Description := VDescription;
                        //ItemRecord."Search Description" := VDescription;

                        if VDiscont = '1' then
                            ItemRecord.Blocked := true;

                        if NPostIndicator = '9' then
                            ItemRecord.Blocked := true;//Not Shippable
                    end;

                //LCC 5-11-10 New section, only update the SMS UPC if it is blank
                if ItemRecord."UPC for SMS" = '' then
                    ItemRecord."UPC for SMS" := VUPC;

                //CS 04-11-22: Adding JBG's Department Code to the Item Card.
                ItemRecord."Vendor Location" := VWarehouseDept;

                //General Modify Update
                ItemRecord.Modify(true);

                //LCC 10-29-09 No longer update pack size and description
                //Update the pack on the item unit of measure table
                //ItemUOM.SETCURRENTKEY(ItemUOM."Item No.");
                //ItemUOM.SETRANGE(ItemUOM."Item No.",ItemRecord."No.");
                //  IF ItemUOM.FIND('-') THEN
                //      BEGIN
                //          ItemUOM.Pack := VPack;
                //          ItemUOM."Pack Description" := VPackDescription;
                //          ItemUOM.MODIFY(TRUE);
                //      END;

            end;//end item lookup

        //Update related item UPC
        UpdateItemUPC;
    end;


    procedure LookupCrossReference()
    var
        CrossReferenceRecord: Record "Item Cross Reference";
    begin
        CrossReferenceRecord.SetCurrentkey("Cross-Reference No.","Cross-Reference Type");
        CrossReferenceRecord.SetRange("Cross-Reference No.",CheckCrossRefNo);
        CrossReferenceRecord.SetRange("Cross-Reference Type",0);

        if CrossReferenceRecord.Find('+') then
            VCrossItemNo := CrossReferenceRecord."Item No.";

        //Clear filters
        CrossReferenceRecord.SetRange("Cross-Reference No.");
        CrossReferenceRecord.SetRange("Cross-Reference Type");
    end;


    procedure UpdateNonStockUPC()
    begin
        //Look for UPC.  If it exists, update it, otherwise create a new UPC record for this item
        NonStockUPCTable.SetCurrentkey ("Nonstock Entry No.",UPC);
        NonStockUPCTable.SetRange("Nonstock Entry No.","Nonstock Item"."Entry No.");
        NonStockUPCTable.SetRange(UPC,VUPC);

        if NonStockUPCTable.Find('+') then
            begin
                NonStockUPCTable."Pack Desc" := VPackDescription;
                NonStockUPCTable."Pack Divider" := VPack;
                NonStockUPCTable."Last Date Updated" := Today();
                NonStockUPCTable.Modify(true);
            end
        else
            begin
                //Enter new UPC
                NonStockUPCTable."Nonstock Entry No." := "Nonstock Item"."Entry No.";
                NonStockUPCTable.UPC := VUPC;
                NonStockUPCTable.Insert(true);
                NonStockUPCTable."Pack Desc" := VPackDescription;
                NonStockUPCTable."Pack Divider" := VPack;
                NonStockUPCTable."Date Created" := Today();
                NonStockUPCTable."Last Date Updated" := Today();
                NonStockUPCTable.Modify(true);
                "Nonstock Item"."UPC Code for SMS" := VUPC;
                "Nonstock Item".Modify(true);
            end;
    end;


    procedure UpdateItemUPC()
    begin
        NewItemUPC := '';
        ItemUPCTable.SetCurrentkey ("Item No.",UPC);
        ItemUPCTable.SetRange("Item No.",VLookupItemNo);
        ItemUPCTable.SetRange(UPC,VUPC);

        if ItemUPCTable.Find('+') then
            begin
                ItemUPCTable."Pack Descrip" := VPackDescription;
                ItemUPCTable."Pack Divider" := VPack;
                ItemUPCTable."Last Date Updated" := Today();
                NewItemUPC := VUPC;
                ItemUPCTable.Modify(true);
            end
        else
            begin
            //Enter new UPC
            //Do not enter a new UPC if this is an item cross, the UPC may not be valid for the cross item
                if VCross <> true then
                    begin
                        ItemUPCTable."Item No." := VLookupItemNo;
                        ItemUPCTable.UPC := VUPC;
                        ItemUPCTable.Insert(true);
                        ItemUPCTable."Pack Descrip" := VPackDescription;
                        ItemUPCTable."Pack Divider" := VPack;
                        ItemUPCTable."Date Created" := Today();
                        ItemUPCTable."Last Date Updated" := Today();
                        NewItemUPC := VUPC;
                        ItemUPCTable.Modify(true);
                    end;
            end;

        //Update the item card with the new UPC if it changed
        if NewItemUPC <> '' then
            begin
                ItemRecord2.SetCurrentkey("No.");
                ItemRecord2.SetRange("No.",VLookupItemNo);
                    if ItemRecord2.Find('+') then
                        begin
                            ItemRecord2."UPC for SMS" := NewItemUPC;
                            ItemRecord2.Modify(true);
                        end;
            end;
    end;


    procedure MakeInactive()
    begin
        NonStocks.LockTable;
        //See if the nonstock item exists
        NonStocks.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        NonStocks.SetRange("Vendor Item No.",VVendorItemNo);
        NonStocks.SetRange("Manufacturer Code", 'G');

        if NonStocks.Find('+') then
            begin
                //Make the item inactive
                NonStocks."ANICA Inactive" := true;
                //Get item number to check item file
                VLookupItemNo := NonStocks."Item No.";
                NonStocks.Modify(true);
            end;

        //clear filters
        NonStocks.SetRange("Vendor Item No.");
        NonStocks.SetRange("Manufacturer Code");

        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",VLookupItemNo);

        if ItemRecord.Find('+') then
            begin
                ItemRecord."ANICA Inactive" := true;
                ItemRecord.Modify(true);
            end;
        ItemRecord.SetRange("No.");//clear filter
    end;
}

