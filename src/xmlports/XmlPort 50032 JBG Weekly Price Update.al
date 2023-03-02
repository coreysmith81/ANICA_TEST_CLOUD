XmlPort 50032 "JBG Weekly Price Update"
{
    // 
    // //This program uses the WrmstPrc file from Gottstein
    // //02/03/10  Change cap code 075 to be Kikitak 0123 cap code 913  PJM.
    // 
    // //CS 12/8/11 : Modified coding so that only items that have had actual changes have their SMS flags cleared.
    // 
    // //CS 11-16-16: Modified to replace all references to Zone Retails, with Target Retails.

    Direction = Import;
    Format = FixedText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer;Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(VJBGItemNO)
                {
                    Width = 6;
                }
                textelement(VCapCode)
                {
                    Width = 3;
                }
                textelement(VStoreNumber)
                {
                    Width = 4;
                }
                textelement(iTargetRetail)
                {
                    Width = 10;

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate(VTargetRetail,iTargetRetail);
                    end;
                }

                trigger OnAfterInsertRecord()
                begin
                    //For Status Box
                    begin
                      Window.Update(1,VJBGItemNO);
                    end;

                    //The price import file must be sorted by item, by Cap Code

                    //Concatenate item no and cap code to determine when the record should be written
                    //VCheckCurrent := VJBGItemNO + VCapCode;
                    VCheckCurrent := VJBGItemNO;

                    //CS 11-17-16: Trying this here. May need to move back down.
                    //Make sure the item exists
                    VLookupNonStock := VJBGItemNO;
                    LookupNonStockSeq;

                    //CS 11-16-16: Lookup target in the 'JBG Store No. to Target' table to get target.
                    LookupTarget;

                    //If item is not marked as "Do Not Update JBG Retails", update/create retail records.
                    //NOTE: Changes here need to be addedd to the Post Data Item Section for the last item read
                    if VNoJBGNonStockUpdate <> true then
                        begin
                            //Update/Create Nonstock Target Retails
                            CreateNonstockTargetRetail;

                            //Lookup Item Record to get necessary variables for later.
                            if VNonStockItemNo <> '' then
                                LookupItemRecord;

                            //Update/Create Item Target Retails
                            if VNonStockItemNo <> '' then
                                CreateItemTargetRetail;

                            //Update/Create Item UPC Entries
                            if VNonStockItemNo <> '' then
                                CreateItemUPCEntries;
                        end
                    else
                        begin
                            //If the nonstock has been marked no JBG update, the cross should not update either
                            VNoJBGCrossUpdate := true;
                        end;

                    //CS 07/09/13: Cross Reference section taken out, Per Gina.

                    //Clear the variables after the records are created
                    VNonStockItemNo := '';
                    VANICACap := '';
                    VDoNotUpdateJBG := false;
                    VNoJBGNonStockUpdate := false;
                    VCrossItemNo := '';
                    CheckCrossRefNo := '';
                    VItemBlocked := false;
                    VNoJBGCrossUpdate := false;

                    //Get the retail for the current Target, for the current item.
                    GetTargetRetail;

                    //compare new retail to current one
                    if VTargetRetail <> VCurrTargetRetail then
                        begin
                            //Create the item number to use in filter for Flag-clearing triggers. (ie. G-000024)
                            VANICAItemNo := 'G-' + VJBGItemNO;

                            //clear the SMS flags on both NonStock and Item tables.
                            ClearNonStockSMSFlags;
                            ClearItemSMSFlags;
                        end;
                end;
            }
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

    trigger OnInitXmlPort()
    begin

        Report.Run(Report::"Backup Telxon Open Items");
        Commit;
        ClearAll;

        Xmlport.Run(Xmlport::"JBG Catalog Import");
        ClearAll;

        //Setup a file for an export with the crosses that were updated
        VFullFileName := '\\filestore\Purchasing\JBG Price File\_JBGPriceUpdateCrosses.txt';
    end;

    trigger OnPostXmlPort()
    begin
        //For Status Box
        Window.Close;
        Clear(Window);
    end;

    trigger OnPreXmlPort()
    begin
        //Get Crosses file.
        currXMLport.Filename(VFullFileName);

        //Insert a tab to a variable for delimiting the output file
        VTab := '|';

        VLineOutputFile.Create(VFullFileName);
        VLineOutputFile.TextMode(true);

        //Print headings
        VOutPutFileLine := 'Import Item No' + VTab + 'Import Descr' + VTab +
              'Crossed Item' + VTab + 'Cross Description' + VTab + 'Target Price';
        VLineOutputFile.Write(VOutPutFileLine);

        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
        end;
    end;

    var
        NonStockUPCTable: Record "Nonstock UPC Table";
        ItemUPCTable: Record "Item UPC Table";
        NonStockRecord: Record "Nonstock Item";
        ItemTargetRetail: Record "Item Target Retail";
        NonstockTargetRetail: Record "Nonstock Target Retail";
        JBGtoTarget: Record "JBG Store No. to Target";
        VZoneRetail: Decimal;
        VTargetRetail: Decimal;
        VLastRecordItemNo: Code[20];
        VFirstRecord: Boolean;
        VLookupNonStock: Code[20];
        VItemBlocked: Boolean;
        VItemDropShip: Boolean;
        VNonStocksSeqNo: Code[20];
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
        CrossReferenceRecord: Record "Item Cross Reference";
        VCrossItemNo: Code[20];
        VCheckCurrent: Code[9];
        VCheckLast: Code[9];
        CheckCrossRefNo: Code[20];
        P: Integer;
        ItemRecord: Record Item;
        VFullFileName: Text[255];
        VOutPutFileLine: Text[255];
        VLineOutputFile: File;
        VTab: Code[1];
        VPrintUnitPrice: Text[30];
        VFileName: Text[255];
        NonStockUPC: Code[20];
        VBasePackSize: Decimal;
        VNonStockCommCode: Code[10];
        VItemCommCode: Code[10];
        VZoneK: Decimal;
        VCurrZoneRetail: Decimal;
        VCurrTargetRetail: Decimal;
        VANICAItemNo: Code[10];
        VCurrZone: Code[10];
        VTarget: Code[10];
        Window: Dialog;


    procedure LookupNonStockSeq()
    begin
        NonStockRecord.LockTable;
        NonStockRecord.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        NonStockRecord.SetRange("Vendor Item No.",VLookupNonStock);
        NonStockRecord.SetRange("Manufacturer Code",'G');

        if NonStockRecord.Find('+') then
            begin
                VNonStocksSeqNo := NonStockRecord."Entry No.";
                VNonStockItemNo := NonStockRecord."Item No.";
                VNonStockDescr := NonStockRecord.Description;
                VNoJBGNonStockUpdate := NonStockRecord."Do Not Update JBG Retails";
                //The JBG Catalogue import assigns the UPC from the import to the nonstock item
                NonStockUPC := NonStockRecord."UPC Code for SMS";
                VBasePackSize := NonStockRecord.Pack;
                VNonStockCommCode := NonStockRecord."Commodity Code";
            end
        else
            begin
                currXMLport.Skip;
            end;

        //clear filters
        NonStockRecord.SetRange("Vendor Item No.");
        NonStockRecord.SetRange("Manufacturer Code");
    end;


    procedure LookupCrossReference()
    begin
        CrossReferenceRecord.SetCurrentkey("Cross-Reference No.","Cross-Reference Type");
        CrossReferenceRecord.SetRange("Cross-Reference No.",CheckCrossRefNo);
        CrossReferenceRecord.SetRange("Cross-Reference Type",0);

        if CrossReferenceRecord.Find('+') then
            VCrossItemNo := CrossReferenceRecord."Item No.";

        //Clear filters
        CrossReferenceRecord.SetRange("Cross-Reference No.");
        CrossReferenceRecord.SetRange("Cross-Reference Type");
    end;


    procedure LookupItemRecord()
    begin
        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",VNonStockItemNo);

        if ItemRecord.Find('+') then
            begin
                VDoNotUpdateJBG := ItemRecord."Do Not Update JBG Retails";
                VItemDescr := ItemRecord.Description;
                VItemBlocked := ItemRecord.Blocked;
                VItemDropShip := ItemRecord."Drop Ship Item";
                VItemCommCode := ItemRecord."Commodity Code";
            end;
    end;


    procedure ClearNonStockSMSFlags()
    begin
        //CS 12/6/11 : This trigger added to clear SMS flags when price changes.
        NonStockRecord.SetCurrentkey("Item No.");
        NonStockRecord.SetRange("Item No.",VANICAItemNo);

        if NonStockRecord.Find('+') then
            begin
                //Clear the price file created flags so the SMS update will consider all items
                NonStockRecord."Price Files Created" := false;
                NonStockRecord.Modify(true);
            end;

        //clear filter
        Clear(NonStockRecord);
    end;


    procedure ClearItemSMSFlags()
    begin
        //CS 12/6/11 : This trigger added to clear SMS flags when price changes.
        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",VANICAItemNo);

        if ItemRecord.Find('+') then
            begin
                //Clear the price file created flags so the SMS update will consider all items
                ItemRecord."Price Files Created" := false;
                ItemRecord.Modify(true);
            end;


        //clear filter
        ItemRecord.SetRange("No.");
    end;


    procedure GetTargetRetail()
    begin
        //This is replacing the old GetZoneRetail function.

        NonstockTargetRetail.SetCurrentkey("Entry No.",UPC,Target);
        NonstockTargetRetail.SetRange("Entry No.",VNonStocksSeqNo);
        NonstockTargetRetail.SetRange(UPC,NonStockUPC);
        NonstockTargetRetail.SetRange(Target,VTarget);

        if NonstockTargetRetail.Find('-') then
            VCurrTargetRetail := NonstockTargetRetail.Retail;

        Clear(NonstockTargetRetail);
    end;


    procedure LookupTarget()
    begin
        JBGtoTarget.SetCurrentkey("JBG Store No.");
        JBGtoTarget.SetRange("JBG Store No.",VStoreNumber);

        if JBGtoTarget.Find('-') then
            VTarget := JBGtoTarget.Target
        else
            Error('Store Number Is Not Valid %1',VStoreNumber);
    end;


    procedure CreateNonstockTargetRetail()
    begin
        //CS 11-08-16: Changed this function to create a Nonstock Target Retail record, instead of Zone Retail.
        NonstockTargetRetail.SetCurrentkey("Entry No.",UPC,Target);
        NonstockTargetRetail.SetRange("Entry No.",VNonStocksSeqNo);
        NonstockTargetRetail.SetRange(UPC,NonStockUPC);
        NonstockTargetRetail.SetRange(Target,VTarget);

        if NonstockTargetRetail.Find('+') then
            begin
                //Update existing record
                NonstockTargetRetail.Retail := VTargetRetail;
                NonstockTargetRetail.Modify(true);

                //CS 05-18-20: Added the following two IFs for new KEB and ARC pricing.
                //==============>
                if VTarget = 'Z01' then
                    begin
                        NonstockTargetRetail.SetRange("Entry No.",VNonStocksSeqNo);
                        NonstockTargetRetail.SetRange(UPC,NonStockUPC);
                        NonstockTargetRetail.SetRange(Target,'KEB');

                        if NonstockTargetRetail.Find('+') then
                            begin
                                //NonstockTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01));
                                NonstockTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01)*0.9); // -10%
                                NonstockTargetRetail.Modify(true);
                            end
                        else
                            begin
                                //Create New Record
                                NonstockTargetRetail.Init;
                                NonstockTargetRetail."Entry No." := VNonStocksSeqNo;
                                NonstockTargetRetail.UPC := NonStockUPC;
                                NonstockTargetRetail.Target := 'KEB';
                                NonstockTargetRetail.Insert(true);
                                //NonstockTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01));
                                NonstockTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01)*0.9); // -10%
                                NonstockTargetRetail.Modify(true);
                            end
                    end;

                if VTarget = 'Z0N' then
                    begin
                        NonstockTargetRetail.SetRange("Entry No.",VNonStocksSeqNo);
                        NonstockTargetRetail.SetRange(UPC,NonStockUPC);
                        NonstockTargetRetail.SetRange(Target,'ARC');

                        if NonstockTargetRetail.Find('+') then
                            begin
                                NonstockTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01)*1.07);
                                NonstockTargetRetail.Modify(true);
                            end
                        else
                            begin
                                //Create New Record
                                NonstockTargetRetail.Init;
                                NonstockTargetRetail."Entry No." := VNonStocksSeqNo;
                                NonstockTargetRetail.UPC := NonStockUPC;
                                NonstockTargetRetail.Target := 'ARC';
                                NonstockTargetRetail.Insert(true);
                                NonstockTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01)*1.07);
                                NonstockTargetRetail.Modify(true);
                            end

                    end;

                //<=============
            end
        else
            begin
                //Create New Record
                NonstockTargetRetail.Init;
                NonstockTargetRetail."Entry No." := VNonStocksSeqNo;
                NonstockTargetRetail.UPC := NonStockUPC;
                NonstockTargetRetail.Target := VTarget;
                NonstockTargetRetail.Insert(true);
                NonstockTargetRetail.Retail := VTargetRetail;
                NonstockTargetRetail.Modify(true);

            end;

        Clear(NonstockTargetRetail);
    end;


    procedure CreateItemTargetRetail()
    begin
        //CS 11-08-16: Changed this function to creat a Nonstock Target Retail record, instead of Zone Retail.
        ItemTargetRetail.SetCurrentkey("Item No.",UPC,Target);
        ItemTargetRetail.SetRange("Item No.",VNonStockItemNo);
        ItemTargetRetail.SetRange(UPC,NonStockUPC);
        ItemTargetRetail.SetRange(Target,VTarget);

        if ItemTargetRetail.Find('+') then
            begin
                //Update existing record
                ItemTargetRetail.Retail := VTargetRetail;
                ItemTargetRetail.Modify(true);

                //CS 05-18-20: Added section below for new KEB and ARC pricing.
                //===============>
                if VTarget = 'Z01' then
                    begin
                        ItemTargetRetail.SetRange("Item No.",VNonStockItemNo);
                        ItemTargetRetail.SetRange(UPC,NonStockUPC);
                        ItemTargetRetail.SetRange(Target,'KEB');

                        if ItemTargetRetail.Find('+') then
                            begin
                                //ItemTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01)); // Normal
                                ItemTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01)*0.9); //-10%
                                ItemTargetRetail.Modify(true);
                            end
                        else
                            begin
                                //Create New Record
                                ItemTargetRetail.Init;
                                ItemTargetRetail."Item No." := VNonStockItemNo;
                                ItemTargetRetail.UPC := NonStockUPC;
                                ItemTargetRetail.Target := 'KEB';
                                ItemTargetRetail.Insert(true);
                                //ItemTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01)); // Normal
                                ItemTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01)*0.9); // -10%
                                ItemTargetRetail.Modify(true);
                            end
                    end;

                if VTarget = 'Z0N' then
                    begin
                        ItemTargetRetail.SetRange("Item No.",VNonStockItemNo);
                        ItemTargetRetail.SetRange(UPC,NonStockUPC);
                        ItemTargetRetail.SetRange(Target,'ARC');

                        if ItemTargetRetail.Find('+') then
                            begin
                                ItemTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01)*1.04);
                                ItemTargetRetail.Modify(true);
                            end
                        else
                            begin
                                //Create New Record
                                ItemTargetRetail.Init;
                                ItemTargetRetail."Item No." := VNonStockItemNo;
                                ItemTargetRetail.UPC := NonStockUPC;
                                ItemTargetRetail.Target := 'ARC';
                                ItemTargetRetail.Insert(true);
                                ItemTargetRetail.Retail := RetailRounding(ROUND(VTargetRetail,0.01)*1.04);
                                ItemTargetRetail.Modify(true);
                            end
                    end;

                //<==============
            end
        else
            begin
                //Create New Record
                ItemTargetRetail.Init;
                ItemTargetRetail."Item No." := VNonStockItemNo;
                ItemTargetRetail.UPC := NonStockUPC;
                ItemTargetRetail.Target := VTarget;
                ItemTargetRetail.Insert(true);
                ItemTargetRetail.Retail := VTargetRetail;
                ItemTargetRetail.Modify(true);
             end;

        Clear(ItemTargetRetail);
    end;


    procedure CreateItemUPCEntries()
    begin
        //First make sure the nonstock UPC entries exist on the item UPC table
        NonStockUPCTable.SetCurrentkey ("Nonstock Entry No.");
        NonStockUPCTable.SetRange("Nonstock Entry No.", VNonStocksSeqNo);

        if NonStockUPCTable.Find('-') then
            repeat
                ItemUPCTable.SetCurrentkey ("Item No.",UPC);
                ItemUPCTable.SetRange("Item No.", VNonStockItemNo);
                ItemUPCTable.SetRange(UPC, NonStockUPCTable.UPC);
                if ItemUPCTable.Find('-') then
                    begin
                        ItemUPCTable."Pack Descrip" := NonStockUPCTable."Pack Desc";
                        ItemUPCTable."Pack Divider" := NonStockUPCTable."Pack Divider";
                        ItemUPCTable."Last Date Updated" := Today();
                        ItemUPCTable.Modify(true);
                    end
                else
                    begin
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


    procedure RetailRounding(_Amount: Decimal): Decimal
    var
        _Decimals: Decimal;
        _Amount2: Decimal;
    begin

        //>> CS 05-18-20: Copied from Item Table, to round KEB and ARC prices.

        if _Amount < 10  then
          begin
            if ROUND(_Amount,1) = ROUND(_Amount) then
              exit(_Amount + 0.05);
            _Decimals := (_Amount * 100) - ROUND((_Amount*100),100,'<');
            _Decimals := _Decimals - ROUND(_Decimals,10,'<');
            if _Decimals > 5 then
              exit(ROUND(_Amount,0.1,'>') - 0.01)
            else
              exit(ROUND(_Amount,0.05,'>'));
          end;
        if (_Amount >= 10) and (_Amount < 100) then
          if _Amount - ROUND(_Amount,0.1) = 0 then
            exit(_Amount)
          else
            exit(ROUND(_Amount,0.1,'>') - 0.01);
        if (_Amount >= 100) and (_Amount < 1000) then
          if _Amount - ROUND(_Amount,1.0) = 0 then
            exit(_Amount)
          else
            exit(ROUND(_Amount,1.0,'>') - 0.01);
        if _Amount >= 1000 then
          exit(ROUND(_Amount,1.0,'='));
        //<<
    end;
}

