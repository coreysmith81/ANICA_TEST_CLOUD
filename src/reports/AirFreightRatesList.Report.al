Report 50097 "Air Freight Rates List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Air Freight Rates List.rdlc';

    dataset
    {
        dataitem("Air Freight Rates"; "Air Freight Rates")
        {
            DataItemTableView = sorting("Customer No.", "Air Rate Type", Carrier, Origin, Destination);
            RequestFilterFields = "Customer No.";
            column(ReportForNavId_2206; 2206)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Air_Freight_Rates__Customer_No__; "Customer No.")
            {
            }
            column(PName; PName)
            {
            }
            column(Air_Freight_Rates__Customer_No___Control8; "Customer No.")
            {
            }
            column(PName_Control7; PName)
            {
            }
            column(Air_Freight_Rates__Customer_No___Control11; "Customer No.")
            {
            }
            column(Air_Freight_Rates__Air_Rate_Type_; "Air Rate Type")
            {
            }
            column(Air_Freight_Rates_Carrier; Carrier)
            {
            }
            column(Air_Freight_Rates_Origin; Origin)
            {
            }
            column(Air_Freight_Rates_Destination; Destination)
            {
            }
            column(Air_Freight_Rates__Low_Flat_Rate_; "Low Flat Rate")
            {
            }
            column(Air_Freight_Rates__High_Flat_Rate_; "High Flat Rate")
            {
            }
            column(Air_Freight_Rates__Rate_per_pound_; "Rate per pound")
            {
            }
            column(Air_Freight_RatesCaption; Air_Freight_RatesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Air_Freight_Rates__Customer_No___Control11Caption; FieldCaption("Customer No."))
            {
            }
            column(Air_Freight_Rates__Air_Rate_Type_Caption; FieldCaption("Air Rate Type"))
            {
            }
            column(Air_Freight_Rates_CarrierCaption; FieldCaption(Carrier))
            {
            }
            column(Air_Freight_Rates_OriginCaption; FieldCaption(Origin))
            {
            }
            column(Air_Freight_Rates_DestinationCaption; FieldCaption(Destination))
            {
            }
            column(Air_Freight_Rates__Low_Flat_Rate_Caption; FieldCaption("Low Flat Rate"))
            {
            }
            column(Air_Freight_Rates__High_Flat_Rate_Caption; FieldCaption("High Flat Rate"))
            {
            }
            column(Air_Freight_Rates__Rate_per_pound_Caption; FieldCaption("Rate per pound"))
            {
            }
            column(Air_Freight_Rates__Customer_No__Caption; FieldCaption("Customer No."))
            {
            }
            column(Air_Freight_Rates__Customer_No___Control8Caption; FieldCaption("Customer No."))
            {
            }

            trigger OnAfterGetRecord()
            begin
                CustomerFile.SetCurrentkey(CustomerFile."No.");
                CustomerFile.SetRange(CustomerFile."No.", "Air Freight Rates"."Customer No.");
                if CustomerFile.Find('-') then PName := CustomerFile.Name;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Customer No.");
                //CustomerFile.SETCURRENTKEY(CustomerFile."No.");
                //CustomerFile.SETRANGE(CustomerFile."No.","Air Freight Rates"."Customer No.");
                //IF CustomerFile.FIND('-') THEN CustomerFile.Name := PName;
                //PageBreak := FALSE;
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
        CustomerFile: Record Customer;
        PName: Text[30];
        PageBreak: Boolean;
        Air_Freight_RatesCaptionLbl: label 'Air Freight Rates';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}

