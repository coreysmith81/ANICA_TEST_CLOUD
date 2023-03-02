Report 50000 "Freight Calculation"
{
    // //>> MAS
    // Freight Calculation Routines.
    // //<<
    // 
    // ANICA 9-13-05, add dimension routine for ver 3.7 which updates the document dimension table for changes in department codes
    // 
    // //MAS: 06/20/01, MAS200
    //         Added code to 'RecalcRetailPerSalesLine' function to prevent calculating retail when
    //          Commidity Code = 'OS' and when Gen.Prod.Post.Grp = 'STOREU'.
    //        09/11/01, MAS200
    //         Rearranged calculation 'Retail Price per Unit'.
    // //ANICA:  10/25/01
    //         Revised Retail calculations to use new CAP code Tables
    // //ANICA 09/02/04 Added check to force a retail for certain shipping instructions.
    // 
    // //ANICA 8-21-15 Create Freight Lines, change sales line type VALIDATION to a direct assignment of type to be "G/L Account"
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Freight Calculation.rdlc';


    dataset
    {
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

    var
        Item: Record Item;
        DocDimension: Record "Gen. Jnl. Dim. Filter";
        _Quantity: Decimal;
        _NewAmountGlobal: Decimal;
        _SaleslineLineNo: Integer;
        VForce: Boolean;
        ShipInstr: Record "Shipping Instructions";
        TargetRetail: Record "Item Target Retail";
        CustomerTarget: Record "Customer Target";
        VTarget: Code[10];
        VRetail: Decimal;
        VPriority: Integer;
        VHighPriority: Integer;
        VCurrPriority: Integer;
        VCurrRetail: Decimal;
        VCurrTarget: Code[10];


    procedure RecalculateFreight(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        // This function is using the RecalcFreightPerSalesLIne routine, to
        // (re)calculate the freightcosts per sales-line, according
        // to the Shipping Instruction Code and the Shipping Legs.
        if SalesHeader."Shipping Instruction Code" = '' then
            exit;


        SalesLine.LockTable;
        SalesLine.SetRange(SalesLine."Document Type", SalesHeader."Document Type");
        SalesLine.SetRange(SalesLine."Document No.", SalesHeader."No.");
        SalesLine.SetRange(SalesLine.Type, SalesLine.Type::Item);
        SalesLine.SetFilter(SalesLine.Quantity, '<>0');
        SalesLine.SetFilter(SalesLine."No.", '<>''''');
        while SalesLine.Next <> 0 do begin
            if RecalcFreightPerSalesLine(SalesHeader, SalesLine) then
                SalesLine.Modify;
        end;
    end;


    procedure RecalcFreightPerSalesLine(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"): Boolean
    var
        ShipLeg: Record "Shipping Legs";
        SalesLineFreight: Record "Sales Line Freight";
        _LegSequence: Integer;
        _EstimatedFreight: Decimal;
    begin
        // (re)calculate freightcosts:
        if (SalesHeader."Shipping Instruction Code" = '') or
           (SalesLine.Type <> SalesLine.Type::Item) then
            exit(false);
        ShipLeg.SetRange(ShipLeg."Shipping Instruction Code", SalesHeader."Shipping Instruction Code");
        if not ShipLeg.Find('-') then begin
            //ERROR('No Shipping Instruction legs were found for Instruction Code %1',SalesHeader."Shipping Instruction Code");
            exit(false);
        end;

        //If found then delete old SalesLineFreight records:
        DeleteOldSalesLinesFreight(SalesLine);

        Item.Get(SalesLine."No.");
        Clear(_LegSequence);

        repeat
            // Estimated Freight is being calculated here: (its the total freight per item)
            case ShipLeg."Calculation Type" of
                0:
                    _EstimatedFreight :=
                    CalcParcelPostDirect(SalesLine, Item, ShipLeg);
                1:
                    _EstimatedFreight :=
                    CalcAirFreight(SalesLine, Item, ShipLeg);
                2:
                    _EstimatedFreight :=
                    CalcBarge(SalesLine, Item, ShipLeg);
                3:
                    _EstimatedFreight :=
                    CalcWarehouseParcelPost(SalesLine, ShipLeg);
                4:
                    _EstimatedFreight :=
                    CalcSteamShipTruck(SalesLine, Item, ShipLeg);
            end;
            // Inserting SalesLineFreight:
            SalesLineFreight.Init;
            _LegSequence := _LegSequence + 10000;
            SalesLineFreight."Document Type" := SalesLine."Document Type";
            SalesLineFreight."Document No." := SalesLine."Document No.";
            SalesLineFreight."Sell-to Customer No." := SalesLine."Sell-to Customer No.";
            SalesLineFreight."Line No." := SalesLine."Line No.";
            SalesLineFreight."Leg Sequence" := _LegSequence;
            SalesLineFreight."Leg Name" := ShipLeg.Leg;
            SalesLineFreight."Freight Account" := ShipLeg."Freight Account";
            SalesLineFreight."Calculation Type" := ShipLeg."Calculation Type";
            SalesLineFreight."Estimated Freight" := _EstimatedFreight; // = Total freight
            if SalesLine.Quantity <> 0 then
                SalesLineFreight."Estimated Freight Per Unit" :=
                                  SalesLineFreight."Estimated Freight" / SalesLine.Quantity;
            // 04/06/2000
            if (SalesLine."Document Type" = SalesLine."document type"::"Credit Memo")
            or (SalesLine."Document Type" = SalesLine."document type"::Invoice) then
                _Quantity := SalesLine.Quantity
            //
            else
                _Quantity := SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced";
            if SalesLine."Qty. to Invoice" < _Quantity then
                _Quantity := SalesLine."Qty. to Invoice";
            SalesLineFreight."Freight to Invoice" := SalesLineFreight."Estimated Freight Per Unit" * _Quantity;
            SalesLineFreight.Insert;
        until ShipLeg.Next = 0;

        SalesLine.CalcFields("Estimated Freight");
        SalesLine."Landed Cost" := ROUND((SalesLine."Unit Price" + SalesLine."Estimated Freight"), 0.01);
        exit;
    end;


    procedure RecalculateRetail(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        //ANICA 09/02/04
        ShipInstr.SetCurrentkey(ShipInstr.Code);
        ShipInstr.SetRange(ShipInstr.Code, SalesHeader."Shipping Instruction Code");
        if ShipInstr.Find('-') then VForce := ShipInstr."Force Retail";

        //Calculating Retail.
        SalesLine.LockTable;
        SalesLine.SetRange(SalesLine."Document Type", SalesHeader."Document Type");
        SalesLine.SetRange(SalesLine."Document No.", SalesHeader."No.");
        SalesLine.SetRange(SalesLine.Type, SalesLine.Type::Item);
        SalesLine.SetFilter(SalesLine.Quantity, '<>0');
        SalesLine.SetFilter(SalesLine."No.", '<>''''');
        while SalesLine.Next <> 0 do begin
            RecalcRetailPerSalesLine(SalesLine);
            SalesLine.Modify;
        end;
    end;


    procedure RecalcRetailPerSalesLine(var SalesLine: Record "Sales Line")
    var
        Customer: Record Customer;
        _Amount: Decimal;
    begin
        //Calculating Retail per SalesLine.
        if SalesLine.Type <> SalesLine.Type::Item then
            exit;

        Item.Get(SalesLine."No.");

        //>>MAS, 06/20/01, MAS200
        if Item."Commodity Code" = 'OS' then begin
            SalesLine."Retail Price Per Unit" := 0;
            exit;
        end;

        Item.Get(SalesLine."No.");
        if Item."Gen. Prod. Posting Group" = 'STOREU' then begin
            SalesLine."Retail Price Per Unit" := 0;
            exit;
        end;
        //<<

        Customer.Get(SalesLine."Sell-to Customer No.");
        Clear(SalesLine."Retail Price Per Unit");


        //Use Std Fixed Retail, if item has one
        if Item."Std Fixed Retail" <> 0 then begin
            VRetail := Item."Std Fixed Retail";
            SalesLine."Retail Price Per Unit" := Item.RetailRounding(VRetail, Item."Commodity Code")
        end
        else
            VRetail := 0;

        //Use Target Retail next, if no Std Fixed Retail is available.
        if VRetail = 0 then begin
            //Initialize Variables
            Clear(VTarget);
            Clear(VHighPriority);

            //Lookup Customer Targets Table for Customer
            CustomerTarget.SetCurrentkey("Customer No.", Target);
            CustomerTarget.SetRange("Customer No.", Customer."No.");

            //IF a record(s) is found, GET the Target and Priority, then look up to see if there is a target retail for the combo.
            if CustomerTarget.Find('-') then begin
                repeat
                    CustomerTarget.CalcFields(Priority);
                    VCurrTarget := CustomerTarget.Target;
                    VCurrPriority := CustomerTarget.Priority;

                    //Lookup Target Retail table to see if there is a retail for this target.
                    // Get the Retail if there is one, skip the target if not.
                    TargetRetail.SetCurrentkey("Item No.", UPC, Target);
                    TargetRetail.SetRange("Item No.", Item."No.");
                    TargetRetail.SetRange(UPC, SalesLine."Vendor UPC Code");
                    TargetRetail.SetRange(Target, VCurrTarget);

                    if TargetRetail.Find('-') then
                        VCurrRetail := TargetRetail.Retail;

                    //IF there is a retail from the combo, us it.
                    if (VCurrPriority > VHighPriority) and (VCurrRetail <> 0) then begin
                        VHighPriority := VCurrPriority;
                        VRetail := VCurrRetail;
                    end;

                    Clear(VCurrRetail);
                    Clear(VCurrPriority);
                    Clear(VCurrTarget);

                until CustomerTarget.Next = 0;
            end
            else
                //IF there is no Target Retail Record, or it's 0, move on to Floating Retail.
                VRetail := 0;
        end;

        //Apply Retail Rounding to Target Retail.
        if VRetail <> 0 then
            SalesLine."Retail Price Per Unit" := Item.RetailRounding(VRetail, Item."Commodity Code")
        else
            VRetail := 0;

        //IF no retail from Fixed or Target Retails, use Floating Retail.
        if VRetail = 0 then
            CalculateRetail(SalesLine, Item);

        Clear(CustomerTarget);
        Clear(TargetRetail);

        //ANICA 09/02/04
        if VForce = true then
            CalculateRetail(SalesLine, Item);

        CalculateMargin(SalesLine, Item);
    end;


    procedure CreateFreightLines(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesLineFreight: Record "Sales Line Freight";
        SalesLineFreight2: Record "Sales Line Freight";
        _LineNo: Integer;
        "(G/L)Account": Record "G/L Account";
    begin
        //Saleslines for freight will be created, according to the different G/LAccount Type Sales lines.
        //and the EstimatedFreight will be calculated.
        SalesLineFreight.SetCurrentkey("Document Type", "Sell-to Customer No.", "Document No.", "Freight Account");
        SalesLineFreight.SetRange("Document Type", SalesHeader."Document Type");

        SalesLineFreight.SetRange("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        SalesLineFreight.SetRange("Document No.", SalesHeader."No.");
        SalesLineFreight.SetFilter("Freight to Invoice", '<>0'); // later on, this filter is removed again.
        if not SalesLineFreight.Find('-') then
            exit;
        // To find last SalesLine Line No:
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if not SalesLine.Find('+') then
            exit;
        _LineNo := SalesLine."Line No.";
        SalesLine.Reset;

        repeat
            /*set range on (GL)Account*/
            SalesLineFreight2.Copy(SalesLineFreight);
            SalesLineFreight2.SetRange("Freight Account", SalesLineFreight."Freight Account");
            SalesLineFreight2.SetRange("Freight to Invoice"); // To remove range on '<>0', because range is not part of calcsumkey.
            SalesLineFreight2.CalcSums("Freight to Invoice");
            // Creating SalesLine for (GL)Account:
            SalesLine.Init;
            _LineNo := _LineNo + 10000;
            SalesLine."Line No." := _LineNo;
            SalesLine.Validate("Document Type", SalesLineFreight."Document Type");
            SalesLine.Validate("Document No.", SalesLineFreight."Document No.");
            SalesLine.Validate("Sell-to Customer No.", SalesLineFreight."Sell-to Customer No.");
            //<<ANICA CHANGE 8-21-15, remove sales line validation due to Status Check in the sales line table in 2015 version
            //Instead, make the sales line type a "G/L Account" without validation
            // SalesLine.VALIDATE(Type,SalesLine.Type::"G/L Account"); // check description
            SalesLine.Type := SalesLine.Type::"G/L Account";
            //>>END ANICA Change
            SalesLine.Validate("No.", SalesLineFreight."Freight Account");
            SalesLine.Quantity := 1;
            SalesLine."Unit Price" := ROUND(SalesLineFreight2."Freight to Invoice", 0.01);
            SalesLine.Amount := SalesLine."Unit Price";
            SalesLine."Calculated Freight Line" := true;
            SalesLine.Validate("Unit Price");
            SalesLine.Validate(Quantity);
            SalesLine."Qty. to Ship" := 0;
            SalesLine."Quantity Shipped" := 0;
            SalesLine."Qty. to Invoice" := 1;
            SalesLine."Quantity Invoiced" := 0;
            SalesLine.Insert;
            //Update dimension table
            UpdateDocDimensionTable(SalesLine);
            SalesLineFreight.SetFilter("Freight Account", '>%1', SalesLineFreight."Freight Account");
        until SalesLineFreight.Next = 0;

    end;


    procedure CalcParcelPostDirect(SalesLine: Record "Sales Line"; Item: Record Item; ShipLeg: Record "Shipping Legs"): Decimal
    var
        ParcPostDirRate: Record "Parcel Post Direct Rates";
    begin
        if not ParcPostDirRate.Get(Item."Commodity Code", ShipLeg."Sea or Anch", ShipLeg."Priority Type") then begin
            //MESSAGE('Parcel Post Direct Rate in %1 table could not be found for: \'+
            //        'Commodity code = %2, Sea or Anch = %3, Priority = %4',
            //         ParcPostDirRate.TABLENAME,Item."Commodity Code",
            //         ShipLeg."Sea or Anch",ShipLeg.Priority);
            exit(0);
        end;
        exit(ROUND((ParcPostDirRate."Rate per dollar" * SalesLine.Amount), 0.01));
    end;


    procedure CalcAirFreight(SalesLine: Record "Sales Line"; Item: Record Item; ShipLeg: Record "Shipping Legs"): Decimal
    var
        AirFreightRate: Record "Air Freight Rates";
        Carrier: Record Carrier;
        FreightCode: Record "Freight Code";
        _TotalWeight: Decimal;
        _EstimatedFreight: Decimal;
    begin
        FreightCode.Get(Item."Freight Code");
        if not AirFreightRate.Get(SalesLine."Sell-to Customer No.", FreightCode."Air Rate Type", ShipLeg.Carrier, ShipLeg.Origin,
                                  ShipLeg.Destination) then begin
            //MESSAGE('Air Freight Rates in %1 table could not be found for: \'+
            //        'Cust.No. = %2, Air Rate Type = %3, Carrier = %4, Origin = %5, Destination = %6',
            //         AirFreightRate.TABLENAME,SalesLine."Sell-to Customer No.",
            //         FreightCode."Air Rate Type",ShipLeg.Carrier,ShipLeg.Origin,ShipLeg.Destination);
            exit(0);
        end;

        Carrier.Get(ShipLeg.Carrier);

        /*
        //Old situation:
        _TotalWeight := SalesLine."Gross Weight" * SalesLine.Quantity;
        IF _TotalWeight <= Carrier."Pivot Pounds (Air Freight)" THEN
           _EstimatedFreight := AirFreightRate."Low Flat Rate" + (AirFreightRate."Rate per pound" * _TotalWeight)
        ELSE
           _EstimatedFreight := AirFreightRate."High Flat Rate" + (AirFreightRate."Rate per pound" * _TotalWeight);
        */

        //New Situation:
        _TotalWeight := SalesLine."Gross Weight" * SalesLine.Quantity;
        if SalesLine."Gross Weight" <= Carrier."Pivot Pounds (Air Freight)" then
            _EstimatedFreight := AirFreightRate."Low Flat Rate"
        else
            _EstimatedFreight := AirFreightRate."High Flat Rate";
        _EstimatedFreight := (_EstimatedFreight * SalesLine.Quantity) +
                             (AirFreightRate."Rate per pound" * _TotalWeight);
        //

        exit(ROUND(_EstimatedFreight, 0.01));

    end;


    procedure CalcBarge(SalesLine: Record "Sales Line"; Item: Record Item; ShipLeg: Record "Shipping Legs"): Decimal
    var
        BargeRate: Record "Barge Rates";
        Customer: Record Customer;
        _EstimatedFreight: Decimal;
    begin
        Customer.Get(SalesLine."Sell-to Customer No.");
        if not BargeRate.Get(Customer."Barge Zone", Item."Freight Code", ShipLeg.Carrier) then begin
            //MESSAGE('Barge Rates in %1 table could not be found for: \'+
            //        'Barge Zone = %2, Freight Code = %3, Carrier = %4',
            //         BargeRate.TABLENAME,Customer."Barge Zone",Item."Freight Code",ShipLeg.Carrier);
            exit(0);
        end;
        _EstimatedFreight := BargeRate."Rate per pound" * (SalesLine."Gross Weight" * SalesLine.Quantity);
        exit(ROUND(_EstimatedFreight, 0.01));
    end;


    procedure CalcWarehouseParcelPost(SalesLine: Record "Sales Line"; ShipLeg: Record "Shipping Legs"): Decimal
    var
        WarehParcPostRate: Record "Warehouse Parcel Post Rates";
        Customer: Record Customer;
        _EstimatedFreight: Decimal;
    begin
        Customer.Get(SalesLine."Sell-to Customer No.");
        if not WarehParcPostRate.Get(Customer."Parcel Post Code", ShipLeg."Priority Type") then begin
            //MESSAGE('Warehouse Parcel Post Rates in %1 table could not be found for: \'+
            //        'Parcel Post Code = %2, Priority = %3',
            //         WarehParcPostRate.TABLENAME,Customer."Parcel Post Code",ShipLeg.Priority);
            exit(0);
        end;
        _EstimatedFreight := WarehParcPostRate."Rate per pound" * (SalesLine."Gross Weight" * SalesLine.Quantity);
        //MESSAGE('Estimated freight %1',_EstimatedFreight);
        exit(ROUND(_EstimatedFreight, 0.01));
    end;


    procedure CalcSteamShipTruck(SalesLine: Record "Sales Line"; Item: Record Item; ShipLeg: Record "Shipping Legs"): Decimal
    var
        SteamShipTruckRate: Record "Steam Ship or Truck Rates";
        _EstimatedFreight: Decimal;
    begin
        if not SteamShipTruckRate.Get(Item."Freight Code", ShipLeg.Carrier, ShipLeg.Origin, ShipLeg.Destination) then begin
            //MESSAGE('Steamship-Or-Truck Rates in %1 table could not be found for: \'+
            //        'Freight Code = %2, Carrier = %3, Origin = %4, Destination = %5',
            //         SteamShipTruckRate.TABLENAME,Item."Freight Code",
            //         ShipLeg.Carrier,ShipLeg.Origin,ShipLeg.Destination);
            exit(0);
        end;
        _EstimatedFreight := SteamShipTruckRate."Rate per Pound" * (SalesLine."Gross Weight" * SalesLine.Quantity);
        exit(ROUND(_EstimatedFreight, 0.01));
    end;


    procedure CalculateRetail(var SalesLine: Record "Sales Line"; Item: Record Item): Boolean
    var
        Commodity: Record "Commodity Code";
        ItemUOM: Record "Item Unit of Measure";
    begin
        /*Floating retail calculation*/
        ItemUOM.Get(SalesLine."No.", SalesLine."Unit of Measure Code"); // for Pack
        ItemUOM.TestField(Pack);

        if not Commodity.Get(Item."Commodity Code") then begin
            //  MESSAGE('Commodity Code could not be found for: \'+
            //          'Commodity Code = %1',Item."Commodity Code");
            exit(false);
        end;

        SalesLine.CalcFields("Estimated Freight");
        SalesLine."Retail Price Per Unit" :=
        //           ((SalesLine."Unit Price" + SalesLine."Estimated Freight") / ItemUOM.Pack) /
                   ((SalesLine."Unit Price" + (SalesLine."Estimated Freight" / SalesLine.Quantity)) / ItemUOM.Pack) /
                   (1 - (Commodity.Margin / 100));
        SalesLine."Retail Price Per Unit" :=
                   Item.RetailRounding(SalesLine."Retail Price Per Unit", Item."Commodity Code");
        exit(true);

    end;


    procedure "RecalcFreightAccount(GL)"(SalesLine: Record "Sales Line"; OldAmount: Decimal)
    var
        SalesLineFreight: Record "Sales Line Freight";
        _Percentage: Decimal;
        _AddAmount: Decimal;
        ItemUOM: Record "Item Unit of Measure";
        _TotalEstGLAmount: Decimal;
        SalesHeader: Record "Sales Header";
    begin
        //Difference between the previous freight amount and new freight amount is prorated over
        //the SaleslLineFreight record for that G/L No.

        if SalesLine.Type <> SalesLine.Type::"G/L Account" then
            exit;

        _NewAmountGlobal := SalesLine.Amount;
        _SaleslineLineNo := SalesLine."Line No.";

        //This routine will be used if the user overrides the calculated
        //freight amount on the freightline.
        //Difference between the previous freight amount and new freight amount is prorated over
        //the SaleslLineFreight record for that G/L No.
        //They use calcfields, connected to the SalesLineFreight table.
        if SalesLine."Calculated Freight Line" then begin
            SalesLineFreight.LockTable;
            SalesLineFreight.SetRange("Document Type", SalesLine."Document Type");
            SalesLineFreight.SetRange("Sell-to Customer No.", SalesLine."Sell-to Customer No.");
            SalesLineFreight.SetRange("Document No.", SalesLine."Document No.");
            SalesLineFreight.SetRange("Freight Account", SalesLine."No.");
            if not SalesLineFreight.Find('-') then
                exit;
            _AddAmount := SalesLine.Amount - OldAmount;
            repeat
                SalesLineFreight."Freight to Invoice" :=
                   SalesLineFreight."Freight to Invoice" +
                   (_AddAmount * (SalesLineFreight."Freight to Invoice" / OldAmount));
                SalesLineFreight.Modify;
            until SalesLineFreight.Next = 0;
        end;

        //Modify Anicafeeline,AnicaReserveline, AnicaInsuranceline, and Tobacco Tax line (6-29-16):
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        CreateInsuranceLine(SalesHeader);
        CreateReserveLine(SalesHeader);
        CreateAnicaFeeLine(SalesHeader);
        CreateTobaccoTaxLine(SalesHeader);

        //
        /* (Don't have to be recalculated here)
        //Recalc SalesLine Landed Cost and Actual GPM fields:
        SalesLine.LOCKTABLE;
        SalesLine.SETRANGE("Document Type",SalesLine."Document Type");
        SalesLine.SETRANGE("Document No.",SalesLine."Document No.");
        SalesLine.SETRANGE(Type,SalesLine.Type::Item);
        
        IF SalesLine.FIND('-') THEN
          REPEAT
        //  Recalc Landed Cost field:
            SalesLine.CALCFIELDS("Estimated Freight");
            SalesLine."Landed Cost" := ROUND((SalesLine."Unit Price" + SalesLine."Estimated Freight"),0.01);
        //  Recalc Actual GPM:
            ItemUOM.GET(SalesLine."No.",SalesLine."Unit of Measure Code"); // for Pack
            ItemUOM.TESTFIELD(Pack);  // or pack from SalesLine ?
            //SalesLine.TESTFIELD("Retail Price Per Unit");
            SalesLine."Actual Margin" :=
               ROUND((SalesLine."Retail Price Per Unit"-(SalesLine."Landed Cost"/ItemUOM.Pack))/
                      SalesLine."Retail Price Per Unit",0.01);
            SalesLine.MODIFY;
          UNTIL SalesLine.NEXT = 0;
        */

    end;


    procedure DeleteOldSalesLinesFreight(SalesLine: Record "Sales Line")
    var
        SalesLineFreight: Record "Sales Line Freight";
    begin
        //If found then delete old SalesLineFreight records:
        SalesLineFreight.LockTable;
        SalesLineFreight.SetRange(SalesLineFreight."Document Type", SalesLine."Document Type");
        SalesLineFreight.SetRange(SalesLineFreight."Document No.", SalesLine."Document No.");
        SalesLineFreight.SetRange(SalesLineFreight."Line No.", SalesLine."Line No.");
        SalesLineFreight.DeleteAll;
    end;


    procedure DeleteCalculatedFreightLines(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        //Setrange op flag 'Calculated Freight Line' is <True> and
        //delete all the Saleslines.
        SalesLine.LockTable;
        SalesLine.SetRange(SalesLine."Document Type", SalesHeader."Document Type");
        SalesLine.SetRange(SalesLine."Document No.", SalesHeader."No.");
        SalesLine.SetRange(SalesLine.Type, SalesLine.Type::"G/L Account");
        SalesLine.SetRange("Calculated Freight Line", true);
        SalesLine.SetCurrentkey("Document Type", "Document No.", Type, "Calculated Freight Line");
        SalesLine.DeleteAll;
    end;


    procedure DeleteInsuranceLine(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        // Delete InsuranceLines to create new one.
        SalesLine.LockTable;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Calculated Insurance Line", true);
        SalesLine.SetCurrentkey("Document Type", "Document No.", Type, "Calculated Insurance Line");
        SalesLine.DeleteAll; // delete insurance line.
    end;


    procedure DeleteReserveLine(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        // Delete ReserveLines to create new one.
        SalesLine.LockTable;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Calculated Reserve Line", true);
        SalesLine.SetCurrentkey("Document Type", "Document No.", Type, "Calculated Reserve Line");
        SalesLine.DeleteAll; // delete reserve line.
    end;


    procedure DeleteAnicaFeeLine(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        // Delete AnicaFeeLine to create new one.
        SalesLine.LockTable;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Calculated Fee Line", true);
        SalesLine.SetCurrentkey("Document Type", "Document No.", Type, "Calculated Fee Line");
        SalesLine.DeleteAll; // delete anica fee line.
    end;


    procedure DeleteTobaccoTaxLine(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        // Delete TobaccoLines to create new one.
        SalesLine.LockTable;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Calculated Tobacco Tax Line", true);
        SalesLine.SetCurrentkey("Document Type", "Document No.", Type, "Calculated Tobacco Tax Line");
        SalesLine.DeleteAll; // delete reserve line.
    end;


    procedure CreateInsuranceLine(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        _TotAmount: Decimal;
        _LineNo: Integer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        //If total merchandise and freight is over $400, and Customer."Exempt from Insurance" is <false>,
        //then create Salesline for Insurance.
        DeleteInsuranceLine(SalesHeader);

        SalesReceivablesSetup.Get;
        SalesReceivablesSetup.TestField("Freight Insurance Acc. No.");
        SalesHeader.TestField("Insurance Rate");

        Customer.Get(SalesHeader."Sell-to Customer No.");
        if Customer."Exempt from Insurance" then
            exit;

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.Find('+') then
            _LineNo := SalesLine."Line No.";

        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter(Quantity, '<>0');
        SalesLine.SetRange("No Insurance", false);

        Clear(_TotAmount);
        if SalesLine.Find('-') then
            repeat
                // 04/06/2000
                if (SalesLine."Document Type" = SalesLine."document type"::"Credit Memo")
                or (SalesLine."Document Type" = SalesLine."document type"::Invoice) then
                    _Quantity := SalesLine.Quantity
                //
                else
                    _Quantity := SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced";
                if SalesLine."Qty. to Invoice" < _Quantity then
                    _Quantity := SalesLine."Qty. to Invoice";
                _TotAmount := _TotAmount + (SalesLine.Amount * (_Quantity / SalesLine.Quantity));
            until SalesLine.Next = 0;

        //Set filter on Account-GL with exclusion of anica lines, for GL-lines for
        //consolidation and miscellaneous:
        SalesLine.SetRange(Type, SalesLine.Type::"G/L Account");
        SalesLine.SetRange(SalesLine."Calculated Freight Line", false);
        SalesLine.SetRange("Calculated Insurance Line", false);
        SalesLine.SetRange("Calculated Reserve Line", false);
        SalesLine.SetRange("Calculated Fee Line", false);
        SalesLine.SetRange("Calculated Tobacco Tax Line", false);
        SalesLine.SetFilter(Quantity, '<>0');

        if SalesLine.Find('-') then
            repeat
                // This has to be done, otherwise a modification of the amount on the line is not working properly:
                if (_NewAmountGlobal <> 0) and (_SaleslineLineNo <> 0) then
                    if SalesLine."Line No." = _SaleslineLineNo then
                        SalesLine.Amount := _NewAmountGlobal; // Just replace, no update here.
                                                              // 04/06/2000
                if (SalesLine."Document Type" = SalesLine."document type"::"Credit Memo")
                or (SalesLine."Document Type" = SalesLine."document type"::Invoice) then
                    _Quantity := SalesLine.Quantity
                //
                else
                    _Quantity := SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced";
                if SalesLine."Qty. to Invoice" < _Quantity then
                    _Quantity := SalesLine."Qty. to Invoice";
                _TotAmount := _TotAmount + (SalesLine.Amount * (_Quantity / SalesLine.Quantity));
            until SalesLine.Next = 0;

        SalesLine.SetRange(SalesLine.Type); // Reset
        SalesLine.SetRange("Calculated Freight Line", true);

        if SalesLine.Find('-') then
            repeat
                // This has to be done, otherwise a modification of the amount on the line is not working properly:
                if (_NewAmountGlobal <> 0) and (_SaleslineLineNo <> 0) then
                    if SalesLine."Line No." = _SaleslineLineNo then
                        SalesLine.Amount := _NewAmountGlobal; // Just replace, no update here.
                _TotAmount := _TotAmount + SalesLine.Amount;
            until SalesLine.Next = 0;

        if _TotAmount < 400 then
            exit;

        SalesReceivablesSetup.TestField("Freight Insurance Acc. No.");
        SalesReceivablesSetup.TestField("Freight Insurance Rate");

        //LCC 6-30-16 Don't add fee to freight insurance, it is charged when added into the total
        //_TotAmount := ROUND(_TotAmount * (1 + (Customer."ANICA Member Fee"/100))
        _TotAmount := ROUND(_TotAmount * (SalesReceivablesSetup."Freight Insurance Rate" / 100), 0.01);

        if _TotAmount = 0 then
            exit;

        // Creating SalesLine for Insurance:
        SalesLine.Reset;
        SalesLine.Init;
        SalesLine."Line No." := _LineNo + 10000;
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
        SalesLine.Validate("No.", SalesReceivablesSetup."Freight Insurance Acc. No.");
        SalesLine.Quantity := 1;
        SalesLine."Unit Price" := _TotAmount;  // Insurance amount.
        SalesLine.Amount := _TotAmount;
        SalesLine.Validate("Unit Price");
        SalesLine.Validate(Quantity);
        SalesLine."Qty. to Ship" := 0;
        SalesLine."Quantity Shipped" := 0;
        SalesLine."Qty. to Invoice" := 1;
        SalesLine."Quantity Invoiced" := 0;
        SalesLine."Calculated Insurance Line" := true;
        //>>CS 05-10-16: Making the Department Code for all freight insurance lines ANICA. OK'd by Jessica.
        SalesLine."Shortcut Dimension 1 Code" := 'ANICA';
        SalesLine.Insert;
        //Update dimension table
        UpdateDocDimensionTable(SalesLine);
    end;


    procedure CreateReserveLine(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        _TotAmount: Decimal;
        _LineNo: Integer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
    begin
        //Reserve Calculation:
        DeleteReserveLine(SalesHeader);

        Customer.Get(SalesHeader."Sell-to Customer No.");
        //Customer.TESTFIELD("Reserve Factor");
        if Customer."Reserve Factor" = 0 then
            exit;

        SalesReceivablesSetup.Get;
        SalesReceivablesSetup.TestField("Reserve Acc. No.");
        SalesReceivablesSetup.TestField("Reserve Department Code");

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.Find('+') then
            _LineNo := SalesLine."Line No.";

        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter(Quantity, '<>0');

        Clear(_TotAmount);
        if SalesLine.Find('-') then
            repeat
                // 04/06/2000
                if (SalesLine."Document Type" = SalesLine."document type"::"Credit Memo")
                or (SalesLine."Document Type" = SalesLine."document type"::Invoice) then
                    _Quantity := SalesLine.Quantity
                //
                else
                    _Quantity := SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced";
                if SalesLine."Qty. to Invoice" < _Quantity then
                    _Quantity := SalesLine."Qty. to Invoice";
                _TotAmount := _TotAmount + (SalesLine.Amount * (_Quantity / SalesLine.Quantity));
            until SalesLine.Next = 0;

        //Set filter on Account-GL with exclusion of anica lines, for GL-lines for
        //consolidation and miscellaneous:
        SalesLine.SetRange(Type, SalesLine.Type::"G/L Account");
        SalesLine.SetRange(SalesLine."Calculated Freight Line", false);
        SalesLine.SetRange("Calculated Insurance Line", false);
        SalesLine.SetRange("Calculated Reserve Line", false);
        SalesLine.SetRange("Calculated Fee Line", false);
        SalesLine.SetRange("Calculated Tobacco Tax Line", false);
        SalesLine.SetFilter(Quantity, '<>0');

        if SalesLine.Find('-') then
            repeat
                // This has to be done, otherwise a modification of the amount on the line is not working properly:
                if (_NewAmountGlobal <> 0) and (_SaleslineLineNo <> 0) then
                    if SalesLine."Line No." = _SaleslineLineNo then
                        SalesLine.Amount := _NewAmountGlobal; // Just replace, no update here.
                                                              // 04/06/2000
                if (SalesLine."Document Type" = SalesLine."document type"::"Credit Memo")
                or (SalesLine."Document Type" = SalesLine."document type"::Invoice) then
                    _Quantity := SalesLine.Quantity
                //
                else
                    _Quantity := SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced";
                if SalesLine."Qty. to Invoice" < _Quantity then
                    _Quantity := SalesLine."Qty. to Invoice";
                _TotAmount := _TotAmount + (SalesLine.Amount * (_Quantity / SalesLine.Quantity));
            until SalesLine.Next = 0;

        SalesReceivablesSetup.TestField("Reserve Acc. No.");
        SalesReceivablesSetup.TestField("Reserve Department Code");
        _TotAmount := ROUND(_TotAmount * (Customer."Reserve Factor" / 100), 0.01);
        if _TotAmount = 0 then
            exit;

        // Creating SalesLine for Reserve:
        SalesLine.Reset;
        SalesLine.Init;
        SalesLine."Line No." := _LineNo + 10000;
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
        SalesLine.Validate("No.", SalesReceivablesSetup."Reserve Acc. No.");
        SalesLine.Quantity := 1;
        SalesLine."Unit Price" := _TotAmount;  // Reserve Amount.
        SalesLine.Amount := _TotAmount;
        SalesLine.Validate("Unit Price");
        SalesLine.Validate(Quantity);
        SalesLine."Calculated Reserve Line" := true;
        SalesLine."Shortcut Dimension 1 Code" := SalesReceivablesSetup."Reserve Department Code";
        //CS 2-16-16 TEST +++
        SalesLine."Dimension Set ID" := 1;
        SalesLine."Qty. to Ship" := 0;
        SalesLine."Quantity Shipped" := 0;
        SalesLine."Qty. to Invoice" := 1;
        SalesLine."Quantity Invoiced" := 0;
        SalesLine.Insert;
        //Update dimension table
        UpdateDocDimensionTable(SalesLine);
    end;


    procedure CreateAnicaFeeLine(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        _TotAmount: Decimal;
        _LineNo: Integer;
        MemberStatus: Record "Member Status";
    begin
        //Anica Fee Calculation:
        DeleteAnicaFeeLine(SalesHeader);

        Customer.Get(SalesHeader."Sell-to Customer No.");
        Customer.TestField(Customer."ANICA Member Fee");
        MemberStatus.Get(Customer."Member Code"); // for DeparmentCode and AccountNo.
        MemberStatus.TestField("Account No.");
        MemberStatus.TestField("Department Code");

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.Find('+') then
            _LineNo := SalesLine."Line No.";

        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter(Quantity, '<>0');

        Clear(_TotAmount);
        if SalesLine.Find('-') then
            repeat
                // 04/06/2000
                if (SalesLine."Document Type" = SalesLine."document type"::"Credit Memo")
                or (SalesLine."Document Type" = SalesLine."document type"::Invoice) then
                    _Quantity := SalesLine.Quantity
                //
                else
                    _Quantity := SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced";
                if SalesLine."Qty. to Invoice" < _Quantity then
                    _Quantity := SalesLine."Qty. to Invoice";
                if ((SalesLine."Store Use") or (SalesLine."Snow Machine")) and (Customer."ANICA Member Fee" > 5) then
                    _TotAmount := _TotAmount + (SalesLine.Amount * (_Quantity / SalesLine.Quantity) * (5 / 100))
                else
                    _TotAmount := _TotAmount +
                        ((SalesLine.Amount * (_Quantity / SalesLine.Quantity))
                        * (Customer."ANICA Member Fee" / 100));
            until SalesLine.Next = 0;

        //Set filter on Account-GL with exclusion of anica lines, for GL-lines for
        //consolidation and miscellaneous:
        SalesLine.SetRange(Type, SalesLine.Type::"G/L Account");
        SalesLine.SetRange(SalesLine."Calculated Freight Line", false);
        SalesLine.SetRange("Calculated Insurance Line", false);
        SalesLine.SetRange("Calculated Reserve Line", false);
        SalesLine.SetRange("Calculated Fee Line", false);
        SalesLine.SetRange("Calculated Tobacco Tax Line", false);
        SalesLine.SetFilter(Quantity, '<>0');

        if SalesLine.Find('-') then
            repeat
                // This has to be done, otherwise a modification of the amount on the line is not working properly:
                if (_NewAmountGlobal <> 0) and (_SaleslineLineNo <> 0) then
                    if SalesLine."Line No." = _SaleslineLineNo then
                        SalesLine.Amount := _NewAmountGlobal; // Just replace, no update here.
                                                              // 04/06/2000
                if (SalesLine."Document Type" = SalesLine."document type"::"Credit Memo")
                or (SalesLine."Document Type" = SalesLine."document type"::Invoice) then
                    _Quantity := SalesLine.Quantity
                //
                else
                    _Quantity := SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced";
                if SalesLine."Qty. to Invoice" < _Quantity then
                    _Quantity := SalesLine."Qty. to Invoice";
                if ((SalesLine."Store Use") or (SalesLine."Snow Machine")) and (Customer."ANICA Member Fee" > 5) then
                    _TotAmount := _TotAmount + (SalesLine.Amount * (_Quantity / SalesLine.Quantity) * (5 / 100))
                else
                    _TotAmount := _TotAmount +
                        ((SalesLine.Amount * (_Quantity / SalesLine.Quantity))
                        * (Customer."ANICA Member Fee" / 100));
            until SalesLine.Next = 0;

        SalesLine.SetRange(Type); // to reset.
        SalesLine.SetRange("Calculated Freight Line", true);

        if SalesLine.Find('-') then
            repeat
                // This has to be done, otherwise a modification of the amount on the line is not working properly:
                if (_NewAmountGlobal <> 0) and (_SaleslineLineNo <> 0) then
                    if SalesLine."Line No." = _SaleslineLineNo then
                        SalesLine.Amount := _NewAmountGlobal; // Just replace, no update here.
                _TotAmount := _TotAmount + (SalesLine.Amount * (Customer."ANICA Member Fee" / 100));
            until SalesLine.Next = 0;

        SalesLine.SetRange("Calculated Freight Line"); // to reset.
        SalesLine.SetRange("Calculated Insurance Line", true);

        if SalesLine.Find('-') then begin
            _TotAmount := _TotAmount + (SalesLine.Amount * (Customer."ANICA Member Fee" / 100));
        end;
        SalesLine.SetRange("Calculated Insurance Line"); // to reset.
        SalesLine.SetRange("Calculated Reserve Line", true);

        if SalesLine.Find('-') then begin
            _TotAmount := _TotAmount + (SalesLine.Amount * (Customer."ANICA Member Fee" / 100));
        end;

        //LCC 6-30-16 Added Tobacco to fee calc
        SalesLine.SetRange("Calculated Reserve Line"); // to reset.
        SalesLine.SetRange("Calculated Tobacco Tax Line", true);

        if SalesLine.Find('-') then begin
            _TotAmount := _TotAmount + (SalesLine.Amount * (Customer."ANICA Member Fee" / 100));
        end;

        SalesLine.SetRange("Calculated Tobacco Tax Line"); // to reset.

        //Round Total Fee
        _TotAmount := ROUND(_TotAmount, 0.01);

        if _TotAmount = 0 then
            exit;

        // Creating SalesLine for Anica Fee:
        SalesLine.Reset;
        SalesLine.Init;
        SalesLine."Line No." := _LineNo + 10000;
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
        SalesLine.Validate("No.", MemberStatus."Account No.");
        SalesLine.Quantity := 1;
        SalesLine."Unit Price" := _TotAmount;  // Anica Fee Amount.
        SalesLine.Amount := _TotAmount;
        SalesLine.Validate("Unit Price");
        SalesLine.Validate(Quantity);
        SalesLine."Calculated Fee Line" := true;
        SalesLine."Shortcut Dimension 1 Code" := MemberStatus."Department Code";
        //CS 2-16-16 TEST +++
        SalesLine."Dimension Set ID" := 1;
        SalesLine."Qty. to Ship" := 0;
        SalesLine."Quantity Shipped" := 0;
        SalesLine."Qty. to Invoice" := 1;
        SalesLine."Quantity Invoiced" := 0;
        SalesLine.Insert;
        //Update dimension table
        UpdateDocDimensionTable(SalesLine);
    end;


    procedure CreateTobaccoTaxLine(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        _LineNo: Integer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        TotalCigPacks: Decimal;
        TotalOTP: Decimal;
        TotalCigTax: Decimal;
        TotalOTPTax: Decimal;
        TotalTobaccoTax: Decimal;
        vPack: Decimal;
    begin
        //Tobacco Tax Calculation:
        DeleteTobaccoTaxLine(SalesHeader);

        Customer.Get(SalesHeader."Sell-to Customer No.");

        if Customer."Tobacco Tax" = false then
            exit;

        SalesReceivablesSetup.Get;
        SalesReceivablesSetup.TestField("Tobacco Tax Acc. No.");

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.Find('+') then
            _LineNo := SalesLine."Line No.";

        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter(Quantity, '<>0');

        if SalesLine.Find('-') then
            repeat
                //Check if line's item is Tobacco.
                Item.Get(SalesLine."No.");
                Item.CalcFields("Number of Retail Units");

                //Get actual quantity shipped not invoiced
                //Get quantity if not a sales order
                if (SalesLine."Document Type" = SalesLine."document type"::"Credit Memo")
                or (SalesLine."Document Type" = SalesLine."document type"::Invoice) then
                    _Quantity := SalesLine.Quantity
                else
                    _Quantity := SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced";
                if SalesLine."Qty. to Invoice" < _Quantity then
                    _Quantity := SalesLine."Qty. to Invoice";

                if Item."Tobacco Type" = 1 then
                    TotalCigPacks := TotalCigPacks + (_Quantity * Item."Number of Retail Units")
                //CS 07-12-17: Had to hard code item No. 0001-0078 here, because this items needs to be on MSA reporting, but
                // there should not be a tax line created for it.
                else
                    if (Item."Tobacco Type" = 2) and (Item."No." <> '0001-0078') then
                        //CS 01-05-18: Per Linda and Jessica, chaning calculation to using Extended Cost from Sales Line, rather than Item."Last Direct Cost"
                        //TotalOTP := TotalOTP + (Item."Last Direct Cost" * _Quantity);
                        TotalOTP := TotalOTP + (SalesLine.Amount + SalesLine."Inv. Discount Amount");

                TotalCigTax := TotalCigPacks * 2.0;
                TotalOTPTax := TotalOTP * 0.45;
                TotalTobaccoTax := TotalCigTax + TotalOTPTax;
            until SalesLine.Next = 0;

        if TotalTobaccoTax = 0 then exit;

        // Creating SalesLine for Reserve:
        SalesLine.Reset;
        SalesLine.Init;
        SalesLine."Line No." := _LineNo + 10000;
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
        SalesLine.Validate("No.", SalesReceivablesSetup."Tobacco Tax Acc. No.");
        SalesLine.Quantity := 1;
        SalesLine."Unit Price" := TotalTobaccoTax;  // Tobacco Tax Amount.
        SalesLine.Amount := TotalTobaccoTax;
        SalesLine.Validate("Unit Price");
        SalesLine.Validate(Quantity);
        SalesLine."Calculated Tobacco Tax Line" := true;
        SalesLine."Shortcut Dimension 1 Code" := 'ANICA'; //NEED TO CONFIRM +++++++++
        //CS 2-16-16 TEST +++
        SalesLine."Dimension Set ID" := 1;
        SalesLine."Qty. to Ship" := 0;
        SalesLine."Quantity Shipped" := 0;
        SalesLine."Qty. to Invoice" := 1;
        SalesLine."Quantity Invoiced" := 0;
        SalesLine.Insert;
        //Update dimension table
        UpdateDocDimensionTable(SalesLine);
    end;


    procedure CalculateMargin(var SalesLine: Record "Sales Line"; Item: Record Item)
    var
        ItemUOM: Record "Item Unit of Measure";
    begin
        ItemUOM.Get(SalesLine."No.", SalesLine."Unit of Measure Code"); // for Pack
        ItemUOM.TestField(Pack);
        Clear(SalesLine."Estimated Margin");
        Clear(SalesLine."Actual Margin");
        if SalesLine.Quantity = 0 then
            exit;
        //SalesLine.TESTFIELD("Retail Price Per Unit");

        SalesLine.CalcFields("Estimated Freight"); // Total
        if SalesLine."Retail Price Per Unit" <> 0 then
            SalesLine."Estimated Margin" :=
                       (SalesLine."Retail Price Per Unit" -
                       ((SalesLine."Unit Price" + (SalesLine."Estimated Freight" / SalesLine.Quantity)) / ItemUOM.Pack)) /
                       SalesLine."Retail Price Per Unit" * 100;
        SalesLine."Actual Margin" := SalesLine."Estimated Margin";
    end;


    procedure UpdateDocDimensionTable(var SalesLine: Record "Sales Line")
    begin
        //>>ANICA added 9-13-05 fix dimension codes on freight lines
        //Update dimenstion table for changes in freight lines
        DocDimension.SetCurrentkey("Table ID", "Document Type", "Document No.", "Line No.", "Dimension Code");
        DocDimension.SetRange("Table ID", 37);
        DocDimension.SetRange("Document Type", 1);
        DocDimension.SetRange("Document No.", SalesLine."Document No.");
        DocDimension.SetRange("Line No.", SalesLine."Line No.");
        DocDimension.SetRange("Dimension Code", 'DEPARTMENT');
        if DocDimension.Find('-') then begin
            DocDimension."Dimension Value Code" := SalesLine."Shortcut Dimension 1 Code";
            DocDimension.Modify(true);
        end;

        DocDimension.SetRange("Table ID");//Clear filter
        DocDimension.SetRange("Document Type");//Clear filter
        DocDimension.SetRange("Document No.");//Clear filter
        DocDimension.SetRange("Line No.");//Clear filter
        DocDimension.SetRange("Dimension Code");//Clear filter
    end;
}

