XmlPort 50011 "Import ADP Payroll Stores"
{
    Direction = Import;
    Format = VariableText;
    //TextEncoding = MS"-";

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
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
                        if Evaluate(VPostingDate, ImpPostingDate) = false then Message('Invalid Date');
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
                        if Evaluate(VAmount, ImpAmount) = false then Message('Invalid Amount');
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    VCustomerNo := '';
                    VCustomerName := '';
                    LookupCustomerNumber;
                    "Gen. Journal Line"."Journal Template Name" := 'GENERAL';
                    "Gen. Journal Line"."Journal Batch Name" := 'STOREPR';
                    "Gen. Journal Line"."Posting Date" := VPostingDate;
                    "Gen. Journal Line".Validate("Posting Date");
                    GetLineNumber;
                    "Gen. Journal Line"."Line No." := VLineNumber;
                    "Gen. Journal Line"."Document Date" := VPostingDate;
                    "Gen. Journal Line".Validate("Document Date");
                    "Gen. Journal Line"."Document Type" := "Gen. Journal Document Type"::" ";
                    "Gen. Journal Line".Validate("Document Type");
                    "Gen. Journal Line"."Document No." := VDocumentNo;
                    "Gen. Journal Line".Validate("Document No.");

                    //Get values for Account Type
                    case VAccountType of
                        'G/L Account':
                            "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                        'Customer':
                            "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::Customer;
                        'Vendor':
                            "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::Vendor;
                        'Bank Account':
                            "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"Bank Account";
                        'Fixed Asset':
                            "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"Fixed Asset";
                        else
                            "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                    end;

                    //Special Routine for the 6 cash stores account type
                    if VAccountNo = 'PAYROLL' then
                        case VADPCompany of
                            '26L':
                                "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                            '497':
                                "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                            '49H':
                                "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                            '49J':
                                "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                            '4J9':
                                "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                            '4LN':
                                "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                            '4LK':
                                "Gen. Journal Line"."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                        end;

                    //Special Routine for the 6 cash stores description
                    if VAccountNo = 'PAYROLL' then
                        case VADPCompany of
                            '26L':
                                VDescrip := 'Payroll Paid at The Store';
                            '497':
                                VDescrip := 'Payroll Paid at The Store';
                            '49H':
                                VDescrip := 'Payroll Paid at The Store';
                            '49J':
                                VDescrip := 'Payroll Paid at The Store';
                            '4J9':
                                VDescrip := 'Payroll Paid at The Store';
                            '4LN':
                                VDescrip := 'Payroll Paid at The Store';
                            '4LK':
                                VDescrip := 'Payroll Paid at The Store';
                        end;

                    "Gen. Journal Line".Validate("Gen. Journal Line"."Account Type");

                    if "Gen. Journal Line"."Account Type" = "Gen. Journal Account Type"::Customer then
                        "Gen. Journal Line"."Account No." := VCustomerNo
                    else
                        "Gen. Journal Line"."Account No." := VAccountNo;
                    "Gen. Journal Line".Validate("Gen. Journal Line"."Account No.");
                    //Add the company number and name for reconciliation purposes to bank entries
                    if "Gen. Journal Line"."Account Type" = "Gen. Journal Account Type"::"Bank Account" then
                        "Gen. Journal Line".Description := CopyStr(UpperCase(VDescrip) + ' ' + VADPCompany + ' ' + VCustomerName, 1, 50) else
                        "Gen. Journal Line".Description := UpperCase(VDescrip);
                    "Gen. Journal Line".Validate(Description);
                    "Gen. Journal Line".Amount := VAmount;
                    "Gen. Journal Line".Validate(Amount);
                    "Gen. Journal Line"."Shortcut Dimension 1 Code" := VDiv;
                    "Gen. Journal Line".Validate("Shortcut Dimension 1 Code");
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
        CustomerLookup.SetRange(CustomerLookup."ADP Code", VADPCompany);
        if CustomerLookup.Find('+') then begin
            VCustomerNo := CustomerLookup."No.";
            VCustomerName := CustomerLookup.Name;
        end
        else
            Error('ADP Customer Number needs to be entered for code %1', CustomerLookup);
    end;

    local procedure GetLineNumber()
    var
        GenJnlLine2: Record "Gen. Journal Line";
    begin
        GenJnlLine2.SetRange(GenJnlLine2."Journal Template Name", "Gen. Journal Line"."Journal Template Name");
        GenJnlLine2.SetRange(GenJnlLine2."Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");
        if GenJnlLine2.Find('+') then
            VLineNumber := GenJnlLine2."Line No." + 10
        else
            VLineNumber := 10;
        GenJnlLine2.SetRange(GenJnlLine2."Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");

    end;
}

