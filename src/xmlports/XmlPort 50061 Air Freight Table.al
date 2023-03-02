XmlPort 50061 "Air Freight Table"
{
    Direction = Both;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Air Freight Rates";"Air Freight Rates")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'AirFreightRates';
                fieldelement(CustomerNo;"Air Freight Rates"."Customer No.")
                {
                }
                fieldelement(AirRateType;"Air Freight Rates"."Air Rate Type")
                {
                }
                fieldelement(Carrier;"Air Freight Rates".Carrier)
                {
                }
                fieldelement(Origin;"Air Freight Rates".Origin)
                {
                }
                fieldelement(Destination;"Air Freight Rates".Destination)
                {
                }
                fieldelement(RatePerPound;"Air Freight Rates"."Rate per pound")
                {
                }
                fieldelement(LowFlatRate;"Air Freight Rates"."Low Flat Rate")
                {
                }
                fieldelement(HighFlatRate;"Air Freight Rates"."High Flat Rate")
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

