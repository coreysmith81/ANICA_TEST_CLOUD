XmlPort 50062 "Parcel Post Direct Rates"
{
    Caption = 'Parcel Post Direct Rates';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Parcel Post Direct Rates";"Parcel Post Direct Rates")
            {
                AutoReplace = true;
                XmlName = 'ParcelPostDirectRates';
                fieldelement(CommodityCode;"Parcel Post Direct Rates"."Commodity Code")
                {
                }
                fieldelement(SeaorAnch;"Parcel Post Direct Rates"."Sea or Anch")
                {
                }
                fieldelement(Priority;"Parcel Post Direct Rates".Priority)
                {
                }
                fieldelement(Rateperdollar;"Parcel Post Direct Rates"."Rate per dollar")
                {
                }
                fieldelement(PriorityType;"Parcel Post Direct Rates"."Priority Type")
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

