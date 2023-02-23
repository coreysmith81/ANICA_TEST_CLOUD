Table 50055 "New Item Input"
{

    fields
    {
        field(1;"ANICA No.";Code[10])
        {
            Description = 'Assigned by Purchasing Agent';
        }
        field(2;"Vendor No.";Code[20])
        {
            Description = 'Selected from Vendor Table';
            TableRelation = "ANICA Vendor Supplement"."Vendor No.";

            trigger OnValidate()
            begin
                //Need to add code to reset fields that rely on Vendor-specific calculations.
                Validate(Cost);
                Validate(Weight);
                Validate("Cases/Pallet");
            end;
        }
        field(3;"Vendor Order No.";Text[30])
        {
            Description = 'Input from PIW';
        }
        field(4;UPC;Code[20])
        {
            Description = 'Input from PIW';
        }
        field(5;Description;Text[60])
        {
            Description = 'Input from PIW';
        }
        field(6;"Cases/Layer";Integer)
        {
            Description = 'Input from PIW';
        }
        field(7;"Layer/Pallet";Integer)
        {
            Description = 'Input from PIW';
        }
        field(8;"Cases/Pallet";Integer)
        {
            Description = 'Input from PIW';

            trigger OnValidate()
            begin
                //GET Vendor Supplement Record.
                VendorSupp.Get("Vendor No.");

                //Set all the calculations to grab the $ from the Vendor Supplement table.
                if "Cases/Pallet" > 0 then
                    "Pallet Charge" := VendorSupp."Pallet Charge" / "Cases/Pallet";
                //Hard Coded below to 24 per Gina. Because only Conagra has this, and it's always 24. May need to change.
                "Box Charge" := VendorSupp."Box Charge" / 24;
            end;
        }
        field(9;UNIT;Code[10])
        {
            Description = 'Manual Input from User';
        }
        field(10;Pack;Integer)
        {
            Description = 'Input from PIW';
        }
        field(11;Size;Code[10])
        {
            Description = 'Input from PIW';
        }
        field(12;"Master Pack";Integer)
        {
            Description = 'Manual Input from User';
        }
        field(13;Cost;Decimal)
        {
            Description = 'Manual Input from User';

            trigger OnValidate()
            begin
                //GET Vendor Supplement Record.
                VendorSupp.Get("Vendor No.");

                if Cost > 0 then
                begin
                    //Set all the calculations to grab the % from the Vendor Supplement table.
                    "Trade Allowance" := Cost * VendorSupp."Trade Allowance";
                    "Accrual Allowance" := Cost * VendorSupp."Accrual Allowance";
                    "Bill Back" := Cost * VendorSupp."Bill Back";
                    "Office Invoice Allowance" := Cost * VendorSupp."Office Invoice Allowance";
                    "Usables/Unsellable Allowance" := Cost * VendorSupp."Usables/Unsellable Allowance";


                    Modify;
                end;
            end;
        }
        field(14;"Master Cost";Decimal)
        {
            Description = 'Manual Input from User';
        }
        field(15;Weight;Decimal)
        {
            Description = 'Manual Input from User';

            trigger OnValidate()
            begin
                //GET Vendor Supplement Record.
                VendorSupp.Get("Vendor No.");

                if Weight > 0 then
                    begin
                        //Set all the calculations to grab the % from the Vendor Supplement table.
                        "Case Weight Allowance" := Weight * VendorSupp."Case Weight Allowance";
                        "Pick Up Freight" := Weight * VendorSupp."Pick Up Freight";
                        "Water Freight" := Weight * VendorSupp."Water Freight";

                        Modify;

                        //The following fields are calculated from the fields above.
                        Freight := "Pallet Charge" + "Box Charge" + "Delivery Charge" + "Pick Up Freight" + "Water Freight";

                        Modify;

                        //Remaining Calculations
                        "ADC Landed Cost" := Cost - (VendorSupp."Trade Allowance"+VendorSupp."Accrual Allowance"+
                            VendorSupp."Bill Back"+VendorSupp."Case Weight Allowance"+VendorSupp."Office Invoice Allowance"+
                            VendorSupp."Usables/Unsellable Allowance") + Freight;

                        if Margin > 0 then
                            "ADC Sell" := "ADC Landed Cost" / Margin;
                    end;
            end;
        }
        field(16;"Master Weight";Decimal)
        {
            Description = 'Manual Input from User';
        }
        field(17;"Trade Allowance";Decimal)
        {
            Description = 'Calculate in Cost OnValidate';
        }
        field(18;"Accrual Allowance";Decimal)
        {
            Description = 'Calculate';
        }
        field(19;"Bill Back";Decimal)
        {
            Description = 'Calculate';
        }
        field(20;"Case Weight Allowance";Decimal)
        {
            Description = 'Calculate';
        }
        field(21;"Office Invoice Allowance";Decimal)
        {
            Description = 'Calculate';
        }
        field(22;"Usables/Unsellable Allowance";Decimal)
        {
            Description = 'Calculate';
        }
        field(23;"Pallet Charge";Decimal)
        {
            Description = 'Calculate';
        }
        field(24;"Box Charge";Decimal)
        {
            Description = 'Calculate';
        }
        field(25;"Delivery Charge";Decimal)
        {
            Description = 'Manual Input from User';
            TableRelation = "ANICA Vendor Supplement"."Delivery Charge" where ("Vendor No."=field("Vendor No."));
        }
        field(26;"Pick Up Freight";Decimal)
        {
            Description = 'Lookup from Vendor Supplement Table';
        }
        field(27;"Water Freight";Decimal)
        {
            Description = 'Lookup from Vendor Supplement Table';
        }
        field(28;Freight;Decimal)
        {
            Description = 'Calculate';
        }
        field(29;"ADC Landed Cost";Decimal)
        {
            Description = 'Calculate';
        }
        field(30;"ADC Sell";Decimal)
        {
            Description = 'Calculate';
        }
        field(31;"Margin Category";Code[20])
        {
            Description = 'Selected from Margin Category Table';
        }
        field(32;Margin;Decimal)
        {
            Description = 'Lookup from Margin Category Table';
            TableRelation = "Margin Category".Margin where ("Margin Category"=field("Margin Category"));
        }
        field(33;Cross;Code[20])
        {
        }
        field(34;"Commodity Code";Code[10])
        {
        }
        field(35;"Commodity Margin";Decimal)
        {
        }
        field(36;FOB;Code[10])
        {
        }
        field(37;"Target Z01 Freight";Decimal)
        {
        }
        field(38;"Target Z01 Landed Cost";Decimal)
        {
        }
        field(39;"Target Z01 Retail";Decimal)
        {
        }
        field(40;"Target Z01 Rounded Retail";Decimal)
        {
        }
        field(41;"Target Z03 Freight";Decimal)
        {
        }
        field(42;"Target Z03 Landed Cost";Decimal)
        {
        }
        field(43;"Target Z03 Retail";Decimal)
        {
        }
        field(44;"Target Z03 Rounded Retail";Decimal)
        {
        }
        field(45;"Target Z0N Freight";Decimal)
        {
        }
        field(46;"Target Z0N Landed Cost";Decimal)
        {
        }
        field(47;"Target Z0N Retail";Decimal)
        {
        }
        field(48;"Target Z0N Rounded Retail";Decimal)
        {
        }
        field(49;"Target 031 Freight";Decimal)
        {
        }
        field(50;"Target 031 Landed Cost";Decimal)
        {
        }
        field(51;"Target 031 Retail";Decimal)
        {
        }
        field(52;"Target 031 Rounded Retail";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"ANICA No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        VendorSupp: Record "ANICA Vendor Supplement";
        VTradeAllow: Decimal;
        VAccrualAllow: Decimal;
        VBillBack: Decimal;
        VCWT: Decimal;
        VOIA: Decimal;
        VUseUnsell: Decimal;
        VPalletChg: Decimal;
        VBoxChg: Decimal;
        VDeliveryChg: Decimal;
        VPickUpFreight: Decimal;
        VWaterFreight: Decimal;
        VVendorNo: Code[10];
}

