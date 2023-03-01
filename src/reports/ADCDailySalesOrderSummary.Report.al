Report 50045 "ADC Daily Sales Order Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ADC Daily Sales Order Summary.rdlc';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "Sell-to Customer No.", "No.") order(ascending) where("Document Type" = filter(Order), "Location Code" = filter('ADC'));
            RequestFilterFields = "Document Date", "No. Printed", "Location Code", Approved, "No.", "Shipping Instruction Code";
            column(ReportForNavId_6640; 6640)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(PrintPick; PrintPick)
            {
            }
            column(Sales_Header_Amount; Amount)
            {
            }
            column(Sales_Header__Document_Date_; "Document Date")
            {
            }
            column(PDropShip; PDropShip)
            {
            }
            column(PReleased; PReleased)
            {
            }
            column(POVendor; POVendor)
            {
            }
            column(Sales_Header__Shipping_Instruction_Code_; "Shipping Instruction Code")
            {
            }
            column(PVendType; PVendType)
            {
                OptionMembers = " ",Budget,Grocery,JBG,OMC,Polaris,Skidoo,Warehouse,"Yakima ",Breakout;
            }
            column(POReleased; POReleased)
            {
            }
            column(TOrderWeight; TOrderWeight)
            {
            }
            column(PVendName; PVendName)
            {
            }
            column(PPurchOrder; PPurchOrder)
            {
            }
            column(Pconfirm; Pconfirm)
            {
                OptionMembers = " ",Phone,Fax,EDI,Special;
            }
            column(Sales_Header__Sales_Order_Type_; "Sales Order Type")
            {
            }
            column(VDestCde; VDestCde)
            {
            }
            column(VOrderAmt; VOrderAmt)
            {
            }
            column(VOrderWt; VOrderWt)
            {
            }
            column(TotalAmt; TotalAmt)
            {
            }
            column(TotalWeight; TotalWeight)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Clear print variables
                PReleased := '';
                PDropShip := '';
                PPurchOrder := '';
                Pconfirm := 0;
                POVendor := '';
                PVendName := '';
                PVendType := 0;
                POReleased := '';
                VCheckDropShip := false;
                PItemNo := '';
                VDestCde := '';

                Customer.SetCurrentkey(Customer."No.");
                Customer.SetRange(Customer."No.", "Sales Header"."Sell-to Customer No.");
                if Customer.Find('-') then VDestCde := Customer."Destination Code";

                if "Sales Header".Status = "Sales Document Status"::Released then PReleased := 'X';
                SalesLine.SetCurrentkey("Document Type", "Document No.");
                SalesLine.SetRange("Document Type", 1);
                SalesLine.SetRange("Document No.", "Sales Header"."No.");
                if SalesLine.Find('-') then begin
                    if SalesLine."Drop Shipment" = true then begin
                        PDropShip := 'X';
                        VCheckDropShip := true;
                    end;
                    PPurchOrder := SalesLine."Purchase Order No.";
                    if SalesLine.Type = 2 then PItemNo := SalesLine."No.";
                    //Total freight for the order
                    TOrderWeight := 0;
                    repeat
                        VOrderAmt := VOrderAmt + SalesLine.Amount;
                        VOrderWt := VOrderWt + (SalesLine.Quantity * SalesLine."Gross Weight");
                        TOrderWeight := TOrderWeight + (SalesLine.Quantity * SalesLine."Gross Weight");
                    until SalesLine.Next = 0;
                end;
                VPickType := 0;
                PrintPick := '';

                if PItemNo <> '' then begin
                    ItemRecord.Get(PItemNo);
                    //CS 01-11-16: Filter down to Vendor specified on request page.
                    if (VVendorSort <> '') and (ItemRecord."Vendor No." = VVendorSort) then
                        POVendor := ItemRecord."Vendor No."
                    else
                        if VVendorSort = '' then
                            POVendor := ItemRecord."Vendor No."
                        else
                            CurrReport.Skip;
                end;

                //Get Pick type
                VPickType := ItemRecord."Pick Type";
                case VPickType of
                    1:
                        PrintPick := 'Hazardous/Air';
                    2:
                        PrintPick := 'Freeze/Chill';
                    else
                        PrintPick := ''
                end;

                if PPurchOrder <> '' then begin
                    PurchHead.SetCurrentkey("Document Type", "No.");
                    PurchHead.SetRange("Document Type", 1);
                    PurchHead.SetRange("No.", PPurchOrder);
                    if PurchHead.Find('+') then begin
                        Pconfirm := PurchHead."ANICA Confirmed";
                        //CS 01-11-16: Filter down to Vendor specified on request page.
                        if (VVendorSort <> '') and (ItemRecord."Vendor No." = VVendorSort) then
                            POVendor := PurchHead."Buy-from Vendor No."
                        else
                            if VVendorSort = '' then
                                POVendor := PurchHead."Buy-from Vendor No."
                            else
                                CurrReport.Skip;
                        if PurchHead.Status = 1 then POReleased := 'X';
                    end;
                end;

                if (PDropShip <> 'X') and ("Sales Header"."Location Code" = 'ADC')
                then
                    POVendor := '';


                if POVendor <> '' then begin
                    VendorRecord.Get(POVendor);
                    PVendName := VendorRecord.Name;
                    PVendType := VendorRecord."Vendor Type Code";
                end;

                //Print Grocery Orders Only
                if PGroceryOnly = true then begin
                    if PVendType <> 2 then CurrReport.Skip;
                end;

                //Print Inventory Orders Only
                if PInventoryOnly = true then begin
                    if VCheckDropShip = true then CurrReport.Skip;
                    if "Sales Header"."Sales Order Type" = 3 then CurrReport.Skip;
                end;

                //Print Promotional Orders Only
                if PPromoOnly = true then begin
                    if "Sales Header"."Sales Order Type" <> 3 then CurrReport.Skip;
                end;

                TotalAmt := TotalAmt + Amount;
                TotalWeight := TotalWeight + TOrderWeight;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals(VOrderAmt);
                CurrReport.CreateTotals(VOrderWt);
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
                    field(PGroceryOnly; PGroceryOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Grocery Orders Only';
                    }
                    field(PInventoryOnly; PInventoryOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Inventory Orders Only';
                    }
                    field(PPromoOnly; PPromoOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Promotional Orders Only';
                    }
                    field(VVendorSort; VVendorSort)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Vendor (Leave blank to see all)';
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
        TotalAmt: Decimal;
        TotalWeight: Decimal;
        SalesLine: Record "Sales Line";
        PurchHead: Record "Purchase Header";
        VendorRecord: Record Vendor;
        ItemRecord: Record Item;
        PPurchOrder: Code[10];
        PDropShip: Code[10];
        Pconfirm: Option;
        PReleased: Code[10];
        POVendor: Code[10];
        PVendName: Text[30];
        PVendType: Option;
        PItemNo: Code[20];
        POReleased: Code[10];
        TOrderWeight: Decimal;
        PGroceryOnly: Boolean;
        PInventoryOnly: Boolean;
        VCheckDropShip: Boolean;
        PrintPick: Text[30];
        VPickType: Option;
        PPromoOnly: Boolean;
        Customer: Record Customer;
        VDestCde: Code[10];
        VOrderWt: Decimal;
        VOrderAmt: Decimal;
        Text19066490: label 'Print Grocery Orders Only';
        PAGECaptionLbl: label 'PAGE';
        ANCHORAGE_DAILY_SALES_ORDERS_SUMMARYCaptionLbl: label 'ANCHORAGE DAILY SALES ORDERS SUMMARY';
        Drop_ShipCaptionLbl: label 'Drop Ship';
        RlsdCaptionLbl: label 'Rlsd';
        Ship_CodeCaptionLbl: label 'Ship Code';
        Vendor_TypeCaptionLbl: label 'Vendor Type';
        RlsdCaption_Control40Lbl: label 'Rlsd';
        WeightCaptionLbl: label 'Weight';
        PO_ConfirmCaptionLbl: label 'PO Confirm';
        PO_No_CaptionLbl: label 'PO No.';
        PO_VendorCaptionLbl: label 'PO Vendor';
        Destination_CodeCaptionLbl: label 'Destination Code';
        Store_TotalsCaptionLbl: label 'Store Totals';
        TOTALCaptionLbl: label 'TOTAL';
        VVendorSort: Code[10];
}

