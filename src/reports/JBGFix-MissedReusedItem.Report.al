Report 50146 "JBG Fix - Missed Reused Item"
{
    // //This program checks for Reused Items after JBG Catalog Price Update.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JBG Fix - Missed Reused Item.rdlc';


    dataset
    {
        dataitem("Nonstock Item";"Nonstock Item")
        {
            column(ReportForNavId_7742; 7742)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(UserId;UserId)
            {
            }
            column(Nonstock_Item__Entry_No__;"Entry No.")
            {
            }
            column(VVendorItem;VVendorItem)
            {
            }
            column(VNSUPC;VNSUPC)
            {
            }
            column(VCheckUPC;VCheckUPC)
            {
            }
            column(VNSDescription;VNSDescription)
            {
            }
            column(VCheckDescription;VCheckDescription)
            {
            }
            column(JBG_Weekly_Reused_No__sCaption;JBG_Weekly_Reused_No__sCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(NonstockCaption;NonstockCaptionLbl)
            {
            }
            column(JBG_No_Caption;JBG_No_CaptionLbl)
            {
            }
            column(Nonstock_UPCCaption;Nonstock_UPCCaptionLbl)
            {
            }
            column(Item_UPCCaption;Item_UPCCaptionLbl)
            {
            }
            column(Nonstock_DescriptionCaption;Nonstock_DescriptionCaptionLbl)
            {
            }
            column(Item_DescriptionCaption;Item_DescriptionCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For Progress Bar
                begin
                    CurRec := CurRec + 1;
                    if (TotalRec <> 0) then
                        Window.Update(1,ROUND(CurRec * 10000 / TotalRec,1));
                end;

                if "ANICA Inactive" then
                    CurrReport.Skip;

                Clear(VIsFound);
                Clear(VVendorItem);
                Clear(VItemNo);
                Clear(VNSUPC);
                Clear(VDescrip);
                Clear(VNewPrice);
                Clear(VPack);
                Clear(VPackDescr);
                Clear(VGrossWeight);
                Clear(VEntry_No);
                Clear(VNSDescription);
                Clear(VCheckDescription);
                Clear(VCheckUPC);
                Clear(VCategoryCode);
                Clear(VHazardous);
                Clear(VFOBCode);
                Clear(VPickType);
                Clear(VJBGCommGroup);
                Clear(VSubDept);
                Clear(VANICACommCode);
                Clear(VInactive);
                Clear(VEntry_No);


                //Get Vendor Item No.
                VVendorItem := "Vendor Item No."; //non "G" number
                VItemNo := "Item No."; // "G" number

                //Get Description & UPC from NS Record.
                VNSDescription:= Description;
                VNSUPC := "UPC Code for SMS";

                //Get Description and UPC from Item record.
                GetItemValues;

                //Compare NS and Item records. If descrip. matches, SKIP.
                if (VIsFound = true) and (VNSDescription <> VCheckDescription) then

                    //If they do not match, AND the UPCs are different, Update Item card.
                    if (VNSUPC <> VCheckUPC) then
                            begin

                            //Put all needed data into variables prior to running LookupItem
                            VDescrip := Description;
                            VNewPrice := "Unit Price";
                            VPack := Pack;
                            VPackDescr := "Pack Description";
                            VGrossWeight := "Gross Weight";
                            VCategoryCode := "Item Category Code";
                            VHazardous := "Hazardous Code";
                            VFOBCode := "FOB Code";
                            VPickType := "Pick Type";
                            VJBGCommGroup := "JBG Commodity Group";
                            VSubDept := "SMS Subdepartment";
                            VANICACommCode := "Commodity Code";
                            VInactive := "ANICA Inactive";
                            VEntry_No := "Entry No.";

                            //Update the Item Card
                            LookupItem;

                            //Clear SMS flags for the SMS update to see these records.
                            "Price Files Created" := false;
                            Modify(true);
                        end
                    else
                        //If the Description do not match, but the UPC's do, only update the description on the item card.
                        UpdateItemDescription
                else
                    CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin
                //clear filters.
                Clear("Nonstock Item");

                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                SetCurrentkey("Vendor Item No.","Manufacturer Code");
                SetRange("Manufacturer Code",'G');

                //For progress bar
                begin
                    Clear(Window);
                    Window.Open('Processing @1@@@@@@@@');
                    TotalRec := COUNTAPPROX;
                    CurRec := 0;
                end;
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

    var
        ItemCheck: Record Item;
        ItemRecord: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        ItemUPCTable: Record "Item UPC Table";
        VVendorItem: Text[30];
        VEntry_No: Text[30];
        VDescrip: Text[30];
        VCategoryCode: Code[10];
        VSubDept: Integer;
        VANICACommCode: Code[10];
        VPack: Decimal;
        VPackDescr: Text[30];
        VItemNo: Text[30];
        VNSUPC: Code[20];
        VNewPrice: Decimal;
        VGrossWeight: Decimal;
        VHazardous: Boolean;
        VIsFound: Boolean;
        VNSDescription: Text[30];
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        VCheckUPC: Text[30];
        VCheckDescription: Text[30];
        VFOBCode: Code[10];
        VPickType: Option;
        VJBGCommGroup: Code[4];
        VInactive: Boolean;
        JBG_Weekly_Reused_No__sCaptionLbl: label 'JBG Weekly Reused No.''s';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        NonstockCaptionLbl: label 'Nonstock';
        JBG_No_CaptionLbl: label 'JBG No.';
        Nonstock_UPCCaptionLbl: label 'Nonstock UPC';
        Item_UPCCaptionLbl: label 'Item UPC';
        Nonstock_DescriptionCaptionLbl: label 'Nonstock Description';
        Item_DescriptionCaptionLbl: label 'Item Description';


    procedure GetItemValues()
    begin
        //Looks up Item record to get Description and UPC to compare with NS Record.

        ItemCheck.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        ItemCheck.SetRange("Vendor Item No.",VVendorItem);
        ItemCheck.SetRange("Manufacturer Code", 'G');

        if ItemCheck.Find('+') then
            begin
                VIsFound := true;
                VCheckDescription := ItemCheck.Description;
                VCheckUPC := ItemCheck."UPC for SMS";
            end
        else
            VIsFound := false;

        Clear(ItemCheck);
    end;


    procedure LookupItem()
    begin
        ItemRecord.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        ItemRecord.SetRange("Vendor Item No.",VVendorItem);
        ItemRecord.SetRange("Manufacturer Code", 'G');

        if ItemRecord.Find('-') then
            begin
                ItemRecord.Description := VNSDescription;
                ItemRecord.Validate(Description);
                ItemRecord."Unit Price" := VNewPrice;
                ItemRecord."UPC for SMS" := VNSUPC;
                ItemRecord."Fixed Price Code" := false;
                ItemRecord."Hazardous Code" := VHazardous;
                ItemRecord."FOB Code" := VFOBCode;
                ItemRecord."Pick Type" := VPickType;
                ItemRecord."Item Category Code" := VCategoryCode;
                ItemRecord."Gen. Prod. Posting Group" := VCategoryCode;
                ItemRecord."Inventory Posting Group" := VCategoryCode;
                ItemRecord."Last Date Modified" := Today;
                ItemRecord."JBG Commodity Group" := VJBGCommGroup;
                ItemRecord."Gross Weight" := VGrossWeight;
                ItemRecord."SMS Subdepartment" := VSubDept;
                ItemRecord."Commodity Code" := VANICACommCode;

                //Clear the price file created flags so the SMS update will consider all items
                ItemRecord."Price Files Created" := false;
                ItemRecord."Do Not Update JBG Retails" := false;

                ItemRecord."ANICA Inactive" := false;
                ItemRecord.Modify(true);

                //Fix the pack
                LookupUOM;
            end
        else
            Message('Item Not Found %1',VVendorItem);

        UpdateItemUPC;
    end;


    procedure LookupUOM()
    begin
        //Update the pack on the item unit of measure table
        ItemUOM.SetCurrentkey("Item No.");
        ItemUOM.SetRange("Item No.",VItemNo);
            if ItemUOM.Find('-') then
                begin
                    ItemUOM.Pack := VPack;
                    ItemUOM."Pack Description" := VPackDescr;
                    ItemUOM.Modify(true);
                end
            else Message('UOM Not Found %1',VItemNo);
    end;


    procedure UpdateItemUPC()
    begin
        //Update the info on the item UPC table

        ItemUPCTable.SetCurrentkey ("Item No.");
        ItemUPCTable.SetRange("Item No.",VItemNo);

        //Delete all records that have this item number.
        if ItemUPCTable.Find('-') then
            begin
                ItemUPCTable.DeleteAll(true);
                Commit;
            end;

        //clear filter
        ItemUPCTable.SetCurrentkey ("Item No.");

        //Add correct record update back to the Item UPC Table
        ItemUPCTable."Item No." := VItemNo;
        ItemUPCTable.UPC := VNSUPC;
        ItemUPCTable.Insert(true);
        ItemUPCTable."Pack Descrip" := VPackDescr;
        ItemUPCTable."Pack Divider" := VPack;
        ItemUPCTable."Date Created" := Today();
        ItemUPCTable."Last Date Updated" := Today();
        //ItemUPCTable."Zone 1 Retail" := 0;
        //ItemUPCTable."Zone 3 Retail" := 0;
        //ItemUPCTable."Zone N Retail" := 0;
        //ItemUPCTable."Zone 1 Price File Created" := FALSE;
        //ItemUPCTable."Zone 3 Price File Created" := FALSE;
        //ItemUPCTable."Zone N Price File Created" := FALSE;
        ItemUPCTable.Modify(true);
    end;


    procedure UpdateItemDescription()
    begin
        //Corrects ONLY the description on the item card.  Called when everything matches except for the description.

        ItemCheck.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        ItemCheck.SetRange("Vendor Item No.",VVendorItem);
        ItemCheck.SetRange("Manufacturer Code", 'G');

        if ItemCheck.Find('+') then
            begin
                ItemCheck.Description := VNSDescription;
                ItemCheck.Modify(true);
            end
        else
            VIsFound := false;

        Clear(ItemCheck);
    end;
}

