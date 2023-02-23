tableextension 50005 Item extends Item
{
    fields
    {
        field(50000; "Drop Ship Item"; Boolean) { }
        field(50001; "ANICA Landed Cost"; Decimal) { }
        field(50002; "Fixed Price Code"; Boolean) { }
        field(50003; "Price Files Created"; Boolean) { } //For all target price files.
        field(50004; "Telxon Vendor Code"; Code[10]) { } //Connection with Telxon Vendor Code Table
        field(50005; "Catalog Group Code"; Code[10]) { } //Connection with Cat.Grp.Table
        field(50006; "Catalog UOM"; Text[10]) { }
        field(50007; "Commodity Code"; Code[10]) { } //Connection with Commodity Table
        field(50008; "Freight Code"; Code[10]) { } //Connection with Freight Table
        field(50009; "Store Landed Cost"; Decimal) { }
        field(50010; "Do Not Update JBG Retails"; Boolean) { }
        field(50011; "Std Fixed Retail"; Decimal) { }
        field(50012; "Std Floating Retail"; Decimal) { }
        field(50013; "Fixed GPM"; Decimal) { }
        field(50014; "Floating GPM"; Decimal) { }
        field(50015; "ANICA Manu Code"; Code[14]) { }
        field(50016; "Hazardous Code"; Boolean) { }
        field(50017; "FOB Code"; Code[3]) { }
        field(50018; "Sales Download Filter"; Code[20]) { } //Note: We may not need this with removing the shadow file
        field(50019; "Pick Type"; Option) { OptionMembers = ,Hazardous,Freeze,Dry,Other,"Phone Cards",Pick6,Oils,"Pick Type 2",Snacks,Pop,JBG2740,Chill,Batteries,Firearms,"NR Hazardous",Pick16,"USPS Direct",Tobacco; } //To separate hazardous and freeze-chill
        field(50020; "No Label Printed"; Boolean) { }
        field(50021; "Case / Layer"; Decimal) { }
        field(50022; "Sales Item Flag"; Boolean) { }
        field(50023; "Vendor UPC Code"; Code[20]) { }
        field(50024; "Fixed Zone Retail"; Code[10]) { } //Connection with Zone Retail Code
        field(50025; "Order Block"; Boolean) { }
        field(50026; "Blocked Date"; Date) { } //Date prior to last block removal
        field(50027; "Print Shelf Tag"; Boolean) { }
        field(50028; "No Item UPC"; Boolean) { }
        field(50029; "JBG Commodity Group"; Code[4]) { }
        field(50030; "Datasym Duplicate"; Boolean) { }
        field(50031; "WIC Item"; Boolean) { }
        field(50034; "UPC for SMS"; Code[20]) { }
        field(50035; Cube; Integer) { }
        field(50036; "Last User"; Code[20]) { }
        field(50037; "Case \ Pallet"; Integer) { }
        field(50038; "ANICA Inactive"; Boolean) { }
        field(50039; "SMS Subdepartment"; Integer) { }
        field(50040; "Promotion Description"; Text[30]) { } //MSA Reporting
        field(50041; "Items Per Selling Unit"; Integer) { } //MSA Reporting
        field(50042; "Promotion Indicator"; Boolean) { } //MSA Reporting
        field(50043; "NACS Standard Category Code"; Code[10]) { } //MSA Reporting
        field(50044; "MSA Category Code"; Code[10]) { } //MSA Reporting
        field(50045; "Project Identification"; Code[10]) { } //MSA Reporting
        field(50046; "Component Shipper Flag"; Option) { OptionMembers = ,Shipper,Component; } //MSA Reporting
        field(50047; "Manufacturer Promo Code"; Code[10]) { } //MSA Reporting
        field(50048; "Manufacturer Prod. ID Code"; Code[14]) { } //MSA Reporting
        field(50049; "UPC Extension"; Code[10]) { } //MSA Reporting
        field(50050; "UPC year/issue Extension"; Code[10]) { } //MSA Reporting
        field(50051; "State Tax Jurisdiction"; Code[10]) { } //MSA Reporting
        field(50052; "Alternate UPC Code 1"; Code[20]) { } //MSA Reporting
        field(50053; "Inventory Count Order"; Integer) { } //MSA Reporting
        field(50054; "MSA Reporting"; Boolean) { } //MSA Reporting
        field(50055; "MSA Item Description"; Text[50]) { } //MSA Reporting
        field(50056; "MSA Vendor"; Code[30]) { } //MSA Reporting
        field(50057; "Status Note"; Text[60]) { } //For "Not Enough Inventory" report
        field(50058; "Tobacco Type"; Option) { OptionMembers = ,Cigarette,OTP; } //For Cigarette and Tobacco Tax Return
        field(50060; "Number of Retail Units"; Decimal) { } //Number of units (pack) per UOM.
        field(50061; Retail; Decimal) { }
        field(50062; "Vendor Location"; Code[10]) { }
    }

    keys
    {
        key(Key20; "Vendor Item No.", "Vendor No.", "Created From Nonstock Item") { }
        key(Key21; "Vendor UPC Code") { }
        key(Key22; "JBG Commodity Group") { }
        key(Key23; "Vendor Item No.", "Manufacturer Code") { }
        key(Key24; "MSA Reporting") { }
    }

    procedure UpdateFixedGPM(_ItemNo: Code[20]; StdFixedRetail: Decimal; StoreLandedCost: Decimal): Decimal
    var
        FixedGPM: Decimal;
        ItemUOM: Record "Item Unit of Measure";
    begin
        ItemUOM.Get("No.", "Base Unit of Measure"); // for Pack
        ItemUOM.TestField(Pack);
        Clear(FixedGPM);
        if StdFixedRetail <> 0 then
            FixedGPM := ROUND((StdFixedRetail - (StoreLandedCost / ItemUOM.Pack)) / StdFixedRetail, 0.01) * 100;
        exit(FixedGPM);
    end;


    procedure UpdateFloatingGPM(Item: Record Item)
    var
        Commodity: Record "Commodity Code";
        ParcelPostRate: Record "Parcel Post Direct Rates";
        _EstimatedFreight: Decimal;
        ItemUOM: Record "Item Unit of Measure";
    begin
        if (Rec."Unit Price" = 0) or (Rec."Commodity Code" = '') then begin
            Rec."Floating GPM" := 0;
            Rec."Store Landed Cost" := 0;
            exit;
        end;

        Commodity.Get(Rec."Commodity Code"); // for Commodity.Margin

        ParcelPostRate.Get(Rec."Commodity Code", 0, false);

        ItemUOM.Get(Rec."No.", Rec."Base Unit of Measure"); // for Pack
        _EstimatedFreight := ROUND(Rec."Unit Price" * ParcelPostRate."Rate per dollar", 0.01);
        Rec."Store Landed Cost" := Rec."Unit Price" + _EstimatedFreight;
        if Rec."Store Landed Cost" = 0 then
            Error('Store Landed Cost has been calculated as being zero.\\' +
                  'Check Item Unit Price or Rate per dollar in Parcel Post Rate Table.');

        ItemUOM.TestField(Pack);

        Rec."Std Floating Retail" := (Rec."Store Landed Cost" / ItemUOM.Pack) / ((100 - Commodity.Margin) / 100);
        Rec."Std Floating Retail" := RetailRounding(Rec."Std Floating Retail", Rec."Commodity Code");
        Rec."Floating GPM" :=
           ((Rec."Std Floating Retail" - (Rec."Store Landed Cost" / ItemUOM.Pack)) / Rec."Std Floating Retail") * 100;
        Rec."Floating GPM" := ROUND(Rec."Floating GPM", 0.01);
    end;


    procedure RetailRounding(_Amount: Decimal; CommodityCode: Code[10]): Decimal
    var
        _Decimals: Decimal;
        Commodity: Record "Commodity Code";
        _Amount2: Decimal;
    begin

        if (not Commodity.Get(CommodityCode)) or Commodity."Not Rounding" then
            exit(ROUND(_Amount, 0.01));

        if _Amount < 10 then begin
            if ROUND(_Amount, 1) = ROUND(_Amount) then
                exit(_Amount + 0.05);
            _Decimals := (_Amount * 100) - ROUND((_Amount * 100), 100, '<');
            _Decimals := _Decimals - ROUND(_Decimals, 10, '<');
            if _Decimals > 5 then
                exit(ROUND(_Amount, 0.1, '>') - 0.01)
            else
                exit(ROUND(_Amount, 0.05, '>'));
        end;
        if (_Amount >= 10) and (_Amount < 100) then
            if _Amount - ROUND(_Amount, 0.1) = 0 then
                exit(_Amount)
            else
                exit(ROUND(_Amount, 0.1, '>') - 0.01);
        if (_Amount >= 100) and (_Amount < 1000) then
            if _Amount - ROUND(_Amount, 1.0) = 0 then
                exit(_Amount)
            else
                exit(ROUND(_Amount, 1.0, '>') - 0.01);
        if _Amount >= 1000 then
            exit(ROUND(_Amount, 1.0, '='));
        //<<
    end;

    var
        ItemUPCTable: Record "Item UPC Table";
}
