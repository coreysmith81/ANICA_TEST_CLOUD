Report 50063 "Daily Purchase Order Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Daily Purchase Order Summary.rdlc';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") order(ascending) where("Document Type" = filter(Order));
            RequestFilterFields = "Document Date", "Location Code", Status, Approved, "No.", "Shipping Instruction Code";
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
            column(Purchase_Header_Amount; Amount)
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
            column(PPurchOrder; PPurchOrder)
            {
            }
            column(Purchase_Header_Approved; Approved)
            {
            }
            column(POVendor; POVendor)
            {
            }
            column(Purchase_Header__Shipping_Instruction_Code_; "Shipping Instruction Code")
            {
            }
            column(PVendName; PVendName)
            {
            }
            column(PVendType; PVendType)
            {
                OptionMembers = " ",Budget,Grocery,JBG,OMC,Polaris,Skidoo,Warehouse,"Yakima ",Breakout;
            }
            column(Pconfirm; Pconfirm)
            {
                OptionMembers = " ",Phone,Fax,EDI,Special,Email,Other;
            }
            column(POReleased; POReleased)
            {
            }
            column(TotalAmt; TotalAmt)
            {
            }
            column(PAGECaption; PAGECaptionLbl)
            {
            }
            column(DAILY_PURCHASE_ORDERS_SUMMARYCaption; DAILY_PURCHASE_ORDERS_SUMMARYCaptionLbl)
            {
            }
            column(Purchase_Header__No__Caption; FieldCaption("No."))
            {
            }
            column(Purchase_Header__Pay_to_Name_Caption; FieldCaption("Pay-to Name"))
            {
            }
            column(Purchase_Header__Document_Date_Caption; FieldCaption("Document Date"))
            {
            }
            column(Purchase_Header_AmountCaption; FieldCaption(Amount))
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
            column(PO_No_Caption; PO_No_CaptionLbl)
            {
            }
            column(ApprovedCaption; ApprovedCaptionLbl)
            {
            }
            column(PO_VendorCaption; PO_VendorCaptionLbl)
            {
            }
            column(PO_ConfirmCaption; PO_ConfirmCaptionLbl)
            {
            }
            column(Ship_CodeCaption; Ship_CodeCaptionLbl)
            {
            }
            column(Vendor_TypeCaption; Vendor_TypeCaptionLbl)
            {
            }
            column(RlsdCaption_Control40; RlsdCaption_Control40Lbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
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


                //IF Released = TRUE THEN PReleased := 'X';
                if "Purchase Header".Status = "Purchase Document Status"::Released then PReleased := 'X';

                PurchLine.SetCurrentkey("Document Type", "Document No.");
                PurchLine.SetRange("Document Type", 1);
                PurchLine.SetRange("Document No.", "Purchase Header"."No.");
                if PurchLine.Find('-') then begin
                    if PurchLine."Drop Shipment" = true then PDropShip := 'X';
                    PPurchOrder := PurchLine."Sales Order No.";
                    if SalesLine.Type = "Sales Line Type"::Item then PItemNo := SalesLine."No.";
                end;

                if PItemNo <> '' then begin
                    ItemRecord.Get(PItemNo);
                    POVendor := ItemRecord."Vendor No.";
                end;

                //IF PPurchOrder <> '' THEN
                //BEGIN

                //PurchHead.SETCURRENTKEY("Document Type","No.");
                //PurchHead.SETRANGE("Document Type",1);
                //PurchHead.SETRANGE("No.",PPurchOrder);
                //  IF PurchHead.FIND('-') THEN
                //  BEGIN
                //  MESSAGE('PO confirm %1',PurchHead."ANICA Confirmed");
                Pconfirm := "Purchase Header"."ANICA Confirmed";
                POVendor := "Purchase Header"."Buy-from Vendor No.";
                //  IF PurchHead.Released = TRUE THEN POReleased := 'X';
                if "Purchase Header".Status = "Purchase Document Status"::Released then POReleased := 'X';
                //  END;
                //END;
                if VConfirm = true then begin
                    if "Purchase Header"."ANICA Confirmed" <> 0 then CurrReport.Skip;
                end;

                if (PDropShip <> 'X') and ("Purchase Header"."Location Code" = 'ADC')
                then
                    POVendor := '';


                if POVendor <> '' then begin
                    VendorRecord.Get(POVendor);
                    PVendName := VendorRecord.Name;
                    PVendType := VendorRecord."Vendor Type Code";
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
                    field(VConfirm; VConfirm)
                    {
                        ApplicationArea = Basic;
                        Caption = 'PO Confirmed';
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
        POVendor: Code[10];
        PVendName: Text[30];
        PVendType: Option;
        PItemNo: Code[20];
        POReleased: Code[10];
        VConfirm: Boolean;
        PurchLine: Record "Purchase Line";
        PAGECaptionLbl: label 'PAGE';
        DAILY_PURCHASE_ORDERS_SUMMARYCaptionLbl: label 'DAILY PURCHASE ORDERS SUMMARY';
        Drop_ShipCaptionLbl: label 'Drop Ship';
        LocationCaptionLbl: label 'Location';
        RlsdCaptionLbl: label 'Rlsd';
        PO_No_CaptionLbl: label 'PO No.';
        ApprovedCaptionLbl: label 'Approved';
        PO_VendorCaptionLbl: label 'PO Vendor';
        PO_ConfirmCaptionLbl: label 'PO Confirm';
        Ship_CodeCaptionLbl: label 'Ship Code';
        Vendor_TypeCaptionLbl: label 'Vendor Type';
        RlsdCaption_Control40Lbl: label 'Rlsd';
        TOTALCaptionLbl: label 'TOTAL';
}

