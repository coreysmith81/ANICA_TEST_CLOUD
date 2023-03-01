Report 50089 "Daily Sales Order Freight Code"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Daily Sales Order Freight Code.rdlc';

    dataset
    {
        dataitem("Sales Header";"Sales Header")
        {
            DataItemTableView = sorting("Document Type","Sell-to Customer No.","No.") order(ascending) where("Document Type"=filter(Order));
            RequestFilterFields = "Document Date","Location Code",Field99001925,Approved,"No.","Shipping Instruction Code";
            column(ReportForNavId_6640; 6640)
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
            column(Sales_Header__No__;"No.")
            {
            }
            column(Sales_Header__Bill_to_Name_;"Bill-to Name")
            {
            }
            column(Sales_Header__Salesperson_Code_;"Salesperson Code")
            {
            }
            column(Sales_Header_Amount;Amount)
            {
            }
            column(Sales_Header__Document_Date_;"Document Date")
            {
            }
            column(PDropShip;PDropShip)
            {
            }
            column(Sales_Header__Location_Code_;"Location Code")
            {
            }
            column(PPurchOrder;PPurchOrder)
            {
            }
            column(POVendor;POVendor)
            {
            }
            column(Sales_Header__Shipping_Instruction_Code_;"Shipping Instruction Code")
            {
            }
            column(PVendName;PVendName)
            {
            }
            column(PVendType;PVendType)
            {
                OptionMembers = " ",Budget,Grocery,JBG,OMC,Polaris,Skidoo,Warehouse,"Yakima ",Breakout;
            }
            column(Sales_Header__Sales_Order_Type_;"Sales Order Type")
            {
            }
            column(Sales_Header__Sell_to_Customer_No__;"Sell-to Customer No.")
            {
            }
            column(PFOBCode;PFOBCode)
            {
            }
            column(TotalAmt;TotalAmt)
            {
            }
            column(PAGECaption;PAGECaptionLbl)
            {
            }
            column(DAILY_SALES_ORDERS_SUMMARY___FREIGHT_CODESCaption;DAILY_SALES_ORDERS_SUMMARY___FREIGHT_CODESCaptionLbl)
            {
            }
            column(Sales_Header__No__Caption;FieldCaption("No."))
            {
            }
            column(StoreCaption;StoreCaptionLbl)
            {
            }
            column(Sales_Header__Document_Date_Caption;FieldCaption("Document Date"))
            {
            }
            column(Sales_Header_AmountCaption;FieldCaption(Amount))
            {
            }
            column(Purch_CodeCaption;Purch_CodeCaptionLbl)
            {
            }
            column(Drop_ShipCaption;Drop_ShipCaptionLbl)
            {
            }
            column(LocationCaption;LocationCaptionLbl)
            {
            }
            column(PO_No_Caption;PO_No_CaptionLbl)
            {
            }
            column(PO_VendorCaption;PO_VendorCaptionLbl)
            {
            }
            column(Ship_CodeCaption;Ship_CodeCaptionLbl)
            {
            }
            column(Vendor_TypeCaption;Vendor_TypeCaptionLbl)
            {
            }
            column(Sales_Header__Sales_Order_Type_Caption;FieldCaption("Sales Order Type"))
            {
            }
            column(FOB_CodeCaption;FOB_CodeCaptionLbl)
            {
            }
            column(TOTALCaption;TOTALCaptionLbl)
            {
            }
            column(Sales_Header_Document_Type;"Document Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmt := TotalAmt + Amount;

                //Clear print variables
                PReleased := '';
                PDropShip := '';
                PPurchOrder := '';
                Pconfirm := 0;
                POVendor := '';
                PVendName := '';
                PVendType := 0;
                POReleased := '';
                PPurchOrder := '';
                PItemNo := '';
                PFOBCode := '';


                //IF Released = TRUE THEN PReleased := 'X';
                if "Sales Header".Status = 1 then PReleased := 'X';
                SalesLine.SetCurrentkey("Document Type","Document No.");
                SalesLine.SetRange("Document Type",1);
                SalesLine.SetRange("Document No.","Sales Header"."No.");
                if SalesLine.Find('-') then
                begin
                if SalesLine."Drop Shipment" = true then PDropShip := 'X';
                PPurchOrder := SalesLine."Purchase Order No.";
                if SalesLine.Type = 2 then PItemNo  := SalesLine."No.";
                end;

                if PItemNo <> '' then
                begin
                ItemRecord.Get(PItemNo);
                POVendor := ItemRecord."Vendor No.";
                PFOBCode := ItemRecord."FOB Code"
                end;

                if PPurchOrder <> '' then
                begin
                PurchHead.SetCurrentkey("Document Type","No.");
                PurchHead.SetRange("Document Type",1);
                PurchHead.SetRange("No.",PPurchOrder);
                  if PurchHead.Find('+') then
                  begin
                  Pconfirm := PurchHead."ANICA Confirmed";
                  POVendor := PurchHead."Buy-from Vendor No.";
                //  IF PurchHead.Released = TRUE THEN POReleased := 'X';
                  if PurchHead.Status = 1 then POReleased := 'X';
                  end;
                end;
                if VConfirm = true then
                begin
                  if PurchHead."ANICA Confirmed" <> 0 then CurrReport.Skip;
                end;

                if (PDropShip <> 'X') and ("Sales Header"."Location Code" = 'ADC')
                then POVendor := '';


                if POVendor <> '' then
                begin
                VendorRecord.Get(POVendor);
                PVendName := VendorRecord.Name;
                PVendType := VendorRecord."Vendor Type Code";
                end;
            end;

            trigger OnPreDataItem()
            begin
                //Get the filter applied in the request form for document date to be used for transfer reporting section
                SalesDatefilter := "Sales Header".GetFilter("Document Date");

                //Check to see if the date is a range
                SeparatorPos := StrPos(SalesDatefilter, '..');
                StrLength := StrLen(SalesDatefilter);
                if SeparatorPos <> 0 then
                begin
                //Change the text response to a date
                Evaluate(SalesReqFilterDate,CopyStr(SalesDatefilter,1,SeparatorPos-1));
                Evaluate(SalesReqEndDate,CopyStr(SalesDatefilter,SeparatorPos+2,StrLength-SeparatorPos-1));
                end
                else
                begin
                //Change the text response to a date
                Evaluate(SalesReqFilterDate,SalesDatefilter);
                SalesReqEndDate := SalesReqFilterDate;
                end;

                //MESSAGE('filter string, begin date and end date %1 %2 %3',SalesDatefilter,SalesReqFilterDate,SalesReqEndDate);
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
                    field(VConfirm;VConfirm)
                    {
                        ApplicationArea = Basic;
                    }
                    label(Control2)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Text19012320;
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
        SalesLine: Record "Sales Line";
        PurchHead: Record "Purchase Header";
        VendorRecord: Record Vendor;
        ItemRecord: Record Item;
        PPurchOrder: Code[10];
        PDropShip: Code[10];
        Pconfirm: Option;
        PReleased: Code[10];
        PFOBCode: Code[10];
        POVendor: Code[10];
        PVendName: Text[30];
        PVendType: Option;
        PItemNo: Code[20];
        POReleased: Code[10];
        VConfirm: Boolean;
        SalesDatefilter: Text[30];
        SalesReqFilterDate: Date;
        SalesReqEndDate: Date;
        SeparatorPos: Decimal;
        StrLength: Decimal;
        Text19012320: label 'Exclude PO Confirmed';
        PAGECaptionLbl: label 'PAGE';
        DAILY_SALES_ORDERS_SUMMARY___FREIGHT_CODESCaptionLbl: label 'DAILY SALES ORDERS SUMMARY - FREIGHT CODES';
        StoreCaptionLbl: label 'Store';
        Purch_CodeCaptionLbl: label 'Purch Code';
        Drop_ShipCaptionLbl: label 'Drop Ship';
        LocationCaptionLbl: label 'Location';
        PO_No_CaptionLbl: label 'PO No.';
        PO_VendorCaptionLbl: label 'PO Vendor';
        Ship_CodeCaptionLbl: label 'Ship Code';
        Vendor_TypeCaptionLbl: label 'Vendor Type';
        FOB_CodeCaptionLbl: label 'FOB Code';
        TOTALCaptionLbl: label 'TOTAL';
}

