Report 50024 "Create Sales Orders"
{
    // //MAS: Modifications are marked by MAS.
    // //ANICA 05/06/09 Added pick types to break sales orders

    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
        dataitem("Telxon Input File"; "Telxon Input File")
        {
            DataItemTableView = sorting(Processed, "Import Error", "Customer Number", Location, "Drop Ship", "Shipping Code", "Vendor No.", "Order Type", "Pick code", Sequence) order(ascending) where("Import Error" = const(false), Processed = const(false), "On Hold" = const(false));
            RequestFilterFields = "Customer Number", Date, Location, "Order Type";
            column(ReportForNavId_9733; 9733)
            {
            }

            trigger OnAfterGetRecord()
            begin

                begin
                    //The report filter excludes error records and those already processed

                    //Set compare variables on first record only
                    if VFirstRecord = true then begin
                        VCurrStore := "Customer Number";
                        VCurrLocation := Location;
                        VCurrDropShip := "Drop Ship";
                        VCurrShipCode := "Shipping Code";
                        VCurrPickCode := "Pick code";
                        VCurrVendor := "Vendor No.";
                        VCurrOrderType := "Order Type";
                        //TItemVariant := "Item Variant";
                        VFirstRecord := false;
                        VNewOrder := false;
                        P := 1;
                        VEndOfFile := Count;
                    end;

                    T := T + 1;

                    //Check to see if a new order should be created

                    if VCurrStore <> "Customer Number" then
                        VNewOrder := true;

                    if VCurrLocation <> Location then
                        VNewOrder := true;

                    if VCurrDropShip <> "Drop Ship" then
                        VNewOrder := true;

                    if VCurrShipCode <> "Shipping Code" then
                        VNewOrder := true;

                    if VCurrVendor <> "Vendor No." then
                        VNewOrder := true;

                    if VCurrOrderType <> "Order Type" then
                        VNewOrder := true;

                    //CS 10-19-2022: Splitting JBG FREEZE items to their own order, only for KIKI/ATKA/DIOM for now. Per Alexis.
                    if ("Vendor No." = 'JBGO001') and (("Customer Number" = 'KIKI001') or ("Customer Number" = 'ATKA001')
                            or ("Customer Number" = 'DIOM001')) then begin
                        //Start a new order if this is FREEZE
                        if "Pick code" = 2 then
                            if VCurrPickCode <> "Pick code" then
                                VNewOrder := true;

                        //Start a new order for only the first non FREEZE pick code
                        if VCurrPickCode = 2 then
                            if VCurrPickCode <> "Pick code" then
                                VNewOrder := true;
                    end;

                    //CS 05-12-16: Added in order to separate JBG Cig orders to their own order. Per Gina.
                    if "Vendor No." = 'JBGO001' then begin
                        //Start a new order if this is tobacco
                        if "Pick code" = 18 then
                            if VCurrPickCode <> "Pick code" then
                                VNewOrder := true;

                        //Start a new order for only the first non tobacco pick code
                        if VCurrPickCode = 18 then
                            if VCurrPickCode <> "Pick code" then
                                VNewOrder := true;
                    end;

                    //If One of the pick codes below, make a separate order (Not JBG)
                    if "Vendor No." <> 'JBGO001' then begin
                        //ANICA 05/06/09
                        //CS 7/23/12: Added in Pick Code 13 for batteries, per Gina
                        //CS 4/11/13: Added in Pick Code 14 for Guns and Ammo, per Gina
                        //CS 10/8/13: Added in Pick Code 15 for NR Hazardous, per Gina
                        //CS 4/9/19: Added Pick Code 17 for USPS Direct, per Jonah
                        if ("Pick code" = 1) or ("Pick code" = 2) or ("Pick code" = 5) or ("Pick code" = 18) or ("Pick code" = 7) or
                                ("Pick code" = 8) or ("Pick code" = 9) or ("Pick code" = 10) or ("Pick code" = 11) or ("Pick code" = 12) or
                                ("Pick code" = 13) or ("Pick code" = 14) or ("Pick code" = 15) or ("Pick code" = 17) then begin
                            if VCurrPickCode <> "Pick code" then
                                VNewOrder := true;
                        end;
                    end;


                    //If Default shipping instructions are used, then break on vendor
                    if (("Shipping Code" = 'DEF ANC') or ("Shipping Code" = 'DEF SEA') or ("Shipping Code" = 'DEF AIR')) and (Location <> 'ADC')
                  then begin
                        if VCurrVendor <> "Vendor No." then
                            VNewOrder := true;
                    end;

                    //Order Processing Routine
                    if VNewOrder = true then begin
                        CreateSalesHeader;
                        CreateSalesLine;
                        UpdateTelxonLine;
                        //Reset check for new order
                        VCurrStore := "Customer Number";
                        VCurrLocation := Location;
                        VCurrDropShip := "Drop Ship";
                        VCurrShipCode := "Shipping Code";
                        VCurrPickCode := "Pick code";
                        VCurrVendor := "Vendor No.";
                        VCurrOrderType := "Order Type";
                        //TItemVariant := "Item Variant";
                        VNewOrder := false;
                        P := 1;
                    end;

                    //check for last line
                    if VEndOfFile = T then begin
                        //IF P = 1, the order before was complete and this last line is one order with one line
                        if P = 1 then
                            P := 1
                        else
                            P := CheckLastLine;

                        //Check for only one record being processed
                        if P = 0 then
                            P := 1;

                        //Get Header Data
                        NewCustomerNumber := "Customer Number";

                        //Convert default shipping instructions
                        case "Shipping Code" of
                            'DEF AIR':
                                VNewShipInstruct := '027';
                            'DEF SEA':
                                VNewShipInstruct := '005';
                            'DEF ANC':
                                VNewShipInstruct := '006';
                            else
                                VNewShipInstruct := "Shipping Code"
                        end;

                        VOrderType := "Order Type";
                        VLocation := Location;
                        VOrderDate := Date;

                        //Do an array for line data
                        VItemNo[P] := "Order Item No.";
                        VDropShip[P] := "Drop Ship";

                        // Change to sales quantity based on UOM
                        // VQuantity[P] := Quantity;
                        VQuantity[P] := "Sales Order Quantity";
                        VStoreUse[P] := "Store Use";
                        VSequenceArray[P] := Sequence;
                        TItemVariant[P] := "Item Variant";

                        //Increment for last check on sales lines
                        P := P + 1;
                        CreateSalesHeader;
                        CreateSalesLine;
                        UpdateTelxonLine;
                        //VNewOrder := TRUE;
                    end;

                    //Get Header Data
                    NewCustomerNumber := "Customer Number";

                    //Convert default shipping instructions
                    case "Shipping Code" of
                        'DEF AIR':
                            VNewShipInstruct := '027';
                        'DEF SEA':
                            VNewShipInstruct := '005';
                        'DEF ANC':
                            VNewShipInstruct := '006';
                        else
                            VNewShipInstruct := "Shipping Code"
                    end;

                    VOrderType := "Order Type";
                    VLocation := Location;
                    VOrderDate := Date;

                    //Do an array for line data
                    VItemNo[P] := "Order Item No.";
                    VDropShip[P] := "Drop Ship";

                    // Change to sales quantity based on UOM
                    // VQuantity[P] := Quantity;
                    VQuantity[P] := "Sales Order Quantity";
                    VStoreUse[P] := "Store Use";
                    VSequenceArray[P] := Sequence;
                    TItemVariant[P] := "Item Variant";

                    //Mark processed records for final update
                    Mark(true);
                    //Processed := TRUE;
                    //MODIFY(TRUE);
                    P := P + 1;
                    CheckLastLine := P;

                end;
            end;

            trigger OnPostDataItem()
            begin
                //Reset next order number for sales orders
                NoSeriesLine.LockTable;
                NoSeriesLine.SetCurrentkey("Series Code", "Line No.");
                NoSeriesLine.SetRange("Series Code", 'S-ORD');
                NoSeriesLine.SetRange("Line No.", 10000);

                if NoSeriesLine.Find('+') then begin
                    if VLineOrderNo > NoSeriesLine."Last No. Used" then begin
                        NoSeriesLine."Last No. Used" := VLineOrderNo;
                        NoSeriesLine.Modify;
                    end;
                end;

                //Mark all processed items
                "Telxon Input File".MarkedOnly;
                "Telxon Input File".ModifyAll(Processed, true, true);
            end;

            trigger OnPreDataItem()
            begin
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

    trigger OnInitReport()
    begin
        //Run the Telxon Validation First
        Report.RunModal(50020);
        ClearAll;
    end;

    trigger OnPostReport()
    begin
        //Backup the Telxon Input File Open Items
        Report.RunModal(50005);
        Message('Sales Orders Have Been Created');
    end;

    trigger OnPreReport()
    begin
        Window.Open('Processing Record #1##########');
        repeat
            Window.Update(1, "Telxon Input File".Sequence);
        until "Telxon Input File".Next = 0;
        SalesHeaderRecord.LockTable;
        SalesLineRecord.LockTable;
        TelxonInputRecord.LockTable;
        NoSeriesLine.LockTable;
    end;

    var
        VHoldLineNo: array[5000] of Integer;
        SalesHeaderRecord: Record "Sales Header";
        SalesLineRecord: Record "Sales Line";
        TelxonInputRecord: Record "Telxon Input File";
        LocationRecord: Record Location;
        NoSeriesLine: Record "No. Series Line";
        Window: Dialog;
        VCurrStore: Code[10];
        VCurrLocation: Code[10];
        VCurrDropShip: Boolean;
        VCurrShipCode: Code[10];
        VCurrPickCode: Option;
        VCurrVendor: Code[10];
        VCurrOrderType: Option;
        VNewOrder: Boolean;
        VFirstRecord: Boolean;
        NewCustomerNumber: Code[10];
        VNewShipInstruct: Code[10];
        VOrderType: Option;
        VLocation: Code[10];
        VLineNo: Integer;
        VOrderDate: Date;
        P: Integer;
        C: Integer;
        T: Integer;
        VItemNo: array[2000] of Code[20];
        VDropShip: array[2000] of Boolean;
        VQuantity: array[5000] of Decimal;
        VStoreUse: array[5000] of Boolean;
        VLineOrderNo: Code[10];
        VEndOfFile: Integer;
        CheckLastLine: Integer;
        VSequenceArray: array[5000] of Integer;
        NewNumber: Code[10];
        CheckLocationItem: Code[20];
        VNoLocation: Boolean;
        ItemVariant: Record "Item Variant";
        TItemVariant: array[2000] of Code[10];


    procedure CreateSalesHeader()
    begin
        NewNumber := '';
        SalesHeaderRecord.SetCurrentkey("Document Type", "No.");
        SalesHeaderRecord.SetRange("Document Type", 1);
        SalesHeaderRecord.SetRange("No.", 'S100000', 'S999999');

        SalesHeaderRecord.Find('+');
        NewNumber := IncStr(SalesHeaderRecord."No.");
        SalesHeaderRecord.SetRange("Document Type");//remove filter
        SalesHeaderRecord.SetRange("No.");//remove filter
        SalesHeaderRecord.Init;
        SalesHeaderRecord."Document Type" := "Sales Document Type"::Order;
        SalesHeaderRecord."No." := NewNumber;
        SalesHeaderRecord.Insert(true);
        SalesHeaderRecord."Sell-to Customer No." := NewCustomerNumber;
        SalesHeaderRecord.Validate(SalesHeaderRecord."Sell-to Customer No.");
        SalesHeaderRecord."Order Date" := VOrderDate;
        SalesHeaderRecord."Document Date" := Today;
        SalesHeaderRecord."Release Date" := Today; //CS 9-24-14: Added per Gina to keep the date order was released.
        SalesHeaderRecord.Validate(SalesHeaderRecord."Document Date");
        SalesHeaderRecord."Salesperson Code" := 'TLX';
        SalesHeaderRecord.Validate(SalesHeaderRecord."Salesperson Code");
        SalesHeaderRecord."Shipping Instruction Code" := VNewShipInstruct;
        //SalesHeaderRecord.VALIDATE(SalesHeaderRecord."Shipping Instruction Code");
        SalesHeaderRecord."Sales Order Type" := VOrderType;
        SalesHeaderRecord.Validate(SalesHeaderRecord."Sales Order Type");
        //SalesHeaderRecord."Pick Type" := VCurrPickCode;
        //SalesHeaderRecord.VALIDATE(SalesHeaderRecord."Pick Type",VCurrPickCode);
        SalesHeaderRecord.Validate(SalesHeaderRecord."Location Code", VLocation);

        //IF this is through Anchorage, change the ship to location to ADC
        if VLocation = 'ADC' then
            SalesHeaderRecord."Ship-to Code" := 'ADC';

        //Blank the posting date
        SalesHeaderRecord."Posting Date" := 0D;
        SalesHeaderRecord.Modify;

        VLineNo := 0;
        VLineOrderNo := SalesHeaderRecord."No.";
    end;


    procedure CreateSalesLine()
    begin
        //>>MAS
        //SalesLineRecord.LOCKTABLE;
        //<<

        CheckLocationItem := '';
        C := 1;
        repeat
            //make sure item location exists
            //>>ANICA 6-8-04, change location code lookup to lookup table of valid location codes
            CheckLocationItem := VItemNo[C];
            LookupLocation;

            //Create a line if the location exists
            if VNoLocation = false then begin
                SalesLineRecord.SetCurrentkey("Document Type", "Document No.", "Line No.");
                SalesLineRecord.Init;
                SalesLineRecord."Document Type" := "Sales Document Type"::Order;
                //SalesLineRecord.VALIDATE(SalesLineRecord."Document Type");
                SalesLineRecord."Document No." := VLineOrderNo;
                //SalesLineRecord.VALIDATE(SalesLineRecord."Document No.");

                if VLineNo = 0 then
                    VLineNo := 10
                else
                    VLineNo := VLineNo + 10;

                SalesLineRecord."Line No." := VLineNo;
                //CS 12/5/11 : added the following in order to add the line number to telxon file.
                VHoldLineNo[C] := SalesLineRecord."Line No.";
                SalesLineRecord.Insert(true);
                SalesLineRecord.Validate(SalesLineRecord."Line No.");
                SalesLineRecord.Type := "Sales Line Type"::Item;
                SalesLineRecord.Validate(SalesLineRecord.Type);
                SalesLineRecord."Sell-to Customer No." := NewCustomerNumber;
                SalesLineRecord."Location Code" := VLocation;
                SalesLineRecord."No." := VItemNo[C];
                SalesLineRecord.Validate(SalesLineRecord."No.");
                SalesLineRecord.Validate(SalesLineRecord."Location Code");

                if VDropShip[C] = true then begin
                    SalesLineRecord."Purchasing Code" := 'DROP SHIP';
                    SalesLineRecord.Validate(SalesLineRecord."Purchasing Code");
                end;

                SalesLineRecord.Quantity := VQuantity[C];
                SalesLineRecord."Telxon Quantity" := VQuantity[C];
                SalesLineRecord.Validate(SalesLineRecord.Quantity);
                SalesLineRecord."Store Use" := VStoreUse[C];

                if TItemVariant[C] <> '' then begin
                    //MESSAGE('Item Variant %1',ItemVariant.Code);
                    ItemVariant.SetCurrentkey(ItemVariant."Item No.", ItemVariant.Code);
                    ItemVariant.SetRange(ItemVariant."Item No.", VItemNo[C]);
                    ItemVariant.SetRange(ItemVariant.Code, TItemVariant[C]);

                    if ItemVariant.Find('-') then begin
                        SalesLineRecord.Description := ItemVariant.Description;
                        SalesLineRecord."Description 2" := ItemVariant."Description 2";
                        SalesLineRecord."Variant Code" := ItemVariant.Code;
                    end;
                end;
                //LCC Added 11-13-15, the department code per the sales line should agree with the sales header
                SalesLineRecord."Shortcut Dimension 1 Code" := SalesHeaderRecord."Shortcut Dimension 1 Code";

                SalesLineRecord.Modify(true);

            end;
            C := C + 1;
        until C >= P;
    end;


    procedure UpdateTelxonLine()
    begin
        TelxonInputRecord.LockTable;
        TelxonInputRecord.SetCurrentkey(Sequence);

        C := 1;

        repeat
            TelxonInputRecord.SetRange(Sequence, VSequenceArray[C]);

            TelxonInputRecord.Find('+');
            TelxonInputRecord."Sales Order No." := VLineOrderNo;

            //CS 12/2/11 : Sales Line No. added to Telxon Input File (next line below)
            //CS 12/5/11 : added the following in order to add the line number to telxon file.
            TelxonInputRecord."Sales Line No." := VHoldLineNo[C];

            TelxonInputRecord."Processed Date" := Today;
            TelxonInputRecord.Modify(true);
            TelxonInputRecord.SetRange(Sequence);
            C := C + 1;
        until C >= P;
    end;


    procedure LookupLocation()
    begin
        //>>ANICA 6-8-04 Changed this to validate location on the location code table
        VNoLocation := false;

        LocationRecord.SetCurrentkey(Code);
        LocationRecord.SetRange(Code, VLocation);

        if LocationRecord.Find('+') then
            VLocation := VLocation
        else begin
            Message('Press enter to continue, Location not found %1 %2', CheckLocationItem, VLocation);
            VNoLocation := true;
        end;

        LocationRecord.SetRange(Code);//Clear filter
    end;
}

