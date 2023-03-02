Report 50132 "Zone Retails for Warehouse"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Zone Retails for Warehouse.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", Blocked, "Inventory Posting Group", "Vendor No.";
            column(ReportForNavId_8129; 8129)
            {
            }
            column(Today; Today)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(PPackSize; PPackSize)
            {
            }
            column(VTargetRetail1; VTargetRetail1)
            {
            }
            column(VTargetRetail2; VTargetRetail2)
            {
            }
            column(VTargetRetail3; VTargetRetail3)
            {
            }
            column(VTarget1; VTarget1)
            {
            }
            column(VTarget2; VTarget2)
            {
            }
            column(VTarget3; VTarget3)
            {
            }
            column(PRetail; PRetail)
            {
            }
            column(PFloatRet; PFloatRet)
            {
            }
            column(PNonStock; PNonStock)
            {
            }
            column(PFixCde; PFixCde)
            {
            }
            column(Item__Unit_Price_; "Unit Price")
            {
            }
            column(ITEM_ZONE_RETAILS_FOR_CAP_CODE_912Caption; ITEM_ZONE_RETAILS_FOR_CAP_CODE_912CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(Item_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Pack_SizeCaption; Pack_SizeCaptionLbl)
            {
            }
            column(Zone_1_2_RetailCaption; Zone_1_2_RetailCaptionLbl)
            {
            }
            column(Zone_3_RetailCaption; Zone_3_RetailCaptionLbl)
            {
            }
            column(Zone_N_RetailCaption; Zone_N_RetailCaptionLbl)
            {
            }
            column(Fixed_RetailCaption; Fixed_RetailCaptionLbl)
            {
            }
            column(Floating_RetailCaption; Floating_RetailCaptionLbl)
            {
            }
            column(Cross_Reference_No_Caption; Cross_Reference_No_CaptionLbl)
            {
            }
            column(Fixed_CodeCaption; Fixed_CodeCaptionLbl)
            {
            }
            column(Unit_PriceCaption; Unit_PriceCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PRetail := Item."Std Fixed Retail";

                PFloatRet := Item."Std Floating Retail";

                if Item."Do Not Update JBG Retails" = true then
                    PFixCde := 'Y'
                else
                    PFixCde := ' ';

                //CS 12-5-16: Get Target Retails for the Selected Targets
                TargetRetail.SetCurrentkey("Item No.", UPC, Target);
                TargetRetail.SetRange("Item No.", Item."No.");
                TargetRetail.SetRange(UPC, Item."UPC for SMS");

                if VTarget1 <> '' then begin
                    TargetRetail.SetRange(Target, VTarget1);

                    if TargetRetail.Find('-') then
                        VTargetRetail1 := TargetRetail.Retail
                    else
                        VTargetRetail1 := 0;
                end;

                if VTarget2 <> '' then begin
                    TargetRetail.SetRange(Target, VTarget2);

                    if TargetRetail.Find('-') then
                        VTargetRetail2 := TargetRetail.Retail
                    else
                        VTargetRetail2 := 0;
                end;

                if VTarget3 <> '' then begin
                    TargetRetail.SetRange(Target, VTarget3);

                    if TargetRetail.Find('-') then
                        VTargetRetail3 := TargetRetail.Retail
                    else
                        VTargetRetail3 := 0;
                end;

                Clear(TargetRetail);


                ItemUnit.SetCurrentkey(ItemUnit."Item No.");
                ItemUnit.SetRange(ItemUnit."Item No.", Item."No.");

                if ItemUnit.Find('-') then begin
                    PPack := ItemUnit.Pack;
                    TPack := Format(PPack);
                    PSize := ItemUnit."Pack Description";
                    PPackSize := TPack + '/' + PSize;
                end;

                PNonStock := '';

                ItemCross.SetCurrentkey(ItemCross."Item No.");
                ItemCross.SetRange(ItemCross."Item No.", Item."No.");

                if ItemCross.Find('-') then begin
                    if ItemCross."Reference Type" = "Item Reference Type"::" " then
                        PNonStock := ItemCross."Reference No."
                    else
                        PNonStock := '';
                end;
            end;

            trigger OnPreDataItem()
            begin
                PZone1 := 0;
                PZone3 := 0;
                PZoneN := 0;
                PFloatRet := 0;
                PRetail := 0;
                PPack := 0;
                PPackSize := '';
                PNonStock := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Select Target(s) for the report:")
                {
                    Caption = 'Select Target(s) for the report:';
                    field(VTarget1; VTarget1)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Target Selection #1';
                        TableRelation = Target;
                    }
                    field(VTarget2; VTarget2)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Target Selection #2';
                        TableRelation = Target;
                    }
                    field(VTarget3; VTarget3)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Target Selection #3';
                        TableRelation = Target;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ItemFilter := Item.GetFilters;
    end;

    var
        ItemUnit: Record "Item Unit of Measure";
        ItemCross: Record "Item Reference";
        TargetRetail: Record "Item Target Retail";
        PRetail: Decimal;
        PFloatRet: Decimal;
        VTarget1: Code[10];
        VTarget2: Code[10];
        VTarget3: Code[10];
        VTargetRetail1: Decimal;
        VTargetRetail2: Decimal;
        VTargetRetail3: Decimal;
        VUPC: Code[20];
        PZone1: Decimal;
        PZone3: Decimal;
        PZoneN: Decimal;
        PPack: Decimal;
        PSize: Text[20];
        PNonStock: Text[20];
        PPackSize: Code[20];
        TPack: Text[10];
        ItemFilter: Text[250];
        PFixCde: Code[1];
        ITEM_ZONE_RETAILS_FOR_CAP_CODE_912CaptionLbl: label 'ITEM ZONE RETAILS FOR CAP CODE 912';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Pack_SizeCaptionLbl: label 'Pack/Size';
        Zone_1_2_RetailCaptionLbl: label 'Zone 1/2 Retail';
        Zone_3_RetailCaptionLbl: label 'Zone 3 Retail';
        Zone_N_RetailCaptionLbl: label 'Zone N Retail';
        Fixed_RetailCaptionLbl: label 'Fixed Retail';
        Floating_RetailCaptionLbl: label 'Floating Retail';
        Cross_Reference_No_CaptionLbl: label 'Cross Reference No.';
        Fixed_CodeCaptionLbl: label 'Fixed Code';
        Unit_PriceCaptionLbl: label 'Unit Price';
}

