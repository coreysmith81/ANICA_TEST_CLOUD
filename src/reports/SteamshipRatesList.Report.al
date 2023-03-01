Report 50098 "Steamship Rates List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Steamship Rates List.rdlc';

    dataset
    {
        dataitem("Steam Ship or Truck Rates";"Steam Ship or Truck Rates")
        {
            DataItemTableView = sorting("Freight Code",Carrier,Origin,Destination);
            RequestFilterFields = "Freight Code";
            column(ReportForNavId_7660; 7660)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(UserId;UserId)
            {
            }
            column(Steam_Ship_or_Truck_Rates__Freight_Code_;"Freight Code")
            {
            }
            column(FreightName;FreightName)
            {
            }
            column(Steam_Ship_or_Truck_Rates__Freight_Code__Control8;"Freight Code")
            {
            }
            column(FreightName_Control16;FreightName)
            {
            }
            column(Steam_Ship_or_Truck_Rates__Freight_Code__Control11;"Freight Code")
            {
            }
            column(Steam_Ship_or_Truck_Rates_Carrier;Carrier)
            {
            }
            column(Steam_Ship_or_Truck_Rates_Origin;Origin)
            {
            }
            column(Steam_Ship_or_Truck_Rates_Destination;Destination)
            {
            }
            column(Steam_Ship_or_Truck_Rates__Rate_per_Pound_;"Rate per Pound")
            {
            }
            column(Steam_Ship_or_Truck_RatesCaption;Steam_Ship_or_Truck_RatesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Steam_Ship_or_Truck_Rates__Freight_Code__Control11Caption;FieldCaption("Freight Code"))
            {
            }
            column(Steam_Ship_or_Truck_Rates_CarrierCaption;FieldCaption(Carrier))
            {
            }
            column(Steam_Ship_or_Truck_Rates_OriginCaption;FieldCaption(Origin))
            {
            }
            column(Steam_Ship_or_Truck_Rates_DestinationCaption;FieldCaption(Destination))
            {
            }
            column(Steam_Ship_or_Truck_Rates__Rate_per_Pound_Caption;FieldCaption("Rate per Pound"))
            {
            }
            column(Steam_Ship_or_Truck_Rates__Freight_Code_Caption;FieldCaption("Freight Code"))
            {
            }
            column(Steam_Ship_or_Truck_Rates__Freight_Code__Control8Caption;FieldCaption("Freight Code"))
            {
            }

            trigger OnAfterGetRecord()
            begin

                CurrReport.SHOWOUTPUT :=
                  CurrReport.TOTALSCAUSEDBY = "Steam Ship or Truck Rates".FieldNo("Freight Code");
                FreightCodeFile.SetCurrentkey(FreightCodeFile."Freight Code");
                FreightCodeFile.SetRange(FreightCodeFile."Freight Code","Steam Ship or Truck Rates"."Freight Code");
                if FreightCodeFile.Find('-') then FreightName := FreightCodeFile.Description;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Freight Code");
            end;
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

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        FreightName: Text[30];
        FreightCodeFile: Record "Freight Code";
        Steam_Ship_or_Truck_RatesCaptionLbl: label 'Steam Ship or Truck Rates';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}

