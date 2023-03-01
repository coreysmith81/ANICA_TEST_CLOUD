Report 50108 "JBG Weekly Reused Items"
{
    // //This program checks for Reused Items after JBG Catalog Price Update.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JBG Weekly Reused Items.rdlc';


    dataset
    {
        dataitem("JBG Item Weekly Table";"JBG Item Weekly Table")
        {
            DataItemTableView = sorting(NCoGroup);
            column(ReportForNavId_8183; 8183)
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
            column(VNSEntryNo;VNSEntryNo)
            {
            }
            column(VVendorItem;VVendorItem)
            {
            }
            column(VNSUPCCode;VNSUPCCode)
            {
            }
            column(JBG_Item_Weekly_Table_UPC;UPC)
            {
            }
            column(VNSDescription;VNSDescription)
            {
            }
            column(JBG_Item_Weekly_Table_Description;Description)
            {
            }
            column(VNSUnitPrice;VNSUnitPrice)
            {
            }
            column(JBG_Item_Weekly_Table__Unit_Price_;"Unit Price")
            {
            }
            column(VNSPack;VNSPack)
            {
            }
            column(VNSPackDesc;VNSPackDesc)
            {
            }
            column(JBG_Item_Weekly_Table_Pack;Pack)
            {
            }
            column(JBG_Item_Weekly_Table_NCoGroup;NCoGroup)
            {
            }
            column(JBG_Item_Weekly_Table_Dept;Dept)
            {
            }
            column(JBG_Item_Weekly_Table__Gross_Weight_;"Gross Weight")
            {
            }
            column(JBG_Item_Weekly_Table__Post_Indicator_;"Post Indicator")
            {
            }
            column(JBG_Item_Weekly_Table_Hazardous;Hazardous)
            {
            }
            column(JBG_Item_Weekly_Table_Vendor;Vendor)
            {
            }
            column(JBG_Item_Weekly_Table__Pack_Descrip_;"Pack Descrip")
            {
            }
            column(JBG_Item_Weekly_Table_Change;Change)
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
            column(Old_UPCCaption;Old_UPCCaptionLbl)
            {
            }
            column(New_UPCCaption;New_UPCCaptionLbl)
            {
            }
            column(Old_Descr_Caption;Old_Descr_CaptionLbl)
            {
            }
            column(New_Descr_Caption;New_Descr_CaptionLbl)
            {
            }
            column(Old_PriceCaption;Old_PriceCaptionLbl)
            {
            }
            column(New_PriceCaption;New_PriceCaptionLbl)
            {
            }
            column(Old_PackCaption;Old_PackCaptionLbl)
            {
            }
            column(Old_SizeCaption;Old_SizeCaptionLbl)
            {
            }
            column(New_PackCaption;New_PackCaptionLbl)
            {
            }
            column(New_SizeCaption;New_SizeCaptionLbl)
            {
            }
            column(Comm__GroupCaption;Comm__GroupCaptionLbl)
            {
            }
            column(DeptCaption;DeptCaptionLbl)
            {
            }
            column(Gr__Wt_Caption;Gr__Wt_CaptionLbl)
            {
            }
            column(Post_Ind_Caption;Post_Ind_CaptionLbl)
            {
            }
            column(HAZCaption;HAZCaptionLbl)
            {
            }
            column(Vend_Caption;Vend_CaptionLbl)
            {
            }
            column(ChgCaption;ChgCaptionLbl)
            {
            }
            column(JBG_Item_Weekly_Table_Import_Date;"Import Date")
            {
            }
            column(JBG_Item_Weekly_Table_Vendor_Item_No;"Vendor Item No")
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

                VIsFound := false;
                VNoPrevRecord := false;
                VCheckItem := '';
                VVendorItem := '';
                VNewUPC := '';
                VDescrip := '';
                VNewPrice := 0;
                VPack := 0;
                VPackDescr := '';
                VNCoGroup := '';
                VDept := '';
                VGrossWeight := 0;
                VPostIndicator := '';
                VVendor := '';
                VChange := '';
                VEntry_No := '';
                VNSEntryNo := '';
                VNSDescription := '';
                VNSVendorItemNo := '';
                VNSUPCCode := '';
                VNSUnitPrice := 0;
                VNSPack := 0;
                VNSPackDesc := '';


                //Get Vendor Item No.
                VVendorItem := "Vendor Item No";
                VNewUPC := UPC;

                //Check to see if previous record was a different item.
                CheckPrevJBG;


                if (VIsFound = true) and (VCheckUPC <> VNewUPC) and (VGrossWeight <> VCheckGrossWt) then

                    with "JBG Item Weekly Table" do begin

                        //Lookup needed values from Backup Nonstock table.
                        LookupBackupNonstock;

                        //Put all needed data into variables prior to running LookupNonStockItem
                        VDescrip := Description;
                        VNewPrice := "Unit Price";
                        VPack := Pack;
                        VPackDescr := "Pack Descrip";
                        VNCoGroup := NCoGroup;
                        VDept := Dept;
                        VGrossWeight := "Gross Weight";
                        VPostIndicator := "Post Indicator";
                        VVendor := Vendor;
                        VChange := Change;

                        //Lookup and update Nonstock tables
                        LookupNonStockItem;

                        //Lookup and update Item tables
                        if VCheckItem <> '' then
                            LookupItem;
                    end

                else if VNoPrevRecord = true then
                    begin
                        //Lookup needed values from Backup Nonstock table.
                        LookupBackupNonstock;

                        //Put all needed data into variables prior to running LookupNonStockItem
                        VDescrip := Description;
                        VNewPrice := "Unit Price";
                        VPack := Pack;
                        VPackDescr := "Pack Descrip";
                        VNCoGroup := NCoGroup;
                        VDept := Dept;
                        VGrossWeight := "Gross Weight";
                        VPostIndicator := "Post Indicator";
                        VVendor := Vendor;
                        VChange := Change;

                        //Lookup and update Nonstock tables
                        LookupNonStockItem;

                        //Lookup and update Item tables
                        if VCheckItem <> '' then
                            LookupItem;

                        VNSEntryNo := VEntry_No; //this is so that on the print out items with no prev record will have NS number.

                    end


                else
                    CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin
                //clear filters.
                Clear("JBG Item Weekly Table");

                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                LookupImportDates;

                "JBG Item Weekly Table".SetCurrentkey("Import Date");
                "JBG Item Weekly Table".SetRange("Import Date",VCurrentImportDate);
                //"JBG Item Weekly Table".SETRANGE(Change,'Y');
                //"JBG Item Weekly Table".SETRANGE("Vendor Item No",'206611');

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
        JBGThisWeek: Record "JBG Item Weekly Table";
        JBGPrev: Record "JBG Item Weekly Table";
        NSBackupRecord: Record "Backup Nonstock Item";
        NonStockRecord: Record "Nonstock Item";
        ItemRecord: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        JBGComGrp: Record "ANICA-JBG Commodity Codes";
        CommodityTable: Record "Commodity Code";
        NonStockUPCTable: Record "Nonstock UPC Table";
        ItemUPCTable: Record "Item UPC Table";
        VVendorItem: Text[30];
        VEntry_No: Text[30];
        VManuCode: Text[5];
        VDescrip: Text[30];
        VCheckItem: Code[20];
        VCategoryCode: Code[10];
        VSubDept: Integer;
        VANICACommCode: Code[10];
        VPack: Decimal;
        VPackDescr: Text[30];
        VItemNo: Text[30];
        VNewUPC: Code[20];
        VNewPrice: Decimal;
        VNCoGroup: Code[10];
        VDept: Code[10];
        VGrossWeight: Decimal;
        VPostIndicator: Code[10];
        VHazardous: Code[10];
        VVendor: Code[10];
        VChange: Code[10];
        VCurrentImportDate: Date;
        VPrevImportDate: Date;
        VIsD: Boolean;
        VIsFound: Boolean;
        VNSEntryNo: Code[20];
        VNSVendorItemNo: Code[20];
        VNSUPCCode: Code[20];
        VNSDescription: Text[30];
        VNSUnitPrice: Decimal;
        VNSPack: Decimal;
        VNSPackDesc: Text[10];
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        VCheckUPC: Text[30];
        VCheckGrossWt: Decimal;
        VNoPrevRecord: Boolean;
        JBG_Weekly_Reused_No__sCaptionLbl: label 'JBG Weekly Reused No.''s';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        NonstockCaptionLbl: label 'Nonstock';
        JBG_No_CaptionLbl: label 'JBG No.';
        Old_UPCCaptionLbl: label 'Old UPC';
        New_UPCCaptionLbl: label 'New UPC';
        Old_Descr_CaptionLbl: label 'Old Descr.';
        New_Descr_CaptionLbl: label 'New Descr.';
        Old_PriceCaptionLbl: label 'Old Price';
        New_PriceCaptionLbl: label 'New Price';
        Old_PackCaptionLbl: label 'Old Pack';
        Old_SizeCaptionLbl: label 'Old Size';
        New_PackCaptionLbl: label 'New Pack';
        New_SizeCaptionLbl: label 'New Size';
        Comm__GroupCaptionLbl: label 'Comm. Group';
        DeptCaptionLbl: label 'Dept';
        Gr__Wt_CaptionLbl: label 'Gr. Wt.';
        Post_Ind_CaptionLbl: label 'Post Ind.';
        HAZCaptionLbl: label 'HAZ';
        Vend_CaptionLbl: label 'Vend.';
        ChgCaptionLbl: label 'Chg';


    procedure LookupImportDates()
    begin
        //Key 'JBG Item Weekly Table' on "Import Date"
        JBGThisWeek.SetCurrentkey("Import Date");

        //Look up the last record in the results to get the most recent date
        JBGThisWeek.Find('+');
        VCurrentImportDate := JBGThisWeek."Import Date";
        VPrevImportDate := VCurrentImportDate - 7;

        Clear(JBGThisWeek);
    end;


    procedure CheckPrevJBG()
    begin
        //This trigger looks up the previous record to see if it is more than a week old.
        // if it is, then UPC and Gross Wt. are stored to compare against the current import record.
        JBGPrev.SetCurrentkey("Import Date");
        JBGPrev.SetRange("Import Date",0D,VPrevImportDate);
        JBGPrev.SetRange("Vendor Item No",VVendorItem);

        if JBGPrev.Find('+') then
            begin
                //JBGPrev.FIND('+');
                if JBGPrev."Import Date" < VPrevImportDate then
                    begin
                        VIsFound := true;
                        VCheckUPC := JBGPrev.UPC;
                        VCheckGrossWt := JBGPrev."Gross Weight";
                    end
                else
                    VIsFound := false;
            end
        else
            VNoPrevRecord := true;


        Clear(JBGPrev);
    end;


    procedure CheckCurrJBG()
    begin
    end;


    procedure LookupBackupNonstock()
    begin
        //This trigger looks up the item in the Backup Nonstock table, and get needed info.
        NSBackupRecord.SetCurrentkey("Vendor Item No.");
        NSBackupRecord.SetRange("Vendor Item No.",VVendorItem);

        if NSBackupRecord.Find('+') then
            begin
                VIsFound := true;
                VNSEntryNo := NSBackupRecord."Entry No.";
                VNSDescription := NSBackupRecord.Description;
                VNSVendorItemNo := NSBackupRecord."Vendor Item No.";
                VNSUPCCode := NSBackupRecord."UPC Code";
                VNSUnitPrice := NSBackupRecord."Unit Price";
                VNSPack := NSBackupRecord.Pack;
                VNSPackDesc := NSBackupRecord."Pack Description";
            end
        else
            VIsFound := false;

        //clear filters
        Clear(NSBackupRecord);
    end;


    procedure LookupNonStockItem()
    begin
        NonStockRecord.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        NonStockRecord.SetRange("Vendor Item No.",VVendorItem);
        NonStockRecord.SetRange("Manufacturer Code", 'G');

        if NonStockRecord.Find('+') then
            begin
                //Get the item number
                VCheckItem := NonStockRecord."Item No.";

                //Update fields in Nonstock Item Table
                NonStockRecord.Description := VDescrip;
                NonStockRecord."Pack Description" := VPackDescr;
                NonStockRecord.Pack := VPack;
                NonStockRecord."Negotiated Cost" := VNewPrice;
                NonStockRecord."Unit Price" := VNewPrice;
                NonStockRecord."UPC Code for SMS" := VNewUPC;
                NonStockRecord."Gross Weight" := VGrossWeight;

                //Lookup item category based on JBG dept codes
                case VDept of
                   '0015' : VCategoryCode := 'PROD';
                   '0021' : VCategoryCode := 'MEAT';
                   else VCategoryCode := 'GROC';
                end;
                NonStockRecord."Item Category Code" := VCategoryCode;

                //Clear the price file created flags so the SMS update will consider all items
                NonStockRecord."Price Files Created" := false;
                //CS 11-1-16: Being consolidated down to one field (above)
        //        NonStockRecord."DEL-Price File Created Zone 1" := FALSE;
        //        NonStockRecord."DEL-Price File Created Zone N" := FALSE;
        //        NonStockRecord."DEL-Price File Created  031" := FALSE;

                //Clear JBG Update Flag
                NonStockRecord."Do Not Update JBG Retails" := false;

                NonStockRecord."Vendor Department" := VDept;
                NonStockRecord."Wholesaler Vendor No." := VVendor;

                //Hazmat section
                if VPostIndicator = '3' then
                    begin
                        NonStockRecord."Hazardous Code" := true;
                        NonStockRecord."FOB Code" := 'HAZ';
                        NonStockRecord."Pick Type" := 1;
                    end
                else
                    begin
                        NonStockRecord."Hazardous Code" := false;
                        NonStockRecord."FOB Code" := '';
                        NonStockRecord."Pick Type" := 0;
                    end;

                if VChange = 'Y' then
                    NonStockRecord."Change Indicator" := 'C'
                else
                    NonStockRecord."Change Indicator" := '';

                //Get the JBG Commodity group from the JBG file and get our corresponding commodity code
                //The JBG Commodity code is also kept on the nonstock item card
                NonStockRecord."JBG Commodity Group" := VNCoGroup;

                JBGComGrp.SetCurrentkey(JBGComGrp."JBG Commodity Group");
                JBGComGrp.SetRange(JBGComGrp."JBG Commodity Group",VNCoGroup);

                if JBGComGrp.Find('-') then
                    begin
                        VANICACommCode := JBGComGrp."ANICA Commodity Code";
                        NonStockRecord."Commodity Code" := VANICACommCode;
                    end;

                //Lookup the SMS Subdepartment
                VSubDept := 0;
                CommodityTable.SetRange(CommodityTable."Commodity Code",VANICACommCode);

                if CommodityTable.Find('-') then
                    begin
                        VSubDept := CommodityTable."SMS Sub Department";
                        NonStockRecord."SMS Subdepartment" := VSubDept;
                    end;


                NonStockRecord."Last Date Modified" := Today;
                NonStockRecord."ANICA Inactive" := false;
                NonStockRecord.Modify(true);
            end
        else Error('NonStock Item Not Found %1',VVendorItem);

        VEntry_No := NonStockRecord."Entry No."; //Needed for UPC Table
        UpdateNonStockUPC;
    end;


    procedure LookupItem()
    begin
        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",VCheckItem);

        if ItemRecord.Find('-') then
            begin
                ItemRecord.Description := VDescrip;
                ItemRecord.Validate(Description);
                ItemRecord."Unit Price" := VNewPrice;
                ItemRecord."UPC for SMS" := VNewUPC;
                ItemRecord."Fixed Price Code" := false;

                //Hazmat section
                if VPostIndicator = '3' then
                    begin
                        ItemRecord."Hazardous Code" := true;
                        ItemRecord."FOB Code" := 'HAZ';
                        ItemRecord."Pick Type" := 1;
                    end
                else
                    begin
                        ItemRecord."Hazardous Code" := false;
                    end;

                //CS 01-30-20: Adding this section so that WIC flag is maintained
                //WIC section
                if VPostIndicator = '6' then
                    begin
                        ItemRecord."WIC Item" := true;
                    end
                else
                    begin
                        ItemRecord."WIC Item" := false;
                    end;


                //Category Code Section
                ItemRecord."Item Category Code" := VCategoryCode;
                ItemRecord."Gen. Prod. Posting Group" := VCategoryCode;
                ItemRecord."Inventory Posting Group" := VCategoryCode;

                ItemRecord."Last Date Modified" := Today;
                ItemRecord."JBG Commodity Group" := VNCoGroup;
                ItemRecord."Gross Weight" := VGrossWeight;
                ItemRecord."SMS Subdepartment" := VSubDept;
                ItemRecord."Commodity Code" := VANICACommCode;

                //Clear the price file created flags so the SMS update will consider all items
                ItemRecord."Price Files Created" := false;
                //CS 11-1-16: Being consolidated down to one field (above)
        //        ItemRecord."DEL-Price File Created Zone 1" := FALSE;
        //        ItemRecord."DEL-Price File Created Zone N" := FALSE;
        //        ItemRecord."DEL-Price File Created Z 031" := FALSE;
                ItemRecord."Do Not Update JBG Retails" := false;

                ItemRecord."ANICA Inactive" := false;
                ItemRecord.Modify(true);

                //Fix the pack
                LookupUOM;
            end
        else
            Error('Item Not Found %1',VCheckItem);

        UpdateItemUPC;
    end;


    procedure LookupUOM()
    begin
        //Update the pack on the item unit of measure table
        ItemUOM.SetCurrentkey(ItemUOM."Item No.");
        ItemUOM.SetRange(ItemUOM."Item No.",VCheckItem);
            if ItemUOM.Find('-') then
                begin
                    ItemUOM.Pack := VPack;
                    ItemUOM."Pack Description" := VPackDescr;
                    ItemUOM.Modify(true);
                end
            else Error('UOM Not Found %1',VCheckItem);
    end;


    procedure UpdateNonStockUPC()
    begin
        //Delete old records with the given "Nonstock Entry No.",
        //then replace it with only the most current.

        NonStockUPCTable.SetCurrentkey("Nonstock Entry No.");
        NonStockUPCTable.SetRange("Nonstock Entry No.",VEntry_No);

        //Delete all records that have this item number
        if NonStockUPCTable.Find('-') then
            begin
                NonStockUPCTable.DeleteAll(true);
                Commit;
            end;

        //clear filter
        NonStockUPCTable.SetRange("Nonstock Entry No.");

        //Add correct record update back to the Nonstock UPC Table
        NonStockUPCTable."Nonstock Entry No." := VEntry_No;
        NonStockUPCTable.UPC := VNewUPC;
        NonStockUPCTable.Insert(true);
        NonStockUPCTable."Pack Desc" := VPackDescr;
        NonStockUPCTable."Pack Divider" := VPack;
        NonStockUPCTable."Date Created" := Today();
        NonStockUPCTable."Last Date Updated" := Today();

        //Reset all fields not set by the update.
        //CS 11-1-16: Retail fields will be removed.
        //NonStockUPCTable."Zone 1 Retail" := 0;
        //NonStockUPCTable."Zone 3 Retail" := 0;
        //NonStockUPCTable."Zone N Retail" := 0;
        //CS 11-1-16: Price File created fields will be removed from UPC Table.
        //NonStockUPCTable."Zone 1 Price File Created" := FALSE;
        //NonStockUPCTable."Zone 3 Price File Created" := FALSE;
        //NonStockUPCTable."Zone N Price File Created" := FALSE;
        //NonStockUPCTable."Zone 031 Price File Created" := FALSE;

        NonStockUPCTable.Modify(true);
    end;


    procedure UpdateItemUPC()
    begin
        ItemUPCTable.SetCurrentkey ("Item No.");
        ItemUPCTable.SetRange("Item No.",VCheckItem);

        //Delete all records that have this item number.
        if ItemUPCTable.Find('-') then
            begin
                ItemUPCTable.DeleteAll(true);
                Commit;
            end;

        //clear filter
        ItemUPCTable.SetCurrentkey ("Item No.");

        //Add correct record update back to the Item UPC Table
        ItemUPCTable."Item No." := VCheckItem;
        ItemUPCTable.UPC := VNewUPC;
        ItemUPCTable.Insert(true);
        ItemUPCTable."Pack Descrip" := VPackDescr;
        ItemUPCTable."Pack Divider" := VPack;
        ItemUPCTable."Date Created" := Today();
        ItemUPCTable."Last Date Updated" := Today();
        //CS 11-1-16: Retail fields will be removed from UPC table.
        //ItemUPCTable."Zone 1 Retail" := 0;
        //ItemUPCTable."Zone 3 Retail" := 0;
        //ItemUPCTable."Zone N Retail" := 0;
        //CS 11-1-16: Price File Created field will be moved.
        //ItemUPCTable."Zone 1 Price File Created" := FALSE;
        //ItemUPCTable."Zone 3 Price File Created" := FALSE;
        //ItemUPCTable."Zone N Price File Created" := FALSE;
        //ItemUPCTable."Zone 031 Price File Created" := FALSE;
        ItemUPCTable.Modify(true);
    end;
}

