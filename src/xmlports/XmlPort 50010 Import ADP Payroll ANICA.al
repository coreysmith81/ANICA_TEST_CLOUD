XmlPort 50010 "Import ADP Payroll ANICA"
{
    // LCC 4-8-13 Added a routine to create an estimated payroll accrual for the payroll
    //              occuring after the current payroll, through the end of the month
    // 
    // LCC 4-22-15 Commented out VALIDATE statements in accrual line creation section.  Created blank G/L lines in NAV 2009 R2

    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                AutoReplace = true;
                XmlName = 'GenJournalLine';
                SourceTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.") order(ascending);
                textelement(ImpPostingDate)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert posting date
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
                textelement(VGPT)
                {
                }
                textelement(VGBP)
                {
                }
                textelement(VGPP)
                {
                }
                textelement(ImpAmount)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert amount
                        if Evaluate(VAmount, ImpAmount) = false then Message('Invalid Amount');
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    "Gen. Journal Line"."Journal Template Name" := 'GENERAL';
                    "Gen. Journal Line"."Journal Batch Name" := 'PAYROLL';
                    "Gen. Journal Line"."Posting Date" := VPostingDate;
                    //Make a text version of the date for the accrual description
                    VPrnDate := Format(VPostingDate, 0, '<Month>') + '-' + Format(VPostingDate, 0, '<Day>');
                    //Make a text version of the date for the estimated accrual description
                    VEstPrnDate := Format(VPostingDate + 14, 0, '<Month>') + '-' + Format(VPostingDate + 14, 0, '<Day>');
                    "Gen. Journal Line".Validate("Posting Date");
                    GetLineNumber;
                    "Gen. Journal Line"."Line No." := VLineNumber;
                    "Gen. Journal Line"."Document Date" := VPostingDate;
                    "Gen. Journal Line".Validate("Document Date");
                    "Gen. Journal Line"."Document Type" := "Gen. Journal Document Type"::" ";
                    "Gen. Journal Line".Validate("Document Type");
                    "Gen. Journal Line"."Document No." := VDocumentNo;
                    "Gen. Journal Line"."External Document No." := VDocumentNo;
                    "Gen. Journal Line".VALIDATE("Document No.");

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

                    "Gen. Journal Line".Validate("Account Type");
                    "Gen. Journal Line"."Account No." := VAccountNo;
                    "Gen. Journal Line".Validate("Account No.");
                    "Gen. Journal Line".Description := VDescrip;
                    "Gen. Journal Line".Validate(Description);
                    "Gen. Journal Line".Amount := VAmount;
                    "Gen. Journal Line".Validate(Amount);
                    "Gen. Journal Line"."Shortcut Dimension 1 Code" := VDiv;
                    "Gen. Journal Line".Validate("Shortcut Dimension 1 Code");

                    //Create the accrual and reversal lines
                    if VCreateAccrual then begin
                        CreateAccrualLine;
                        CreateReversalLIne;
                    end;

                    //Create the Estimated accrual and reversal lines
                    if VCreateEstAccrual then begin
                        CreateEstAccrualLine;
                        CreateEstReversalLine;
                    end;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("<Control1000000011>")
                {
                    Caption = 'Options';
                    field("<Control8>"; VCreateAccrual)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Check to Create Accrual and Reversing Entries';
                    }
                    field("<Control2>"; VAccrualDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Payroll Accrual Date';
                    }
                    field("<Control3>"; VReversalDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Date for Reversing Entry';
                    }
                    field("<Control4>"; VDaysAccrued)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Number of Days to Accrue';
                    }
                    field("<Control5>"; VCreateEstAccrual)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Check to Create Estimated Accrual and Reversing Entries';
                    }
                    field("<Control6>"; VEstDaysAccrued)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Number of Estimated Days to Accrue';
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin

        //Create contra accrual lines for both entries
        if VCreateAccrual then begin
            GenJournalLine1.Init;
            GenJournalLine1."Journal Template Name" := 'GENERAL';
            GenJournalLine1."Journal Batch Name" := 'PRACCRUE';
            GenJournalLine1."Shortcut Dimension 1 Code" := 'ANICA';
            GenJournalLine1."Line No." := VLineNumber + 10;
            GenJournalLine1.Insert(true);
            GenJournalLine1."Posting Date" := VAccrualDate;
            GenJournalLine1."Document Date" := VAccrualDate;
            GenJournalLine1."Document Type" := "Gen. Journal Document Type"::" ";
            ;
            GenJournalLine1."Document No." := 'Payroll Accrue ' + VPrnDate;
            GenJournalLine1."External Document No." := 'Payroll Accrue ' + VPrnDate;
            GenJournalLine1."Account Type" := "Gen. Journal Account Type"::"G/L Account";
            GenJournalLine1."Account No." := '230-02';//accrued payroll
            GenJournalLine1.Description := 'Monthend PR Accrual';
            GenJournalLine1.Amount := -VAccrualTotal;
            GenJournalLine1.Validate(Amount);
            GenJournalLine1.Modify(true);

            GenJournalLine2.Init;
            GenJournalLine2."Journal Template Name" := 'GENERAL';
            GenJournalLine2."Journal Batch Name" := 'PRREVERSE';
            GenJournalLine2."Shortcut Dimension 1 Code" := 'ANICA';
            GenJournalLine2."Line No." := VLineNumber + 10;
            GenJournalLine2.Insert(true);
            GenJournalLine2."Posting Date" := VReversalDate;
            GenJournalLine2."Document Date" := VReversalDate;
            GenJournalLine2."Document Type" := "Gen. Journal Document Type"::" ";
            GenJournalLine2."Document No." := 'Rev PR Accrual ' + VPrnDate;
            GenJournalLine2."External Document No." := 'Rev PR Accrual ' + VPrnDate;
            GenJournalLine2."Account Type" := "Gen. Journal Account Type"::"G/L Account";
            GenJournalLine2."Account No." := '230-02';//accrued payroll
            GenJournalLine2.Description := 'Reverse PR Accrual';
            GenJournalLine2.Amount := VAccrualTotal;
            GenJournalLine2.Validate(Amount);
            GenJournalLine2.Modify(true);
        end;

        //Create contra accrual lines for both estimated entries
        if VCreateEstAccrual then begin
            GenJournalLine3.Init;
            GenJournalLine3."Journal Template Name" := 'GENERAL';
            GenJournalLine3."Journal Batch Name" := 'ESTPRACCR';
            GenJournalLine3."Shortcut Dimension 1 Code" := 'ANICA';
            GenJournalLine3."Line No." := VLineNumber + 10;
            GenJournalLine3.Insert(true);
            GenJournalLine3."Posting Date" := VAccrualDate;
            GenJournalLine3."Document Date" := VAccrualDate;
            GenJournalLine3."Document Type" := "Gen. Journal Document Type"::" ";
            GenJournalLine3."Document No." := 'Est PR Accrued ' + VEstPrnDate;
            GenJournalLine3."External Document No." := 'Rev PR Accrual ' + VPrnDate;
            GenJournalLine3."Account Type" := "Gen. Journal Account Type"::"G/L Account";
            GenJournalLine3."Account No." := '230-02';//accrued payroll
            GenJournalLine3.Description := 'Monthend PR Accrual';
            GenJournalLine3.Amount := -VEstAccrualTotal;
            GenJournalLine3.Validate(Amount);
            GenJournalLine3.Modify(true);

            GenJournalLine4.Init;
            GenJournalLine4."Journal Template Name" := 'GENERAL';
            GenJournalLine4."Journal Batch Name" := 'ESTPRREV';
            GenJournalLine4."Shortcut Dimension 1 Code" := 'ANICA';
            GenJournalLine4."Line No." := VLineNumber + 10;
            GenJournalLine4.Insert(true);
            GenJournalLine4."Posting Date" := VReversalDate;
            GenJournalLine4."Document Date" := VReversalDate;
            GenJournalLine4."Document Type" := "Gen. Journal Document Type"::" ";
            GenJournalLine4."Document No." := 'Rev Est PR ' + VEstPrnDate;
            GenJournalLine4."External Document No." := 'Rev Est PR ' + VEstPrnDate;
            GenJournalLine4."Account Type" := "Gen. Journal Account Type"::"G/L Account";
            GenJournalLine4."Account No." := '230-02';//accrued payroll
            GenJournalLine4.Description := 'Reverse PR Accrual';
            GenJournalLine4.Amount := VEstAccrualTotal;
            GenJournalLine4.Validate(Amount);
            GenJournalLine4.Modify(true);
        end;

        Message('Payroll Import is Done');
    end;

    trigger OnPreXmlPort()
    begin

        //Check request form inputs
        if VCreateAccrual then begin
            if VAccrualDate = 0D then Error('Enter Date for Accrual');
            if VReversalDate = 0D then Error('Enter Date for Reversal');
            if VDaysAccrued = 0 then Error('Enter Number of Days to Accrue');
            if VDaysAccrued > 10 then Error('Number of Days to Accrue must Be Less than or equal to 10');
            if VAccrualDate >= VReversalDate then Error('Accrual Date Should Come Before the Reversal Date');
        end;
        if VCreateEstAccrual then begin
            if VCreateAccrual = false then Error('You Must Check to Create the Accrual');
            if VEstDaysAccrued = 0 then Error('Enter Number of Days to Accrue');
            if VEstDaysAccrued > 10 then Error('Number of Days to Accrue must Be Less than or equal to 10');
        end;
    end;

    var
        GenJournalLine1: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
        GenJournalLine4: Record "Gen. Journal Line";
        VAcctNo: Text;
        VPostingDate: Date;
        VDocumentDate: Date;
        VAmount: Decimal;
        VTestAmount: Decimal;
        VNewAccount: Code[10];
        VNewDept: Code[10];
        VDocNo1: Code[10];
        VDocNo2: Code[10];
        VLastDoc: Code[10];
        VAccrualDate: Date;
        VReversalDate: Date;
        VDaysAccrued: Integer;
        VEstDaysAccrued: Integer;
        VCreateAccrual: Boolean;
        VCreateEstAccrual: Boolean;
        VAccrualTotal: Decimal;
        VEstAccrualTotal: Decimal;
        VLineNumber: Decimal;
        VImport: Boolean;
        VFileName: Text;
        ltxtFilename: Text;
        VPrnDate: Text;
        VEstPrnDate: Text;

    local procedure GetLineNumber()
    var
        GenJnlLine3: Record "Gen. Journal Line";
    begin
        GenJnlLine3.SetRange(GenJnlLine3."Journal Template Name", "Gen. Journal Line"."Journal Template Name");
        GenJnlLine3.SetRange(GenJnlLine3."Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");
        if GenJnlLine3.Find('+') then
            VLineNumber := GenJnlLine3."Line No." + 10
        else
            VLineNumber := 10;
    end;

    local procedure CreateAccrualLine()
    begin
        if (VAccountType <> 'Bank Account') and (VAccountNo <> '125-05') then begin
            GenJournalLine1.Init;
            GenJournalLine1."Journal Template Name" := 'GENERAL';
            GenJournalLine1."Journal Batch Name" := 'PRACCRUE';
            GenJournalLine1."Shortcut Dimension 1 Code" := VDiv;
            GenJournalLine1."Line No." := VLineNumber;
            GenJournalLine1.Insert(true);
            GenJournalLine1."Posting Date" := VAccrualDate;
            GenJournalLine1.Validate("Posting Date");
            GenJournalLine1."Document Date" := VAccrualDate;
            GenJournalLine1.Validate("Document Date");
            GenJournalLine1."Document Type" := "Gen. Journal Document Type"::" ";
            GenJournalLine1.Validate("Document Type");
            GenJournalLine1."Document No." := 'Payroll Accrue ' + VPrnDate;
            GenJournalLine1."External Document No." := 'Payroll Accrue ' + VPrnDate;
            GenJournalLine1.VALIDATE("Document No.");
            //Get values for Account Type
            case VAccountType of
                'G/L Account':
                    GenJournalLine1."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                'Customer':
                    GenJournalLine1."Account Type" := "Gen. Journal Account Type"::Customer;
                'Vendor':
                    GenJournalLine1."Account Type" := "Gen. Journal Account Type"::Vendor;
                'Bank Account':
                    GenJournalLine1."Account Type" := "Gen. Journal Account Type"::"Bank Account";
                'Fixed Asset':
                    GenJournalLine1."Account Type" := "Gen. Journal Account Type"::"Fixed Asset";
                else
                    GenJournalLine1."Account Type" := "Gen. Journal Account Type"::"G/L Account";
            end;

            GenJournalLine1."Account No." := VAccountNo;
            GenJournalLine1.Validate("Account No.");
            GenJournalLine1.Description := VDescrip;
            GenJournalLine1.Validate(Description);
            GenJournalLine1.Amount := ROUND((VAmount * (VDaysAccrued / 10)), 1);
            GenJournalLine1.Validate(Amount);
            GenJournalLine1.Validate("Shortcut Dimension 1 Code");
            //Get entry total
            VAccrualTotal := VAccrualTotal + GenJournalLine1.Amount;
            GenJournalLine1.Modify(true);
        end;

    end;

    local procedure CreateReversalLIne()
    begin
        //Only Create lines that are not bank account entries
        if (VAccountType <> 'Bank Account') and (VAccountNo <> '125-05') then begin
            GenJournalLine2.Init;
            GenJournalLine2."Journal Template Name" := 'GENERAL';
            GenJournalLine2."Journal Batch Name" := 'PRREVERSE';
            GenJournalLine2."Shortcut Dimension 1 Code" := VDiv;
            GenJournalLine2."Line No." := VLineNumber;
            GenJournalLine2.Insert(true);
            GenJournalLine2."Posting Date" := VReversalDate;
            GenJournalLine2.Validate("Posting Date");
            GenJournalLine2."Document Date" := VReversalDate;
            GenJournalLine2.Validate("Document Date");
            GenJournalLine2."Document Type" := "Gen. Journal Document Type"::" ";
            GenJournalLine2.Validate("Document Type");
            GenJournalLine2."Document No." := 'Rev PR Accrual ' + VPrnDate;
            GenJournalLine2."External Document No." := 'Rev PR Accrual ' + VPrnDate;
            GenJournalLine2.VALIDATE("Document No.");
            //Get values for Account Type
            case VAccountType of
                'G/L Account':
                    GenJournalLine2."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                'Customer':
                    GenJournalLine2."Account Type" := "Gen. Journal Account Type"::Customer;
                'Vendor':
                    GenJournalLine2."Account Type" := "Gen. Journal Account Type"::Vendor;
                'Bank Account':
                    GenJournalLine2."Account Type" := "Gen. Journal Account Type"::"Bank Account";
                'Fixed Asset':
                    GenJournalLine2."Account Type" := "Gen. Journal Account Type"::"Fixed Asset";
                else
                    GenJournalLine2."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                    GenJournalLine2.validate("Account Type");
                    GenJournalLine2."Account No." := VAccountNo;
                    GenJournalLine2.Validate("Account No.");
                    GenJournalLine2.Description := VDescrip;
                    GenJournalLine2.Validate(Description);
                    GenJournalLine2.Amount := -ROUND((VAmount * (VDaysAccrued / 10)), 1);
                    GenJournalLine2.Validate(Amount);
                    GenJournalLine2.Validate("Shortcut Dimension 1 Code");
                    GenJournalLine2.Modify(true);
            end;
        end
    end;

    local procedure CreateEstAccrualLine()
    begin
        //Check for zero lines
        VTestAmount := ROUND((VAmount * (VEstDaysAccrued / 10)), 10);
        if (VAccountType <> 'Bank Account') and (VAccountNo <> '125-05') and (VTestAmount <> 0) then begin
            GenJournalLine3.Init;
            GenJournalLine3."Journal Template Name" := 'GENERAL';
            GenJournalLine3."Journal Batch Name" := 'ESTPRACCR';
            GenJournalLine3."Shortcut Dimension 1 Code" := VDiv;
            GenJournalLine3."Line No." := VLineNumber;
            GenJournalLine3.Insert(true);
            //Use the regular accrual date for the posting date for the estimate
            GenJournalLine3."Posting Date" := VAccrualDate;
            GenJournalLine3.Validate("Posting Date");
            GenJournalLine3."Document Date" := VAccrualDate;
            GenJournalLine3.Validate("Document Date");
            GenJournalLine3."Document Type" := "Gen. Journal Document Type"::" ";
            GenJournalLine3.Validate("Document Type");
            GenJournalLine3."Document No." := 'Est PR Accrued ' + VEstPrnDate;
            GenJournalLine3."External Document No." := 'Est PR Accrued ' + VEstPrnDate;
            GenJournalLine3.VALIDATE("Document No.");

            //Get values for Account Type
            case VAccountType of
                'G/L Account':
                    GenJournalLine3."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                'Customer':
                    GenJournalLine3."Account Type" := "Gen. Journal Account Type"::Customer;
                'Vendor':
                    GenJournalLine3."Account Type" := "Gen. Journal Account Type"::Vendor;
                'Bank Account':
                    GenJournalLine3."Account Type" := "Gen. Journal Account Type"::"Bank Account";
                'Fixed Asset':
                    GenJournalLine3."Account Type" := "Gen. Journal Account Type"::"Fixed Asset";
                else
                    GenJournalLine3."Account Type" := "Gen. Journal Account Type"::"G/L Account";
            end;
            GenJournalLine3.Validate("Account Type");
            GenJournalLine3."Account No." := VAccountNo;
            GenJournalLine3.Validate("Account No.");
            GenJournalLine3.Description := VDescrip;
            GenJournalLine3.Validate(Description);
            GenJournalLine3.Amount := ROUND((VAmount * (VEstDaysAccrued / 10)), 10);
            GenJournalLine3.Validate(Amount);
            GenJournalLine3.Validate("Shortcut Dimension 1 Code");
            //Get entry total
            VEstAccrualTotal := VEstAccrualTotal + GenJournalLine3.Amount;
            GenJournalLine3.Modify(true);
        end;
    end;

    local procedure CreateEstReversalLine()
    begin
        //Only Create lines that are not bank account entries
        //Check for zero lines
        VTestAmount := ROUND((VAmount * (VEstDaysAccrued / 10)), 10);
        if (VAccountType <> 'Bank Account') and (VAccountNo <> '125-05') and (VTestAmount <> 0) then begin
            GenJournalLine4.Init;
            GenJournalLine4."Journal Template Name" := 'GENERAL';
            GenJournalLine4."Journal Batch Name" := 'ESTPRREV';
            GenJournalLine4."Shortcut Dimension 1 Code" := VDiv;
            GenJournalLine4."Line No." := VLineNumber;
            GenJournalLine4.Insert(true);
            GenJournalLine4."Posting Date" := VReversalDate;
            GenJournalLine4.Validate("Posting Date");
            GenJournalLine4."Document Date" := VReversalDate;
            GenJournalLine4.Validate("Document Date");
            GenJournalLine4."Document Type" := "Gen. Journal Document Type"::" ";
            GenJournalLine4.Validate("Document Type");
            GenJournalLine4."Document No." := 'Rev Est PR ' + VEstPrnDate;
            GenJournalLine4."External Document No." := 'Rev Est PR ' + VEstPrnDate;
            GenJournalLine4.VALIDATE("Document No.");
            //Get values for Account Type
            case VAccountType of
                'G/L Account':
                    GenJournalLine4."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                'Customer':
                    GenJournalLine4."Account Type" := "Gen. Journal Account Type"::Customer;
                'Vendor':
                    GenJournalLine4."Account Type" := "Gen. Journal Account Type"::Vendor;
                'Bank Account':
                    GenJournalLine4."Account Type" := "Gen. Journal Account Type"::"Bank Account";
                'Fixed Asset':
                    GenJournalLine4."Account Type" := "Gen. Journal Account Type"::"Fixed Asset";
                else
                    GenJournalLine4."Account Type" := "Gen. Journal Account Type"::"G/L Account";
            end;

            GenJournalLine4.Validate("Account Type");
            GenJournalLine4."Account No." := VAccountNo;
            GenJournalLine4.Validate("Account No.");
            GenJournalLine4.Description := VDescrip;
            GenJournalLine4.Validate(Description);
            GenJournalLine4.Amount := -ROUND((VAmount * (VEstDaysAccrued / 10)), 10);
            GenJournalLine4.Validate(Amount);
            GenJournalLine4.Validate("Shortcut Dimension 1 Code");
            GenJournalLine4.Modify(true);
        end;
    end;
}

