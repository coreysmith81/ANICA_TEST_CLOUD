Report 50020 "Telxon Line Validation"
{
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
 "Telxon Input File")
        {
            DataItemTableView = sorting(Processed, "Batch Name", Sequence) order(ascending) where(Processed = const(false));
            RequestFilterFields = "Customer Number", Sequence, "Vendor No.", "Batch Name", 
                begin
                  Window.Update(1,Sequence);
                end;


                //with "Telxon Input File" do
                    begin
                        //Clear the order item no for items rerun
                          "Order Ite m No." := '';

                        //CS 05-04-15: Adding this so that items with these numbers are skipped, and error left alone.
                        if ("Import Item No." = 'JBGDISC') or ("Import Item No." = 'JBG999') then
                            CurrReport.Skip begin
                    //Clear the order item no for items rerun
                    if not "On Hold" then
                            begin
                    //CS 05-04-15: Adding this so that items with these numbers are skipped, and error left alone.
                            "Error Remark" := '';
                        end;

                    //CS 01-07-14: Adding this to prevent "On Hold" items from having error cleared out.
 begin
                VQuantityPerBaseUOM := 1.0;
                        itofMeasure := '';
                    end;

                    TOrderItemNo := '';
                        VPostGroup := '';
                    //Reset Variables
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

                // * Get Telxon record information *****

                     customer number has not been entered
                    eck for invalid number greater than 2
                    trLen(Store) > 2 then
                    begin
                            "Import Error" := true;
                                "Error Remark" := 'Store No Invalid';
                            Modify(true);
                        end;

                    //Check for customer numb begin
                    begin
                        "Import Error" := true;
                        "Error Remark" := 'Store No. Is Missing';
                        Modify(true);
                        end;

                    if "Import Error"  begin

                    if "rt Error" = false then
                        upCustomer;

                    if VCustomerFound = true then
                        begin
                            "Customer Number" := TCustomerNumber;
                            Modify(true);
                        end
                    else
                        begin
                          if "Import Error" = fal begin
                          //Do not overwrite the error if an earlier customer error was found
                          "Import Error" := true;
                    end
                    else begin
                      //Changed 10-28-10 so that repor begin
                            //Do not overwrite the error if an earlier customer error was found

                    TDate :=ate;
                    TManend;
                        Modify(true);
                        //Changed 10-28-10 so that report skip occurs after item lookup
                        //CurrReport.SKIP;

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
                        '8000':
                            TManu := 'P';
                        '9000':
                            TManu := 'C';
                         else  
                            TManu := 'X'
                    end;
                           

                           
                    //Reject it
                           ems with no telxon vendor number
                    if TManu = 
                           'X' then
                        begin
                           
                            "Im
                           port Error" := true;
                        else
                            TManu := 'X'
                    end;

                    //Reject items with no telxon vendor number
                    if TManu = 'X' then begin
                        "Import Error" := true;
                        "Error Remark" := 'Invalid Telxon Vendor';
                        Modify(true);
                        //Changed 10-28-10 so that report skip occurs after item lookup
                        //CurrReport.SKIP;
                    end;

                    //Reject items with zero qty
                    //CS 07-01-14: Adding a check for blank quantities as well.
                    if (TQuantity = 0) or (Format(TQuantity) = '') then begin
                        "Import Error" := true;
                        "Error Remark" := 'Zero Quantity';
                        Modify(true);
                        //Changed 10-28-10 so that report skip occurs after item lookup
                        //CurrReport.SKIP;
                    end;

                                IsItem := true;
                            LookupItemNumber;
                        end
                    else
                        IsItem := false;
 begin
                    begin
                        LookupItemNumber;

                          //If non-stock is not found report the error and quit this record
                          if VItemFound = false then
                              begin
                                  "Import  begin
                        LookupNonStock;

                        //If non-stock is not found report the error and quit this record
                            end begin
                        begin
                            //Check Item Numbers to see if they exist
                            Modify;
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end
                        else begin
                            //Check Item Numbers to see if they exist
                            LookupItemNumber;
                            Modify;
                        end;
                    end;

                               VCrossItemNo := '';
                        end
                    else
                        begin
                            //LCC 5-7-10 changed to Torderitem no to allow UPC items to cross
                            //CheckCrossRefNo := TItem; begin

                    end
                    else begin
                        //LCC 5-7-10 changed to Torderitem no to allow UPC items to cross
                        //CheckCrossRefNo := TItem;

                            //Read the Cross Reference Table to get item cross up to 6 crosses
                        //Since the Cross Reference table uses only the 6 digit JBG code, remove the first 2 characters.
                        while P < 7 do 1, 
                            begin 3, 
                                    CheckCrossRefNo := VCrossItemNo;
                        LookupCrossReference;

                        //Read the Cross Reference Table to get item cross up to 6 crosses
                    end;
 begin
            //Need to check cross reference numbers to see if they are valid
                    if VCrosLookupCrossReference;
                begin
                        end;

                            //CS 01-07-14: Adding this to prevent "On Hold" items from having error cleared out.
                            if not "On Hold" then
                                begin
                                    "Import Er begin
                            end;

                        //CS 01-07-14: Adding this to prevent "On Hold" items from having error cleared out.
                        ItemRecord.SetRange(" begin
                    if ItemRecord.Find('+') then
                            n
                        end;

                        ItemRecord.SetCurrentkey("No.");
                        ItemRecord.SetRange("No.", VCrossItemNo);

                        if ItemRecord.Find('+') then begin
                            //added 2-24-09 LCC - problem with inventory check, set isitem to true
                            IsItem := true;
                            VCheckblocked := ItemRecord.Blocked;
                            VUnitPrice := ItemRecord."Unit Price";

                            if ItemRecord."Drop Ship Item" = true then
                                VCrossNSFlag := true;

                            if ItemRecord."Created From Nonstock Item" = true then
                                VCrossNSFlag := true;
                        end
                        else begin
                            "Import Error" := true;
                            "Error Remark" := 'Cross Ref Item Not Found';
                            Modify(true);
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end;

                        //Check for unpriced items
                        if VUnitPrice = 0.0 then begin
                            "Import Error" := true;
                            "Error Remark" := 'No Unit Price on cross item';
                            Modify(true);
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end;

                        //Check for blocked items
                        if VCheckblocked = true then begin
                            "Import Error" := true;
                            "Error Remark" := 'Cross Ref Item is Blocked';
                            Modify(true);
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end;
                        "Error Remark" := 'Item No Not Found';
                            Modify(true);
                            CurrReport.Skip;
                        end;
 begin
                if VUnitPrice = 0.0 then
                        n
                        "Import Error" := true;
                        "Error Remark" := 'No Unit Price';
                        Modify(true);
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end; begin
                //Check for blocked items
                    if Vkblocked = true then
                        n
                        //Changed 10-28-10 so that report skip occurs after item lookup
                        //CurrReport.SKIP;
                        Modify(true);
                            //Changed 10-28-10 so that report skip occurs after item lookup
                            //CurrReport.SKIP;
                        end; begin
                //Clear filter
                    Itemrd.SetRange("No.");

                    //If//Changed 10-28-10 so that report skip occurs after item lookup
                        //CurrReport.SKIP;
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
                        TOrderItemNo := VCrossItemNo;     CheckPreviousOrders;

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
                                //Set to no cross begin
                        end;
                    end;end
                        else begin
                //Changed from VADCCross to Vlocationfound 11-9-04
                        if (//Set to no cross
                        begin
                           TOrderItemNo := VCrossItemNo;
                            end;

                    //Lookup items to get vendor no and other info after crosses
                        //Check for blocked items
                    if TOrderItemNo = '' then begin
                         "Import Error" := true;
                    end;

                    //Lookup items to get vendor no and other info after crosses
                    //Check for blocked items
                        end; begin
                LookupItemNumber;

                        Modify;
                        //Changed 10-28-10 so that report skip occurs after item lookup
                        //CurrReport.SKIP;
                    end;

                    LookupItemNumber;

                    //Check for blocked items
                            //CurrReport.SKIP; begin

                        for unpriced items
                        Price = 0.0 then
                        Modify;
                        //Changed 10-28-10 so that report skip occurs after item lookup
                        //CurrReport.SKIP;
                    end;

                    //Check for unpriced items
                        //CurrReport.SKIP; begin

                    //Seore Use
                    if VGroup = 'STOREU' then
                        Modify;
                        //Changed 10-28-10 so that report skip occurs after item lookup
                        //CurrReport.SKIP;

                        //If the Item is marked created from non-stock or normally non-stock
                        //Location is drop-ship, otherwise ADC
                        //Override the drop ship location from the location in the default shipping table
                        TDropShip := false;
                        TLocation := 'ADC';
                    // ***** Location Section *****

                    //If the Item is marked created from non-stock or normally non-stock
                    //Location is drop-ship, otherwise ADC
                    //Override the drop ship location from the location in the default shipping table
                            //TPickType := 0;
                        end;
if (VCatalogueFlag = true) or (VNonStockFlag = true) then begin
                        TDropShip := true;
                        TLocation := 'DROP-SHIP';
                        //Commented out LCC 6-15-09
                        //TPickType := 0;
                    end;

                    //If a drop ship location exists in the default shipping table, it will override this later
                    //For ADC Items check to see if there is enough inventory
                    //1-12-04 changed this section to exclude items for orders on hold
                    NewQuantity := TQuantity;
                    if (TLocation <> 'DROP-SHIP') and (TDropShip = false) and ("On Hold" = false) and (IsItem = true) then begin
                        CheckPreviousOrders;
                        VADCQuantity := 0.0;
                        VCheckLocItem := TOrderItemNo;
                        VCheckLocation := 'ADC';
                        LookupLocation;

                        if (VADCQuantity - VItemFill) > TQuantity then begin
                            //There is enough in inventory for the order quantity
                            VItemFill := VItemFill;//For a true argument
                        end
                        else begin
                            if (VADCQuantity - VItemFill) > 0 then
                                NewQuantity := (VADCQuantity - VItemFill)
                            else begin
                                if TOrderItemNo <> '0040-9016' then begin
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

                            //If no shipping c begin
                        LookupParcelPostRates;

                        else
                            TShippingCode := 'DEF SEA'; // will default to 005
                        end;
//If no shipping code default to parcel post
                        if TShippingCode = '' then
                // (To account for Commodity code being incorrect on some items).
                    if TFOBCode AZ' then
                        begin
                            TShippingCode := 'DEF AIR';
                    end;


                    //Check to see if the location exists for the final record
                    //if not, create a locat begin
                VCheckLocItem := TOrderItemNo;

                    LookupLocation;

                    if VLocationFound = false then
                        begin
                            //See if location is valid
                            case TLocation of
                                'ADC' : VLocationFound := true;
                                'DROP-SHIP' : VLocationFound := true;
                                'KENT' : VLocationFound := true;
                                'BIA' : VLocationF begin
                        //See if location is valid
                    end;
'ADC':
                               
                    if VLoca'DROP-SHIP':
                                then
                        begi'KENT':
                               
                            'BIA':
                                No." := TOrderItemNo;
                            'CORP':
                               r" := true;
                            else
                               emark" := 'No location' + TLocation;
                            Modify;
                            //Changed 10-28-10 so that report skip occurs after item lookup
                                //CurrReport.SKIP; end;
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
                        end; begin
                //Update the file
                    Loca := TLocation;
                    "VenNo." := TVendorNo;
                    "Ite//Changed 10-28-10 so that report skip occurs after item lookup
                        //CurrReport.SKIP;
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
                    Manuf:
                           turer := TManu;
:
                           
                    if NewQuantity < TQuantity then
                        begin
                            Quantity := NewQuantity;
                            "Inventory Fill Amount" := NewQuantity;
                        end
                    else
                        begin
                            Quantity := TQuantity; begin
                    end;

                    end
                    else begin

                    if Qity <> 0 then
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
                    // validation is run, so I'm adding this  / VQuantityPerBaseUOM, 
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
            RequilterHeading = 'Check Minimums';
            column(ReportForNavId_5554; 5554)
            {
            } "Telxon Input File")
        {
            DataItemTableView = sorting(Processed, "Import Error", "Customer Number", Location, "Drop Ship", "Shipping Code", "Vendor No.", "Order Type", "Pick code", Sequence) order(ascending) where(Processed = const(false), "Import Error" = const(false));
            RequestFilterFields = "Customer Number", Sequence, 
                "Check Minimums".LockTable;

                //CS 05-04-15: Adding this so that items with these numbers are skipped, and error left alone.
                if ("Check Minimums"."Import Item No." = 'JBGDISC') or ("Check Minimums"."Import Item No." = 'JBG999') then
                    CurrReport.Skip;

                //2nd run through file to check minimums
                //with "Check Minimums" do begin
                //The report filter excludes records already processed

                //>>1-10-06 Changed filter on error records to IF statement to speed up program
                if "Import Error" = true then CurrReport.Skip;

                //Set compare variables on first record only
                if VFirstRecord = true then
                    //The report filter excludes records already processed

                    //>>1-10-06 Changed filter on error records to IF statement to speed up program
                    VCurrStore := "Customer Number";
                VCurrLocation := Location;
                    //Set compare variables on first record only
                    VCurrShipcode := "Shipping  begin
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
                    T := T + 1;

                    //Check to see if an order should be created
                    begin
                    //ANICA 05/06/09
                    //CS 1/25/11: Added Pick code 12, for Chill.
                    //CS 6-30-16: Changed tobacco from 6 to 18.
                  if ("Pick code" = 1) or ("Pick code" = 2) or ("Pick code" = 5) or ("Pick code" = 18) or ("Pick code" = 7) or ("Pick code" = 8)
                    //If hazardous or freeze, make a separate order (Not JBG)
                          begin begin
                        //ANICA 05/06/09
                        //CS 1/25/11: Added Pick code 12, for Chill.
                        //CS 6-30-16: Changed tobacco from 6 to 18.
                        if ("Pick code" = 1) or ("Pick code" = 2) or ("Pick code" = 5) or ("Pick code" = 18) or ("Pick code" = 7) or ("Pick code" = 8)
                          or ("Pick code" = 9) or ("Pick code" = 10) or ("Pick code" = 11) or ("Pick code" = 12) then begin
                            if VCurrPickCode <> "Pick code" then
                                VNewOrder := true;
                        end;
                    end;

                    //If Default shipping instructions are used, then break on vendor
                    if (("Shipping Code" = 'DEF ANC') or ("Shipping Code" = 'DEF SEA') or ("Shipping Code" = 'DEF AIR')) and (Location <> 'ADC') then begin
                        if VCurrVendor <> "Vendor No." then VNewOrder := true;
                    end;

                    //Create a separate order per vendor
                    CheckOrderMin;
                //Reset check for new order
                    VCurrStore := "Customer Number";
                VCurrLocation := Location;
                    //Minimum Checks Processing Routine
                    VCurrShipcode := "Shippi begin
                        CheckOrderMin;
                        //Reset check for new order
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
                    end;

                    //check for last line
                     CkPickCode := "Pick c begin
                        //IF P = 1, the order before was complete and this last line is one order with one line
                        CKUnitPrice[P]  := "Unit Price";
                        //Check for only one record being processed
                        VLocation[P] := Location;
                        VGrossWeight[P] := "Gross Weight";
                        VCkShipCode[P] := "Shipping Code";
                        //Get code to check JBG minimum bypass
                        VNoJBGMinimum[P] := "Allow Less 1000 lbs";
                        VNoHazMinimum[P] := "Allow HAZ Less 100 lbs";
                        //Increment for last check on sales lines
                        P:=P+1;
                        CheckOrderMin;
                e       nd;
       //Get code to check JBG minimum bypass
                       //Do an array for line data
                C       kPickCode := "Pick code";
                N       //Increment for last check on sales lines
                        P := P + 1;
                        CheckOrderMin;
                    end;

                    //Do an array for line data
                    VGrossWeight[P] := "Gross Weight";
                    VCkShipCode[P] := "Shipping Code";
                    VItemNo[P] := "Order Item No.";
                    //Get code to check JBG minimum bypass
                    VNoJBGMinimum[P] := "Allow Less 1000 lbs";
                    VNoHazMinimum[P] := "Allow HAZ Less 100 lbs";
    
                    P:=P+1;
                    Checklastline := P;
                    end;
            //en    //Get code to check JBG minimum bypass
    
            trig    ger OnPreDataItem()
            begin
                    P := P + 1;
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
        emUnitofMeasure: Record "Item Unit of Measure";
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
        VMaxNoJBGMinimum:Boolean;
        VMaxNoHazMinimum: Bolean;
        VGrossWeight: array 6000] of Decimal;
        TVendorMin: Decial;
        CkVendorTotal: Decmal;
        VendorError: array [6000] of Boolean;
        VendorRemark: array [6000] of Text[30];
        Vsequence: array [6000] of Integer;
        CKUnitPrice: array [6000] of Decimal;
        CkPickCode: Option;
        VQuantity: array [6000] of Decimal;
        VImportError: Boolean;
        VImportRemark: Tex[30];
        Checklastline: Inteer;
        VFirstArray: Booean;
        VItemFill: Decimal
        NewQuantity: Decimal;
        VLocationFound: oolean;
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
        ItemDesc2: Tex[50];
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
            begin begin
            VCustomerFound := false;
            TCustomerNumber := '';
            
    end;end
        else begin
procedure LookupItemNumber()
    begin
        VInae := false;
        Found := false;

        //First check for UPC instead of item number

        //If the item number is other than 9 digits long, assume it is a UPC
        if StrLen(TOrderItemNo) <> 9 then
          begin
              //First try as is and drop the first 0 on thirteen digits
              LLength := StrLen(TOrderItemNo);
              VFirstItemCode := CopyStr(TOrderItemNo,1,1);

              if LLength = 13 then
                  NewTItem := CopyStr(TOr begin
            //First try as is and drop the first 0 on thirteen digits

            ItemUPC.SetCurrentkey(ItemUPC.UPC); 1, 
              ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
              //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
                 ItemUPC.Find('+') then 2, 12)
            else
                      TOrderItemNo := ItemUPC."Item No.";
                        VUPCFound := true;
                  end;
 
            //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
        if (VUPCFound = false) and (L begin
          NewTItem := '00' + TOrderItemNo;
                C.SetCurrentkey(ItemUPC.UPC);
            emUPC.SetRange(ItemUPC.UPC,NewTItem);

                  //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
                  if ItemUPC.Find('+') then begin
                      TOrderItemNo := ItemUPC."Item No.";
                      VUPCFound := true;
                  end; 
                end;
//CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
        //If that doesn't work try droppi begin
      begin
            NewTItemCopyStr(TOrderItemNo,1,12);
            Itemend;
            end;

            //If that doesn't work try dropping the check digit on 13 digit numbers
                  begin begin
                        VUPCFound := true; 1, 
                    end;
          en    d; 
    //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
              //Reformat 8 digit numbers p the first and last digit, the format is 00 and 126 and 0000 and 345
          if (VUPCFound = false) and (LLength = 8) and (VFirstItemCode >= '0') and (VFirstItemCode <= '9') then
          begin
            NewTItem := '00' + CopyStr(TOrderItemNo,2,2) + CopyStr(TOrderItemNo,7,1) + '0000' + CopyStr(TOrderItemNo,4,3);
            end;

            //Reformat 8 digit numbers to 12
            //Drop the first and last digit, the format is 00 and 126 and 0000 and 345
                  begin begin
                    VUPCFound := true; 2,  7,  4, 
                    end;
          en    d; 
    //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
     begin
              //For remaining 12 digit add a zero and drop the check digit
          if (VU    PCFound = false) and (LLength = 12) and (VFirstItemCode >= '0') and (VFirstItemCode <= '9') then
              begin
            end;


            //CS 2-3-12: modifying this so that produce items have 8 leading zeros
            //For remaining 12 digit add a zero and drop the check digit
                    else begin
 1, 
                ItemUPC.SetCurrentkey(ItemUPC.UPC); 12, 
                  ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
                //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
                  iftemUPC.Find('+') then 7, 4)
                else
                        TOrderItemNo := ItemUPC."Item No."; 1, 
                          VUPCFound := true;
                    end;
              en 
//CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
 begin
    if (VUPCFound = false) and (LLength = 11) and (VFirstItemCode >= '0') and (VFirstItemCode <= '9') then
          begin
            NewTend;
            end;


            //For remaining 11 digit add a zero
                  begin begin
                        VUPCFound := true;
                    end;
          en    d; 
    //CS 11-05-12: Changed to '+' which should grab the ANICA numbers over G numbers.
    nd UPC Section

        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",TOrderItemNo);
        if   ItemRecord.Find('+') then
            begin
            VItemFound := true;
            VCatalogueFlag := ItemRecord."Created From Nonstock Item";
            TVendorNo := ItemRecord."Vendor No.";
            VVendorLocation := ItemRecord."Vendor Location"; //CS Added 04/14/22
            TGrossWeight := ItemRe cord."Gross Weight";
            TItemDescrip := ItemReco ItemDesc2 := ItemRecord."Description 2";
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
                    TItemDescrip := It begin
                ItemVariant.SetCurrentkey(ItemVariant."Item No.", ItemVariant.Code);
                ItemVariant.SetRange(ItemVariant."Item No.", TOrderItemNo);
                ItemVariant.SetRange(ItemVariant.Code, TItemVariant);
                if ItemVariant.Find('-') then begin
                    TItemDescrip := ItemVariant.Description;
                    ItemDesc2 := ItemVariant."Description 2";
                end;
            end;

       ItemRecord.SetRange("No.");
//Keep this variable in case we cross back
       //Lookup pack and UOM information
        end
        else
            VItemFound := false;

        //Clear filter
        ItemRecord.SetRange("No.");

        //Lookup pack and UOM information
        if VItemFound = true then begin
            if ItemUnitofMeasure.Get(TOrderItemNo, VSalesUnitofMeasure) then begin
                VPackDescription := ItemUnitofMeasure."Pack Description";
                VPack := ItemUnitofMeasure.Pack;
                VQuantityPerBaseUOM := ItemUnitofMeasure."Qty. per Unit of Measure";
            end
            else begin
                VPackDescription := '';
                VPack := 0;
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
                VUnitPrice := NonStockRe begin
        end
        else VItund := false;
        //IF Item has not been created, create it
        if (kNSItemNo = '') and (VItemFound = true) then
            n
            NonStockCreate.NonstockAutoItem(NonStockRecord);
            CheckNSItemNo := NonStockRecord."Item No.";
        end
        else
           

        //check for UPC if the item was not found begin
    if VItemFound = false then
            n
            NewTItem := TItem;
                LLength := StrLen(TItem);
                if LLength = 13 then
                    NewTItem := CopyStr(TItem,2,12)
                else NewTItem := TItem;
 begin
            ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
              if ItemUPC.Find('-') then
                  begin
                      VItemFound := true; 2, 12)
            else
                     CheckNSItemNo := ItemUPC."Item No.";
                      end;
            
 
        //cllter begin

        //Next c against the Nonstock upc file
        if Vend;
        begin
                NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
                NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

                if NonstockUPC.Find('-') then
                  begin
                      VItemFound : begin
                  Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");
 
                      if Nonstocks.Find('-') then
                     begin begin
                      VNonStockSequence := Nonstocks."Entry No.";
                      VUnitPrice := Nonstocks."Unit Price";
                      CreateNonStockItem; 
                         end;
                 begin

        //Clear filt
        NonstockUPC.(NonstockUPC.UPC);
        Nonstocks.SeCreateNonStockItem;
                end;
            end;
    //Next, if this is a 10 digit UPC, add two zeros and check
        if (VItemFound = false) and (LLength = 10) then
            begin
                NewTItem := '00' + TItem;
                ItemUPC.SetCurrentkey(ItemUPC.UPC);
                ItemUPC.SetRange(ItemUPC.UPC,NewTItem);

                if ItemUPC.Find('-') then
                  begin begin
                  CheckNSItemNo := ItemUPC."Item No.";
              end;
             

        //clfilter begin


        //Neend;
    if VItemFound = false then
            begin
            NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
            NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

            if NonstockUPC.Find('-') then
                begin
                VItemFound := true     Nonstocks.SetCurrentkey(Nonstocks."Entry No.");
                Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");
 
                if Nonstocks.Find('-') then
                    begin         CheckNSItemNo := Nonstocks."Item No.";
                        VNonStockSequence := Nonstocks."Entry No.";
                        VUnitPrice := Nonstocks."Unit Price";
                        CreateNonStockItem; 
                    end;
                end; begin

            NonstockSetRange(NonstockUPC.UPC);//Clear filter
            NonstocktRange(Nonstocks."Entry No.");//Clear filter
CreateNonStockItem;
                end;
            end;
        end;

        NonstockUPC.SetRange(NonstockUPC.UPC);//Clear filter
        ItemUPC.SetRange(ItemUPC.UPC,NewTItem);
            if ItemUPC.Find('-') then
                begin
                VItemFound := true;         CheckNSItemNo := ItemUPC."Item No.";
                end; 1, 
        end;
 
        //clear filter.SetRange(ItemUPC.UPC);

        //Next check as is against the Nonstock upc file
        if VFound = false then
            begin
                NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
                NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

                if NonstockUPC.Find('-') then
                    begin
                        VItemFound begin
                    Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");
 
                        if Nonstocks.Find('-') then
                        begin begin
                        VNonStockSequence := Nonstocks."Entry No.";
                        VUnitPrice := Nonstocks."Unit Price";
                        CreateNonStockItem; 
                            end;
                 begin

          NonstockUPonstockUPC.UPC);//Clear filter
          Nonstocks.stocks."Entry No.");//Clear filter
CreateNonStockItem;
                end;
            end
        end;

        NonstockUPC.SetRange(NonstockUPC.UPC);//Clear filter
        Nonstocks.SetRange(Nonstocks."Entry No.");//Clear filter


        //Reformat 8 digit numbers to 12
        //Drop the first and last digit, the format is 00 and 126 and 0000 and 345
        if (VItemFound = false) and (LLength = 8) then begin
            NewTItem := '00' + CopyStr(TItem, 2, 2) + CopyStr(TItem, 7, 1) + '0000' + CopyStr(TItem, 4, 3);
            ItemUPC.SetCurrentkey(ItemUPC.UPC);
            ItemUPC.SetRange(ItemUPC.UPC, NewTItem);

            if ItemUPC.Find('-') then begin
                VItemFound := true;
                CheckNSItemNo := ItemUPC."Item No.";
            end;
        begin
                NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
                NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

                if NonstockUPC.Find('-') then
                    begin
                        VItemFound begin
                    Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");
 
                        if Nonstocks.Find('-') then
                        begin begin
                        VNonStockSequence := Nonstocks."Entry No.";
                        CreateNonStockItem;
                    end; 
                    end;
            end; begin
ear filters
        NonstockUPC.stockUPC.UPC);
        Nonstocks.SeCreateNonStockItem;
                end;
            end;
    if (VItemFound = false) and (LLength = 12) then
            begin
                NewTItem := '0' + CopyStr(TItem,1,11);
                ItemUPC.SetCurrentkey(ItemUPC.UPC);
                ItemUPC.SetRange(ItemUPC.UPC,NewTItem);

                if ItemUPC.Find('-') then
                    begin begin
                    CheckNSItemNo := ItemUPC 1, Item No.";
                end;
             

        //clfilter begin

        //Next cis against the Nonstock upc file
        if Vend;
        begin
                NonstockUPC.SetCurrentkey(NonstockUPC.UPC);
                NonstockUPC.SetRange(NonstockUPC.UPC,NewTItem);

                if NonstockUPC.Find('-') then
                begin
                    VItemFound :=  begin
                Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");
 
                    if Nonstocks.Find('-') then
                    if Nonstocks.Find('-' begin
                            CheckNSItemNo := Nonstocks."Item No.";
                            VNonStockSequence := Nonstocks."Entry No.";
                            CreateNonStockItem; 
                            end;
                if Nonstocks.Find('-') then
        end; begin
//Clear filters
        NonstockUPC.SetRstockUPC.UPC);
        Nonstocks.SetRanCreateNonStockItem;
                    end;
            end;
      if (VItemFound = false) and (LLength = 11) then
              begin
                  NewTItem := '0' + TItem;
                  ItemUPC.SetCurrentkey(ItemUPC.UPC);
                  ItemUPC.SetRange(ItemUPC.UPC,NewTItem);

        //For remaining 11 digit add a zero
                    begin begin
                CheckNSItemNo := ItemUPC."Item No.";
                end;
             

            r filters begin

          //Next as is against the Nonstock upc file
          ifend;
        end;

        //clear filters

                  if NonstockUPC.Find('-') then
        //Next check as is against the Nonstock upc file
                        VItemFound begin
                    Nonstocks.SetRange(Nonstocks."Entry No.",NonstockUPC."Nonstock Entry No.");
 
                          if Nonstocks.Find('-') then
                        if Nonstocks.Find begin
                            CheckNSItemNo := Nonstocks."Item No.";
                            VNonStockSequence := Nonstocks."Entry No.";
                            CreateNonStockItem; 
                                  end;
                
              end; begin
Clear filters
            NonstockUPC.ockUPC.UPC);
            Nonstocks.SeCreateNonStockItem;
                    end;
            end;
        end;

        //Clear filters


    procedure CreateNonStockItem()
    begin
        //IF Item has not been created, create it
        if (CheckNSItemNo = '') and (VItemFound = true) then
            begin
                NonStockCreate.NonstockAutoItem(Nonstocks);
                CheckNSItemNo := Nonstocks."Item No.";
            end
    end;

 begin
var
        CroserenceRecord: Record "Item Reference";
    begi
        CrossReferenceRecord.SetCurrentkey("Reference No.","Reference Type");
        CrossReferenceRecord.SetRange("Reference No.",CheckCrossRefNo);
        CrossReferenceRecord.SetRange("Reference Type",0);

        //CS 07-26-12: Changed the '+' to a '-' to try to fix the issue of UPC's not crossing correctly.
        //CS 11-05-12: Changed back to '+'. This wasn't the issue.  And '+' will grab the ANICA number, rather than the G number.
        if CrossReferenceRecord.Find('+') then
            VCrossItemNo := CrossReferenceRecord."Item No."; 
 
        //Clear filters 
        CrossReferenceRecord.SetRange("Reference No.");
        CrossReferenceRecord.SetRange("Reference Type");
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
               VLocationFound := true; "Location Code", 
               repeat 
                  //VADCQuantity := ItemLedgerEnt ry.Quantity + VADCQuantity;
                  VADCQuantity := Item LedgerEntry."Remaining Quantity" + VADCQuantity;
               until ItemLedgerEntry.Next = 0;
            end begin
         VLocationFound := false;
repeat
                //VADCQuantity := ItemLedgerEntry.Quantity + VADCQuantity;
      ItemLedgerEntry.SetRange("Item No.");
        ItemgerEntry.SetRange("Location Code");

        //Lookup sales lines for quantities on sales orders
        SalesLine.SetCurrentkey("Location Code",Type,"No.");
        SalesLine.SetRange("Location Code",VCheckLocation);
        SalesLine.SetRange(Type,2);
        SalesLine.SetRange("No.",VCheckLocItem);

        if SalesLine.Find('-') then
        begin
           repeat Type, 
           //Lookup sales lines and reduce  the quantity already on order from VADC Quantity
           //LCC 3-11-09 changed  the following form SalesLine.Quantity to SalesLine.Outstanding Quantity
           VADCQuantity := VADCQu antity - SalesLine."Outstanding Quantity";
           until SalesLine.Next = 0;
        end; begin
            repeat
                //Lookup sales lines and reduce the quantity already on order from VADC Quantity
                //LCC 3-11-09 changed the following form SalesLine.Quantity to SalesLine.Outstanding Quantity
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

        //Clear filter begin
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

 begin
  var
        ShipTVendorMin :=ord "Default Shipping Table";
    begi
        ShipTableRecord.SetCurrentkey("FOB Code","Store No.","Vendor No.");
        ShipTableRecord.SetRange("FOB Code",TFOBCode);
        ShipTableRecord.SetRange("Store No.",TCustomerNumber);
        ShipTableRecord.SetRange("Vendor No.",TVendorNo);

        if ShipTableRecord.Find('+') then
            begin
                TShippingCode := ShipTableRecord. "Store No.", struction";
                VDropShipLocation := ShipTab leRecord."Drop Ship Location";
            end; 
    end; 

 begin
var
        ARSeecord: Record "Sales & Receivables Setup";
    begi
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
                    CkVendorTotal := CkVendorT begin
            end; begin
                    //ArrayStart := e;
    //ArrayEnd := e - 1;
            if Tend;
                CkVendorTotal := CkVendorTotal + (VQuantity[e] * CKUnitPrice[e]);
                e := e + 1;
                begin
                        VImportError := true;
                        VImportRemark := 'Below Vendor Minimum ' + CopyStr(TVendorNo,1,7);
                        f := 1;
 begin
                        FindSequence := Vsequence[ begin
                        f := f + 1;
                    until f >= P; 1, 
                    
                end;
            VFirstArrepeat
    until e >= P;
ProcessErrorUpdate;

        VImportErrorfalse;
        VImportRend;

        //Check for overall order minimums
        if VOrderTotDollars < VOrderMin then
            begin
                VImportError := true;
                VImportRemark := 'Below ANICA Minimum Order';
            end;

        //See if the order is air freight
        h := 1; begin
        ShipLegRecord.SetCurrentkey("Shipping Instruction Code","Calculation Type");
            LegRecord.SetRange("Shipping Instruction Code",VCkShipCode[h]);
        ShipLegRecord.SetRange("Calculation Type",1);

            if ShipLegRecord.Find('+') then
                begin
                    //Check Air freight Minimum
                    case NewCustomerNumber of 
                        'FAMI001' : AirtFrtMin := VBethAirFrtMi n;
                        'RIVE001' : AirtFrtMin := VBet hAirFrtMin;
                        'BETH001' : AirtFrtMin := VBethAirFrtMin;
                        'KALT001' : AirtFrt begin
                //Check Air freight Minimum

                    'FAMI001':
                       t < VAirFreightMin then
                    'RIVE001':
                       
                    'BETH001':
                       Error := true;
                    'KALT001':
                       Remark := 'Below Air Freight Minimum';
                    else
                       
                end;

                if VOrderTotWght < VAirFreightMin then begin
                    VImportError := true;
                    VImportRemark := 'Below Air Freight Minimum';
                end;
        begin
                if (CkPickCode = 1) and (VChkVendor[1] = 'JBGO001') and (VOrderTotWght < VJBGHazMin) then
                    begin
                        VImportError := true;
                        VImportRemark := 'JBG Hazardous under 100 lb';
                    end;
            end; begin
    //2-5-03 Add Check for JBG orders under 1000 lbs begin
if VMaxNoJBGMinimum = false then
            begi
            end;
                begin
                        VImportError := true;
                        VImportRemark := 'JBG Below 1000 lb. Bypass Wt.';
                    end;
            end; begin
    if VImportError = true thenthen begin
        J := 1;
                at
            end;
                    ProcessErrorUpdate;
                        J := J + 1;
                    until J >= P; begin

        VImprepeat
VImportRemark := '';
    end;ProcessErrorUpdate;


    proce ProcessErrorUpdate()
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
                TelxonInputRecord2."Error Rem ark" := VImportRemark;
            end;

        TelxonInputRecord2.Modify(true);
        TelxonInputRecord2.SetRange(Sequence);// begin


    proce CheckPreviousOrders()
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
            repeat "Import Error", Processed, 
                VItemFill := VItemFill + TelxonInputR ecord3."Inventory Fill Amount";
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
                        TVendorName := 'Anchorage Hazardous begin
                end;

                if TPickType = 2 then
                begin begin
                TVendorName := 'Anchorage Hazardous';
                TVendorNo := 'ANIC059';
            end;

            if TPickType = 2 then begin
                TVendorName := 'Anchorage Chill/Freeze';
                TVendorNo := 'ANIC040';
            end;

                begin
                begin
                TVendorNo := 'ANIC040';
                
end;

            if TPickType = 12 then begin
                TVendorName := 'Anchorage Chill/Freeze';
                TVendorNo := 'ANIC040';
            end;

            //Added by CS on 02/25/13 for Batteries Shipping Code (BAT)
            if TPickType = 13 then begin
                TVendorName := 'Anchorage Batteries';
                TVendorNo := 'ANIC017';
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
 begin
      end;
}  
  
end
        else
           