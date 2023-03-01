Report 50087 "Void Rebate Checks"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Void Rebate Check Table";"Void Rebate Check Table")
        {
            column(ReportForNavId_5177; 5177)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Skip checks alread processed - Make a key for this
                if "AP Credit Processed" = true then CurrReport.Skip;
                if "Void Rebate Check Table"."Void Date" = 0D then
                  begin
                  Message('Missing date Check No %1',"Check No.");
                  CurrReport.Skip;
                  end;

                VCheckNo := "Void Rebate Check Table"."Check No.";

                //Get the related check info and see if it has been voided
                LookupCheck;

                LookupVendorLedgerEntry;

                CreatePurchaseJournalEntry;

                //Mark processed records for final update
                Mark(true);
            end;

            trigger OnPostDataItem()
            begin
                //Mark all processed items
                "Void Rebate Check Table".SetRange("Check No.");//clear filter
                "Void Rebate Check Table".MarkedOnly(true);
                "Void Rebate Check Table".ModifyAll("AP Credit Processed",true,false);
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

    trigger OnPreReport()
    begin
        //Next Document Number
        VendorLedgerEntry1.SetCurrentkey("Document Type","Document No.");
        VendorLedgerEntry1.SetRange("Document Type",2);
        VendorLedgerEntry1.SetRange("Document Type",3);
        VendorLedgerEntry1.SetRange("Document No.",'Z000001','Z999999');
        if VendorLedgerEntry1.Find('+') then
        VDocumentNo := VendorLedgerEntry1."Document No."
        else Error('Next Document Number Error');
    end;

    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntry1: Record "Vendor Ledger Entry";
        CheckLedgerEntry: Record "Check Ledger Entry";
        GenJnlLine1: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        VCheckNo: Code[20];
        VVendorNo: Code[20];
        VAmount: Decimal;
        VDocumentNo: Code[20];
        VApplyDocNo: Code[20];
        VExternalDocNo: Code[20];


    procedure LookupCheck()
    begin
        VVendorNo := '';
        VAmount := 0;
        CheckLedgerEntry.SetCurrentkey("Bank Account No.","Entry Status","Check No.");
        CheckLedgerEntry.SetRange("Bank Account No.",'MAIN');
        CheckLedgerEntry.SetRange("Check No.",VCheckNo);
        if CheckLedgerEntry.Find('+') then
        begin
          //Check to see that the check was voided, if not, skip this one
          if ((CheckLedgerEntry."Entry Status" = 4) and (CheckLedgerEntry.Open = false)) then
          begin
          //This has been voided
          VVendorNo := CheckLedgerEntry."Bal. Account No.";
          VAmount := CheckLedgerEntry.Amount;
          end
          else
          begin
          Message('This check has not been voided %1',VCheckNo);
          CurrReport.Skip
          end;
        end;
    end;


    procedure LookupVendorLedgerEntry()
    begin
        VApplyDocNo := '';
        VendorLedgerEntry.SetCurrentkey("Document Type","Document No.","Vendor No.");
        VendorLedgerEntry.SetRange("Document Type",1);//payment
        VendorLedgerEntry.SetRange("Document No.",VCheckNo);
        VendorLedgerEntry.SetRange("Vendor No.",VVendorNo);
        if VendorLedgerEntry.Find('-') then
        begin
        //Find the original payment entry to get the apply to doc number
          repeat
          begin
              if VendorLedgerEntry."Source Code" = 'PAYMENTJNL' then
              begin
              VApplyDocNo := CopyStr(VendorLedgerEntry.Description,20,7);
              end;
          VendorLedgerEntry.Next;
          end
          until VendorLedgerEntry.Next = 0;
        end;
        VendorLedgerEntry.SetRange("Document Type");//Clear Filters
        VendorLedgerEntry.SetRange("Document No.");
        VendorLedgerEntry.SetRange("Vendor No.");

        //Get External Doc no for application
        if VApplyDocNo <> '' then
        begin
          VExternalDocNo := '';
          VendorLedgerEntry.SetCurrentkey("Document Type","Document No.","Vendor No.");
          VendorLedgerEntry.SetRange("Document Type",2);//invoice
          VendorLedgerEntry.SetRange("Document No.",VApplyDocNo);
          VendorLedgerEntry.SetRange("Vendor No.",VVendorNo);
          if VendorLedgerEntry.Find('+') then VExternalDocNo := VendorLedgerEntry."External Document No.";
        end
        else Message('Count not find apply to doc for check no %1',VCheckNo);
    end;


    procedure GetLineNumber()
    begin
        //Line Number
        GenJnlLine2.SetRange(GenJnlLine2."Journal Template Name",GenJnlLine1."Journal Template Name");
        GenJnlLine2.SetRange(GenJnlLine2."Journal Batch Name",GenJnlLine1."Journal Batch Name");
        if GenJnlLine2.Find('+') then
           begin
           GenJnlLine1."Line No." := GenJnlLine2."Line No." + 10;
           end
        else
           begin
           GenJnlLine1."Line No." := 10;
           end;
    end;


    procedure CreatePurchaseJournalEntry()
    begin
        with GenJnlLine1 do
        begin
                  Init;
                  "Journal Template Name" := 'PURCH';
                  "Journal Batch Name" := 'REB VOID';
                  GetLineNumber;
                  "Shortcut Dimension 1 Code" := 'ANICA';
                  Insert(true);
                  "Posting Date" := "Void Rebate Check Table"."Void Date";
                  Validate("Posting Date");
                  "Document Date" := "Void Rebate Check Table"."Void Date";
                  Validate("Document Date");
                  "Due Date" := "Void Rebate Check Table"."Void Date";
                  "Document Type" := 3;//Credit Memo
                  Validate("Document Type");
                  VDocumentNo := IncStr(VDocumentNo);
                  "Document No." := VDocumentNo;
                  Validate("Document No.");
                  "Account Type" := 2;//Vendor
                  Validate("Account Type");
                  "Account No." := VVendorNo;
                  Validate("Account No.");
                  "Bal. Account Type" := 0;//General Ledger
                  Validate("Bal. Account Type");
                  "Bal. Account No." := '144-01';//Rebates to be billed
                  Validate("Bal. Account No.");
                  if VApplyDocNo <> '' then
                    begin
                    "Applies-to Doc. Type" := 2;//invoice
                    "Applies-to Doc. No." := VApplyDocNo;
                    "External Document No." := VExternalDocNo;
                    end;
                  Amount :=   VAmount;
                  Validate(Amount);
                  Validate("Shortcut Dimension 1 Code");
                  Modify(true);
        end;
    end;
}

