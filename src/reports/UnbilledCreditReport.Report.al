Report 50026 "Unbilled Credit Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Unbilled Credit Report.rdlc';

    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = sorting("Credit Report") order(ascending) where("Global Dimension 1 Code"=filter('ANICA'));
            PrintOnlyIfDetail = false;
            column(ReportForNavId_6836; 6836)
            {
            }
            column(Today;Today)
            {
            }
            column(Time;Time)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(Customer__Credit_Report_;"Credit Report")
            {
            }
            column(Customer__Credit_Report__Control16;"Credit Report")
            {
            }
            column(Customer_Name;Name)
            {
            }
            column(Barge;Barge)
            {
            }
            column(Supplemt;Supplemt)
            {
            }
            column(Seasonal;Seasonal)
            {
            }
            column(Promo;Promo)
            {
            }
            column(Fuel;Fuel)
            {
            }
            column(Total;Total)
            {
            }
            column(Barge_Control26;Barge)
            {
            }
            column(Supplemt_Control27;Supplemt)
            {
            }
            column(Seasonal_Control28;Seasonal)
            {
            }
            column(Promo_Control29;Promo)
            {
            }
            column(Fuel_Control30;Fuel)
            {
            }
            column(Total_Control31;Total)
            {
            }
            column(TotalBarge;TotalBarge)
            {
            }
            column(TotalSupple;TotalSupple)
            {
            }
            column(TotalSeason;TotalSeason)
            {
            }
            column(TotalPromo;TotalPromo)
            {
            }
            column(TotalFuel;TotalFuel)
            {
            }
            column(TotalTotal;TotalTotal)
            {
            }
            column(ANICACaption;ANICACaptionLbl)
            {
            }
            column(UNBILLED_BREAKDOWNCaption;UNBILLED_BREAKDOWNCaptionLbl)
            {
            }
            column(PAGECaption;PAGECaptionLbl)
            {
            }
            column(VILLAGE_STORECaption;VILLAGE_STORECaptionLbl)
            {
            }
            column(BARGECaption;BARGECaptionLbl)
            {
            }
            column(SUPPLEMENTALCaption;SUPPLEMENTALCaptionLbl)
            {
            }
            column(SEASONALCaption;SEASONALCaptionLbl)
            {
            }
            column(FUEL_PO_sCaption;FUEL_PO_sCaptionLbl)
            {
            }
            column(PROMO_PO_sCaption;PROMO_PO_sCaptionLbl)
            {
            }
            column(TOTALCaption;TOTALCaptionLbl)
            {
            }
            column(SUB_TOTALSCaption;SUB_TOTALSCaptionLbl)
            {
            }
            column(TOTALSCaption;TOTALSCaptionLbl)
            {
            }
            column(Customer_No_;"No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Credit Report" = 0 then
                     CurrReport.Skip;


                SalesHeader.SetCurrentkey(SalesHeader."Document Type",SalesHeader."Bill-to Customer No.");
                SalesHeader.SetRange(SalesHeader."Document Type",1);
                SalesHeader.SetRange(SalesHeader."Bill-to Customer No.",Customer."No.");
                if SalesHeader.Find('-') then
                begin
                repeat
                SalesHeader.CalcFields(SalesHeader."Outstanding Amount");
                if SalesHeader."Sales Order Type" = 0 then Barge := Barge + SalesHeader."Outstanding Amount";
                if SalesHeader."Sales Order Type" = 1 then Supplemt := Supplemt + SalesHeader."Outstanding Amount";
                if SalesHeader."Sales Order Type" = 2 then Seasonal := Seasonal + SalesHeader."Outstanding Amount";
                if SalesHeader."Sales Order Type" = 3 then Promo := Promo + SalesHeader."Outstanding Amount";
                if SalesHeader."Sales Order Type" = 4 then Fuel := Fuel + SalesHeader."Outstanding Amount";
                until SalesHeader.Next = 0;
                TotalBarge := TotalBarge + Barge;
                TotalSupple := TotalSupple + Supplemt;
                TotalSeason := TotalSeason + Seasonal;
                TotalPromo := TotalPromo + Promo;
                TotalFuel := TotalFuel + Fuel;
                Total := Total + Barge + Supplemt + Seasonal + Promo + Fuel;
                SubTotal := SubTotal + Total;
                TotalTotal := TotalTotal + Total;
                end;
            end;

            trigger OnPostDataItem()
            begin
                if SalesHeader."Sales Order Type" = 0 then Barge := Barge + SalesHeader."Outstanding Amount";
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals(Total);
                CurrReport.CreateTotals(Supplemt);
                CurrReport.CreateTotals(Barge);
                CurrReport.CreateTotals(Seasonal);
                CurrReport.CreateTotals(Promo);
                CurrReport.CreateTotals(Fuel);
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
        VCredLim: Option;
        Barge: Decimal;
        Supplemt: Decimal;
        Seasonal: Decimal;
        Fuel: Decimal;
        Promo: Decimal;
        Total: Decimal;
        SubBarge: Decimal;
        SubSupple: Decimal;
        SubSeason: Decimal;
        SubFuel: Decimal;
        SubPromo: Decimal;
        SubTotal: Decimal;
        TotalBarge: Decimal;
        TotalSupple: Decimal;
        TotalSeason: Decimal;
        TotalFuel: Decimal;
        TotalPromo: Decimal;
        TotalTotal: Decimal;
        SalesHeader: Record "Sales Header";
        ANICACaptionLbl: label 'ANICA';
        UNBILLED_BREAKDOWNCaptionLbl: label 'UNBILLED BREAKDOWN';
        PAGECaptionLbl: label 'PAGE';
        VILLAGE_STORECaptionLbl: label 'VILLAGE STORE';
        BARGECaptionLbl: label 'BARGE';
        SUPPLEMENTALCaptionLbl: label 'SUPPLEMENTAL';
        SEASONALCaptionLbl: label 'SEASONAL';
        FUEL_PO_sCaptionLbl: label 'FUEL PO''s';
        PROMO_PO_sCaptionLbl: label 'PROMO PO''s';
        TOTALCaptionLbl: label 'TOTAL';
        SUB_TOTALSCaptionLbl: label 'SUB TOTALS';
        TOTALSCaptionLbl: label 'TOTALS';
}

