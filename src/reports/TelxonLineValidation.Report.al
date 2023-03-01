Report 50020 "Telxon Line Validation"
{
    // 10-25-06 Added Item Variant to Telxon
    // 05-12-08 Added check for zero quantities
    // 10-28-10 Add descriptions etc to blocked or inactive items
    // 06-06-11 Add check for invalid store number - overflow on field
    // 11-18-11 Add code in shipping section to make all HAZ shipping codes 'DEF AIR'
    // 10-26-16 LCC Add Sales Price Table lookup to unit price lookup

    ProcessingOnly = true;
    ShowPrintStatus = false;

    dataset
    {
        dataitem("Telxon Input File";"Telxon Input File")
        {
            DataItemTableView = sorting(Processed,"Batch Name",Sequence) order(ascending) where(Processed=const(false));
            RequestFilterFields = "Customer Number",Sequence,"Vendor No.","Batch Name","Order Type";
            column(ReportForNavId_9733; 9733)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For Status Box
                begin
                  Window.Update(1,Sequence);
                end;


                with "Telxon Input File" do
                    begin
                        //Clear the order item no for items rerun
                        "Order Item No." := '';

                        //CS 05-04-15: Adding this so that items with these numbers are skipped, and error left alone.
                        if ("Import Item No." = 'JBGDISC') or ("Import Item No." = 'JBG999') then
                            CurrReport.Skip;

                        //CS 01-07-14: Adding this to prevent "On Hold" items from having error cleared out.
                        if not "On Hold" then
                            begin
                                "Import Error" := false;
                                "Error Remark" := '';
                            end;

                        Modify(true);

                        //Reset Variables
                        VQuantityPerBaseUOM := 1.0;
                        VSalesUnitofMeasure := '';
                        VPackDescription := '';
                        VPack := 0;
                        TOrderItemNo := '';
                        VPostGroup := '';
                        CheckNSItemNo := '';
                        VItemFound := false;
                        VLocationFound := false;
                        VCheckLocation := '';
                        VCheckblocked := false;
                        VUnitPrice := 0.0;
                        VCrossItemNo := '';
                        TFOBCode := '';
                        TShippingCode := '';
                        VNonStockFlag := false;
                        VCrossNSFlag := false;
                        VCatalogueFlag := false;
                        VCheckLocItem := '';
                        OrigItemNo := '';
                        TVendorName := '';
                        TGrossWeight := 0.0;
                        TPickType := 0;
                        VSToreUse := false;
                        VDropShipLocation := '';
                        VCustomerFound := false;
                        VImportError := false;
                        VImportRemark := '';
                        VItemFill := 0;
                        CheckJBGCross := false;
                        VADCQuantity := 0.0;
                        VADCCross := false;
                        VNonStockSequence := '';
                        VDiscontinued := false;
                        TItemVariant := '';
                        NewTItem := '';
                        TWIC := false;
                        VVelocity := 0;
                        VInactive := false;
                        VVendorLocation := ''; //CS 04/14/22 added.

                // ***** Get Telxon record information *****

                    //If customer number has not been entered
                    //Check for invalid number greater than 2
                    if StrLen(Store) > 2 then
                        begin
                            "Import Error" := true;
                            "Error Remark" := 'Store No Invalid';
                            Modify(true);
                        end;

                    //Check for customer number not been entered, causes error on default ship table lookup
                    if Store = '' then
                        begin
                            "Import Error" := true;
                            "Error Remark" := 'Store No. Is Missing';
                            Modify(true);
                        end;

                    if "Import Error" = false then
                        TStore := Store;

                    if "Import Error" = false then
                        LookupCustomer;

                    if VCustomerFound = true then
                        begin
                            "Customer Number" := TCustomerNumber;
                            Modify(true);
                        end
                    else
                        begin
                          if "Import Error" = false then
                              begin
                              //Do not overwrite the error if an earlier customer error was found
                              "Import Error" := true;
                              "Error Remark" := 'Store No Not Found';
                              end;
                        Modify(true);
                        //Changed 10-28-10 so that report skip occurs after item lookup
                        //CurrReport.SKIP;
                        end;

                    TDate := Date;
                    TManu := Manufacturer;
                    TItem := "Import Item No.";
                    TOrderItemNo := "Import Item No.";
                    TQuantity := Quantity;

                    if "Shipping Code" <> '' then
                        TShippingCode := "Shipping Code";

                    //ANICA 10-25-06
                    if "Item Variant" <> '' then
                        TItemVariant := "Item Variant";

                    TTelxonVendor := "Telxon Vendor";

                    case TTelxonVendor of
                        '1000': TManu := '';
                        '2000': TManu := 'VFG';
                        '3000': TManu := 'G';
                        '4000': TManu := 'S';
                        '5000': TManu := 'M';
                        '6000': TManu := 'VIP';
                        '7000': TManu := 'Y';
                        '8000': TManu := 'P';
                        '9000': TManu := 'C';
                         else   TManu := 'X'
                    end;

                    //Reject items with no telxon vendor number
                    if TManu = 'X' then
                        begin
                            "Import Error" := true;
                            "Error Remark" := 'Invalid Telxon Vendor';
                            Modify(true);
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end;

                    //Reject items with zero qty
                    //CS 07-01-14: Adding a check for blank quantities as well.
                    if (TQuantity = 0) or (Format(TQuantity) = '') then
                        begin
                            "Import Error" := true;
                            "Error Remark" := 'Zero Quantity';
                            Modify(true);
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end;

                // ***** General Item Number Validation Section *****

                    //Check catalogue items first so we can create items numbers if needed
                    //before validating the items
                    //Check to see if ordered item is a non-stock
                    if "Telxon Vendor" = '1000' then
                        begin
                            IsItem := true;
                            LookupItemNumber;
                        end
                    else
                        IsItem := false;

                    if IsItem = false then
                        begin
                          LookupNonStock;

                          //If non-stock is not found report the error and quit this record
                          if VItemFound = false then
                              begin
                                  "Import Error" := true;
                                  "Error Remark" := 'Cat Item Not Found';
                                  Modify;
                                  //Changed 10-28-10 so that report skip occurs after item lookup
                                  //CurrReport.SKIP;
                              end
                          else
                              begin
                                  //Check Item Numbers to see if they exist
                                  LookupItemNumber;
                                  Modify;
                              end;
                        end;

                // ***** Item Cross Over Section *****

                    //Read the Cross Reference Table to get item cross

                    //Skip the cross over section if the customer does not want cross from JBG
                    if (CheckJBGCross = true) and ("Telxon Vendor" = '3000') then
                        begin
                           VCrossItemNo := '';
                        end
                    else
                        begin
                            //LCC 5-7-10 changed to Torderitem no to allow UPC items to cross
                            //CheckCrossRefNo := TItem;
                            CheckCrossRefNo := TOrderItemNo;

                            //Since the Cross Reference table uses only the 6 digit JBG code, remove the first 2 characters.
                            if CopyStr(CheckCrossRefNo,1,2) = 'G-' then
                                CheckCrossRefNo := CopyStr(CheckCrossRefNo,3,6);

                            LookupCrossReference;

                            //Read the Cross Reference Table to get item cross up to 6 crosses
                            P := 1;
                            while P < 7 do
                                begin
                                    CheckCrossRefNo := VCrossItemNo;
                                    LookupCrossReference;
                                    P := P + 1;
                                end;
                        end;


                    //Need to check cross reference numbers to see if they are valid
                    if VCrossItemNo <> '' then
                        begin
                            VItemFound := true;

                            //CS 01-07-14: Adding this to prevent "On Hold" items from having error cleared out.
                            if not "On Hold" then
                                begin
                                    "Import Error" := false;
                                    "Error Remark" := '';
                                end;

                            ItemRecord.SetCurrentkey("No.");
                            ItemRecord.SetRange("No.",VCrossItemNo);

                            if ItemRecord.Find('+') then
                                begin
                                    //added 2-24-09 LCC - problem with inventory check, set isitem to true
                                    IsItem := true;
                                    VCheckblocked := ItemRecord.Blocked;
                                    VUnitPrice := ItemRecord."Unit Price";

                                    if ItemRecord."Drop Ship Item" = true then
                                        VCrossNSFlag := true;

                                    if ItemRecord."Created From Nonstock Item" = true then
                                        VCrossNSFlag := true;
                                end
                            else
                                begin
                                    "Import Error" := true;
                                    "Error Remark" := 'Cross Ref Item Not Found';
                                    Modify(true);
                                    //Changed 10-28-10 so that report skip occurs after item lookup
                                    //CurrReport.SKIP;
                                end;

                            //Check for unpriced items
                            if VUnitPrice = 0.0 then
                                begin
                                    "Import Error" := true;
                                    "Error Remark" := 'No Unit Price on cross item';
                                    Modify(true);
                                    //Changed 10-28-10 so that report skip occurs after item lookup
                                    //CurrReport.SKIP;
                                end;

                            //Check for blocked items
                            if VCheckblocked = true then
                                begin
                                    "Import Error" := true;
                                    "Error Remark" := 'Cross Ref Item is Blocked';
                                    Modify(true);
                                    //Changed 10-28-10 so that report skip occurs after item lookup
                                    //CurrReport.SKIP;
                                end;
                        end;


                    //IF the item is not found it is invalid
                    if VItemFound = false then
                        begin
                            "Import Error" := true;
                            "Error Remark" := 'Item No Not Found';
                            Modify(true);
                            CurrReport.Skip;
                        end;

                    //Check for unpriced items
                    if VUnitPrice = 0.0 then
                        begin
                            "Import Error" := true;
                            "Error Remark" := 'No Unit Price';
                            Modify(true);
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end;

                    //Check for blocked items
                    if VCheckblocked = true then
                        begin
                            "Import Error" := true;
                            "Error Remark" := 'Item No is Blocked';
                            Modify(true);
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end;

                    //Clear filter
                    ItemRecord.SetRange("No.");

                    //If the item cross was JBG remove the cross for stores
                    //that have no JBG to ANICA crossover
                    if (CheckJBGCross = true) and ("Telxon Vendor" = '3000') then
                        VCrossItemNo := '';

                    //8-27-03 stopped crossover for items on hold
                    //2-2-11 LCC change the stop cross only for non drop ship items
                    if ("On Hold" = true) and (VCrossNSFlag = false) then
                        VCrossItemNo := '';

                    //See if we have enough quantity on inventory cross for JBG
                    //may not need the following two lines, I reset at the beginning
                    VADCQuantity := 0.0;

                    //changed 11-9-04 from VADCCross to VlocationFound
                    VLocationFound := false;

                    if (VCrossNSFlag = false) and (VCrossItemNo <> '') and (CheckJBGCross = false) and ("Telxon Vendor" = '3000') then
                    begin
                        VCheckLocItem := VCrossItemNo;
                        VCheckLocation := 'ADC';
                        LookupLocation;

                        //added 2-24-09 LCC Change TOrderItemNo for CheckPrevousOrders routine
                        TOrderItemNo := VCrossItemNo;
                        CheckPreviousOrders;

                        //Put the TOrderItemNo value back
                        TOrderItemNo :=  OrigItemNo;

                        //changed from VADCCross to VlocationFound found 11-9-04
                        if (VLocationFound = true) and ((VADCQuantity - VItemFill) >= TQuantity) then
                            begin
                                TOrderItemNo := VCrossItemNo;
                            end
                        else
                            begin
                                TOrderItemNo := OrigItemNo;
                                //Set to no cross
                                VCrossItemNo := '';
                            end;
                    end;

                    //Set values for valid cross overs
                    //Changed from VADCCross to Vlocationfound 11-9-04
                        if (VCrossItemNo <> '') and (VLocationFound = false) then
                            begin
                               TOrderItemNo := VCrossItemNo;
                            end;

                    //Lookup items to get vendor no and other info after crosses
                        //Check for blocked items
                        if TOrderItemNo = '' then
                            begin
                                "Import Error" := true;
                                "Error Remark" := 'Item No not found';
                                Modify;
                                //Changed 10-28-10 so that report skip occurs after item lookup
                                //CurrReport.SKIP;
                            end;

                        LookupItemNumber;

                        //Check for blocked items
                        if VCheckblocked = true then
                            begin
                                "Import Error" := true;
                                "Error Remark" := 'Item No is Blocked';
                                "Pick code" := TPickType;
                                Modify;
                                //Changed 10-28-10 so that report skip occurs after item lookup
                                //CurrReport.SKIP;
                            end;

                        //Check for unpriced items
                        if VUnitPrice = 0.0 then
                            begin
                            "Import Error" := true;
                            "Pick code" := TPickType;
                            "Error Remark" := 'No Unit Price on cross item';
                            Modify;
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end;

                    //Set Store Use
                    if VPostGroup = 'STOREU' then
                        VSToreUse := true;

                // ***** Location Section *****

                        //If the Item is marked created from non-stock or normally non-stock
                        //Location is drop-ship, otherwise ADC
                        //Override the drop ship location from the location in the default shipping table
                        TDropShip := false;
                        TLocation := 'ADC';
                        if (VCatalogueFlag = true) or (VNonStockFlag = true) then
                            begin
                                TDropShip := true;
                                TLocation := 'DROP-SHIP';
                                //Commented out LCC 6-15-09
                                //TPickType := 0;
                            end;

                    //If a drop ship location exists in the default shipping table, it will override this later
                    //For ADC Items check to see if there is enough inventory
                    //1-12-04 changed this section to exclude items for orders on hold
                        NewQuantity := TQuantity;
                        if (TLocation <> 'DROP-SHIP') and (TDropShip = false) and ("On Hold" = false) and (IsItem = true) then
                            begin
                                CheckPreviousOrders;
                                VADCQuantity := 0.0;
                                VCheckLocItem := TOrderItemNo;
                                VCheckLocation := 'ADC';
                                LookupLocation;

                                if (VADCQuantity - VItemFill) > TQuantity then
                                    begin
                                        //There is enough in inventory for the order quantity
                                        VItemFill := VItemFill;//For a true argument
                                    end
                                else
                                    begin
                                        if (VADCQuantity - VItemFill) > 0 then
                                            NewQuantity := (VADCQuantity - VItemFill)
                                    else
                                        begin
                                            if TOrderItemNo <> '0040-9016' then
                                            begin
                                            "Order Item No." := TOrderItemNo;
                                            "Import Error" := true;
                                            "Pick code" := TPickType;
                                            "Error Remark" := 'Not enough inventory for order';
                                            "Shipping Code" := '';
                                            //CS 12-14-16: Adding Status Note from Item Card to lines with this error. Per Gina
                                            "Status Note" := VStatusNote;
                                            Modify;
                                            //Remove report skip so that inventory information is looked up - CurrReport.SKIP;
                                            end
                                        end;
                                    end;
                           end;

                    //For ADC Items set FOB code to Anchorage
                    //CS 2-8-12: Added a check for HAZ into the IF statement.
                    if (TLocation = 'ADC') and (TDropShip = false) and (TFOBCode <> 'HAZ') then
                        TFOBCode := 'ANC';

                    //Lookup Vendor Name
                    LookupVendor;

                    //Change vendor for Warehouse
                    ChangeVendorForWarehouse;

                // ***** Shipping Instruction Section *****

                    //First see if an instruction exists on the default shipping table
                    if "Import Error" = false then
                        LookupShipInstruct;

                    //Location will be read from this table for Drop Ship Location
                    if VDropShipLocation <> '' then
                        TLocation := VDropShipLocation;

                    //If no entry in the default shipping table table check for zero parcel post rate
                    //and default to air
                    if TShippingCode = '' then
                        begin
                            LookupParcelPostRates;

                            if (VParcelPostRate = 0.0) and (TShippingCode = '') then
                                TShippingCode := 'DEF AIR'; // will default to '027'

                            //If no shipping code default to parcel post
                            if TShippingCode = '' then
                                if TFOBCode = 'ANC' then
                                    TShippingCode := 'DEF ANC' // will default to 006
                            else
                                TShippingCode := 'DEF SEA'; // will default to 005
                        end;

                    // CS 11/18/11 : If item's FOB Code is HAZ, make Shipping Code 'DEF AIR'
                    // (To account for Commodity code being incorrect on some items).
                    if TFOBCode = 'HAZ' then
                        begin
                            TShippingCode := 'DEF AIR';
                        end;


                    //Check to see if the location exists for the final record
                    //if not, create a location record
                    VCheckLocation := TLocation;
                    VCheckLocItem := TOrderItemNo;

                    LookupLocation;

                    if VLocationFound = false then
                        begin
                            //See if location is valid
                            case TLocation of
                                'ADC' : VLocationFound := true;
                                'DROP-SHIP' : VLocationFound := true;
                                'KENT' : VLocationFound := true;
                                'BIA' : VLocationFound := true;
                                'CORP' : VLocationFound := true;
                                else VLocationFound := false
                        end;

                    if VLocationFound = false then
                        begin
                            "Order Item No." := TOrderItemNo;
                            "Import Error" := true;
                            "Error Remark" := 'No location' + TLocation;
                            Modify;
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end;
                    end;

                    //UPdate the OrderItem Number in the File
                    "Order Item No." := TOrderItemNo;
                    Modify(true);

                    //Added 5-13-10 LCC, skip the record if the item is inactive
                    if VInactive = true then
                        begin
                            "Import Error" := true;
                            "Error Remark" := 'Item is Inactive';
                            Modify(true);
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end;

                    //Update the file
                    Location := TLocation;
                    "Vendor No." := TVendorNo;
                    "Item Description" := TItemDescrip;
                    "Item Description2" := ItemDesc2;
                    "Shipping Code" := TShippingCode;
                    "FOB Code" := TFOBCode;
                    "Drop Ship" := TDropShip;

                    //CS 01-07-14: Adding 2nd part of IF to prevent "On Hold" items from having error cleared out.
                    if ("Import Error" <> true) and (not "On Hold") then
                        "Error Remark" := '';

                    "Vendor Name" := TVendorName;
                    "Gross Weight" := TGrossWeight;
                    "Vendor Location" := VVendorLocation; //CS 04-14-22 added.

                    //For now, change pick code to blank if not freeze or hazardous
                    case TPickType of
                        4 : TPickType := 0;
                        8 : TPickType := 0;
                    end;

                    "Pick code" := TPickType;
                    "Unit Price" := VUnitPrice;
                    "Store Use" := VSToreUse;
                    Manufacturer := TManu;

                    if NewQuantity < TQuantity then
                        begin
                            Quantity := NewQuantity;
                            "Inventory Fill Amount" := NewQuantity;
                        end
                    else
                        begin
                            Quantity := TQuantity;
                            "Inventory Fill Amount" := TQuantity;
                        end;

                    //Added 1-12-04, do not add an inventory fill quantity for items on hold
                    if "On Hold" = true then
                        "Inventory Fill Amount" := 0;

                    if Quantity <> 0 then
                        Validate(Quantity);

                    "Pack Description" := VPackDescription;
                    Pack := VPack;
                    "Sales Unit of Measure" := VSalesUnitofMeasure;
                    "Order Unit of Measure" := VUnitofMeasure;

                    //Convert the order quantity to sales order quantity based on sales UOM
                    "Sales Order Quantity" := ROUND(TQuantity/VQuantityPerBaseUOM,1.0);

                    //LCC 4-27-10 Add sales to date to velocity field
                    Velocity := VVelocity;
                    "WIC Code" := TWIC;

                    //CS 11/23/11 : Tobacco items are not receiving the correct shipping code after
                    // validation is run, so I'm adding this line as a temp fix.
                    //CS 11/29 : Fixed bug that caused this issue.  The following should no longer be needed.
                    //CS 7-1-16: Putting this back in play, so that JBG orders come up with CIG ship code.
                    if "Pick code" = 18 then
                        "Shipping Code" := 'CIG';

                    //CS 09/14/15: Added ANICA Commodity Code to the Table, per Gina.
                    "ANICA Commodity Code" := VCommodityCode;


                    Modify(true);

                    end;
            end;
        }
        dataitem("Check Minimums";"Telxon Input File")
        {
            DataItemTableView = sorting(Processed,"Import Error","Customer Number",Location,"Drop Ship","Shipping Code","Vendor No.","Order Type","Pick code",Sequence) order(ascending) where(Processed=const(false),"Import Error"=const(false));
            RequestFilterFields = "Customer Number",Sequence,Date;
            RequestFilterHeading = 'Check Minimums';
            column(ReportForNavId_5554; 5554)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Check Minimums".LockTable;

                //CS 05-04-15: Adding this so that items with these numbers are skipped, and error left alone.
                if ("Check Minimums"."Import Item No." = 'JBGDISC') or ("Check Minimums"."Import Item No." = 'JBG999') then
                    CurrReport.Skip;

                //2nd run through file to check minimums
                with "Check Minimums" do begin
                //The report filter excludes records already processed

                //>>1-10-06 Changed filter on error records to IF statement to speed up program
                if "Import Error" = true then CurrReport.Skip;

                //Set compare variables on first record only
                if VFirstRecord = true then
                begin
                //Get minimums to check against
                GetSalesSetupValues;
                VCurrStore := "Customer Number";
                VCurrLocation := Location;
                VCurrDropShip := "Drop Ship";
                VCurrShipcode := "Shipping Code";
                VCurrPickCode := "Pick code";
                VCurrVendor := "Vendor No.";
                VCurrOrderType := "Order Type";
                VFirstRecord := false;
                VNewOrder := false;
                P := 1;
                VEndOfFile := Count;
                end;

                //Count the physical records being read
                T := T+1;

                //Check to see if an order should be created
                if VCurrStore <> "Customer Number" then VNewOrder := true;
                if VCurrLocation <> Location then VNewOrder := true;
                if VCurrDropShip <> "Drop Ship" then VNewOrder := true;
                if VCurrShipcode <> "Shipping Code" then VNewOrder := true;

                //If hazardous or freeze, make a separate order (Not JBG)
                if "Vendor No." <> 'JBGO001' then
                begin
                //ANICA 05/06/09
                //CS 1/25/11: Added Pick code 12, for Chill.
                //CS 6-30-16: Changed tobacco from 6 to 18.
                  if ("Pick code" = 1) or ("Pick code" = 2) or ("Pick code" = 5) or ("Pick code" = 18) or ("Pick code" = 7) or ("Pick code" = 8)
                    or ("Pick code" = 9) or ("Pick code" = 10) or ("Pick code" = 11) or ("Pick code" = 12) then
                      begin
                          if VCurrPickCode <> "Pick code" then
                              VNewOrder := true;
                      end;
                end;

                //If Default shipping instructions are used, then break on vendor
                if (("Shipping Code" = 'DEF ANC') or ("Shipping Code" = 'DEF SEA') or ("Shipping Code" = 'DEF AIR')) and (Location <> 'ADC') then
                begin
                if VCurrVendor <> "Vendor No." then VNewOrder := true;
                end;

                //Create a separate order per vendor
                if VCurrVendor <> "Vendor No." then VNewOrder := true;

                if VCurrOrderType <> "Order Type" then VNewOrder := true;

                //Minimum Checks Processing Routine
                if VNewOrder = true then
                begin
                CheckOrderMin;
                //Reset check for new order
                VCurrStore := "Customer Number";
                VCurrLocation := Location;
                VCurrDropShip := "Drop Ship";
                VCurrShipcode := "Shipping Code";
                VCurrPickCode := "Pick code";
                VCurrVendor := "Vendor No.";
                VCurrOrderType := "Order Type";
                VOrderTotDollars := 0.0;
                VOrderTotWght := 0.0;
                VNewOrder := false;
                VImportError := false;
                VImportRemark := '';
                P := 1;
                end;

                //check for last line
                if VEndOfFile = T then
                begin
                 //IF P = 1, the order before was complete and this last line is one order with one line
                 if P = 1 then P:= 1 else P := Checklastline;
                 //Check for only one record being processed
                 if P = 0 then P := 1;
                 NewCustomerNumber := "Customer Number";
                 CkPickCode := "Pick code";
                 Vsequence[P] := Sequence;
                 VQuantity[P] := Quantity;
                 CKUnitPrice[P] := "Unit Price";
                 VChkVendor[P] := "Vendor No.";
                 VLocation[P] := Location;
                 VGrossWeight[P] := "Gross Weight";
                 VCkShipCode[P] := "Shipping Code";
                 //Get code to check JBG minimum bypass
                 VNoJBGMinimum[P] := "Allow Less 1000 lbs";
                 VNoHazMinimum[P] := "Allow HAZ Less 100 lbs";
                 //Increment for last check on sales lines
                 P:=P+1;
                 CheckOrderMin;
                end;

                //Do an array for line data
                CkPickCode := "Pick code";
                NewCustomerNumber := "Customer Number";
                Vsequence[P] := Sequence;
                VQuantity[P] := Quantity;
                CKUnitPrice[P] := "Unit Price";
                VChkVendor[P] := "Vendor No.";
                VLocation[P] := Location;
                VGrossWeight[P] := "Gross Weight";
                VCkShipCode[P] := "Shipping Code";
                VItemNo[P] := "Order Item No.";
                //Get code to check JBG minimum bypass
                VNoJBGMinimum[P] := "Allow Less 1000 lbs";
                VNoHazMinimum[P] := "Allow HAZ Less 100 lbs";

                P:=P+1;
                Checklastline := P;
                end;
            end;

            trigger OnPreDataItem()
            begin
                ClearAll;
                VFirstRecord := true;
            end;
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

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message('Telxon Validation is Complete');
    end;

    trigger OnPreReport()
    begin
        "Telxon Input File".LockTable;

        Window.Open('Processing Record #1##########');

        //REPEAT
          //Window.UPDATE(1,"Telxon Input File".Sequence);
        //UNTIL "Telxon Input File".NEXT = 0;
    end;

    var
        TelxonInputRecord: Record "Telxon Input File";
        ItemRecord: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesLine: Record "Sales Line";
        SalesPrice: Record "Sales Price";
        TStore: Code[7];
        TTelxonVendor: Code[10];
        TDate: Date;
        TImportItemNo: Code[20];
        TQuantity: Decimal;
        TItem: Code[20];
        TManu: Code[10];
        TCustomerNumber: Code[10];
        TManufacturer: Code[10];
        TLocation: Code[10];
        TShippingCode: Code[10];
        TOrderItemNo: Code[20];
        TDropShip: Boolean;
        TVendorNo: Code[10];
        VVendorLocation: Code[10];
        TProcessed: Boolean;
        TFOBCode: Code[10];
        TVendorName: Text[50];
        TGrossWeight: Decimal;
        TPickType: Option;
        TItemDescrip: Text[50];
        IsItem: Boolean;
        CheckJBGCross: Boolean;
        CheckNSItemNo: Code[20];
        VCatalogueFlag: Boolean;
        VCheckLocItem: Code[20];
        VCheckLocation: Code[20];
        VItemFound: Boolean;
        VUPCFound: Boolean;
        VFirstItemCode: Text[30];
        VCustomerFound: Boolean;
        VCrossItemNo: Code[20];
        VUnitPrice: Decimal;
        VDropShipLocation: Code[10];
        VADCQuantity: Decimal;
        VNonStockFlag: Boolean;
        VADCCross: Boolean;
        VCommodityCode: Code[10];
        VParcelPostRate: Decimal;
        CheckCrossRefNo: Code[20];
        VCheckblocked: Boolean;
        VPostGroup: Code[10];
        VSToreUse: Boolean;
        NonStockCreate: Codeunit "Catalog Item Management";
        OrigItemNo: Code[20];
        C: Integer;
        P: Integer;
        T: Integer;
        ArrayStart: Integer;
        ArrayEnd: Integer;
        Window: Dialog;
        VCurrStore: Code[10];
        VCurrLocation: Code[10];
        VCurrDropShip: Boolean;
        VCurrShipcode: Code[10];
        VCurrPickCode: Option;
        VCurrVendor: Code[10];
        VCurrOrderType: Option;
        VFirstRecord: Boolean;
        VNewOrder: Boolean;
        NewCustomerNumber: Code[10];
        VEndOfFile: Integer;
        AirtFrtMin: Decimal;
        VAirFreightMin: Decimal;
        VBethAirFrtMin: Decimal;
        VOrderMin: Decimal;
        VJBGHazMin: Decimal;
        VChkVendor: array [6000] of Code[10];
        VNoJBGMinimum: array [6000] of Boolean;
        VNoHazMinimum: array [6000] of Boolean;
        VLocation: array [6000] of Code[20];
        VCkShipCode: array [6000] of Code[10];
        VOrderTotDollars: Decimal;
        VOrderTotWght: Decimal;
        VMaxNoJBGMinimum: Boolean;
        VMaxNoHazMinimum: Boolean;
        VGrossWeight: array [6000] of Decimal;
        TVendorMin: Decimal;
        CkVendorTotal: Decimal;
        VendorError: array [6000] of Boolean;
        VendorRemark: array [6000] of Text[30];
        Vsequence: array [6000] of Integer;
        CKUnitPrice: array [6000] of Decimal;
        CkPickCode: Option;
        VQuantity: array [6000] of Decimal;
        VImportError: Boolean;
        VImportRemark: Text[30];
        Checklastline: Integer;
        VFirstArray: Boolean;
        VItemFill: Decimal;
        NewQuantity: Decimal;
        VLocationFound: Boolean;
        VCrossNSFlag: Boolean;
        VSalesUnitofMeasure: Code[10];
        VUnitofMeasure: Code[10];
        VPackDescription: Text[20];
        VPack: Decimal;
        VQuantityPerBaseUOM: Decimal;
        VNonStockSequence: Code[20];
        VDiscontinued: Boolean;
        FindSequence: Integer;
        VItemNo: array [6000] of Code[30];
        d: Integer;
        e: Integer;
        f: Integer;
        g: Integer;
        h: Integer;
        J: Integer;
        ItemDesc2: Text[50];
        ItemVariant: Record "Item Variant";
        TItemVariant: Code[10];
        ItemUPC: Record "Item UPC Table";
        NonstockUPC: Record "Nonstock UPC Table";
        Nonstocks: Record "Nonstock Item";
        LUPC: Code[20];
        LLength: Integer;
        NewTItem: Code[20];
        TWIC: Boolean;
        VVelocity: Decimal;
        VInactive: Boolean;
        VFirstSix: Text[6];
        VLastItemCode: Text[1];
        VANICACommCode: Code[10];
        VSalesPrice: Decimal;
        VSalesStartDate: Date;
        VSalesEndDate: Date;
        VStatusNote: Text[60];


    procedure LookupCustomer()
    var
        CustomerRecord: Record Customer;
    begin
        CustomerRecord.SetCurrentkey("Telxon Store number");
        CustomerRecord.SetRange("Telxon Store number",TStore);

        if CustomerRecord.Find('+') then
            begin
                CheckJBGCross := CustomerRecord."NoJBG Cross Flag";
                TCustomerNumber := CustomerRecord."No.";
                VCustomerFound := true;
            end
        else
            begin
                CheckJBGCross := false;
                VCustomerFound := false;
                TCustomerNumber := '';
            end;
    end;


    procedure LookupItemNumber()
    begin
        VInactive := false;
        VUPCFound := false;

        //First check for UPC instead of item number

        //If the item number is other than 9 digits long, assume it is a UPC
        if StrLen(TOrderItemNo) <> 9 then
          begin
              //First try as is and drop the first 0 on thirteen digits
              LLength := StrLen(TOrderItemNo);
              VFirstItemCode := CopyStr(TOrderItemNo,1,1);

              if LLength = 13 then
                  NewTItem := CopyStr(TOrderItemNo,2,12)
              else
                  NewTItem := TOrderItemNo;

              ItemUPC.SetCurrentkey(ItemUPC.UPC);
              ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
                //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
                if ItemUPC.Find('+') then
                    begin
                        TOrderItemNo := ItemUPC."Item No.";
                        VUPCFound := true;
                    end;

            //Next, if this is a 10 digit UPC, add two zeros and check
            if (VUPCFound = false) and (LLength = 10) and (VFirstItemCode >= '0') and (VFirstItemCode <= '9') then
                begin
                  NewTItem := '00' + TOrderItemNo;
                  ItemUPC.SetCurrentkey(ItemUPC.UPC);
                  ItemUPC.SetRange(ItemUPC.UPC,NewTItem);

                  //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
                  if ItemUPC.Find('+') then
                    begin
                        TOrderItemNo := ItemUPC."Item No.";
                        VUPCFound := true;
                    end;
                end;

          //If that doesn't work try dropping the check digit on 13 digit numbers
          if (VUPCFound = false) and (LLength = 13) and (VFirstItemCode >= '0') and (VFirstItemCode <= '9') then
          begin
            NewTItem := CopyStr(TOrderItemNo,1,12);
            ItemUPC.SetCurrentkey(ItemUPC.UPC);
            ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
            //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
            if ItemUPC.Find('+') then
                begin
                    TOrderItemNo := ItemUPC."Item No.";
                    VUPCFound := true;
                end;
          end;

          //Reformat 8 digit numbers to 12
          //Drop the first and last digit, the format is 00 and 126 and 0000 and 345
          if (VUPCFound = false) and (LLength = 8) and (VFirstItemCode >= '0') and (VFirstItemCode <= '9') then
          begin
            NewTItem := '00' + CopyStr(TOrderItemNo,2,2) + CopyStr(TOrderItemNo,7,1) + '0000' + CopyStr(TOrderItemNo,4,3);
            ItemUPC.SetCurrentkey(ItemUPC.UPC);
            ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
            //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
            if ItemUPC.Find('+') then
                begin
                TOrderItemNo := ItemUPC."Item No.";
                VUPCFound := true;
                end;
          end;


          //CS 2-3-12: modifying this so that produce items have 8 leading zeros
          //For remaining 12 digit add a zero and drop the check digit
          if (VUPCFound = false) and (LLength = 12) and (VFirstItemCode >= '0') and (VFirstItemCode <= '9') then
              begin
                  VFirstSix := CopyStr(TOrderItemNo,1,6);
                  VLastItemCode := CopyStr(TOrderItemNo,12,1);

                  if (VFirstSix = '000000') and (VLastItemCode = '0') then
                      NewTItem := '00000000' + CopyStr(TOrderItemNo,7,4)
                  else
                      NewTItem := '0' + CopyStr(TOrderItemNo,1,11);

                  ItemUPC.SetCurrentkey(ItemUPC.UPC);
                  ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
                  //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
                  if ItemUPC.Find('+') then
                      begin
                          TOrderItemNo := ItemUPC."Item No.";
                          VUPCFound := true;
                      end;
              end;


          //For remaining 11 digit add a zero
          if (VUPCFound = false) and (LLength = 11) and (VFirstItemCode >= '0') and (VFirstItemCode <= '9') then
          begin
            NewTItem := '0' + TOrderItemNo;
            ItemUPC.SetCurrentkey(ItemUPC.UPC);
            ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
            //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
            if ItemUPC.Find('+') then
                begin
                    TOrderItemNo := ItemUPC."Item No.";
                    VUPCFound := true;
                end;
          end;


        end;//End UPC Section

        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",TOrderItemNo);
        if ItemRecord.Find('+') then
            begin
            VItemFound := true;
            VCatalogueFlag := ItemRecord."Created From Nonstock Item";
            TVendorNo := ItemRecord."Vendor No.";
            VVendorLocation := ItemRecord."Vendor Location"; //CS Added 04/14/22
            TGrossWeight := ItemRecord."Gross Weight";
            TItemDescrip := ItemRecord.Description;
            ItemDesc2 := ItemRecord."Description 2";
            VNonStockFlag := ItemRecord."Drop Ship Item";
            VCheckblocked := ItemRecord.Blocked;
            VUnitPrice := ItemRecord."Unit Price";
            VPostGroup := ItemRecord."Gen. Prod. Posting Group";
            VSalesUnitofMeasure := ItemRecord."Sales Unit of Measure";
            VUnitofMeasure := ItemRecord."Base Unit of Measure";
            TFOBCode := ItemRecord."FOB Code";
            VCommodityCode := ItemRecord."Commodity Code";
            TPickType := ItemRecord."Pick Type";
            VStatusNote := ItemRecord."Status Note"; //CS 12-14-16: For 'Not enough inventory error'.

            //Added 10-26-16 LCC Need to check and see if a sales price exists for this item
            LookupSalesPrice;
            if (VSalesPrice <> 0) and (TDate >= VSalesStartDate) and (TDate <= VSalesEndDate) then VUnitPrice := VSalesPrice;

            //Added 4-27-10 LCC add velocity
            ItemRecord.CalcFields(ItemRecord."Sales (Qty.)");
            VVelocity := ItemRecord."Sales (Qty.)";
            TWIC := ItemRecord."WIC Item";

            //LCC Added 5-13-10
            VInactive := ItemRecord."ANICA Inactive";

            //ANICA 10-25-06
            if TItemVariant <> '' then
                begin
                ItemVariant.SetCurrentkey(ItemVariant."Item No.",ItemVariant.Code);
                ItemVariant.SetRange(ItemVariant."Item No.",TOrderItemNo);
                ItemVariant.SetRange(ItemVariant.Code,TItemVariant);
                if ItemVariant.Find('-') then
                    begin
                    TItemDescrip := ItemVariant.Description;
                    ItemDesc2 := ItemVariant."Description 2";
                    end;
                end;

             if ItemRecord."Drop Ship Item" = true then VNonStockFlag := true;
             //Keep this variable in case we cross back
             OrigItemNo := TOrderItemNo;
           end
        else VItemFound := false;

        //Clear filter
        ItemRecord.SetRange("No.");

        //Lookup pack and UOM information
        if VItemFound = true then
            begin
                if ItemUnitofMeasure.Get(TOrderItemNo,VSalesUnitofMeasure) then
                    begin
                        VPackDescription := ItemUnitofMeasure."Pack Description";
                        VPack := ItemUnitofMeasure.Pack;
                        VQuantityPerBaseUOM := ItemUnitofMeasure."Qty. per Unit of Measure";
                    end
                else
                    begin
                        VPackDescription := '';
                        VPack := 0;
                    end;

            end;

        //IF NewTItem = '001070002808' THEN MESSAGE('after item lookup torderitem llength newitem vitemfound %1 %2 %3 %4',
        //        TOrderItemNo,LLength,NewTItem,VItemFound);
    end;


    procedure LookupNonStock()
    var
        NonStockRecord: Record "Nonstock Item";
    begin
        NonStockRecord.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        NonStockRecord.SetRange("Vendor Item No.",TItem);
        NonStockRecord.SetRange("Manufacturer Code", TManu);

        if NonStockRecord.Find('+') then
            begin
                if NonStockRecord."Change Indicator" = 'D' then
                    VDiscontinued := true;

                VItemFound := true;
                CheckNSItemNo := NonStockRecord."Item No.";
                VUnitPrice := NonStockRecord."Unit Price";
                VNonStockSequence := NonStockRecord."Entry No.";
            end
        else VItemFound := false;
        //IF Item has not been created, create it
        if (CheckNSItemNo = '') and (VItemFound = true) then
            begin
                NonStockCreate.NonstockAutoItem(NonStockRecord);
                CheckNSItemNo := NonStockRecord."Item No.";
            end;


        //check for UPC if the item was not found
        //First try UPC as is against the ITEM UPC file
        if VItemFound = false then
            begin
                NewTItem := TItem;
                LLength := StrLen(TItem);
                if LLength = 13 then
                    NewTItem := CopyStr(TItem,2,12)
                else NewTItem := TItem;

                ItemUPC.SetCurrentkey(ItemUPC.UPC);
                ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
                  if ItemUPC.Find('-') then
                      begin
                          VItemFound := true;
                          CheckNSItemNo := ItemUPC."Item No.";
                      end;
            end;

        //clear filter
        ItemUPC.SetRange(ItemUPC.UPC);

        //Next check as is against the Nonstock upc file
        if VItemFound = false then
            begin
                NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
                NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

                if NonstockUPC.Find('-') then
                  begin
                      VItemFound := true;
                      Nonstocks.SetCurrentkey(Nonstocks."Entry No.");
                      Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");

                      if Nonstocks.Find('-') then
                         begin
                            CheckNSItemNo := Nonstocks."Item No.";
                            VNonStockSequence := Nonstocks."Entry No.";
                            VUnitPrice := Nonstocks."Unit Price";
                            CreateNonStockItem;
                         end;
                  end;
            end;

        //Clear filters
        NonstockUPC.SetRange(NonstockUPC.UPC);
        Nonstocks.SetRange(Nonstocks."Entry No.");


        //Next, if this is a 10 digit UPC, add two zeros and check
        if (VItemFound = false) and (LLength = 10) then
            begin
                NewTItem := '00' + TItem;
                ItemUPC.SetCurrentkey(ItemUPC.UPC);
                ItemUPC.SetRange(ItemUPC.UPC,NewTItem);

                if ItemUPC.Find('-') then
                  begin
                      VItemFound := true;
                      CheckNSItemNo := ItemUPC."Item No.";
                  end;
            end;

        //clear filter
        ItemUPC.SetRange(ItemUPC.UPC);


        //Next check as is against the Nonstock upc file
        if VItemFound = false then
            begin
            NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
            NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

            if NonstockUPC.Find('-') then
                begin
                VItemFound := true;
                Nonstocks.SetCurrentkey(Nonstocks."Entry No.");
                Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");

                if Nonstocks.Find('-') then
                    begin
                        CheckNSItemNo := Nonstocks."Item No.";
                        VNonStockSequence := Nonstocks."Entry No.";
                        VUnitPrice := Nonstocks."Unit Price";
                        CreateNonStockItem;
                    end;
                end;
            end;

            NonstockUPC.SetRange(NonstockUPC.UPC);//Clear filter
            Nonstocks.SetRange(Nonstocks."Entry No.");//Clear filter

        //If that doesn't work try dropping the check digit on 13 digit numbers
        if (VItemFound = false) and (LLength = 13) then
        begin
            NewTItem := CopyStr(TItem,1,12);
            ItemUPC.SetCurrentkey(ItemUPC.UPC);
            ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
            if ItemUPC.Find('-') then
                begin
                VItemFound := true;
                CheckNSItemNo := ItemUPC."Item No.";
                end;
        end;

        //clear filter
        ItemUPC.SetRange(ItemUPC.UPC);

        //Next check as is against the Nonstock upc file
        if VItemFound = false then
            begin
                NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
                NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

                if NonstockUPC.Find('-') then
                    begin
                        VItemFound := true;
                        Nonstocks.SetCurrentkey(Nonstocks."Entry No.");
                        Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");

                        if Nonstocks.Find('-') then
                            begin
                                CheckNSItemNo := Nonstocks."Item No.";
                                VNonStockSequence := Nonstocks."Entry No.";
                                VUnitPrice := Nonstocks."Unit Price";
                                CreateNonStockItem;
                            end;
                    end
            end;

          NonstockUPC.SetRange(NonstockUPC.UPC);//Clear filter
          Nonstocks.SetRange(Nonstocks."Entry No.");//Clear filter


        //Reformat 8 digit numbers to 12
        //Drop the first and last digit, the format is 00 and 126 and 0000 and 345
        if (VItemFound = false) and (LLength = 8) then
            begin
                NewTItem := '00' + CopyStr(TItem,2,2) + CopyStr(TItem,7,1) + '0000' + CopyStr(TItem,4,3);
                ItemUPC.SetCurrentkey(ItemUPC.UPC);
                ItemUPC.SetRange(ItemUPC.UPC,NewTItem);

                if ItemUPC.Find('-') then
                    begin
                        VItemFound := true;
                        CheckNSItemNo := ItemUPC."Item No.";
                    end;
            end;

        //clear filter
        ItemUPC.SetRange(ItemUPC.UPC);

        //Next check as is against the Nonstock upc file
        if VItemFound = false then
            begin
                NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
                NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

                if NonstockUPC.Find('-') then
                    begin
                        VItemFound := true;
                        Nonstocks.SetCurrentkey(Nonstocks."Entry No.");
                        Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");

                        if Nonstocks.Find('-') then
                            begin
                                CheckNSItemNo := Nonstocks."Item No.";
                                VNonStockSequence := Nonstocks."Entry No.";
                                CreateNonStockItem;
                            end;
                    end;
            end;

        //Clear filters
        NonstockUPC.SetRange(NonstockUPC.UPC);
        Nonstocks.SetRange(Nonstocks."Entry No.");

        //For remaining 12 digit add a zero and drop the check digit
        if (VItemFound = false) and (LLength = 12) then
            begin
                NewTItem := '0' + CopyStr(TItem,1,11);
                ItemUPC.SetCurrentkey(ItemUPC.UPC);
                ItemUPC.SetRange(ItemUPC.UPC,NewTItem);

                if ItemUPC.Find('-') then
                    begin
                        VItemFound := true;
                        CheckNSItemNo := ItemUPC."Item No.";
                    end;
            end;

        //clear filter
        ItemUPC.SetRange(ItemUPC.UPC);

        //Next check as is against the Nonstock upc file
        if VItemFound = false then
            begin
                NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
                NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

                if NonstockUPC.Find('-') then
                begin
                    VItemFound := true;
                    Nonstocks.SetCurrentkey(Nonstocks."Entry No.");
                    Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");

                    if Nonstocks.Find('-') then
                        if Nonstocks.Find('-') then
                            begin
                                CheckNSItemNo := Nonstocks."Item No.";
                                VNonStockSequence := Nonstocks."Entry No.";
                                CreateNonStockItem;
                            end;
                end;
            end;

        //Clear filters
        NonstockUPC.SetRange(NonstockUPC.UPC);
        Nonstocks.SetRange(Nonstocks."Entry No.");

          //For remaining 11 digit add a zero
          if (VItemFound = false) and (LLength = 11) then
              begin
                  NewTItem := '0' + TItem;
                  ItemUPC.SetCurrentkey(ItemUPC.UPC);
                  ItemUPC.SetRange(ItemUPC.UPC,NewTItem);

                  if ItemUPC.Find('-') then
                      begin
                      VItemFound := true;
                      CheckNSItemNo := ItemUPC."Item No.";
                      end;
              end;

            //clear filters
            ItemUPC.SetRange(ItemUPC.UPC);

          //Next check as is against the Nonstock upc file
          if VItemFound = false then
              begin
                  NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
                  NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

                  if NonstockUPC.Find('-') then
                      begin
                          VItemFound := true;
                          Nonstocks.SetCurrentkey(Nonstocks."Entry No.");
                          Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");

                          if Nonstocks.Find('-') then
                              if Nonstocks.Find('-') then
                                  begin
                                      CheckNSItemNo := Nonstocks."Item No.";
                                      VNonStockSequence := Nonstocks."Entry No.";
                                      CreateNonStockItem;
                                  end;
                      end;
              end;

            //Clear filters
            NonstockUPC.SetRange(NonstockUPC.UPC);
            Nonstocks.SetRange(Nonstocks."Entry No.");

        //END UPC Section

        TOrderItemNo := CheckNSItemNo;
    end;


    procedure CreateNonStockItem()
    begin
        //IF Item has not been created, create it
        if (CheckNSItemNo = '') and (VItemFound = true) then
            begin
                NonStockCreate.NonstockAutoItem(Nonstocks);
                CheckNSItemNo := Nonstocks."Item No.";
            end
    end;


    procedure LookupCrossReference()
    var
        CrossReferenceRecord: Record "Item Cross Reference";
    begin
        CrossReferenceRecord.SetCurrentkey("Cross-Reference No.","Cross-Reference Type");
        CrossReferenceRecord.SetRange("Cross-Reference No.",CheckCrossRefNo);
        CrossReferenceRecord.SetRange("Cross-Reference Type",0);

        //CS 07-26-12: Changed the '+' to a '-' to try to fix the issue of UPC's not crossing correctly.
        //CS 11-05-12: Changed back to '+'. This wasn't the issue.  And '+' will grab the ANICA number, rather than the G number.
        if CrossReferenceRecord.Find('+') then
            VCrossItemNo := CrossReferenceRecord."Item No.";

        //Clear filters
        CrossReferenceRecord.SetRange("Cross-Reference No.");
        CrossReferenceRecord.SetRange("Cross-Reference Type");
    end;


    procedure LookupLocation()
    begin
        //In version 3.7 there is no longer a location table.  Checking the item ledger entry table
        //   and sales line tables for quantities by location.
        VLocationFound := false;
        VADCQuantity := 0;

        ItemLedgerEntry.SetCurrentkey("Item No.","Location Code",Open);
        ItemLedgerEntry.SetRange("Item No.",VCheckLocItem);
        ItemLedgerEntry.SetRange("Location Code",VCheckLocation);
        ItemLedgerEntry.SetRange(Open,true);

        if ItemLedgerEntry.Find('-') then
            begin
               VLocationFound := true;
               repeat
                  //VADCQuantity := ItemLedgerEntry.Quantity + VADCQuantity;
                  VADCQuantity := ItemLedgerEntry."Remaining Quantity" + VADCQuantity;
               until ItemLedgerEntry.Next = 0;
            end
        else
            VLocationFound := false;

        //Clear filters
        ItemLedgerEntry.SetRange("Item No.");
        ItemLedgerEntry.SetRange("Location Code");

        //Lookup sales lines for quantities on sales orders
        SalesLine.SetCurrentkey("Location Code",Type,"No.");
        SalesLine.SetRange("Location Code",VCheckLocation);
        SalesLine.SetRange(Type,2);
        SalesLine.SetRange("No.",VCheckLocItem);

        if SalesLine.Find('-') then
        begin
           repeat
           //Lookup sales lines and reduce the quantity already on order from VADC Quantity
           //LCC 3-11-09 changed the following form SalesLine.Quantity to SalesLine.Outstanding Quantity
           VADCQuantity := VADCQuantity - SalesLine."Outstanding Quantity";
           until SalesLine.Next = 0;
        end;

        //Clear filters
        SalesLine.SetRange("No.");
        SalesLine.SetRange("Location Code");
        SalesLine.SetRange(Type);
    end;


    procedure LookupParcelPostRates()
    var
        ParcelPostRateRecord: Record "Parcel Post Direct Rates";
    begin
        ParcelPostRateRecord.SetCurrentkey("Commodity Code");
        ParcelPostRateRecord.SetRange("Commodity Code",VCommodityCode);

        if ParcelPostRateRecord.Find('+') then
            begin
                VParcelPostRate := ParcelPostRateRecord."Rate per dollar";
            end
        else
            VParcelPostRate := 0.0;

        //Clear filter
        ParcelPostRateRecord.SetRange("Commodity Code");
    end;


    procedure LookupVendor()
    var
        VendorRecord: Record Vendor;
    begin
        VendorRecord.SetCurrentkey("No.");
        VendorRecord.SetRange("No.",TVendorNo);

        if VendorRecord.Find('+') then
            begin
              TVendorName := VendorRecord.Name;
              TVendorMin :=  VendorRecord."Vendor Minimum";
            end;
    end;


    procedure LookupShipInstruct()
    var
        ShipTableRecord: Record "Default Shipping Table";
    begin
        ShipTableRecord.SetCurrentkey("FOB Code","Store No.","Vendor No.");
        ShipTableRecord.SetRange("FOB Code",TFOBCode);
        ShipTableRecord.SetRange("Store No.",TCustomerNumber);
        ShipTableRecord.SetRange("Vendor No.",TVendorNo);

        if ShipTableRecord.Find('+') then
            begin
                TShippingCode := ShipTableRecord."Shipping Instruction";
                VDropShipLocation := ShipTableRecord."Drop Ship Location";
            end;
    end;


    procedure GetSalesSetupValues()
    var
        ARSetupRecord: Record "Sales & Receivables Setup";
    begin
        ARSetupRecord.Find('+');
        VAirFreightMin := ARSetupRecord."Air Freight Minimum";
        VBethAirFrtMin := ARSetupRecord."Air Freight Min - Co Stores";
        VOrderMin := ARSetupRecord."Order Minimum";
        VJBGHazMin := ARSetupRecord."JBG Haz Weight Min";
    end;


    procedure CheckOrderMin()
    var
        ShipLegRecord: Record "Shipping Legs";
    begin
        VImportError := false;
        VImportRemark := '';
        VOrderTotDollars := 0;
        VOrderTotWght := 0;
        VMaxNoJBGMinimum := false;
        VMaxNoHazMinimum := false;

        //Get totals
        //Also, if any line has the 'allow under JBG 1000' pounds marked, all lines will qualify.
        //1-25-11, if any line has the 'allow HAZ under 100' pounds marked, all lines will qualify.
        d := 1;

        repeat
            VOrderTotDollars := VOrderTotDollars + (VQuantity[d] * CKUnitPrice[d]);
            VOrderTotWght := VOrderTotWght + (VGrossWeight[d] * VQuantity[d]);
            if VMaxNoJBGMinimum = false then VMaxNoJBGMinimum := VNoJBGMinimum[d];
            if VMaxNoHazMinimum = false then VMaxNoHazMinimum := VNoHazMinimum[d];
            d := d + 1;
        until d >= P;

        //check vendor minimums within the order
        //Check first Vendor
        TVendorNo := VChkVendor[1];

        e := 1;
        VFirstArray := true;

        repeat
            CkVendorTotal := 0;
            TVendorNo := VChkVendor[e];
            TVendorMin := 0;
            LookupVendor;

            while TVendorNo = VChkVendor[e] do
                begin
                    if VFirstArray = true then
                        begin
                            //ArrayStart := e;
                            VFirstArray := false;
                        end;
                    CkVendorTotal := CkVendorTotal + (VQuantity[e] * CKUnitPrice[e]);
                    e := e + 1;
                end;

            //Get the ending value of E in the range and reduce by 1
            //ArrayEnd := e - 1;
            if TVendorMin > 0 then
                begin
                    if CkVendorTotal < TVendorMin then
                    begin
                        VImportError := true;
                        VImportRemark := 'Below Vendor Minimum ' + CopyStr(TVendorNo,1,7);
                        f := 1;

                        repeat
                            FindSequence := Vsequence[f];
                            ProcessErrorUpdate;
                            f := f + 1;
                        until f >= P;
                    end;
                end;
            VFirstArray := true;
        until e >= P;


        VImportError := false;
        VImportRemark := '';

        //Check for overall order minimums
        if VOrderTotDollars < VOrderMin then
            begin
                VImportError := true;
                VImportRemark := 'Below ANICA Minimum Order';
            end;

        //See if the order is air freight
        h := 1;
        repeat
            ShipLegRecord.SetCurrentkey("Shipping Instruction Code","Calculation Type");
            ShipLegRecord.SetRange("Shipping Instruction Code",VCkShipCode[h]);
            ShipLegRecord.SetRange("Calculation Type",1);

            if ShipLegRecord.Find('+') then
                begin
                    //Check Air freight Minimum
                    case NewCustomerNumber of
                        'FAMI001' : AirtFrtMin := VBethAirFrtMin;
                        'RIVE001' : AirtFrtMin := VBethAirFrtMin;
                        'BETH001' : AirtFrtMin := VBethAirFrtMin;
                        'KALT001' : AirtFrtMin := VBethAirFrtMin;
                        else AirtFrtMin := VAirFreightMin
                    end;

                    if VOrderTotWght < VAirFreightMin then
                        begin
                            VImportError := true;
                            VImportRemark := 'Below Air Freight Minimum';
                        end;
                end;
            h := h + 1;
        until h >= P;

        //1-25-11 LCC if any line is checked to ignore the 100 lb HAZ minimum, all lines for that order will not be tested
        //Check For JBG Hazardous less than 100 pounds
        if VMaxNoHazMinimum = false then
            begin
                if (CkPickCode = 1) and (VChkVendor[1] = 'JBGO001') and (VOrderTotWght < VJBGHazMin) then
                    begin
                        VImportError := true;
                        VImportRemark := 'JBG Hazardous under 100 lb';
                    end;
            end;

        //2-5-03 Add Check for JBG orders under 1000 lbs
        //12-14-10 if any line is checked to ignore the 1000 lb minimum, all lines for that order will not be tested
        if VMaxNoJBGMinimum = false then
            begin
                if (VChkVendor[1] = 'JBGO001') and (VOrderTotWght < 1000) and (VLocation[1] <> 'ADC')  then
                    begin
                        VImportError := true;
                        VImportRemark := 'JBG Below 1000 lb. Bypass Wt.';
                    end;
            end;

        if VImportError = true then
            begin
                J := 1;
                    repeat
                        FindSequence := Vsequence[J];
                        ProcessErrorUpdate;
                        J := J + 1;
                    until J >= P;
            end;

        VImportError := false;
        VImportRemark := '';
    end;


    procedure ProcessErrorUpdate()
    var
        TelxonInputRecord2: Record "Telxon Input File";
    begin
        TelxonInputRecord2.SetCurrentkey(Sequence);
        TelxonInputRecord2.SetRange(Sequence,FindSequence);
        TelxonInputRecord2.Find('+');

        //CS 01-07-14: Adding this to prevent "On Hold" items from having error cleared out.
        if not TelxonInputRecord2."On Hold" then
            begin
                TelxonInputRecord2."Import Error" := VImportError;
                TelxonInputRecord2."Error Remark" := VImportRemark;
            end;

        TelxonInputRecord2.Modify(true);
        TelxonInputRecord2.SetRange(Sequence);//to clear
    end;


    procedure CheckPreviousOrders()
    var
        TelxonInputRecord3: Record "Telxon Input File";
    begin
        VItemFill := 0;
        TelxonInputRecord3.SetCurrentkey("Order Item No.","Import Error",Processed,"On Hold");
        TelxonInputRecord3.SetRange("Order Item No.",TOrderItemNo);
        TelxonInputRecord3.SetRange("Import Error",false);
        TelxonInputRecord3.SetRange(Processed,false);
        TelxonInputRecord3.SetRange("On Hold",false);

        if TelxonInputRecord3.Find('-') then
            repeat
                VItemFill := VItemFill + TelxonInputRecord3."Inventory Fill Amount";
            until TelxonInputRecord3.Next = 0;

        //To Clear Filters
        TelxonInputRecord3.SetRange("Order Item No.");
        TelxonInputRecord3.SetRange("Import Error");
        TelxonInputRecord3.SetRange(Processed);
        TelxonInputRecord3.SetRange("On Hold");
    end;


    procedure ChangeVendorForWarehouse()
    begin
        if (TLocation = 'ADC') and (TDropShip = false) then
            begin
                TVendorName := 'Anchorage Warehouse';
                TVendorNo := 'ANIC030';

                if TPickType = 1 then
                    begin
                        TVendorName := 'Anchorage Hazardous';
                        TVendorNo := 'ANIC059';
                    end;

                if TPickType = 2 then
                    begin
                        TVendorName := 'Anchorage Chill/Freeze';
                        TVendorNo := 'ANIC040';
                    end;

                if TPickType = 18 then //CS 6-30-16 Changed due to change in Tobacco Pick Type Position.
                    begin
                        TVendorName := 'Anchorage Tobacco';
                        TVendorNo := 'ANIC031';
                    end;

                if TPickType = 12 then
                    begin
                        TVendorName := 'Anchorage Chill/Freeze';
                        TVendorNo := 'ANIC040';
                    end;

                //Added by CS on 02/25/13 for Batteries Shipping Code (BAT)
                if TPickType = 13 then
                    begin
                        TVendorName := 'Anchorage Batteries';
                        TVendorNo := 'ANIC017';
                    end;
            end;
    end;


    procedure BackupOpenItems(var BackupTelxonInputFile: Record "Backup Telxon Input File")
    begin
    end;

    local procedure LookupSalesPrice()
    begin
        SalesPrice.SetRange(SalesPrice."Item No.",TItem);

        if SalesPrice.Find('+') then
          begin
          VSalesPrice := SalesPrice."Unit Price";
          VSalesStartDate := SalesPrice."Starting Date";
          VSalesEndDate := SalesPrice."Ending Date";
          end
          else VSalesPrice := 0;

        SalesPrice.SetRange(SalesPrice."Item No.");//clear filter
    end;
}

