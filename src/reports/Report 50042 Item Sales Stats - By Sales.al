Report 50042 "Item Sales Stats - By Sales"
{
    // ANICA LCC 10-24-16 Added selections to show Drop Ship with other than zero net profit and inventory items with greater than 50% profit or a loss.
    //   Added a column at the end of the report layout to show drop ship items
    //   Added code as indicated below with the ANICA inidicators.
    //   Added the selections to the report request form
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Item Sales Stats - By Sales.rdlc';

    Caption = 'Item Sales Statistics';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Drop Ship Item", "Search Description", "Inventory Posting Group", "Statistics Group", "Base Unit of Measure", "Date Filter";
            column(ReportForNavId_8129; 8129)
            {
            }
            column(Title; Title)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Time; Time)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(UserId; UserId)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(BreakdownByVariant; BreakdownByVariant)
            {
            }
            column(IncludeItemDescriptions; IncludeItemDescriptions)
            {
            }
            column(PrintOnlyIfSales; PrintOnlyIfSales)
            {
            }
            column(TLGroup; TLGroup)
            {
            }
            column(GroupField; GroupField)
            {
            }
            column(NoShow; NoShow)
            {
            }
            column(ItemDateFilterExsit; ItemDateFilterExsit)
            {
            }
            column(Item_TABLECAPTION__________ItemFilter; Item.TableCaption + ': ' + ItemFilter)
            {
            }
            column(GroupName_________GroupNo; GroupName + ' ' + GroupNo)
            {
            }
            column(GroupDesc; GroupDesc)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item__Base_Unit_of_Measure_; "Base Unit of Measure")
            {
            }
            column(Item__COGS__LCY__; "COGS (LCY)")
            {
            }
            column(Item__Unit_Price_; "Unit Price")
            {
            }
            column(Item__Sales__Qty___; "Sales (Qty.)")
            {
                DecimalPlaces = 2 : 5;
            }
            column(Item__Sales__LCY__; "Sales (LCY)")
            {
            }
            column(Profit; Profit)
            {
            }
            column(ItemProfitPct; ItemProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(QuantityReturned; QuantityReturned)
            {
                DecimalPlaces = 2 : 5;
            }
            column(NoVariant; NoVariant)
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Text003_________GroupName_________GroupNo; Text003 + ' ' + GroupName + ' ' + GroupNo)
            {
            }
            column(Item__Sales__Qty____Control32; "Sales (Qty.)")
            {
                DecimalPlaces = 2 : 5;
            }
            column(Item__Sales__LCY___Control33; "Sales (LCY)")
            {
            }
            column(Profit_Control34; Profit)
            {
            }
            column(ItemProfitPct_Control35; ItemProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(QuantityReturned_Control3; QuantityReturned)
            {
                DecimalPlaces = 2 : 5;
            }
            column(Item__COGS__LCY___Control4; "COGS (LCY)")
            {
            }
            column(Item__Sales__Qty____Control37; "Sales (Qty.)")
            {
                DecimalPlaces = 2 : 5;
            }
            column(Item__Sales__LCY___Control38; "Sales (LCY)")
            {
            }
            column(Profit_Control39; Profit)
            {
            }
            column(ItemProfitPct_Control40; ItemProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(QuantityReturned_Control5; QuantityReturned)
            {
                DecimalPlaces = 2 : 5;
            }
            column(Item__COGS__LCY___Control6; "COGS (LCY)")
            {
            }
            column(Item_Inventory_Posting_Group; "Inventory Posting Group")
            {
            }
            column(Item_Vendor_No_; "Vendor No.")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Inventory_items_without_sales_are_not_included_on_this_report_Caption; Inventory_items_without_sales_are_not_included_on_this_report_CaptionLbl)
            {
            }
            column(Inventory_items_without_sales_during_the_above_period_are_not_included_on_this_report_Caption; Inventory_items_without_sales_during_the_above_period_are_not_included_on_this_report_CaptionLbl)
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; FieldCaption("Base Unit of Measure"))
            {
            }
            column(Item__COGS__LCY__Caption; FieldCaption("COGS (LCY)"))
            {
            }
            column(Item__Unit_Price_Caption; FieldCaption("Unit Price"))
            {
            }
            column(Item__Sales__Qty___Caption; FieldCaption("Sales (Qty.)"))
            {
            }
            column(Item__Sales__LCY__Caption; FieldCaption("Sales (LCY)"))
            {
            }
            column(ProfitCaption; ProfitCaptionLbl)
            {
            }
            column(ItemProfitPctCaption; ItemProfitPctCaptionLbl)
            {
            }
            column(QuantityReturnedCaption; QuantityReturnedCaptionLbl)
            {
            }
            column(Item__No__Caption_Control41; FieldCaption("No."))
            {
            }
            column(Item__Base_Unit_of_Measure_Caption_Control43; FieldCaption("Base Unit of Measure"))
            {
            }
            column(Item__Unit_Price_Caption_Control44; FieldCaption("Unit Price"))
            {
            }
            column(Item__Sales__Qty___Caption_Control45; FieldCaption("Sales (Qty.)"))
            {
            }
            column(QuantityReturnedCaption_Control46; QuantityReturnedCaption_Control46Lbl)
            {
            }
            column(Item__Sales__LCY__Caption_Control47; FieldCaption("Sales (LCY)"))
            {
            }
            column(Item__COGS__LCY__Caption_Control48; FieldCaption("COGS (LCY)"))
            {
            }
            column(ProfitCaption_Control49; ProfitCaption_Control49Lbl)
            {
            }
            column(ItemProfitPctCaption_Control50; ItemProfitPctCaption_Control50Lbl)
            {
            }
            column(Item_Variant_CodeCaption; Item_Variant_CodeCaptionLbl)
            {
            }
            column(Report_TotalCaption; Report_TotalCaptionLbl)
            {
            }
            column(DropShip; Item."Drop Ship Item")
            {
            }
            column(PrintDropShip; PrintDropShip)
            {
            }
            column(SelectInvUnder0OVer50; SelectInvUnder0Over50)
            {
            }
            column(SelectDroptShipNot0; SelectDShipUnder0)
            {
            }
            column(CommCode; "Commodity Code")
            {
            }
            column(VPack; VPack)
            {
            }
            column(VUPC; Item."UPC for SMS")
            {
            }
            dataitem("Item Variant"; "Item Variant")
            {
                DataItemLink = "Item No." = field("No.");
                DataItemTableView = sorting("Item No.", Code);
                column(ReportForNavId_7031; 7031)
                {
                }
                column(Item_Variant_Code; Code)
                {
                }
                column(Item__No___Control53; Item."No.")
                {
                }
                column(Item__Base_Unit_of_Measure__Control55; Item."Base Unit of Measure")
                {
                }
                column(Item__Unit_Price__Control56; Item."Unit Price")
                {
                }
                column(Item__Sales__Qty____Control57; Item."Sales (Qty.)")
                {
                    DecimalPlaces = 2 : 5;
                }
                column(QuantityReturned_Control58; QuantityReturned)
                {
                    DecimalPlaces = 2 : 5;
                }
                column(Item__Sales__LCY___Control59; Item."Sales (LCY)")
                {
                }
                column(Item__COGS__LCY___Control60; Item."COGS (LCY)")
                {
                }
                column(Profit_Control61; Profit)
                {
                }
                column(ItemProfitPct_Control62; ItemProfitPct)
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Item_Description_Control63; Item.Description)
                {
                }
                column(Item_Variant_Description; Description)
                {
                }
                column(Item_Variant_Item_No_; "Item No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if BlankVariant then begin
                        Code := '';
                        "Item No." := '';
                        Description := 'Blank Variant';
                        "Description 2" := '';
                        BlankVariant := false;
                    end;

                    Item.SetRange("Variant Filter", Code);
                    Item.CalcFields("Sales (Qty.)", "Sales (LCY)", "COGS (LCY)");
                    if (Item."Sales (Qty.)" = 0) and PrintOnlyIfSales then
                        CurrReport.Skip;
                    Profit := Item."Sales (LCY)" - Item."COGS (LCY)";
                    if Item."Sales (LCY)" <> 0 then
                        ItemProfitPct := ROUND(Profit / Item."Sales (LCY)" * 100, 0.1)
                    else
                        ItemProfitPct := 0;
                    QuantityReturned := 0;
                    ItemLedgerEntry.SetRange("Item No.", Item."No.");
                    ItemLedgerEntry.SetRange("Variant Code", Code);
                    if ItemLedgerEntry.Find('-') then
                        repeat
                            if ItemLedgerEntry."Invoiced Quantity" > 0 then begin
                                QuantityReturned := QuantityReturned + ItemLedgerEntry."Invoiced Quantity";
                                Item."Sales (Qty.)" := Item."Sales (Qty.)" + ItemLedgerEntry."Invoiced Quantity";
                            end;
                        until ItemLedgerEntry.Next = 0;
                    if (Item."Sales (Qty.)" = 0) and (QuantityReturned = 0) and
                       (Item."Sales (LCY)" = 0) and (Item."COGS (LCY)" = 0)
                    then
                        CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                begin
                    if not BreakdownByVariant then
                        CurrReport.Break;
                    if not AnyVariants then
                        CurrReport.Break;

                    BlankVariant := true;
                    //CurrReport.CreateTotals(Item."Sales (Qty.)",Item."Sales (LCY)",Item."COGS (LCY)",
                    //Profit,QuantityReturned);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                NoShow := false;
                if BreakdownByVariant then begin
                    NoVariant := Text002;
                    if AnyVariants then
                        NoShow := true;
                    // EXIT;
                end;

                //<ANICA LCC 10-21-16 Skip Items if Not selected on request Page
                if SelectDShipUnder0 then if Item."Drop Ship Item" = false then CurrReport.Skip;
                if SelectInvUnder0Over50 then if Item."Drop Ship Item" then CurrReport.Skip;
                //ANICA

                //ANICA Added Drop Ship Indicator to report
                if Item."Drop Ship Item" then PrintDropShip := 'X' else PrintDropShip := ' ';

                ItemUOM.SetCurrentkey(ItemUOM."Item No.", ItemUOM.Code);
                ItemUOM.SetRange(ItemUOM."Item No.", Item."No.");
                ItemUOM.SetRange(ItemUOM.Code, Item."Base Unit of Measure");
                if ItemUOM.Find('-') then begin
                    VPack := ItemUOM.Pack;
                    VPackDesc := ItemUOM."Pack Description";
                    //MESSAGE('Pack desc %1',ItemUOM.Code);
                end;
                ItemUPC.SetCurrentkey(ItemUPC."Item No.");
                ItemUPC.SetRange(ItemUPC."Item No.", Item."No.");
                if ItemUPC.Find('-') then VUPC := ItemUPC.UPC;

                //SETRANGE("Variant Filter");
                CalcFields("Sales (Qty.)", "Sales (LCY)", "COGS (LCY)");
                if ("Sales (Qty.)" = 0) and PrintOnlyIfSales then
                    CurrReport.Skip;
                Profit := "Sales (LCY)" - "COGS (LCY)";
                if "Sales (LCY)" <> 0 then
                    ItemProfitPct := ROUND(Profit / "Sales (LCY)" * 100, 0.1)
                else
                    ItemProfitPct := 0;
                QuantityReturned := 0;
                //<ANICA LCC 10-26-15 Add Key
                ItemLedgerEntry.SetCurrentkey("Item No.", "Variant Code", "Location Code", "Posting Date");
                //>ANICA
                ItemLedgerEntry.SetRange("Item No.", "No.");
                //ItemLedgerEntry.SETRANGE("Variant Code");
                if ItemLedgerEntry.Find('-') then
                    repeat
                        if ItemLedgerEntry."Invoiced Quantity" > 0 then begin
                            QuantityReturned := QuantityReturned + ItemLedgerEntry."Invoiced Quantity";
                            "Sales (Qty.)" := "Sales (Qty.)" + ItemLedgerEntry."Invoiced Quantity";
                        end;
                    until ItemLedgerEntry.Next = 0;

                //<ANICA LCC 10-21-16 Skip Items if Not selected on request Page
                if SelectDShipUnder0 then if ItemProfitPct = 0 then NoShow := true;
                if SelectInvUnder0Over50 then if (ItemProfitPct < 0.0) or (ItemProfitPct > 50.0) then NoShow := false else NoShow := true;
                //ANICA

                WriteLineRecord;
            end;

            trigger OnPreDataItem()
            begin
                // CurrReport.CreateTotals("Sales (Qty.)","Sales (LCY)","COGS (LCY)",
                //   Profit,QuantityReturned);
                ItemLedgerEntry.SetCurrentkey("Entry Type", "Item No.");
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."entry type"::Sale);
                Copyfilter("Date Filter", ItemLedgerEntry."Posting Date");
                Copyfilter("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                Copyfilter("Global Dimension 2 Filter", ItemLedgerEntry."Global Dimension 2 Code");
                Copyfilter("Location Filter", ItemLedgerEntry."Location Code");

                if StrPos(CurrentKey, FieldCaption("Inventory Posting Group")) = 1 then begin
                    if not ItemPostingGr.Get("Inventory Posting Group") then
                        ItemPostingGr.Init;
                    TLGroup := true;
                    GroupField := 2;
                    GroupName := ItemPostingGr.TableCaption;
                    GroupNo := "Inventory Posting Group";
                    GroupDesc := ItemPostingGr.Description;
                end;
                if StrPos(CurrentKey, FieldCaption("Vendor No.")) = 1 then begin
                    if not Vendor.Get("Vendor No.") then
                        Vendor.Init;
                    TLGroup := true;
                    GroupField := 3;
                    GroupName := Vendor.TableCaption;
                    GroupNo := "Vendor No.";
                    GroupDesc := Vendor.Name;
                end;
                if (StrPos(CurrentKey, FieldCaption("Inventory Posting Group")) = 0) and
                   (StrPos(CurrentKey, FieldCaption("Vendor No.")) = 0)
                then begin
                    TLGroup := false;
                    GroupName := '';
                    GroupNo := '';
                    GroupDesc := '';
                end;

                VUPC := '';
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(SelectDShipUnder0; SelectDShipUnder0)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drop Ship Items with Profit Not = Zero';
                    }
                    field(SelectInvUnder0Over50; SelectInvUnder0Over50)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Inventory Items Over 50% Profit or a Loss';
                    }
                    field(PrintOnlyIfSales; PrintOnlyIfSales)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Only Items with Sales';
                    }
                    field(IncludeItemDescriptions; IncludeItemDescriptions)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Item Descriptions';
                    }
                    field(BreakdownByVariant; BreakdownByVariant)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Breakdown By Variant';
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

    trigger OnPostReport()
    begin
        VLineOutputFile.Close;
    end;

    trigger OnPreReport()
    begin
        Title := Text000;
        if BreakdownByVariant then
            Title := Title + ' - ' + Text001;

        VSpace := ' ';
        VZero := '0';
        TDate := Today;
        VDay := Date2dmy(TDate, 1);
        VMonth := Date2dmy(TDate, 2);
        VYear := Date2dmy(TDate, 3);
        VTextDay := Format(VDay, 2, '<Integer>');
        VTextMonth := Format(VMonth, 2, '<Integer>');
        VTextYear := Format(VYear, 4, '<Integer>');
        VTextDate := VTextMonth + VTextDay + VTextYear;
        VZeroDate := ConvertStr(VTextDate, VSpace, VZero);


        CompanyInformation.Get;
        ItemFilter := Item.GetFilters;
        ItemDateFilterExsit := (Item.GetFilter("Date Filter") <> '');

        VFileName := 'ItemSS' + VZeroDate + '.txt';
        VFullFileName := '\\filestore\Company\Item Sales Statistics\' + VFileName;
        VLineOutputFile.Create(VFullFileName);
        VLineOutputFile.TextMode(true);

        //<ANICA LCC 10-21-16 Add ANICA Titles
        if SelectDShipUnder0 then Title := 'ITEM STATISTICS - Drop Ship Items with Markup or Loss';
        if SelectInvUnder0Over50 then Title := 'ITEM STATISTICS - Inventory Items with Over 50% Markup or Loss';
        //ANICA
    end;

    var
        CompanyInformation: Record "Company Information";
        ItemPostingGr: Record "Inventory Posting Group";
        Vendor: Record Vendor;
        ItemLedgerEntry: Record "Item Ledger Entry";
        IncludeItemDescriptions: Boolean;
        BreakdownByVariant: Boolean;
        BlankVariant: Boolean;
        NoShow: Boolean;
        ItemFilter: Text;
        Title: Text[80];
        NoVariant: Text[30];
        Profit: Decimal;
        QuantityReturned: Decimal;
        ItemProfitPct: Decimal;
        PrintOnlyIfSales: Boolean;
        GroupName: Text[30];
        GroupNo: Code[20];
        GroupDesc: Text[30];
        Text000: label 'Inventory Sales Statistics';
        Text001: label 'by Variant';
        Text002: label 'No Variants';
        Text003: label 'Total';
        TLGroup: Boolean;
        GroupField: Integer;
        ItemDateFilterExsit: Boolean;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Inventory_items_without_sales_are_not_included_on_this_report_CaptionLbl: label 'Inventory items without sales are not included on this report.';
        Inventory_items_without_sales_during_the_above_period_are_not_included_on_this_report_CaptionLbl: label 'Inventory items without sales during the above period are not included on this report.';
        ProfitCaptionLbl: label 'Profit';
        ItemProfitPctCaptionLbl: label 'Profit %';
        QuantityReturnedCaptionLbl: label 'Quantity Returned';
        QuantityReturnedCaption_Control46Lbl: label 'Quantity Returned';
        ProfitCaption_Control49Lbl: label 'Profit';
        ItemProfitPctCaption_Control50Lbl: label 'Profit %';
        Item_Variant_CodeCaptionLbl: label 'Variant Code';
        Report_TotalCaptionLbl: label 'Report Total';
        SelectInvUnder0Over50: Boolean;
        SelectDShipUnder0: Boolean;
        PrintDropShip: Text[1];
        ItemUOM: Record "Item Unit of Measure";
        VPack: Decimal;
        VPackDesc: Code[20];
        VFullFileName: Text[70];
        VFileName: Text[30];
        VLineOutputFile: File;
        TDate: Date;
        VOutputFileLine: Text[130];
        PUnitPrice: Code[12];
        PSalesQty: Code[12];
        PCOGS: Code[12];
        PPack: Code[12];
        VDay: Integer;
        VMonth: Integer;
        VYear: Integer;
        VTextDay: Text[2];
        VTextMonth: Text[2];
        VTextYear: Text[4];
        VTextDate: Text[10];
        VZeroDate: Text[10];
        VSpace: Text[1];
        VZero: Text[1];
        ItemUPC: Record "Item UPC Table";
        VUPC: Code[20];


    procedure AnyVariants(): Boolean
    var
        ItemVariant: Record "Item Variant";
    begin
        ItemVariant.SetRange("Item No.", Item."No.");
        exit(ItemVariant.FindFirst);
    end;


    procedure WriteLineRecord()
    begin
        PUnitPrice := Format(Item."Unit Price", 12, '<Integer><Decimal,3>');
        PSalesQty := Format(Item."Sales (Qty.)", 12, '<Integer><Decimal,3>');
        PCOGS := Format(Item."COGS (LCY)", 12, '<Integer><Decimal,3>');
        PPack := Format(VPack, 12, '<Integer><Decimal,3>');
        VOutputFileLine := Item."No." + '~' + PUnitPrice + '~' + PSalesQty + '~' + PCOGS + '~' + Item."JBG Commodity Group" + '~' +
        Item.Description + '~' + PPack + '~' + VPackDesc + '~' + VUPC;
        VLineOutputFile.Write(VOutputFileLine);
    end;
}

