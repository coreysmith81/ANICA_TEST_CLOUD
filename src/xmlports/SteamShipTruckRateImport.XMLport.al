XmlPort 50060 "Steam Ship Truck Rate Import"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Steam Ship or Truck Rates";"Steam Ship or Truck Rates")
            {
                AutoUpdate = true;
                XmlName = 'SteamShiporTruckRates';
                fieldelement(FreightCode;"Steam Ship or Truck Rates"."Freight Code")
                {
                }
                fieldelement(Carrier;"Steam Ship or Truck Rates".Carrier)
                {
                }
                fieldelement(Origin;"Steam Ship or Truck Rates".Origin)
                {
                }
                fieldelement(Destination;"Steam Ship or Truck Rates".Destination)
                {
                }
                fieldelement(RateperPound;"Steam Ship or Truck Rates"."Rate per Pound")
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

