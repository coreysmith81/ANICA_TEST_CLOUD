Codeunit 50104 "Item-Post to Telxon"
{
    // // MAS: Posting routine for ItemJnlLines to be posted to the Telxon Input File.
    //         Modified, regarding new Telxon Recurring Journal  // 04/11/2000
    // // MAS: Added filter (Quantity <> 0) in 'TelxonItemPostBatch Function  // 11/28/00
    //   //ANICA 10-25-06 Added Item Variant to Telxon

    TableNo = "Item Journal Line";

    trigger OnRun()
    begin
        ItemJnlLine.Copy(Rec);
        Code;
        Rec.Copy(ItemJnlLine);
    end;

    var
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        TempJnlBatchName: Code[10];
        TelxonInputFile: Record "Telxon Input File";
        _LastNo: Integer;
        TelxonVendorCodes: Record "Telxon Vendor Code";

    local procedure "Code"()
    begin
        //Removed LOCKTABLE 8-24-15
        //TelxonInputFile.LOCKTABLE;

        if TelxonInputFile.Find('+') then
            _LastNo := TelxonInputFile.Sequence
        else
            _LastNo := 0;

        //with ItemJnlLine do begin
        ItemJnlTemplate.Get(ItemJnlLine."Journal Template Name");
        ItemJnlTemplate.TestField("Force Posting Report", false);
        if ItemJnlTemplate.Recurring and (ItemJnlLine.GetFilter("Posting Date") <> '') then
            ItemJnlLine.FieldError("Posting Date", 'cannot be filtered when posting recurring journals');

        if not Confirm('Do you want to post the telxon items?', false) then
            exit;

        TempJnlBatchName := ItemJnlLine."Journal Batch Name";

        TelxonItemPostBatch;

        if ItemJnlLine."Line No." = 0 then
            Message('There is nothing to post.')
        else
            if TempJnlBatchName = ItemJnlLine."Journal Batch Name" then
                Message('The telxon items were successfully posted.')
            else
                Message(
                  'The telxon items were successfully posted. ' +
                  'You are now in the %1 journal.',
                  ItemJnlLine."Journal Batch Name");

        if not ItemJnlLine.Find('=><') or (TempJnlBatchName <> ItemJnlLine."Journal Batch Name") then begin
            ItemJnlLine.Reset;
            ItemJnlLine.FilterGroup(2);
            ItemJnlLine.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
            ItemJnlLine.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
            ItemJnlLine.FilterGroup(0);
            ItemJnlLine."Line No." := 1;
        end;
        //end;
    end;


    procedure TelxonItemPostBatch()
    var
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine2: Record "Item Journal Line";
        ItemJnlLine3: Record "Item Journal Line";
        NoSeries: Record "No. Series" temporary;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt2: array[10] of Codeunit NoSeriesManagement;
        Window: Dialog;
        ItemRegNo: Integer;
        StartLineNo: Integer;
        NoOfRecords: Integer;
        LineCount: Integer;
        LastDocNo: Code[20];
        LastDocNo2: Code[20];
        LastPostedDocNo: Code[20];
        NoOfPostingNoSeries: Integer;
        PostingNoSeriesNo: Integer;
    begin
        ItemJnlLine.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
        ItemJnlLine.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
        //>> MAS 11/28/00
        ItemJnlLine.SetFilter(Quantity, '<> 0');
        //<<

        ItemJnlTemplate.Get(ItemJnlLine."Journal Template Name");
        ItemJnlBatch.Get(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
        if StrLen(IncStr(ItemJnlBatch.Name)) > MaxStrLen(ItemJnlBatch.Name) then
            ItemJnlBatch.FieldError(
              Name,
              StrSubstNo(
                'cannot exceed %1 characters',
                MaxStrLen(ItemJnlBatch.Name)));

        if not ItemJnlLine.Find('=><') then begin
            ItemJnlLine."Line No." := 0;
            exit;
        end;

        Window.Open(
          'Journal Batch Name    #1##########\\' +
          'Posting lines         #3###### @4@@@@@@@@@@@@@');

        Window.Update(1, ItemJnlLine."Journal Batch Name");

        // Check Lines
        LineCount := 0;
        StartLineNo := ItemJnlLine."Line No.";
        repeat
            LineCount := LineCount + 1;
            if ItemJnlLine.Next = 0 then
                ItemJnlLine.Find('-');
        until ItemJnlLine."Line No." = StartLineNo;
        NoOfRecords := LineCount;

        // Post lines to Telxon Input File.
        LineCount := 0;
        LastDocNo := '';
        LastDocNo2 := '';
        LastPostedDocNo := '';
        ItemJnlLine.Find('-');
        repeat
            LineCount := LineCount + 1;
            Window.Update(3, LineCount);
            Window.Update(4, ROUND(LineCount / NoOfRecords * 10000, 1));
            ItemJnlPostToTelxon;
        until ItemJnlLine.Next = 0;

        ItemJnlLine.Init;

        //Delete lines
        //LOCKTABLE(TRUE,TRUE);
        ItemJnlLine2.CopyFilters(ItemJnlLine);
        ItemJnlLine2.SetFilter("Item No.", '<>%1', '');
        if ItemJnlLine2.Find('+') then; // Remember the last line
        if not ItemJnlTemplate.Recurring then
            ItemJnlLine.DeleteAll;
        Commit;
    end;


    procedure ItemJnlPostToTelxon()
    var
        Item: Record Item;
        NonStockItem: Record "Nonstock Item";
        Vendor: Record Vendor;
        Customer: Record Customer;
    begin
        // Posting to Telxon Input File.
        TelxonInputFile.Init;
        _LastNo := _LastNo + 10;
        TelxonInputFile.Sequence := _LastNo;
        TelxonInputFile."Template Name" := ItemJnlLine."Journal Template Name";
        TelxonInputFile."Batch Name" := ItemJnlLine."Journal Batch Name";
        TelxonInputFile.Store := ItemJnlLine.Store;
        TelxonInputFile."Telxon Vendor" := ItemJnlLine."Telxon Vendor No.";
        TelxonInputFile."Import Item No." := ItemJnlLine."Telxon Item No.";
        TelxonInputFile.Quantity := ItemJnlLine.Quantity;
        //CS 03/06/2015: Added "Import Quantity" since it is populated when any other sort of order is imported.
        TelxonInputFile."Import Quantity" := ItemJnlLine.Quantity;
        TelxonInputFile."Order Type" := ItemJnlLine."Order Type 2";
        TelxonInputFile."Purchaser Code" := ItemJnlLine."Salespers./Purch. Code";
        TelxonInputFile.Date := ItemJnlLine."Posting Date";
        //ANICA 10-25-06
        TelxonInputFile."Item Variant" := ItemJnlLine."Telxon Variant Code";

        if ItemJnlLine."Posting Date" <> 0D then
            ItemJnlLine.Validate("Posting Date", CalcDate(ItemJnlLine."Recurring Frequency", ItemJnlLine."Posting Date"));
        if (ItemJnlLine."Recurring Method" = ItemJnlLine."recurring method"::Variable) and
           (ItemJnlLine."Item No." <> '')
          then begin
            ItemJnlLine.Quantity := 0;
            ItemJnlLine."Invoiced Quantity" := 0;
            ItemJnlLine.Amount := 0;
        end;
        ItemJnlLine.Modify;

        TelxonInputFile.Insert;
    end;
}

