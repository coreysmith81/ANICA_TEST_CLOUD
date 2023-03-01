XmlPort 50064 "Barge Rates Import"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Barge Rates";"Barge Rates")
            {
                AutoReplace = true;
                XmlName = 'BargeRates';
                fieldelement(BargeZone;"Barge Rates"."Barge Zone")
                {
                }
                fieldelement(FreightCode;"Barge Rates"."Freight Code")
                {
                }
                fieldelement(Carrier;"Barge Rates".Carrier)
                {
                }
                fieldelement(RatePerPound;"Barge Rates"."Rate per pound")
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
}

