Report 50111 "JBG Reused Prices -- LIST ONLY"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JBG Reused Prices -- LIST ONLY.rdlc';

    dataset
    {
        dataitem("JBG Price Weekly Table"; "JBG Price Weekly Table")
        {
            DataItemTableView = sorting("Import Date", "JBG Item No", "Cap Code") order(ascending);
            column(ReportForNavId_7382; 7382)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(JBG_Price_Weekly_Table__JBG_Item_No_; "JBG Item No")
            {
            }
            column(VTarget; VTarget)
            {
            }
            column(VStoreNumber; VStoreNumber)
            {
            }
            column(VTargetRetail; VTargetRetail)
            {
            }
            column(VNonStockEntryNo; VNonStockEntryNo)
            {
            }
            column(VNewUPC; VNewUPC)
            {
            }
            column(VDescr; VDescr)
            {
            }
            column(VNewPack; VNewPack)
            {
            }
            column(VNewPackDescr; VNewPackDescr)
            {
            }
            column(JBG_Price_Weekly_TableCaption; JBG_Price_Weekly_TableCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(JBG_No_Caption; JBG_No_CaptionLbl)
            {
            }
            column(Cap_CodeCaption; Cap_CodeCaptionLbl)
            {
            }
            column(Store_NumberCaption; Store_NumberCaptionLbl)
            {
            }
            column(Zone_RetailCaption; Zone_RetailCaptionLbl)
            {
            }
            column(NonstockCaption; NonstockCaptionLbl)
            {
            }
            column(New_UPCCaption; New_UPCCaptionLbl)
            {
            }
            column(New_DescriptionCaption; New_DescriptionCaptionLbl)
            {
            }
            column(New_PackCaption; New_PackCaptionLbl)
            {
            }
            column(New_SizeCaption; New_SizeCaptionLbl)
            {
            }
            column(JBG_Price_Weekly_Table_Import_Date; "Import Date")
            {
            }
            column(JBG_Price_Weekly_Table_Store_Number; "Store Number")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For Progress Bar
                begin
                    CurRec := CurRec + 1;
                    if (TotalRec <> 0) then
                        Window.Update(1, ROUND(CurRec * 10000 / TotalRec, 1));
                end;



                //Get JBG Item Number
                VJBGItemNo := "JBG Price Weekly Table"."JBG Item No";

                //Check to see if previous record was a different item.
                CheckPrevJBG;

                //Lookup values from Current JBG Item Import
                if (VIsFound = true) then
                    GetJBGItemTableData;

                if (VIsFound = true) and (VCheckUPC <> VNewUPC) and (VNewGrossWt <> VCheckGrossWt) then begin

                    //========================================================================
                    //BEGIN INITIALIZING NEEDED VARIABLES
                    //========================================================================
                    //Clear All Variables
                    Clear(VNonStockEntryNo);
                    Clear(VNewUPC);
                    Clear(VDescr);
                    Clear(VNewPack);
                    Clear(VNewPackDescr);
                    Clear(VCapCode);
                    Clear(VStoreNumber);


                    //Lookup in Backup Nonstock to get Entry No.
                    CheckNonStockItem;

                    if VIsFound <> true then
                        CurrReport.Skip
                    else begin
                        //Get necessary values from JBG Item Weekly Table
                        GetJBGItemTableData;
                        if VIsFound <> true then
                            CurrReport.Skip

                        else
                            //Get necessary values from JBG Price Weekly Table
                            begin
                            VCapCode := "Cap Code";

                            //CS 11-4-16: Switching to Target Retail.
                            VTargetRetail := "Target Retail";
                            VStoreNumber := "Store Number"; //VStoreNumber first populated ****

                            //CS 11-08-16: Lookup Target using Store Number, via JBG Store to Target Table
                            JBGStoreToTarget.Get(VStoreNumber);
                            VTarget := JBGStoreToTarget.Target;

                        end;

                    end;
                    //========================================================================
                    //END INITIALIZING NEEDED VARIABLES
                    //========================================================================

                end
                else
                    CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin
                //clear filters.
                Clear("JBG Price Weekly Table");

                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                LookupImportDates;

                "JBG Price Weekly Table".SetCurrentkey("Import Date", "JBG Item No", "Cap Code");
                "JBG Price Weekly Table".SetRange("Import Date", VCurrentImportDate);

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
        JBGItemTable: Record "JBG Item Weekly Table";
        JBGPrev: Record "JBG Item Weekly Table";
        JBGPriceTable: Record "JBG Price Weekly Table";
        NSBackupRecord: Record "Backup Nonstock Item";
        NonStockUPCTable: Record "Nonstock UPC Table";
        ItemUPCTable: Record "Item UPC Table";
        NonStockRecord: Record "Nonstock Item";
        NonstockTargetRetail: Record "Nonstock Target Retail";
        ItemTargetRetail: Record "Item Target Retail";
        JBGStoreToTarget: Record "JBG Store No. to Target";
        VNonStockEntryNo: Code[10];
        VNSEntryNoLookup: Code[10];
        VJBGItemNo: Code[20];
        VNonStockItemLookup: Code[20];
        VNewUPC: Code[20];
        VCheckUPC: Code[20];
        VNewGrossWt: Decimal;
        VCheckGrossWt: Decimal;
        VCapCode: Code[10];
        VStoreNumber: Code[10];
        VZoneRetail: Decimal;
        VDescr: Text[30];
        VLastRecordItemNo: Code[20];
        VNewPack: Decimal;
        VFirstRecord: Boolean;
        VNewPackDescr: Text[30];
        VLookupNonStock: Code[20];
        VItemBlocked: Boolean;
        VItemDropShip: Boolean;
        VNonStockItemNo: Code[20];
        VNonStockDescr: Text[50];
        VZone1and2: Decimal;
        VZone3: Decimal;
        VZoneN: Decimal;
        CalcZone1and2: Decimal;
        CalcZone3: Decimal;
        CalcZoneN: Decimal;
        VANICACap: Code[10];
        VDoNotUpdateJBG: Boolean;
        VNoJBGCrossUpdate: Boolean;
        VNoJBGNonStockUpdate: Boolean;
        VItemDescr: Text[50];
        VCrossItemNo: Code[20];
        VCheckCurrent: Code[9];
        VCheckLast: Code[9];
        CheckCrossRefNo: Code[20];
        P: Integer;
        ItemRecord: Record Item;
        NonStockUPC: Code[20];
        VBasePackSize: Decimal;
        VNonStockCommCode: Code[10];
        VItemCommCode: Code[10];
        VZoneK: Decimal;
        VFileName: Text[255];
        VCurrentImportDate: Date;
        VPrevImportDate: Date;
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        VIsFound: Boolean;
        VNoPrevRecord: Boolean;
        JBG_Price_Weekly_TableCaptionLbl: label 'JBG Price Weekly Table';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        JBG_No_CaptionLbl: label 'JBG No.';
        Cap_CodeCaptionLbl: label 'Cap Code';
        Store_NumberCaptionLbl: label 'Store Number';
        Zone_RetailCaptionLbl: label 'Zone Retail';
        NonstockCaptionLbl: label 'Nonstock';
        New_UPCCaptionLbl: label 'New UPC';
        New_DescriptionCaptionLbl: label 'New Description';
        New_PackCaptionLbl: label 'New Pack';
        New_SizeCaptionLbl: label 'New Size';
        VTargetRetail: Decimal;
        VTarget: Code[10];


    procedure LookupImportDates()
    begin
        //Key 'JBG Item Weekly Table' on "Import Date"
        JBGItemTable.SetCurrentkey("Import Date");

        //Look up the last record in the results to get the most recent date
        JBGItemTable.Find('+');
        VCurrentImportDate := JBGItemTable."Import Date";
        VPrevImportDate := VCurrentImportDate - 7;
    end;


    procedure CheckNonStockItem()
    begin
        //This trigger checks to see if Item
        NSBackupRecord.SetCurrentkey("Vendor Item No.");
        NSBackupRecord.SetRange("Vendor Item No.", VJBGItemNo);
        //NSBackupRecord.SETRANGE("Change Indicator",'D');

        if NSBackupRecord.Find('+') then begin
            VIsFound := true;
            VNonStockEntryNo := NSBackupRecord."Entry No.";
        end

        else
            VIsFound := false;

        //clear filters
        Clear(NSBackupRecord);
    end;


    procedure CheckPrevJBG()
    begin
        //This trigger looks up the previous record to see if it is more than a week old.
        // if it is, then UPC and Gross Wt. are stored to compare against the current import record.
        JBGPrev.SetCurrentkey("Import Date");
        JBGPrev.SetRange("Import Date", 0D, VPrevImportDate);
        JBGPrev.SetRange("Vendor Item No", VJBGItemNo);

        if JBGPrev.Find('+') then begin
            //JBGPrev.FIND('+');
            if JBGPrev."Import Date" < VPrevImportDate then begin
                VIsFound := true;
                VCheckUPC := JBGPrev.UPC;
                VCheckGrossWt := JBGPrev."Gross Weight";
            end
            else
                VIsFound := false;
        end
        else begin
            VNoPrevRecord := true;
            VIsFound := true;
        end;


        Clear(JBGPrev);
    end;


    procedure GetJBGItemTableData()
    begin
        JBGItemTable.SetCurrentkey("Import Date");
        JBGItemTable.SetRange("Import Date", VCurrentImportDate);
        JBGItemTable.SetRange("Vendor Item No", VJBGItemNo);
        //JBGItemTable.SETRANGE(Change,'Y');

        if JBGItemTable.Find('+') then begin
            VNewUPC := JBGItemTable.UPC;
            VDescr := JBGItemTable.Description;
            VNewPack := JBGItemTable.Pack;
            VNewPackDescr := JBGItemTable."Pack Descrip";
            VNewGrossWt := JBGItemTable."Gross Weight";
            VIsFound := true;
        end

        else
            VIsFound := false;

        //clear filters.
        Clear(JBGPriceTable);
    end;


    procedure LookupNonStockItem()
    begin
        NonStockRecord.LockTable;
        NonStockRecord.SetCurrentkey("Vendor Item No.", "Manufacturer Code");
        NonStockRecord.SetRange("Vendor Item No.", VNonStockItemLookup);
        NonStockRecord.SetRange("Manufacturer Code", 'G');

        if NonStockRecord.Find('+') then begin
            VNonStockItemNo := NonStockRecord."Item No.";
            VBasePackSize := NonStockRecord.Pack;
            VNonStockCommCode := NonStockRecord."Commodity Code";
            VNonStockEntryNo := NonStockRecord."Entry No."
        end
        else
            Error('Non Stock Item Does Not Exist %1', VNonStockItemLookup);

        Clear(NonStockRecord);
    end;


    procedure CreateNonstockTargetRetail()
    begin
        //CS 11-08-16: Changed this function to creat a Nonstock Target Retail record, instead of Zone Retail.
        NonstockTargetRetail.SetCurrentkey("Entry No.", UPC, Target);
        NonstockTargetRetail.SetRange("Entry No.", VNSEntryNoLookup);
        NonstockTargetRetail.SetRange(UPC, VNewUPC);
        NonstockTargetRetail.SetRange(Target, VTarget);

        if NonstockTargetRetail.Find('+') then begin
            //Update existing record
            NonstockTargetRetail.Retail := VTargetRetail;
            NonstockTargetRetail.Modify(true);
        end
        else begin
            //Create New Record
            NonstockTargetRetail.Init;
            NonstockTargetRetail."Entry No." := VNSEntryNoLookup;
            NonstockTargetRetail.UPC := VNewUPC;
            NonstockTargetRetail.Target := VTarget;
            NonstockTargetRetail.Insert(true);
            NonstockTargetRetail.Retail := VTargetRetail;
            NonstockTargetRetail."Date Created" := Today;
            NonstockTargetRetail."Last Modified" := Today;
            NonstockTargetRetail."Last User" := UserId;
            NonstockTargetRetail.Modify(true);
        end;

        Clear(NonstockTargetRetail);
    end;


    procedure CreateItemTargetRetail()
    begin
        //CS 11-08-16: Changed this function to creat a Nonstock Target Retail record, instead of Zone Retail.
        ItemTargetRetail.SetCurrentkey("Item No.", UPC, Target);
        ItemTargetRetail.SetRange("Item No.", VNonStockItemNo);
        ItemTargetRetail.SetRange(UPC, VNewUPC);
        ItemTargetRetail.SetRange(Target, VTarget);

        if ItemTargetRetail.Find('+') then begin
            //Update existing record
            ItemTargetRetail.Retail := VTargetRetail;
            ItemTargetRetail.Modify(true);
        end
        else begin
            //Create New Record
            ItemTargetRetail.Init;
            ItemTargetRetail."Item No." := VNonStockItemNo;
            ItemTargetRetail.UPC := VNewUPC;
            ItemTargetRetail.Target := VTarget;
            ItemTargetRetail.Insert(true);
            ItemTargetRetail.Retail := VTargetRetail;
            ItemTargetRetail."Date Created" := Today;
            ItemTargetRetail."Last Modified" := Today;
            ItemTargetRetail."Last User" := UserId;
            ItemTargetRetail.Modify(true);
        end;

        Clear(ItemTargetRetail);
    end;


    procedure CreateItemUPCEntries()
    begin
        //First make sure the nonstock UPC entries exist on the item UPC table
        NonStockUPCTable.SetCurrentkey("Nonstock Entry No.");
        NonStockUPCTable.SetRange("Nonstock Entry No.", VNSEntryNoLookup);

        if NonStockUPCTable.Find('-') then
            repeat
                ItemUPCTable.SetCurrentkey("Item No.", UPC);
                ItemUPCTable.SetRange("Item No.", VNonStockItemNo);
                ItemUPCTable.SetRange(UPC, NonStockUPCTable.UPC);
                if ItemUPCTable.Find('-') then begin
                    ItemUPCTable."Pack Descrip" := NonStockUPCTable."Pack Desc";
                    ItemUPCTable."Pack Divider" := NonStockUPCTable."Pack Divider";
                    ItemUPCTable."Last Date Updated" := Today();
                    ItemUPCTable.Modify(true);
                end
                else begin
                    ItemUPCTable.Init;
                    ItemUPCTable."Item No." := VNonStockItemNo;
                    ItemUPCTable.UPC := NonStockUPCTable.UPC;
                    ItemUPCTable."Pack Descrip" := NonStockUPCTable."Pack Desc";
                    ItemUPCTable."Pack Divider" := NonStockUPCTable."Pack Divider";
                    ItemUPCTable."Last Date Updated" := Today();
                    ItemUPCTable.Insert;
                end;
            until NonStockUPCTable.Next = 0;

        Clear(NonStockUPCTable);
    end;


    procedure SecondaryNSEntryNoLookup()
    begin
        //For items with now previous record in the JBG update table
        NonStockRecord.SetCurrentkey("Vendor Item No.");
        NonStockRecord.SetRange("Vendor Item No.", VJBGItemNo);

        if NonStockRecord.Find('+') then begin
            VIsFound := true;
            VNonStockEntryNo := NonStockRecord."Entry No.";
        end

        else
            VIsFound := false;

        //clear filters
        Clear(NonStockRecord);
    end;
}

