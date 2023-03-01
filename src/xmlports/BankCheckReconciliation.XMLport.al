XmlPort 50021 "Bank Check Reconciliation"
{
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
                textelement(VField1)
                {
                }
                textelement(VField2)
                {
                }
                textelement(VField3)
                {
                }
                textelement(VField4)
                {
                }
                textelement(VField5)
                {
                }
                textelement(VField6)
                {
                }
                textelement(TXTAmtCleared)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(AmtCleared,TXTAmtCleared) = false then Message('Invalid Amount');
                    end;
                }
                textelement(VField7)
                {
                }
                textelement(VField8)
                {
                }
                textelement(VField9)
                {
                }
                textelement(VField10)
                {
                }
                textelement(VField11)
                {
                }
                textelement(VField12)
                {
                }
                textelement(CheckNo)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    BankRecLines.SetCurrentkey("Document Type","Document No.");
                    BankRecLines.SetRange(BankRecLines."Document Type",1);
                    BankRecLines.SetRange(BankRecLines."Document No.",CheckNo);
                    if BankRecLines.Find('-') then
                    begin
                    BankRecLines.Cleared := true;
                    BankRecLines."Cleared Amount" := AmtCleared;
                    BankRecLines.Modify(true);
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
    end;

    var
        BankRecLines: Record "Bank Rec. Line";
        AmtCleared: Decimal;
        Window: Dialog;
}

