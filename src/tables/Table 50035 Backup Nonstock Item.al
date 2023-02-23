Table 50035 "Backup Nonstock Item"
{
    // //05/14/09 Added delete of Nonstock Zone Retail table


    fields
    {
        field(1; "Entry No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "Entry No." <> xRec."Entry No." then begin
                    GetInvtSetup;
                    NoSeriesMgt.TestManual(InvtSetup."Nonstock Item Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Manufacturer Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if ("Manufacturer Code" <> xRec."Manufacturer Code") and
                   ("Item No." <> '') then
                    Error(Text001);
            end;
        }
        field(3; "Vendor No."; Code[20])
        {

            trigger OnValidate()
            begin
                if ("Vendor No." <> xRec."Vendor No.") and
                   ("Item No." <> '') then
                    Error(Text001);

                if "Vendor No." <> xRec."Vendor No." then
                    if CheckVendorItemNo("Vendor No.", "Vendor Item No.") then
                        Error(Text002, "Vendor No.", "Vendor Item No.");
            end;
        }
        field(4; "Vendor Item No."; Code[20])
        {

            trigger OnValidate()
            begin
                if ("Vendor Item No." <> xRec."Vendor Item No.") and
                   ("Item No." <> '') then
                    Error(Text001);

                if "Vendor Item No." <> xRec."Vendor Item No." then
                    if CheckVendorItemNo("Vendor No.", "Vendor Item No.") then
                        Error(Text002, "Vendor No.", "Vendor Item No.");
            end;
        }
        field(5; Description; Text[30])
        {

            trigger OnValidate()
            begin
                if (Description <> xRec.Description) and
                   ("Item No." <> '') then
                    Error(Text001);
            end;
        }
        field(6; "Unit of Measure"; Code[10])
        {

            trigger OnValidate()
            begin
                if ("Unit of Measure" <> xRec."Unit of Measure") and
                   ("Item No." <> '') then
                    Error(Text001);
            end;
        }
        field(7; "Published Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Published Cost" <> xRec."Published Cost") and
                   ("Item No." <> '') then
                    Error(Text001);
            end;
        }
        field(8; "Negotiated Cost"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Negotiated Cost" <> xRec."Negotiated Cost") and
                   ("Item No." <> '') then
                    Error(Text001);
            end;
        }
        field(9; "Unit Price"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Unit Price" <> xRec."Unit Price") and
                   ("Item No." <> '') then
                    Error(Text001);
                UpdateFloatingRet;
            end;
        }
        field(10; "Gross Weight"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Gross Weight" <> xRec."Gross Weight") and
                   ("Item No." <> '') then
                    Error(Text001);
            end;
        }
        field(11; "Net Weight"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Net Weight" <> xRec."Net Weight") and
                   ("Item No." <> '') then
                    Error(Text001);
            end;
        }
        field(12; "Item Category Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if ("Item Category Code" <> xRec."Item Category Code") and
                   ("Item No." <> '') then
                    Error(Text001);

                "Product Group Code" := '';
            end;
        }
        field(13; "Product Group Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if ("Product Group Code" <> xRec."Product Group Code") and
                   ("Item No." <> '') then
                    Error(Text001);
            end;
        }
        field(14; "Last Date Modified"; Date)
        {
        }
        field(15; "Bar Code"; Code[20])
        {

            trigger OnValidate()
            begin
                if ("Bar Code" <> xRec."Bar Code") and
                   ("Item No." <> '') then
                    Error(Text001);
            end;
        }
        field(16; "Item No."; Code[20])
        {

            trigger OnValidate()
            begin
                if ("Item No." <> xRec."Item No.") and
                   ("Item No." <> '') then
                    Error(Text001);
            end;
        }
        field(53; Comment; Boolean)
        {
        }
        field(97; "No. Series"; Code[10])
        {
        }
        field(50000; "Price Files Created"; Boolean)
        {
            Description = 'For all target price files';
        }
        field(50001; "Telxon Category Code"; Code[10])
        {
            Description = 'Connection with Telxon Vendor Code Table';
        }
        field(50002; Pack; Decimal)
        {
        }
        field(50003; "Pack Description"; Text[10])
        {
        }
        field(50004; "Commodity Code"; Code[10])
        {
            Description = 'Connection with Commodity code Table';

            trigger OnValidate()
            begin
                UpdateFloatingRet;
            end;
        }
        field(50005; "Parcel Post Code"; Code[10])
        {
            Description = 'Connection with Parcel Post Code Table';
        }
        field(50006; "Freight Code"; Code[10])
        {
            Description = 'Connection with Freight Code Table';
        }
        field(50007; "Hazardous Code"; Boolean)
        {
        }
        field(50008; "Vendor Retail"; Decimal)
        {
        }
        field(50009; "Store Landed Cost"; Decimal)
        {
        }
        field(50010; "Floating Retail"; Decimal)
        {
        }
        field(50011; "Discount Code"; Code[10])
        {
        }
        field(50012; "Minimum Order Qty"; Integer)
        {
        }
        field(50013; "Price Factor"; Decimal)
        {
        }
        field(50014; "Stock Activity Code"; Code[10])
        {
        }
        field(50015; "Superceding No."; Text[20])
        {
        }
        field(50016; "Vendor Merch Type"; Text[20])
        {
            Description = 'Modified 10 -> 20 Rdj';
        }
        field(50017; "Vendor Pack"; Integer)
        {
        }
        field(50018; "Vendor Price Code"; Code[10])
        {
        }
        field(50019; "Vendor UOM"; Text[10])
        {
        }
        field(50020; "Pick Type"; Option)
        {
            OptionMembers = " ",Hazardous,"Freeze/Chill",Dry,Other,"Phone Cards",Tobacco,Oils,"Pick Type 2",Snacks,Pop,JBG2740;
        }
        field(50021; "Standard Fixed Retail"; Decimal)
        {
        }
        field(50022; "FOB Code"; Code[10])
        {
        }
        field(50023; "UPC Code"; Code[20])
        {
        }
        field(50024; "Change Indicator"; Text[1])
        {
        }
        field(50025; "Vendor Department"; Text[4])
        {
        }
        field(50026; "Wholesaler Vendor No."; Text[6])
        {
        }
        field(50027; "Do Not Update JBG Retails"; Boolean)
        {
        }
        field(50028; "Print Shelf Tag"; Boolean)
        {
        }
        field(50029; "Do Not Update SMS"; Boolean)
        {
        }
        field(50030; "JBG Commodity Group"; Code[4])
        {
        }
        field(50031; "WIC Flag"; Boolean)
        {
        }
        field(50032; "DEL-Price File Created Zone 1"; Boolean)
        {
        }
        field(50033; "DEL-Price File Created Zone N"; Boolean)
        {
        }
        field(50034; "UPC Code for SMS"; Code[20])
        {
        }
        field(50035; "Last User"; Code[20])
        {
        }
        field(50036; "SMS Subdepartment"; Integer)
        {
        }
        field(50037; "ANICA Inactive"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Vendor Item No.", "Manufacturer Code")
        {
        }
        key(Key3; "Item No.")
        {
        }
        key(Key4; "Vendor No.", "Vendor Item No.")
        {
        }
        key(Key5; Description)
        {
        }
        key(Key6; "UPC Code")
        {
        }
        key(Key7; "JBG Commodity Group")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //CS 12-16-14: Replaced the deletion of record in Nonstock Zone Retail table with NS Target Retail.
        NonstockTargetRetail.SetRange(NonstockTargetRetail."Entry No.", "Entry No.");
        NonstockTargetRetail.DeleteAll;

        //05/12/10 Delete Nonstock UPC's
        NonStockUPC.SetRange("Nonstock Entry No.", "Entry No.");
        NonStockUPC.DeleteAll;
    end;

    trigger OnInsert()
    begin
        NonStockItem.LockTable;
        if "Entry No." = '' then begin
            GetInvtSetup;
            InvtSetup.TestField("Nonstock Item Nos.");
            NoSeriesMgt.InitSeries(InvtSetup."Nonstock Item Nos.", xRec."No. Series", 0D, "Entry No.", "No. Series");
        end;
        "Last User" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "Last User" := UserId;
        MfrLength := StrLen("Manufacturer Code");
        VenLength := StrLen("Vendor Item No.");

        NonStockItemSetup.Get;
        case NonStockItemSetup."No. Format" of
            NonStockItemSetup."no. format"::"Entry No.":
                ItemNo := "Entry No.";
            NonStockItemSetup."no. format"::"Vendor Item No.":
                ItemNo := "Vendor Item No.";
            NonStockItemSetup."no. format"::"Mfr. + Vendor Item No.":
                begin
                    if NonStockItemSetup."No. Format Separator" = '' then begin
                        if MfrLength + VenLength <= 20 then
                            ItemNo := InsStr("Manufacturer Code", "Vendor Item No.", 6)
                        else
                            ItemNo := InsStr("Manufacturer Code", "Entry No.", 6);
                    end else begin
                        TempItemNo :=
                          InsStr("Manufacturer Code", NonStockItemSetup."No. Format Separator", 6);
                        if MfrLength + VenLength < 20 then
                            ItemNo := InsStr(TempItemNo, "Vendor Item No.", 7)
                        else
                            ItemNo := InsStr(TempItemNo, "Entry No.", 7);
                    end;
                end;
            NonStockItemSetup."no. format"::"Vendor Item No. + Mfr.":
                begin
                    if NonStockItemSetup."No. Format Separator" = '' then begin
                        if VenLength + MfrLength <= 20 then
                            ItemNo := InsStr("Vendor Item No.", "Manufacturer Code", 11)
                        else
                            ItemNo := InsStr("Entry No.", "Manufacturer Code", 11);
                    end else begin
                        TempItemNo :=
                          InsStr("Vendor Item No.", NonStockItemSetup."No. Format Separator", 10);
                        if VenLength + MfrLength < 20 then
                            ItemNo := InsStr(TempItemNo, "Manufacturer Code", 11);
                    end;
                end;
        end;
        Item.SetRange(Item."No.", ItemNo);
        //>>ANICA 8-30-05 commented out error message consistent with version 2.0 mod
        if Item.Find('-') then begin
            // ERROR(Text001);
        end;
    end;

    var
        Text000: label 'NS00000000';
        Text001: label 'Modification not allowed, item record already exists.';
        Text002: label 'No.=<%1>and Vendor Item No.=<%2> already exists.';
        NonStockItem: Record "Nonstock Item";
        NonStockItemSetup: Record "Nonstock Item Setup";
        Item: Record Item;
        InvtSetup: Record "Inventory Setup";
        NonstockTargetRetail: Record "Nonstock Target Retail";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ItemNo: Code[20];
        TempItemNo: Code[20];
        NonStockItemSeqNo: Code[10];
        MfrLength: Integer;
        VenLength: Integer;
        HasInvtSetup: Boolean;
        Commodity: Record "Commodity Code";
        ParcelPostRate: Record "Parcel Post Direct Rates";
        NonStockUPC: Record "Nonstock UPC Table";


    procedure AssistEdit(): Boolean
    var
        _Decimals: Decimal;
        Commodity: Record "Commodity Code";
        _Amount2: Decimal;
    begin
        GetInvtSetup;
        InvtSetup.TestField("Nonstock Item Nos.");
        if NoSeriesMgt.SelectSeries(InvtSetup."Nonstock Item Nos.", xRec."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("Entry No.");
            exit(true);
        end;
    end;


    procedure CheckVendorItemNo(VendorNo: Code[20]; VendorItemNo: Code[20]): Boolean
    begin
        NonStockItem.Reset;
        NonStockItem.SetCurrentkey("Vendor No.", "Vendor Item No.");
        NonStockItem.SetRange("Vendor No.", VendorNo);
        NonStockItem.SetRange("Vendor Item No.", VendorItemNo);
        exit(NonStockItem.Find('-'));
    end;


    procedure GetInvtSetup()
    begin
        if not HasInvtSetup then begin
            InvtSetup.Get;
            HasInvtSetup := true;
        end;
    end;


    procedure RetailRounding(_Amount: Decimal; CommodityCode: Code[10]): Decimal
    var
        _Decimals: Decimal;
        Commodity: Record "Commodity Code";
        _Amount2: Decimal;
    begin
        //>> MAS
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


    procedure UpdateFloatingRet()
    var
        _EstimatedFreight: Decimal;
    begin
        if (Rec."Unit Price" = 0) or (Rec."Commodity Code" = '') then begin
            //    Rec."Floating GPM" := 0;
            Rec."Store Landed Cost" := 0;
            exit;
        end;

        Commodity.Get(Rec."Commodity Code"); // for Commodity.Margin

        ParcelPostRate.Get(Rec."Commodity Code", 0, false);
        // 0=Continental-US and Priority=False
        // for ParcelPostRate."Rate per dollar";

        //ItemUOM.GET(Rec."No.",Rec."Base Unit of Measure"); // for Pack
        _EstimatedFreight := ROUND(Rec."Unit Price" * ParcelPostRate."Rate per dollar", 0.01);
        Rec."Store Landed Cost" := Rec."Unit Price" + _EstimatedFreight;
        if Rec."Store Landed Cost" = 0 then
            Error('Store Landed Cost has been calculated as being zero.\\' +
                  'Check Item Unit Price or Rate per dollar in Parcel Post Rate Table.');

        Rec.TestField(Pack);

        Rec."Floating Retail" := (Rec."Store Landed Cost" / Rec.Pack) / ((100 - Commodity.Margin) / 100);
        Rec."Floating Retail" := RetailRounding(Rec."Floating Retail", Rec."Commodity Code");
        //Rec."Floating GPM" :=
        //   ((Rec."Std Floating Retail" - (Rec."Store Landed Cost"/ItemUOM.Pack))/Rec."Std Floating Retail") * 100;
        //Rec."Floating GPM" := ROUND(Rec."Floating GPM",0.01);
        //Item.MODIFY;
    end;
}

