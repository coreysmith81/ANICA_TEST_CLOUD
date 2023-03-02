XmlPort 50090 "Retail Updates"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Item;Item)
            {
                AutoUpdate = true;
                XmlName = 'Item';
                fieldelement(No;Item."No.")
                {
                }
                textelement(vCapCode)
                {
                }
                textelement(TxtZone2Retail)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(vZone2Retail,TxtZone2Retail) = false then Message('Invalid Amount');
                    end;
                }
                textelement(TxtZone3Retail)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(vZone3Retail,TxtZone3Retail) = false then Message('Invalid Amount');
                    end;
                }
                textelement(TxtZoneNRetail)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(vZoneNRetail,TxtZoneNRetail) = false then Message('Invalid Amount');
                    end;
                }
                textelement(vUPCforSMS)
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
        UPC: Record "Item UPC Table";
        ZONE: Record "Margin Category";
        vItemNo: Text;
        vZone2Retail: Decimal;
        vZone3Retail: Decimal;
        vZoneNRetail: Decimal;
        Window: Dialog;

    local procedure LookupUPCTable()
    begin
        UPC.SetRange("Item No.",vItemNo);

        if UPC.Find('-') then
            begin
                UPC."Zone 1 Retail" := vZone2Retail;
                UPC."Zone 3 Retail" := vZone3Retail;
                UPC."Zone N Retail" := vZoneNRetail;
                UPC."Zone 1 Price File Created" := false;
                UPC."Zone 3 Price File Created" := false;
                UPC."Zone N Price File Created" := false;
                UPC."Last Date Updated" := Today;
                UPC."Last User" := UserId;
                UPC.Modify;
            end;
    end;

    local procedure LookupZoneRetail()
    begin

        ZONE.SetRange("Margin Category",vItemNo);

        if ZONE.Find('-') then
            begin
                ZONE."Fixed Retail Zone 1/2" := vZone2Retail;
                ZONE."Fixed Retail Zone 3" := vZone3Retail;
                ZONE."Fixed Retail Zone N" := vZoneNRetail;
                ZONE."Last Date Updated" := Today;
                ZONE."Last User" := UserId;
                //ZONE."Date Created" := TODAY;
                ZONE.Modify;
            end
        else
            begin
                ZONE.Init;
                ZONE."Margin Category" := vItemNo;
                ZONE.Margin := vCapCode;
                ZONE.Insert;
                ZONE."Fixed Retail Zone 1/2" := vZone2Retail;
                ZONE."Fixed Retail Zone 3" := vZone3Retail;
                ZONE."Fixed Retail Zone N" := vZoneNRetail;
                ZONE."Last Date Updated" := Today;
                ZONE."Last User" := UserId;
                ZONE."Date Created" := Today;
                ZONE.Modify;
            end;
    end;
}

