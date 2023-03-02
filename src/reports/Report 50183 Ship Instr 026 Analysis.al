Report 50183 "Ship Instr 026 Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Ship Instr 026 Analysis.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("Sell-to Customer No.", "Order Date") order(ascending); //Removed the WHERE that filtered order date on 01-11-11..08-31-11
            RequestFilterFields = "No.", "Posting Date";
            column(ReportForNavId_5581; 5581)
            {
            }
            column(Sales_Invoice_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(Sales_Invoice_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
            {
            }
            column(Sales_Invoice_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Sales_Invoice_Header__No__; "No.")
            {
            }
            column(VExpectedFreight; VExpectedFreight)
            {
            }
            column(VPriorityFreight; VPriorityFreight)
            {
            }
            column(VDifference; VDifference)
            {
            }
            column(VParcelPostFreight; VParcelPostFreight)
            {
            }
            column(VTotalWeight; VTotalWeight)
            {
            }
            column(VTotPriorityFreight; VTotPriorityFreight)
            {
            }
            column(VTotDifference; VTotDifference)
            {
            }
            column(VTotExpectedFreight; VTotExpectedFreight)
            {
            }
            column(VTotParcelPostFreight; VTotParcelPostFreight)
            {
            }
            column(VGrandPriorityFreight; VGrandPriorityFreight)
            {
            }
            column(VGrandDifference; VGrandDifference)
            {
            }
            column(VGrandExpectedFreight; VGrandExpectedFreight)
            {
            }
            column(VGrandParcelPostFreight; VGrandParcelPostFreight)
            {
            }
            column(Sales_Invoice_Header__Posting_Date_Caption; FieldCaption("Posting Date"))
            {
            }
            column(Priority_FreightCaption; Priority_FreightCaptionLbl)
            {
            }
            column(DifferenceCaption; DifferenceCaptionLbl)
            {
            }
            column(Estimated_FreightCaption; Estimated_FreightCaptionLbl)
            {
            }
            column(Actual_FreightCaption; Actual_FreightCaptionLbl)
            {
            }
            column(Total_WeightCaption; Total_WeightCaptionLbl)
            {
            }
            column(Sales_Invoice_Header__No__Caption; FieldCaption("No."))
            {
            }
            column(Sales_Invoice_Header__Bill_to_Name_Caption; FieldCaption("Bill-to Name"))
            {
            }
            column(Sales_Invoice_Header__Sell_to_Customer_No__Caption; FieldCaption("Sell-to Customer No."))
            {
            }
            column(Customer_TotalsCaption; Customer_TotalsCaptionLbl)
            {
            }
            column(Grand_TotalsCaption; Grand_TotalsCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //The data has already been limited to 1-1-11 to 8-31-11

                //Only analzye shipping instruction 026
                if "Sales Invoice Header"."Shipping Instruction Code" <> '026' then CurrReport.Skip;

                LookupCustomer;

                //Get total weight and frieght amount charged
                LookupLines;

                //Calc expected freight
                CalcFreight;

                //Used to check for new customer, change in totals
                VCheckCustomer := "Sales Invoice Header"."Sell-to Customer No.";
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

    trigger OnPreReport()
    begin
        Window.Open('Processing Record #1##########');
        Window.Update(1, "Sales Invoice Header"."No.");
    end;

    var
        CustomerTable: Record Customer;
        SalesLineTable: Record "Sales Invoice Line";
        Window: Dialog;
        VZone: Text[30];
        VTotalWeight: Decimal;
        VParcelPostFreight: Decimal;
        VParcelRate: Decimal;
        VPriorityRate: Decimal;
        VExpectedFreight: Decimal;
        VPriorityFreight: Decimal;
        VDifference: Decimal;
        VTotParcelPostFreight: Decimal;
        VTotExpectedFreight: Decimal;
        VTotPriorityFreight: Decimal;
        VTotDifference: Decimal;
        VCheckCustomer: Code[10];
        VGrandParcelPostFreight: Decimal;
        VGrandExpectedFreight: Decimal;
        VGrandPriorityFreight: Decimal;
        VGrandDifference: Decimal;
        Priority_FreightCaptionLbl: label 'Priority Freight';
        DifferenceCaptionLbl: label 'Difference';
        Estimated_FreightCaptionLbl: label 'Estimated Freight';
        Actual_FreightCaptionLbl: label 'Actual Freight';
        Total_WeightCaptionLbl: label 'Total Weight';
        Customer_TotalsCaptionLbl: label 'Customer Totals';
        Grand_TotalsCaptionLbl: label 'Grand Totals';


    procedure LookupCustomer()
    begin
        VZone := '';
        CustomerTable.SetCurrentkey("No.");
        CustomerTable.SetRange("No.", "Sales Invoice Header"."Sell-to Customer No.");
        if CustomerTable.Find('+') then begin
            VZone := CustomerTable."Parcel Post Code";
        end;
    end;


    procedure LookupLines()
    begin
        //Get total order weight and freight line total
        VTotalWeight := 0;
        VParcelPostFreight := 0;
        SalesLineTable.SetCurrentkey("Document No.");
        SalesLineTable.SetRange("Document No.", "Sales Invoice Header"."No.");
        if SalesLineTable.Find('-') then
            repeat
            begin
                if SalesLineTable."Gross Weight" <> 0 then
                    VTotalWeight := VTotalWeight + (SalesLineTable.Quantity * SalesLineTable."Gross Weight");
                //MESSAGE('Gross weight, quantity, weight %1 %2 %3', VTotalWeight,SalesLineTable.Quantity, SalesLineTable."Gross Weight");
                if SalesLineTable.Description = 'Warehouse Parcel Post Billed' then
                    VParcelPostFreight := SalesLineTable.Amount;

            end;
            until SalesLineTable.Next = 0;

        SalesLineTable.SetRange("Document No.");//clear filter
    end;


    procedure CalcFreight()
    begin
        //Get correct rates for zone
        VParcelRate := 0;
        VPriorityRate := 0;
        VExpectedFreight := 0;
        VPriorityFreight := 0;

        //Clear totals if this is a new customer
        if VCheckCustomer <> "Sales Invoice Header"."Sell-to Customer No." then begin
            VTotParcelPostFreight := 0;
            VTotExpectedFreight := 0;
            VTotPriorityFreight := 0;
            VTotDifference := 0;
        end;

        case VZone of
            'ZONE N':
                VParcelRate := 0.373;
            'ZONE 1/2':
                VParcelRate := 0.455;
            'ZONE 3':
                VParcelRate := 0.515;
        end;

        case VZone of
            'ZONE N':
                VPriorityRate := 1.18;
            'ZONE 1/2':
                VPriorityRate := 0.75;
            'ZONE 3':
                VPriorityRate := 0.97;
        end;

        VExpectedFreight := VTotalWeight * VParcelRate;
        VPriorityFreight := VTotalWeight * VPriorityRate;
        VDifference := VParcelPostFreight - VExpectedFreight;

        //For now, skip the record if there is little freight variance
        if Abs(VParcelPostFreight - VPriorityFreight) > 1 then CurrReport.Skip;

        //Get Report Totals
        VTotParcelPostFreight := VTotParcelPostFreight + VParcelPostFreight;
        VTotExpectedFreight := VTotExpectedFreight + VExpectedFreight;
        VTotPriorityFreight := VTotPriorityFreight + VPriorityFreight;
        VTotDifference := VTotDifference + VDifference;

        //Get Grand Totals
        VGrandParcelPostFreight := VParcelPostFreight + VGrandParcelPostFreight;
        VGrandExpectedFreight := VExpectedFreight + VGrandExpectedFreight;
        VGrandPriorityFreight := VPriorityFreight + VGrandPriorityFreight;
        VGrandDifference := VDifference + VGrandDifference;
    end;
}

