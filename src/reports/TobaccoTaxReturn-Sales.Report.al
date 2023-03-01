Report 50158 "Tobacco Tax Return - Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Tobacco Tax Return - Sales.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header";"Sales Invoice Header")
        {
            DataItemTableView = sorting("Posting Date");
            column(ReportForNavId_5581; 5581)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(FORMAT_VStartDate_0___Month_Text___;Format(VStartDate,0,'<Month Text>'))
            {
            }
            column(DATE2DMY_VStartDate_3_;Date2dmy(VStartDate,3))
            {
            }
            column(Sales_Invoice_Header__Posting_Date_;"Posting Date")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Bill_to_Name_;"Sales Invoice Header"."Bill-to Name")
            {
            }
            column(Sales_Invoice_Header__Sell_to_Customer_No__;"Sell-to Customer No.")
            {
            }
            column(Sales_Invoice_Header__No__;"No.")
            {
            }
            column(VCigTotal;VCigTotal)
            {
            }
            column(VPriceTotal;VPriceTotal)
            {
            }
            column(VFooterCig;VFooterCig)
            {
            }
            column(VFooterPrice;VFooterPrice)
            {
            }
            column(Municipality_of_AnchorageCaption;Municipality_of_AnchorageCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(SUPPORTING_SCHEDULECaption;SUPPORTING_SCHEDULECaptionLbl)
            {
            }
            column(Cigarette_and_Tobacco_Products_Tax_ReturnCaption;Cigarette_and_Tobacco_Products_Tax_ReturnCaptionLbl)
            {
            }
            column(ANICA__Inc_Caption;ANICA__Inc_CaptionLbl)
            {
            }
            column(Licensee_Caption;Licensee_CaptionLbl)
            {
            }
            column(V2655001Caption;V2655001CaptionLbl)
            {
            }
            column(License_No_Caption;License_No_CaptionLbl)
            {
            }
            column(FORMAT_VStartDate_0___Month_Text___Caption;FORMAT_VStartDate_0___Month_Text___CaptionLbl)
            {
            }
            column(YearCaption;YearCaptionLbl)
            {
            }
            column(Cigarettes_and_other_Tobacco_Products_acquiredCaption;Cigarettes_and_other_Tobacco_Products_acquiredCaptionLbl)
            {
            }
            column(Deductions_for_Sales_to_RegistrantsCaption;Deductions_for_Sales_to_RegistrantsCaptionLbl)
            {
            }
            column(Other_DeductionsCaption;Other_DeductionsCaptionLbl)
            {
            }
            column(XCaption;XCaptionLbl)
            {
            }
            column(Invoice_DateCaption;Invoice_DateCaptionLbl)
            {
            }
            column(Business_Name_of_Supplier_or_PurchaserCaption;Business_Name_of_Supplier_or_PurchaserCaptionLbl)
            {
            }
            column(Customer_or_Member_NumberCaption;Customer_or_Member_NumberCaptionLbl)
            {
            }
            column(Invoice_NumberCaption;Invoice_NumberCaptionLbl)
            {
            }
            column(VCigTotalCaption;VCigTotalCaptionLbl)
            {
            }
            column(VPriceTotalCaption;VPriceTotalCaptionLbl)
            {
            }
            column(Total_Number_of_Cigarettes_______________________________________________________________Caption;Total_Number_of_Cigarettes_______________________________________________________________CaptionLbl)
            {
            }
            column(Total_wholesale_price_of_Other_Tobacco_Products________________________________________________________Caption;Total_wholesale_price_of_Other_Tobacco_Products________________________________________________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For Progress Bar
                begin
                    CurRec := CurRec + 1;
                    if (TotalRec <> 0) then
                        Window.Update(1,ROUND(CurRec * 10000 / TotalRec,1));
                end;

                Clear(VCigTotal);
                Clear(VPriceTotal);
                Clear(VIsTobacco);

                VDocumentNo := "No.";

                //check lines for tobacco products.
                CheckForTobacco;

                //If tobacco is on the order, then look up sales shipment lines to get all tobacco from order.
                if VIsTobacco then
                    LookupLines
                else
                    CurrReport.Skip;

                VFooterCig := VFooterCig + VCigTotal;
                VFooterPrice := VFooterPrice + VPriceTotal;
            end;

            trigger OnPostDataItem()
            begin
                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date",VStartDate,VEndDate);

                //For progress bar
                begin
                    Clear(Window);
                    Window.Open('Processing @1@@@@@@@@');
                    TotalRec := COUNTAPPROX;
                    CurRec := 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(VStartDate;VStartDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Start Date';
                    }
                    field(VEndDate;VEndDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'End Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Lines: Record "Sales Invoice Line";
        Item: Record Item;
        VStartDate: Date;
        VEndDate: Date;
        VDocumentNo: Code[10];
        VCigCount: Integer;
        VCigTotal: Integer;
        VPrice: Decimal;
        VPriceTotal: Decimal;
        VItem: Code[20];
        VItemType: Option;
        VLastDirectCost: Decimal;
        VItemsPer: Integer;
        VFooterCig: Integer;
        VFooterPrice: Decimal;
        VIsTobacco: Boolean;
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        Municipality_of_AnchorageCaptionLbl: label 'Municipality of Anchorage';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        SUPPORTING_SCHEDULECaptionLbl: label 'SUPPORTING SCHEDULE';
        Cigarette_and_Tobacco_Products_Tax_ReturnCaptionLbl: label 'Cigarette and Tobacco Products Tax Return';
        ANICA__Inc_CaptionLbl: label 'ANICA, Inc.';
        Licensee_CaptionLbl: label 'Licensee:';
        V2655001CaptionLbl: label '2655001';
        License_No_CaptionLbl: label 'License No.';
        FORMAT_VStartDate_0___Month_Text___CaptionLbl: label 'For the month of:';
        YearCaptionLbl: label 'Year';
        Cigarettes_and_other_Tobacco_Products_acquiredCaptionLbl: label 'Cigarettes and other Tobacco Products acquired';
        Deductions_for_Sales_to_RegistrantsCaptionLbl: label 'Deductions for Sales to Registrants';
        Other_DeductionsCaptionLbl: label 'Other Deductions';
        XCaptionLbl: label 'X';
        Invoice_DateCaptionLbl: label 'Invoice Date';
        Business_Name_of_Supplier_or_PurchaserCaptionLbl: label 'Business Name of Supplier or Purchaser';
        Customer_or_Member_NumberCaptionLbl: label 'Customer or Member Number';
        Invoice_NumberCaptionLbl: label 'Invoice Number';
        VCigTotalCaptionLbl: label 'Number of Cigarettes';
        VPriceTotalCaptionLbl: label 'OTP Wholesle Price';
        Total_Number_of_Cigarettes_______________________________________________________________CaptionLbl: label 'Total Number of Cigarettes ..............................................................';
        Total_wholesale_price_of_Other_Tobacco_Products________________________________________________________CaptionLbl: label 'Total wholesale price of Other Tobacco Products .......................................................';


    procedure CheckForTobacco()
    begin
        Lines.SetCurrentkey("Document No.","Line No.");
        Lines.SetRange("Document No.",VDocumentNo);

        if Lines.Find('-') then
            repeat
                begin
                    VItem := Lines."No.";
                    LookupItem;

                    if VIsTobacco then
                        exit;
                end
            until Lines.Next = 0;
    end;


    procedure LookupLines()
    begin
        Lines.SetCurrentkey("Document No.","Line No.");
        Lines.SetRange("Document No.",VDocumentNo);

        if Lines.Find('-') then
            repeat
                begin
                    Clear(VItemType);
                    Clear(VCigCount);
                    Clear(VPrice);
                    VItem := Lines."No.";
                    LookupItem;

                    if VItemType = 1 then
                        begin
                            VCigCount := VItemsPer * Lines.Quantity;
                            VCigTotal := VCigTotal + VCigCount;
                        end
                    else if (VItemType = 2) and (Lines."No." <> '0001-0078') then
                        begin
                            VPrice := VLastDirectCost * Lines.Quantity;
                            VPriceTotal := VPriceTotal + VPrice;
                        end;
                end;
            until Lines.Next = 0;
    end;


    procedure LookupItem()
    begin
        Item.SetCurrentkey("No.");
        Item.SetRange("No.",VItem);

        if Item.Find('-') then
            begin
                VIsTobacco := Item."MSA Reporting";
                VLastDirectCost := Item."Last Direct Cost";
                VItemsPer := Item."Items Per Selling Unit";
                VItemType := Item."Tobacco Type";
            end;
    end;
}

