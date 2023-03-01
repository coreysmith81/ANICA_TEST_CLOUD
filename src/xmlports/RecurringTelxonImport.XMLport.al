XmlPort 50051 "Recurring Telxon Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Item Journal Line";"Item Journal Line")
            {
                AutoUpdate = true;
                XmlName = 'ItemJournalLine';
                fieldelement(JournalTemplateName;"Item Journal Line"."Journal Template Name")
                {
                }
                fieldelement(LineNo;"Item Journal Line"."Line No.")
                {
                }
                fieldelement(PostingDate;"Item Journal Line"."Posting Date")
                {
                }
                fieldelement(EntryType;"Item Journal Line"."Entry Type")
                {
                }
                fieldelement(JournalBatchName;"Item Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(Store;"Item Journal Line".Store)
                {
                }
                fieldelement(TelxonVendorNo;"Item Journal Line"."Telxon Vendor No.")
                {
                }
                fieldelement(OrderType;"Item Journal Line"."Order Type")
                {
                }
                fieldelement(TelxonItemNo;"Item Journal Line"."Telxon Item No.")
                {
                }
                fieldelement(Quantity;"Item Journal Line".Quantity)
                {
                }
                fieldelement(InvoicedQuantity;"Item Journal Line"."Invoiced Quantity")
                {
                }
                fieldelement(InvoicedQtyBase;"Item Journal Line"."Invoiced Qty. (Base)")
                {
                }
                fieldelement(QuantityBase;"Item Journal Line"."Quantity (Base)")
                {
                }
                fieldelement(PurchaserCode;"Item Journal Line"."Salespers./Purch. Code")
                {
                }
                fieldelement(DocumentDate;"Item Journal Line"."Document Date")
                {
                }
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
        Window: Dialog;
}

