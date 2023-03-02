XmlPort 50020 "Bank Deposit Reconciliation"
{
    // This import is used by the accounting department to import cleared deposits
    //   from the bank web site to expedite the reconciliation process.
    //   The imports are at \\filestore\cash report\Monthly Deposits\

    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer;Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(TxtDate)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert posting date
                        if Evaluate(VDate,TxtDate) = false then Message('Invalid Date');
                    end;
                }
                textelement(VBankRoutingNo)
                {
                }
                textelement(VAccountNo)
                {
                }
                textelement(VDebitCredit)
                {
                }
                textelement(VBAITypeCode)
                {
                }
                textelement(VDescrip)
                {
                }
                textelement(TxtAmount)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VAmount,TxtAmount) = false then Message('Invalid Amount');
                    end;
                }
                textelement(VAccountText)
                {
                }
                textelement(VKeyBankRef)
                {
                }
                textelement(TxtOneDayFloat)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VOneDayFloat,TxtOneDayFloat) = false then Message('Invalid Amount');
                    end;
                }
                textelement(Txt2DayFloat)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(V2DayFloat,Txt2DayFloat) = false then Message('Invalid Amount');
                    end;
                }
                textelement(VRef1)
                {
                }
                textelement(VRef2)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    //Clear Variables
                    VBankLedgerLookup := 0;
                    VNavisionStoreNo := '';

                    //Get the Navision store number based on the account number
                    VLookupAccountNo := CopyStr(VAccountText,16,15);
                    LookupCustomerNumber;

                    //First see if a bank rec line matches the recon import
                    BankRecLines.SetCurrentkey("Document Type","Document No.");
                    BankRecLines.SetRange(BankRecLines."Document Type",0); //Deposits
                    BankRecLines.SetRange(BankRecLines."Posting Date",VDate);
                    BankRecLines.SetRange(BankRecLines.Amount,VAmount);
                    if BankRecLines.Find('-') then
                    begin
                      //See if the customer number matches as well
                      VBankLedgerLookup := BankRecLines."Bank Ledger Entry No.";
                      LookupBankLedgerEntry;
                        if VNavisionStoreNo <> VCheckNavStoreNo then
                        begin
                        //Write an error to the error output file
                        VOutputFileLine := 'Store Does Not Match ' + Format(VAmount,13,'<Integer><Decimal,3>') + ' ' +
                            VNavisionStoreNo + ' ' + Format(VDate,0,'<Month>/<Day>/<Year>');
                        VLineOutputFile.Write(VOutputFileLine);
                        end;
                      //Clear the transaction
                      BankRecLines.Cleared := true;
                      BankRecLines."Cleared Amount" := VAmount;
                      BankRecLines.Modify(true);
                    end
                    else
                        begin
                        //The reconciling item didn't match
                        //Write an error to the error output file
                        VOutputFileLine := 'Deposit does not match any open items ' + Format(VAmount,13,'<Integer><Decimal,3>') + ' ' +
                        VNavisionStoreNo + ' ' + Format(VDate,0,'<Month>/<Day>/<Year>');
                        VLineOutputFile.Write(VOutputFileLine);
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

    trigger OnPostXmlPort()
    begin
        //Close spreadsheet file
        VLineOutputFile.Close;

        //For Status Box
        Window.Close;
        Clear(Window);
        Message('Import is Done');
    end;

    trigger OnPreXmlPort()
    begin
        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
        end;

        //Setup a file for an export with the crosses that were updated
        //VFullFileName := '\\filestore\Cash Report\Monthly Deposits\Reconciliation_Errors.txt';
        VFullFileName := '\\filestore\EDI\JBG\JBG Reused Reports\Reconciliation_Errors.txt';
        VLineOutputFile.Create(VFullFileName);
        VLineOutputFile.TextMode(true);
    end;

    var
        BankRecLines: Record "Bank Rec. Line";
        StoreAcctNos: Record "Store Bank Account Numbers";
        BankLedgerEntries: Record "Bank Account Ledger Entry";
        VDate: Date;
        VAmount: Decimal;
        VOneDayFloat: Decimal;
        V2DayFloat: Decimal;
        VBankLedgerLookup: Integer;
        VLookupAccountNo: Text;
        VNavisionStoreNo: Text;
        VCheckNavStoreNo: Text;
        VFullFileName: Text;
        VOutputFileLine: Text;
        VLineOutputFile: File;
        VFileName: Text;
        Window: Dialog;

    local procedure LookupCustomerNumber()
    begin
        StoreAcctNos.SetRange(StoreAcctNos."Account No.",VLookupAccountNo);
        if StoreAcctNos.Find('-') then VNavisionStoreNo := StoreAcctNos."Navision Customer No."
        else
        begin
        //Write an error to the error output file
        VOutputFileLine := 'Bank Account Number Not Found ' + VLookupAccountNo;
        VLineOutputFile.Write(VOutputFileLine);
        end;
    end;

    local procedure LookupBankLedgerEntry()
    begin
        BankLedgerEntries.SetCurrentkey("Entry No.");
        BankLedgerEntries.SetRange("Entry No.",VBankLedgerLookup);
        if BankLedgerEntries.Find('-') then VCheckNavStoreNo := BankLedgerEntries."Bal. Account No.";
    end;
}

