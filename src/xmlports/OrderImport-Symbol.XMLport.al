XmlPort 50005 "Order Import - Symbol"
{
    // This program imports orders from the Symbol unit program
    //   into the Telxon Input File for review and subsequent order creation.
    //   The import file is at \\filestore\EDI\Symbol\SYMProc\SYMOrder.txt

    Caption = 'Order Import - Symbol';
    Direction = Import;
    FileName = '\\filestore\EDI\Symbol\SYMProc\SYMOrder.txt';
    Format = FixedText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer;Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(InputRecord)
                {
                    Width = 40;
                }

                trigger OnBeforeInsertRecord()
                begin
                    //For Status Box
                    begin
                      Window.Update(1,TCustomerNumber);
                    end;

                    ItemFound := false;
                    CheckNSItemNo := '';
                    TRecordType := CopyStr(InputRecord,1,1);
                    if TRecordType = '' then currXMLport.Skip;
                    if TRecordType = 'Z' then currXMLport.Skip;

                    //Check first record in the file to see if it is an S Record
                    if VFirstRecord = true then
                    begin
                       if TRecordType <> 'S' then
                       begin
                       Error('First record in the file is not a store record %1',InputRecord);
                       end;
                    end;

                    //Convert Different Types of Records
                    if TRecordType = 'S' then
                    begin
                    //Check for previous record - should be an O record except for first record
                       if VFirstRecord <> true then
                       begin
                          if VPrevRecType <> 'O' then
                          Error('S record not preceded by O record %1',InputRecord);
                       end;

                    TCust := CopyStr(InputRecord,2,7);
                    LookupCustomer;
                    VFirstRecord := false;
                    VPrevRecType := TRecordType;
                    currXMLport.Skip;
                    end;

                    if TRecordType = 'D' then
                    begin
                       //Check see if this followed a store
                       if VPrevRecType <> 'S' then
                          Error('D record not preceded by S record %1',InputRecord);

                      VTemp := CopyStr(InputRecord,2,8);
                      if Evaluate(TDate,VTemp) = false then
                      begin
                      TInvalidDate := true;
                      end
                      else
                      begin
                      TInvalidDate := false;
                      Evaluate(TDate,VTemp);
                      //Added for Y2K
                      TDate := Today;
                      end;
                    VFirstRecord := false;
                    VPrevRecType := TRecordType;
                    currXMLport.Skip;
                    end;

                    if TRecordType = 'N' then
                    begin
                       //Check see if this record followed a date or end vendor record
                       if (VPrevRecType <> 'O') and (VPrevRecType <> 'D') then
                          Error('N record not preceded by D or O record %1',InputRecord);
                      TInvalidVendor := false;
                      TVendor := CopyStr(InputRecord,2,4);
                      case TVendor of
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
                      if TVendor = '1000' then IsItem := true
                      else IsItem := false;
                      VFirstRecord := false;
                      VPrevRecType := TRecordType;
                      currXMLport.Skip;
                    end;

                    if TRecordType = 'I' then
                    begin
                      TInvalidQuantity := false;
                      P := StrPos(InputRecord,'Q');

                      //check for lower case Q
                      if P < 3 then P := StrPos(InputRecord,'q');

                      //check for invalid I record format
                      if P < 3 then
                      begin
                      Message('Invalid I Record Format - Item Skipped %1',InputRecord);
                      currXMLport.Skip;
                      end;

                      VTemp1 := CopyStr(InputRecord,P+1,20);
                      //Check for invalid quantities
                      if Evaluate(TQuantity,VTemp1) = false then
                      TInvalidQuantity := true
                      else Evaluate(TQuantity,VTemp1);
                      TItem := CopyStr(InputRecord,2,P-2);
                      //Flag zero quantities
                      if TQuantity = 0 then TInvalidQuantity := true;

                      //LCC 7-13-10, added routine to exclude UPCs from reformatting
                      //If the item number is 8 digits, then reformat to ANICA number, otherwise leave it alone.
                      if (IsItem = true) and (P = 10) then
                      begin
                      TItem := CopyStr(TItem,1,4) + '-' + CopyStr(TItem,5,4);
                      end;

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

                      //IF ItemFound = FALSE THEN
                      //BEGIN
                      //TOrderItemNo := '';
                      //TImportError := TRUE;
                      //TErrorRemark := 'Item not found';
                      //END;

                      CreateTelxonRecord;
                    VPrevRecType := TRecordType;
                    end;

                    VPrevRecType := TRecordType;
                    VFirstRecord := false;
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

        //Old Method
        //SHELL('\\filestore\EDI\Symbol\SYMProc\CopySYM.bat');

        //NEW VERSION for TEST
        //_CommandLine := '"\\filestore\TESTEDI\Symbol\SYMProc\CopySYM.bat"';
        _CommandLine := '"\\filestore\EDI\Symbol\SYMProc\CopySYM.bat"';
        _DummyInt := 1;
        _RunModally := false;

        Create(wSHShell,false,ISSERVICETIER);
        wSHShell.Run(_CommandLine,_DummyInt,_RunModally);
        Clear(wSHShell);
    end;

    trigger OnPostXmlPort()
    begin
        //Run DOS batch file to copy all files to backup folder

        //OLD method
        //SHELL('\\filestore\EDI\Symbol\SYMProc\MoveFileSYM.bat');

        //NEW VERSION for TEST
        //_CommandLine := '"\\filestore\TESTEDI\Symbol\SYMProc\MoveFileSYM.bat"';
        _CommandLine := '"\\filestore\EDI\Symbol\SYMProc\MoveFileSYM.bat"';
        _DummyInt := 1;
        _RunModally := false;

        Create(wSHShell,false,ISSERVICETIER);
        wSHShell.Run(_CommandLine,_DummyInt,_RunModally);
        Clear(wSHShell);





        ClearAll;

        //Backup the Telxon Input File Open Items
        Report.Run(Report::"Backup Telxon Open Items");

        Message('Symbol Files Successfully Imported');
    end;

    trigger OnPreXmlPort()
    begin
        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
        end;

        VFirstRecord := true;
    end;

    var
        TelxonInputFile: Record "Telxon Input File";
        TSequence: Integer;
        TRecordType: Text;
        TStore: Text;
        TDate: Date;
        TVendor: Text;
        TItem: Text;
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
        VStatus: InStream;
        VFile: File;
        ItemFound: Boolean;
        IsItem: Boolean;
        IsCross: Boolean;
        CheckNSItemNo: Text;
        NonStockRecord: Record "Nonstock Item";
        ItemRecord: Record Item;
        VFirstRecord: Boolean;
        VPrevRecType: Text;
        TCust: Text;
        Window: Dialog;
        _CommandLine: Text[1024];
        wSHShell: Automation WshShell;
        _DummyInt: Integer;
        _RunModally: Boolean;

    local procedure GetSequenceNo()
    begin
        TelxonInputFile.LockTable;
        TelxonInputFile.SetCurrentkey(Sequence);
        TelxonInputFile.SetRange(Sequence);
        if TelxonInputFile.Find('+') then
        TSequence := TelxonInputFile.Sequence + 10
        else TSequence := 10;
    end;

    local procedure CreateTelxonRecord()
    begin
        GetSequenceNo;
        TelxonInputFile.LockTable;
        TelxonInputFile.SetCurrentkey("Batch Name",Sequence);
        TelxonInputFile.Init;
        TelxonInputFile."Batch Name" := 'SYMBOL';
        TelxonInputFile.Sequence := TSequence;
        TelxonInputFile.Insert(true);
        TelxonInputFile.Store := TStore;
        //TelxonInputFile.Date := TODAY;
        TelxonInputFile.Date := TDate;
        TelxonInputFile."Telxon Vendor" := TVendor;
        TelxonInputFile."Import Item No." := TItem;
        TelxonInputFile."Order Item No." := TOrderItemNo;
        TelxonInputFile.Quantity := TQuantity;
        //Added 1-13-11
        TelxonInputFile."Import Quantity" := TQuantity;
        TelxonInputFile."Customer Number" := TCustomerNumber;
        TelxonInputFile."Order Type" := 1;
        TelxonInputFile."Import Error" := TImportError;
        TelxonInputFile."Error Remark" := TErrorRemark;
        TelxonInputFile."Purchaser Code" := 'TLX';
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
        TCustomerNumber := CustomerRecord."No.";
        TStore := CustomerRecord."Telxon Store number";
        TInvalidCustomer := false;
        end
        else TInvalidCustomer := true;
    end;
}

