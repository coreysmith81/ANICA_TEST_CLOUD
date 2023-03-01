XmlPort 50063 "Default Shipping Import"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Default Shipping Table";"Default Shipping Table")
            {
                AutoReplace = true;
                XmlName = 'DefaultShippingTable';
                SourceTableView = sorting("FOB Code") order(ascending);
                fieldelement(FOBCode;"Default Shipping Table"."FOB Code")
                {
                }
                fieldelement(StoreNo;"Default Shipping Table"."Store No.")
                {
                }
                fieldelement(VendorNo;"Default Shipping Table"."Vendor No.")
                {
                }
                fieldelement(ShippingInstruction;"Default Shipping Table"."Shipping Instruction")
                {
                }
                fieldelement(DropShipLocation;"Default Shipping Table"."Drop Ship Location")
                {
                }
                fieldelement(FreightCode;"Default Shipping Table"."Freight Code")
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

