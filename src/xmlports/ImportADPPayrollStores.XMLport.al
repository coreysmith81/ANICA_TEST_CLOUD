XmlPort 50011 "Import ADP Payroll Stores"
{
    Direction = Import;
    Format = VariableText;
    TextEncoding = MS"-";

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line";"Gen. Journal Line")
            {
                AutoReplace = true;
                AutoSave = true;
                XmlName = 'GenJournalLine';
                textelement(VADPCompany)
                {
                }
                textelement(VADPLocation)
                {
                }
                textelement(ImpPostingDate)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert test date to date variable
                        if Evaluate(VPostingDate,ImpPostingDate) = false then Message('Invalid Date');
                    end;
                }
                textelement(VDocumentType)
                {
                }
                textelement(VDocumentNo)
                {
                }
                textelement(VAccountType)
                {
                }
                textelement(VAccountNo)
                {
                }
                textelement(VDescrip)
                {
                }
                textelement(VDiv)
                {
                }
                textelement(ImpAmount)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert test date to date variable
                        if Evaluate(VAmount,ImpAmount) = false then Message('Invalid Amount');
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    with "Gen. Journal Line" do
                              begin
                              VCustomerNo := '';
                              VCustomerName := '';
                              LookupCustomerNumber;
                              "Journal Template Name" := 'GENERAL';
                              "Journal Batch Name" := 'STOREPR';
                              "Posting Date" := VPostingDate;
                              Validate("Posting Date");
                              GetLineNumber;
                              "Gen. Journal Line"."Line No." := VLineNumber;
                              "Document Date" := VPostingDate;
                              Validate("Document Date");
                              "Document Type" := 0;
                              Validate("Document Type");
                              "Document No." := VDocumentNo;
                              Validate("Document No.");

                              //Get values for Account Type
                              case VAccountType of
                              'G/L Account': "Account Type" := 0;
                              'Customer': "Account Type" := 1;
                              'Vendor': "Account Type" := 2;
                              'Bank Account': "Account Type" := 3;
                              'Fixed Asset': "Account Type" := 4;
                              else "Account Type" := 0;
                              end;

                              //Special Routine for the 6 cash stores account type
                              if VAccountNo = 'PAYROLL' then
                              case VADPCompany of
                              '26L': "Account Type" := 1;
                              '497': "Account Type" := 1;
                              '49H': "Account Type" := 1;
                              '49J': "Account Type" := 1;
                              '4J9': "Account Type" := 1;
                              '4LN': "Account Type" := 1;
                              '4LK': "Account Type" := 1;
                              end;

                              //Special Routine for the 6 cash stores description
                              if VAccountNo = 'PAYROLL' then
                              case VADPCompany of
                              '26L': VDescrip := 'Payroll Paid at The Store';
                              '497': VDescrip := 'Payroll Paid at The Store';
                              '49H': VDescrip := 'Payroll Paid at The Store';
                              '49J': VDescrip := 'Payroll Paid at The Store';
                              '4J9': VDescrip := 'Payroll Paid at The Store';
                              '4LN': VDescrip := 'Payroll Paid at The Store';
                              '4LK': VDescrip := 'Payroll Paid at The Store';
                              end;

                              Validate("Account Type");

                              if "Account Type" = 1 then "Account No." := VCustomerNo
                                 else "Account No." := VAccountNo;
                              Validate("Account No.");
                              //Add the company number and name for reconciliation purposes to bank entries
                              if "Account Type" = 3 then Description := CopyStr(UpperCase(VDescrip) + ' ' + VADPCompany + ' ' + VCustomerName,1,50) else
                              Description := UpperCase(VDescrip);
                              Validate(Description);
                              Amount := VAmount;
                              Validate(Amount);
                              "Shortcut Dimension 1 Code" := VDiv;
                              Validate("Shortcut Dimension 1 Code");
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
        Message('Payroll Import is Done');
    end;

    trigger OnPreXmlPort()
    begin
        VIncrement := '01'
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        CustomerLookup: Record Customer;
        VAcctNo: Text[30];
        VPostingDate: Date;
        VDocumentDate: Date;
        VAmount: Decimal;
        VCustomerNo: Code[20];
        VCustomerName: Text[30];
        VGPT: Text[30];
        VGBP: Text[30];
        VGPP: Text[30];
        VNewAccount: Code[20];
        VNewDept: Code[10];
        VDocNo1: Code[10];
        VDocNo2: Code[10];
        VIncrement: Code[10];
        VLastDoc: Code[10];
        VLineNumber: Decimal;

    local procedure LookupCustomerNumber()
    begin
        CustomerLookup.SetRange(CustomerLookup."ADP Code",VADPCompany);
        if CustomerLookup.Find('+') then
        begin
        VCustomerNo := CustomerLookup."No.";
        VCustomerName := CustomerLookup.Name;
        end
        else Error('ADP Customer Number needs to be entered for code %1',CustomerLookup);
    end;

    local procedure GetLineNumber()
    var
        GenJnlLine2: Record "Gen. Journal Line";
    begin
        GenJnlLine2.SetRange(GenJnlLine2."Journal Template Name","Gen. Journal Line"."Journal Template Name");
        GenJnlLine2.SetRange(GenJnlLine2."Journal Batch Name","Gen. Journal Line"."Journal Batch Name");
        if GenJnlLine2.Find('+') then
           VLineNumber := GenJnlLine2."Line No." + 10
           else
           VLineNumber := 10;
        GenJnlLine2.SetRange(GenJnlLine2."Journal Batch Name","Gen. Journal Line"."Journal Batch Name");

    end;
}

