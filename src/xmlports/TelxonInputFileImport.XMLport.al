XmlPort 50052 "Telxon Input File Import"
{
    // LCC 5-25-10 I forced some fields below for Gina's import

    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Telxon Input File";"Telxon Input File")
            {
                AutoUpdate = true;
                XmlName = 'TelxonInputFile';
                textelement(VItem)
                {
                }
                textelement(TxtQuantity)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VQuantity,TxtQuantity) = false then Message('Invalid Amount');
                    end;
                }
                textelement(VVendor)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    GetSequenceNo;

                    with "Telxon Input File" do
                        begin
                            "Batch Name" := 'RBIMPORT';
                            Sequence := TSequence;
                            //Store := VStore;
                            Store := '86';
                            Date := Today;
                            //Date := TDate;
                            //"Telxon Vendor" := VVendor;
                            "Telxon Vendor" := VVendor;
                            "Import Item No." := VItem;
                            //"Order Item No." := TOrderItemNo;
                            Quantity := VQuantity;
                            //"Customer Number" := TCustomerNumber;
                            "Order Type" := 1;
                            //"Import Error" := TImportError;
                            //"Error Remark" := TErrorRemark;
                            "Purchaser Code" := 'RB';
                            //Manufacturer := TManu;
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
        TelxonInputFile: Record "Telxon Input File";
        VFlag: Text;
        TSequence: Decimal;
        VGetItemNo: Text;
        VQuantity: Decimal;
        VDescr: Text;
        VInvoice: Text;
        VLastDate: Date;
        VPack: Decimal;
        VPackDesc: Text;
        VUPC: Text;
        VRetail: Decimal;
        VJBGComm: Text;
        VStore: Text;
        Window: Dialog;

    local procedure GetSequenceNo()
    begin
        TelxonInputFile.LockTable;
        TelxonInputFile.SetCurrentkey(Sequence);
        TelxonInputFile.SetRange(Sequence);

        if TelxonInputFile.Find('+') then
            TSequence := TelxonInputFile.Sequence + 10
        else TSequence := 10;
    end;
}

