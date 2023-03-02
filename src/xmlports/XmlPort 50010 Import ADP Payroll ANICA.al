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
            tableelement("Gen. Journal Line";"Gen. Journal Line")
            {
                AutoReplace = true;
                XmlName = 'GenJournalLine';
                SourceTableView = sorting("Journal Template Name","Journal Batch Name","Line No.") order(ascending);
                textelement(ImpPostingDate)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert posting date
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
                        if Evaluate(VAmount,ImpAmount) = false then Message('Invalid Amount');
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    with "Gen. Journal Line" do
                              begin
                              "Journal Template Name" := 'GENERAL';
                              "Journal Batch Name" := 'PAYROLL';
                              "Posting Date" := VPostingDate;
                              //Make a text version of the date for the accrual description
                              VPrnDate := Format(VPostingDate,0,'<Month>') + '-' + Format(VPostingDate,0,'<Day>');
                              //Make a text version of the date for the estimated accrual description
                              VEstPrnDate := Format(VPostingDate + 14,0,'<Month>') + '-' + Format(VPostingDate + 14,0,'<Day>');
                              Validate("Posting Date");
                              GetLineNumber;
                              "Gen. Journal Line"."Line No." := VLineNumber;
                              "Document Date" := VPostingDate;
                              Validate("Document Date");
                              "Document Type" := 0;
                              Validate("Document Type");
                              "Document No." := VDocumentNo;
                              "External Document No." := VDocumentNo;
                              //VALIDATE("Document No.");
                              //Get values for Account Type
                              case VAccountType of
                              'G/L Account': "Account Type" := 0;
                              'Customer': "Account Type" := 1;
                              'Vendor': "Account Type" := 2;
                              'Bank Account': "Account Type" := 3;
                              'Fixed Asset': "Account Type" := 4;
                              else "Account Type" := 0;
                              end;
                              Validate("Account Type");
                              "Account No." := VAccountNo;
                              Validate("Account No.");
                              Description := VDescrip;
                              Validate(Description);
                              Amount := VAmount;
                              Validate(Amount);
                              "Shortcut Dimension 1 Code" := VDiv;
                              Validate("Shortcut Dimension 1 Code");
                              end;

                    //Create the accrual and reversal lines
                    if VCreateAccrual then
                    begin
                    CreateAccrualLine;
                    CreateReversalLIne;
                    end;

                    //Create the Estimated accrual and reversal lines
                    if VCreateEstAccrual then
                    begin
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
                    field("<Control8>";VCreateAccrual)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Check to Create Accrual and Reversing Entries';
                    }
                    field("<Control2>";VAccrualDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Payroll Accrual Date';
                    }
                    field("<Control3>";VReversalDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Date for Reversing Entry';
                    }
                    field("<Control4>";VDaysAccrued)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Enter Number of Days to Accrue';
                    }
                    field("<Control5>";VCreateEstAccrual)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Check to Create Estimated Accrual and Reversing Entries';
                    }
                    field("<Control6>";VEstDaysAccrued)
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
        if VCreateAccrual then
        begin
           with GenJournalLine1 do
                  begin
                  Init;
                  "Journal Template Name" := 'GENERAL';
                  "Journal Batch Name" := 'PRACCRUE';
                  "Shortcut Dimension 1 Code" := 'ANICA';
                  "Line No." := VLineNumber + 10;
                  Insert(true);
                  "Posting Date" := VAccrualDate;
                  "Document Date" := VAccrualDate;
                  "Document Type" := 0;
                  "Document No." := 'Payroll Accrue '  + VPrnDate;
                  "External Document No." := 'Payroll Accrue '  + VPrnDate;
                  "Account Type" := 0;
                  "Account No." := '230-02';//accrued payroll
                  Description := 'Monthend PR Accrual';
                  Amount := -VAccrualTotal;
                  Validate(Amount);
                  Modify(true);
                  end;

           with GenJournalLine2 do
                  begin
                  Init;
                  "Journal Template Name" := 'GENERAL';
                  "Journal Batch Name" := 'PRREVERSE';
                  "Shortcut Dimension 1 Code" := 'ANICA';
                  "Line No." := VLineNumber + 10;
                  Insert(true);
                  "Posting Date" := VReversalDate;
                  "Document Date" := VReversalDate;
                  "Document Type" := 0;
                  "Document No." := 'Rev PR Accrual ' + VPrnDate;
                  "External Document No." := 'Rev PR Accrual ' + VPrnDate;
                  "Account Type" := 0;
                  "Account No." := '230-02';//accrued payroll
                  Description := 'Reverse PR Accrual';
                  Amount := VAccrualTotal;
                  Validate(Amount);
                  Modify(true);
                  end;
        end;

        //Create contra accrual lines for both estimated entries
        if VCreateEstAccrual then
        begin
           with GenJournalLine3 do
                  begin
                  Init;
                  "Journal Template Name" := 'GENERAL';
                  "Journal Batch Name" := 'ESTPRACCR';
                  "Shortcut Dimension 1 Code" := 'ANICA';
                  "Line No." := VLineNumber + 10;
                  Insert(true);
                  "Posting Date" := VAccrualDate;
                  "Document Date" := VAccrualDate;
                  "Document Type" := 0;
                  "Document No." := 'Est PR Accrued '  + VEstPrnDate;
                  "External Document No." := 'Rev PR Accrual ' + VPrnDate;
                  "Account Type" := 0;
                  "Account No." := '230-02';//accrued payroll
                  Description := 'Monthend PR Accrual';
                  Amount := -VEstAccrualTotal;
                  Validate(Amount);
                  Modify(true);
                  end;

           with GenJournalLine4 do
                  begin
                  Init;
                  "Journal Template Name" := 'GENERAL';
                  "Journal Batch Name" := 'ESTPRREV';
                  "Shortcut Dimension 1 Code" := 'ANICA';
                  "Line No." := VLineNumber + 10;
                  Insert(true);
                  "Posting Date" := VReversalDate;
                  "Document Date" := VReversalDate;
                  "Document Type" := 0;
                  "Document No." := 'Rev Est PR ' + VEstPrnDate;
                  "External Document No." :=  'Rev Est PR ' + VEstPrnDate;
                  "Account Type" := 0;
                  "Account No." := '230-02';//accrued payroll
                  Description := 'Reverse PR Accrual';
                  Amount := VEstAccrualTotal;
                  Validate(Amount);
                  Modify(true);
                  end;
        end;

        Message('Payroll Import is Done');
    end;

    trigger OnPreXmlPort()
    begin

        //Check request form inputs
        if VCreateAccrual then
        begin
             if VAccrualDate = 0D then Error('Enter Date for Accrual');
             if VReversalDate = 0D then Error('Enter Date for Reversal');
             if VDaysAccrued = 0 then Error('Enter Number of Days to Accrue');
             if VDaysAccrued > 10 then Error('Number of Days to Accrue must Be Less than or equal to 10');
             if VAccrualDate >= VReversalDate then Error('Accrual Date Should Come Before the Reversal Date');
        end;
        if VCreateEstAccrual then
        begin
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
        GenJnlLine3.SetRange(GenJnlLine3."Journal Template Name","Gen. Journal Line"."Journal Template Name");
        GenJnlLine3.SetRange(GenJnlLine3."Journal Batch Name","Gen. Journal Line"."Journal Batch Name");
        if GenJnlLine3.Find('+') then
           VLineNumber := GenJnlLine3."Line No." + 10
           else
           VLineNumber := 10;
    end;

    local procedure CreateAccrualLine()
    begin
        with GenJournalLine1 do
                  begin
                     if (VAccountType <> 'Bank Account') and (VAccountNo <> '125-05') then
                     begin
                     Init;
                     "Journal Template Name" := 'GENERAL';
                     "Journal Batch Name" := 'PRACCRUE';
                     "Shortcut Dimension 1 Code" := VDiv;
                     "Line No." := VLineNumber;
                     Insert(true);
                     "Posting Date" := VAccrualDate;
                     Validate("Posting Date");
                     "Document Date" := VAccrualDate;
                     Validate("Document Date");
                     "Document Type" := 0;
                     Validate("Document Type");
                     "Document No." := 'Payroll Accrue '  + VPrnDate;
                     "External Document No."  := 'Payroll Accrue '  + VPrnDate;
                     //VALIDATE("Document No.");
                     //Get values for Account Type
                     case VAccountType of
                     'G/L Account': "Account Type" := 0;
                     'Customer': "Account Type" := 1;
                     'Vendor': "Account Type" := 2;
                     'Bank Account': "Account Type" := 3;
                     'Fixed Asset': "Account Type" := 4;
                     else "Account Type" := 0;
                     end;
                     Validate("Account Type");
                     "Account No." := VAccountNo;
                     Validate("Account No.");
                     Description := VDescrip;
                     Validate(Description);
                     Amount := ROUND((VAmount * (VDaysAccrued/10)),1);
                     Validate(Amount);
                     Validate("Shortcut Dimension 1 Code");
                     //Get entry total
                     VAccrualTotal := VAccrualTotal + Amount ;
                     Modify(true);
                     end;
                  end;

    end;

    local procedure CreateReversalLIne()
    begin
        with GenJournalLine2 do
                  begin
                  //Only Create lines that are not bank account entries
                     if (VAccountType <> 'Bank Account') and (VAccountNo <> '125-05') then
                     begin
                     Init;
                     "Journal Template Name" := 'GENERAL';
                     "Journal Batch Name" := 'PRREVERSE';
                     "Shortcut Dimension 1 Code" := VDiv;
                     "Line No." := VLineNumber;
                     Insert(true);
                     "Posting Date" := VReversalDate;
                     Validate("Posting Date");
                     "Document Date" := VReversalDate;
                     Validate("Document Date");
                     "Document Type" := 0;
                     Validate("Document Type");
                     "Document No." := 'Rev PR Accrual ' + VPrnDate;
                     "External Document No." := 'Rev PR Accrual ' + VPrnDate;
                     //VALIDATE("Document No.");
                     //Get values for Account Type
                     case VAccountType of
                     'G/L Account': "Account Type" := 0;
                     'Customer': "Account Type" := 1;
                     'Vendor': "Account Type" := 2;
                     'Bank Account': "Account Type" := 3;
                     'Fixed Asset': "Account Type" := 4;
                     else "Account Type" := 0;
                     end;
                     Validate("Account Type");
                     "Account No." := VAccountNo;
                     Validate("Account No.");
                     Description := VDescrip;
                     Validate(Description);
                     Amount := -ROUND((VAmount * (VDaysAccrued/10)),1);
                     Validate(Amount);
                     Validate("Shortcut Dimension 1 Code");
                     Modify(true);
                     end;
                  end;

    end;

    local procedure CreateEstAccrualLine()
    begin
        with GenJournalLine3 do
                  begin
                     //Check for zero lines
                     VTestAmount := ROUND((VAmount * (VEstDaysAccrued/10)),10);
                     if (VAccountType <> 'Bank Account') and (VAccountNo <> '125-05') and (VTestAmount <> 0) then
                     begin
                     Init;
                     "Journal Template Name" := 'GENERAL';
                     "Journal Batch Name" := 'ESTPRACCR';
                     "Shortcut Dimension 1 Code" := VDiv;
                     "Line No." := VLineNumber;
                     Insert(true);
                     //Use the regular accrual date for the posting date for the estimate
                     "Posting Date" := VAccrualDate;
                     Validate("Posting Date");
                     "Document Date" := VAccrualDate;
                     Validate("Document Date");
                     "Document Type" := 0;
                     Validate("Document Type");
                     "Document No." := 'Est PR Accrued '  + VEstPrnDate;
                     "External Document No." := 'Est PR Accrued '  + VEstPrnDate;
                     //VALIDATE("Document No.");
                     //Get values for Account Type
                     case VAccountType of
                     'G/L Account': "Account Type" := 0;
                     'Customer': "Account Type" := 1;
                     'Vendor': "Account Type" := 2;
                     'Bank Account': "Account Type" := 3;
                     'Fixed Asset': "Account Type" := 4;
                     else "Account Type" := 0;
                     end;
                     Validate("Account Type");
                     "Account No." := VAccountNo;
                     Validate("Account No.");
                     Description := VDescrip;
                     Validate(Description);
                     Amount := ROUND((VAmount * (VEstDaysAccrued/10)),10);
                     Validate(Amount);
                     Validate("Shortcut Dimension 1 Code");
                     //Get entry total
                     VEstAccrualTotal := VEstAccrualTotal + Amount;
                     Modify(true);
                     end;
                  end;

    end;

    local procedure CreateEstReversalLine()
    begin
         with GenJournalLine4 do
                  begin
                  //Only Create lines that are not bank account entries
                     //Check for zero lines
                     VTestAmount := ROUND((VAmount * (VEstDaysAccrued/10)),10);
                     if (VAccountType <> 'Bank Account') and (VAccountNo <> '125-05') and (VTestAmount <> 0)  then
                     begin
                     Init;
                     "Journal Template Name" := 'GENERAL';
                     "Journal Batch Name" := 'ESTPRREV';
                     "Shortcut Dimension 1 Code" := VDiv;
                     "Line No." := VLineNumber;
                     Insert(true);
                     "Posting Date" := VReversalDate;
                     Validate("Posting Date");
                     "Document Date" := VReversalDate;
                     Validate("Document Date");
                     "Document Type" := 0;
                     Validate("Document Type");
                     "Document No." := 'Rev Est PR ' + VEstPrnDate;
                     "External Document No." := 'Rev Est PR ' + VEstPrnDate;
                     //VALIDATE("Document No.");
                     //Get values for Account Type
                     case VAccountType of
                     'G/L Account': "Account Type" := 0;
                     'Customer': "Account Type" := 1;
                     'Vendor': "Account Type" := 2;
                     'Bank Account': "Account Type" := 3;
                     'Fixed Asset': "Account Type" := 4;
                     else "Account Type" := 0;
                     end;
                     Validate("Account Type");
                     "Account No." := VAccountNo;
                     Validate("Account No.");
                     Description := VDescrip;
                     Validate(Description);
                     Amount := -ROUND((VAmount * (VEstDaysAccrued/10)),10);
                     Validate(Amount);
                     Validate("Shortcut Dimension 1 Code");
                     Modify(true);
                     end;
                  end;

    end;
}

