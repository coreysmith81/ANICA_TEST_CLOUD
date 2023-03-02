Report 50070 "Cross Reference Open PO's SO"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './Layouts/Cross Reference Open PO's SO.rdlc';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") order(ascending) where("Document Type" = const(Order), "No." = filter('P000000' .. 'P999999'));
            RequestFilterFields = "Document Date", "Location Code", Approved, "No.", "Buy-from Vendor No.", "Shipping Instruction Code", "Your Reference";
            column(ReportForNavId_4458; 4458)
            {
            }
            column(Today; Today)
            {
            }
            column(Time; Time)
            {
            }
            column(Purchase_Header__No__; "No.")
            {
            }
            column(Purchase_Header__Pay_to_Name_; "Pay-to Name")
            {
            }
            column(TOrderWeight; TOrderWeight)
            {
            }
            column(Purchase_Header__Document_Date_; "Document Date")
            {
            }
            column(PDropShip; PDropShip)
            {
            }
            column(Purchase_Header__Location_Code_; "Location Code")
            {
            }
            column(PReleased; PReleased)
            {
            }
            column(Purchase_Header_Approved; Approved)
            {
            }
            column(Purchase_Header__Shipping_Instruction_Code_; "Shipping Instruction Code")
            {
            }
            column(PSalesOrder; PSalesOrder)
            {
            }
            column(SOCustomer; SOCustomer)
            {
            }
            column(Purchase_Header__ANICA_Confirmed_; "ANICA Confirmed")
            {
            }
            column(PAGECaption; PAGECaptionLbl)
            {
            }
            column(CROSS_REFERENCE_OPEN_PURCHASE_ORDERS_WITH_SALES_ORDERSCaption; CROSS_REFERENCE_OPEN_PURCHASE_ORDERS_WITH_SALES_ORDERSCaptionLbl)
            {
            }
            column(Purchase_Header__No__Caption; FieldCaption("No."))
            {
            }
            column(VendorCaption; VendorCaptionLbl)
            {
            }
            column(Purchase_Header__Document_Date_Caption; FieldCaption("Document Date"))
            {
            }
            column(WeightCaption; WeightCaptionLbl)
            {
            }
            column(Drop_ShipCaption; Drop_ShipCaptionLbl)
            {
            }
            column(LocationCaption; LocationCaptionLbl)
            {
            }
            column(RlsdCaption; RlsdCaptionLbl)
            {
            }
            column(ApprovedCaption; ApprovedCaptionLbl)
            {
            }
            column(PO_ConfirmCaption; PO_ConfirmCaptionLbl)
            {
            }
            column(Ship_CodeCaption; Ship_CodeCaptionLbl)
            {
            }
            column(Sales_OrderCaption; Sales_OrderCaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Clear print variables
                SOCustomer := '';
                PReleased := '';
                PDropShip := '';
                PPurchOrder := '';
                PSalesOrder := '';
                Pconfirm := 0;
                POVendor := '';
                PVendName := '';
                PVendType := 0;
                POReleased := '';

                if "Purchase Header".Status = "Purchase Document Status"::Released then PReleased := 'X';
                //IF Released = TRUE THEN PReleased := 'X';

                PurchaseLine.SetCurrentkey("Document Type", "Document No.");
                PurchaseLine.SetRange("Document Type", 1);
                PurchaseLine.SetRange("Document No.", "Purchase Header"."No.");
                if PurchaseLine.Find('-') then begin
                    if PurchaseLine."Drop Shipment" = true then PDropShip := 'X';
                    PSalesOrder := PurchaseLine."Sales Order No.";
                end;

                if PSalesOrder <> '' then begin
                    SalesHeader.SetCurrentkey("Document Type", "No.");
                    SalesHeader.SetRange("Document Type", 1);
                    SalesHeader.SetRange("No.", PSalesOrder);
                    if SalesHeader.Find('+') then
                        SOCustomer := SalesHeader."Bill-to Name";
                end;

                //Get order weight for ADC
                SalesLine.SetCurrentkey("Document Type", "Document No.");
                SalesLine.SetRange("Document Type", 1);
                SalesLine.SetRange("Document No.", PSalesOrder);
                if SalesLine.Find('-') then begin
                    //Total freight for the order
                    TOrderWeight := 0;
                    repeat
                        TOrderWeight := TOrderWeight + ROUND((SalesLine.Quantity * SalesLine."Gross Weight"), 1.0);
                    until SalesLine.Next = 0;
                end;
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
        TotalAmt: Decimal;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        PurchHead: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        VendorRecord: Record Vendor;
        ItemRecord: Record Item;
        PPurchOrder: Code[10];
        PSalesOrder: Code[10];
        PDropShip: Code[10];
        Pconfirm: Option;
        PReleased: Code[10];
        POVendor: Code[10];
        SOCustomer: Text[30];
        PVendName: Text[30];
        PVendType: Option;
        PItemNo: Code[20];
        POReleased: Code[10];
        TOrderWeight: Decimal;
        PAGECaptionLbl: label 'PAGE';
        CROSS_REFERENCE_OPEN_PURCHASE_ORDERS_WITH_SALES_ORDERSCaptionLbl: label 'CROSS REFERENCE OPEN PURCHASE ORDERS WITH SALES ORDERS';
        VendorCaptionLbl: label 'Vendor';
        WeightCaptionLbl: label 'Weight';
        Drop_ShipCaptionLbl: label 'Drop Ship';
        LocationCaptionLbl: label 'Location';
        RlsdCaptionLbl: label 'Rlsd';
        ApprovedCaptionLbl: label 'Approved';
        PO_ConfirmCaptionLbl: label 'PO Confirm';
        Ship_CodeCaptionLbl: label 'Ship Code';
        Sales_OrderCaptionLbl: label 'Sales Order';
        CustomerCaptionLbl: label 'Customer';
}

