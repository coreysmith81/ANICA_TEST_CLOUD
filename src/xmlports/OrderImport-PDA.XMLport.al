XmlPort 50002 "Order Import - PDA"
{
    // This program imports orders from the PDA and Symbol units.
    // The import file is \\filestore\EDI\PDA\PDAProc\PDAOrder.txt

    Direction = Import;
    FieldDelimiter = '~';
    FieldSeparator = '|';
    FileName = '\\filestore\EDI\PDA\PDAProc\PDAOrder.txt';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer;Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(TCust)
                {
                }
                textelement(VDate)
                {
                }
                textelement(TVendor)
                {
                }
                textelement(TUPC)
                {
                }
                textelement(TItem)
                {
                }
                textelement(VQty)
                {
                }
                textelement(TVendor2)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    //For Status Box
                    begin
                      Window.Update(1,TCustomerNumber);
                    end;

                    ItemFound := false;

                    if StrLen(TUPC) > 13 then
                        TUPC := CopyStr(TUPC,1,13);

                    LookupCustomer;
                    VFirstRecord := false;

                      VTemp := VDate;
                      if Evaluate(TDate,VTemp) = false then
                      begin
                      TInvalidDate := true;
                      end
                      else
                      begin
                      TInvalidDate := false;
                      end;

                    TInvalidVendor := false;

                      case TVendor2 of
                      '1000': TManu := '';
                      '2000': TManu := 'VFG';
                      '3000': TManu := 'G';
                      '4000': TManu := 'S';
                      '5000': TManu := 'M';
                      '6000': TManu := 'VIP';
                      '7000': TManu := 'Y';
                      '8000': TManu := 'P';
                      '9000': TManu := 'C';
                      else TInvalidVendor := true
                      end;
                      if TVendor2 = '1000' then IsItem := true
                      else IsItem := false;


                       VTemp1 := VQty;
                      //Check for invalid quantities
                      if Evaluate(TQuantity,VTemp1) = false then
                      TInvalidQuantity := true
                      else
                      TInvalidQuantity := false;
                      //Flag zero quantities
                      if TQuantity = 0 then TInvalidQuantity := true;


                      //Check error status before creating Telxon record
                      if TInvalidDate = true then
                      begin
                      //Don't mark as an error, run the record anyway
                      TDate := Today;
                      TImportError := false;
                      TErrorRemark := 'Invalid Date Used Todays Date';
                      end
                      else
                      begin
                      //Reset error values
                      TImportError := false;
                      TErrorRemark := '';
                      end;

                      if TInvalidCustomer = true then
                      begin
                      TCustomerNumber := '';
                      TImportError := true;
                      TErrorRemark := 'Invalid Store Number';
                      end;

                      if TInvalidVendor = true then
                      begin
                      TImportError := true;
                      TErrorRemark := 'Invalid Vendor Number';
                      end;

                      if TInvalidQuantity = true then
                      begin
                      TQuantity := 0;
                      TImportError := true;
                      TErrorRemark := 'Invalid Quantity';
                      end;


                      CreateTelxonRecord;
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

        //Start with a blank file to avoid dup processing
        //Run DOS batch file to copy all files to D:\TELXPROC\TELXON.TXT

        //Old version
        //SHELL('\\filestore\EDI\PDA\PDAProc\COPYPDA.BAT');

        //NEW VERSION for TEST
        //_CommandLine := '"\\filestore\TESTEDI\PDA\PDAProc\COPYPDA.BAT"';
        _CommandLine := '"\\filestore\EDI\PDA\PDAProc\COPYPDA.BAT"';
        _DummyInt := 1;
        _RunModally := false;

        Create(wSHShell,false,ISSERVICETIER);
        wSHShell.Run(_CommandLine,_DummyInt,_RunModally);
        Clear(wSHShell);
    end;

    trigger OnPostXmlPort()
    begin
        //Run DOS batch file to copy all files to backup folder

        //Old Version
        //SHELL('\\filestore\EDI\PDA\PDAProc\MoveFilePDA.BAT');

        //NEW VERSION for TEST
        //_CommandLine := '"\\filestore\TESTEDI\PDA\PDAProc\MoveFilePDA.BAT"';
        _CommandLine := '"\\filestore\EDI\PDA\PDAProc\MoveFilePDA.BAT"';
        _DummyInt := 1;
        _RunModally := false;

        Create(wSHShell,false,ISSERVICETIER);
        wSHShell.Run(_CommandLine,_DummyInt,_RunModally);
        Clear(wSHShell);







        ClearAll;

        //Backup the Telxon input table
        Report.Run(Report::"Backup Telxon Open Items");

        Message('PDA Orders Successfully Imported');
    end;

    trigger OnPreXmlPort()
    begin
        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Orders for #1######');
        end;
    end;

    var
        InputRecord: Text;
        TelxonInputFile: Record "Telxon Input File";
        TSequence: Integer;
        TRecordType: Text;
        TStore: Text;
        TDate: Date;
        TQuantity: Decimal;
        TCustomerNumber: Text;
        TImportError: Boolean;
        TErrorRemark: Text;
        TInvalidVendor: Boolean;
        TInvalidCustomer: Boolean;
        TInvalidDate: Boolean;
        TInvalidQuantity: Boolean;
        TManu: Text;
        TOrderItemNo: Text;
        VTemp: Text;
        VTemp1: Text;
        P: Integer;
        VStatus: Integer;
        VFile: File;
        ItemFound: Boolean;
        IsItem: Boolean;
        IsCross: Boolean;
        CheckNSItemNo: Text;
        NonStockCreate: Codeunit "Catalog Item Management";
        NonStockRecord: Record "Nonstock Item";
        ItemRecord: Record Item;
        VFirstRecord: Boolean;
        VPrevRecType: Text;
        Window: Dialog;
        _CommandLine: Text[1024];
        wSHShell: Automation WshShell;
        _DummyInt: Integer;
        _RunModally: Boolean;

    local procedure GetSequenceNo()
    begin
        //7-8-15 LCC removed lock table
        //TelxonInputFile.LOCKTABLE;
        TelxonInputFile.SetCurrentkey(Sequence);
        TelxonInputFile.SetRange(Sequence);
        if TelxonInputFile.Find('+') then
        TSequence := TelxonInputFile.Sequence + 10
        else TSequence := 10;
    end;

    local procedure CreateTelxonRecord()
    begin
        GetSequenceNo;
        //7-8-15 LCC removed lock table
        //TelxonInputFile.LOCKTABLE;
        TelxonInputFile.SetCurrentkey("Batch Name",Sequence);
        TelxonInputFile.Init;
        TelxonInputFile."Batch Name" := 'PDA';
        TelxonInputFile.Sequence := TSequence;
        TelxonInputFile.Insert(true);
        TelxonInputFile.Store := TStore;
        if TDate < 20170101D then
            TelxonInputFile.Date := Today
        else
            TelxonInputFile.Date := TDate;
        TelxonInputFile."Telxon Vendor" := TVendor2;
        TelxonInputFile."Import Item No." := TItem;
        TelxonInputFile."Order Item No." := TOrderItemNo;
        TelxonInputFile.Quantity := TQuantity;
        //Added 1-13-11
        TelxonInputFile."Import Quantity" := TQuantity;
        TelxonInputFile."Customer Number" := TCustomerNumber;
        TelxonInputFile."Order Type" := 1;
        TelxonInputFile."Import Error" := TImportError;
        TelxonInputFile."Error Remark" := TErrorRemark;
        TelxonInputFile."Purchaser Code" := 'PDA';
        TelxonInputFile.Manufacturer := TManu;
        TelxonInputFile.Modify;
    end;

    local procedure LookupCustomer()
    var
        CustomerRecord: Record Customer;
    begin
        CustomerRecord.SetCurrentkey("No.");
        CustomerRecord.SetRange("No.",TCust);
        if CustomerRecord.Find('+') then
        begin
        //MESSAGE('customer no. %1',TCust);
        TCustomerNumber := CustomerRecord."No.";
        TStore := CustomerRecord."Telxon Store number";
        TInvalidCustomer := false;
        end
        else TInvalidCustomer := true;
    end;

    local procedure LookupItemNumber()
    begin

        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",TItem);
        if ItemRecord.Find('+') then
        begin
        ItemFound := true;
        TOrderItemNo := TItem;
        end
        else ItemFound := false;
        //Clear filter
        ItemRecord.SetRange("No.");
    end;

    local procedure LookupNonStock()
    begin
        NonStockRecord.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        NonStockRecord.SetRange("Vendor Item No.",TItem);
        NonStockRecord.SetRange("Manufacturer Code", TManu);
        if NonStockRecord.Find('+') then
        begin
        ItemFound := true;
        CheckNSItemNo := NonStockRecord."Item No.";
        end
        else
        begin
        ItemFound := false;
        CheckNSItemNo := '';
        end;
        //Clear filters
        NonStockRecord.SetRange("Vendor Item No.");
        NonStockRecord.SetRange("Manufacturer Code");
        //IF Item has not been created, create it
        if (CheckNSItemNo = '') and (ItemFound = true) then
        begin
        NonStockCreate.NonstockAutoItem(NonStockRecord);
        CheckNSItemNo := NonStockRecord."Item No.";
        end;
        //Move to Order ITem No
        TOrderItemNo := CheckNSItemNo;
    end;

    local procedure LookupCrossReference()
    var
        CrossReferenceRecord: Record "Item Cross Reference";
    begin

        IsCross := false;
        CrossReferenceRecord.SetCurrentkey("Cross-Reference No.");
        CrossReferenceRecord.SetRange("Cross-Reference No.",TItem);
        if CrossReferenceRecord.Find('+') then
          begin
          TOrderItemNo := CrossReferenceRecord."Item No.";
          ItemFound := true;
          IsCross := true;
          end
        else ItemFound := false;
        //Check to see if stock items exist for cross
        if (ItemFound = true) and (IsCross = true) then
          begin
          ItemRecord.SetCurrentkey("No.");
          ItemRecord.SetRange("No.",TOrderItemNo);
             if ItemRecord.Find('+') then
             ItemFound := true
             else ItemFound := false;
        end;
        //Clear filters
        ItemRecord.SetRange("No.");
    end;
}

