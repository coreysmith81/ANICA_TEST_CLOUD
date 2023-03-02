Report 50041 "ADC Packing List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ADC Packing List.rdlc';
    PreviewMode = PrintLayout;
    ShowPrintStatus = false;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "Sell-to Customer No.", "No.") order(ascending) where("Document Type" = const(Order), "Location Code" = filter('ADC'), Status = const(Released));
            RequestFilterFields = "Document Date";
            RequestFilterHeading = 'Sales Order';
            column(ReportForNavId_6640; 6640)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(ReportForNavId_5701; 5701)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(ReportForNavId_6455; 6455)
                    {
                    }
                    column(BillToAddress_1_; BillToAddress[1])
                    {
                    }
                    column(BillToAddress_2_; "Sales Header"."Bill-to Address")
                    {
                    }
                    column(BillToAddress_3_; BillToAddress[3])
                    {
                    }
                    column(BillToAddress_4_; BillToAddress[4])
                    {
                    }
                    column(BillToAddress_5_; BillToAddress[5])
                    {
                    }
                    column(Sales_Header___Bill_to_Customer_No__; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Header___No__; "Sales Header"."No.")
                    {
                    }
                    column(Sales_Header___Document_Date_; "Sales Header"."Document Date")
                    {
                    }
                    column(PShipHead; PShipHead)
                    {
                    }
                    column(PrintPick; PrintPick)
                    {
                    }
                    column(Sales_Header___Salesperson_Code_; "Sales Header"."Salesperson Code")
                    {
                    }
                    column(Sold_To_Caption; Sold_To_CaptionLbl)
                    {
                    }
                    column(Store_No_Caption; Store_No_CaptionLbl)
                    {
                    }
                    column(Order_Number_Caption; Order_Number_CaptionLbl)
                    {
                    }
                    column(Date_Caption; Date_CaptionLbl)
                    {
                    }
                    column(Page_Caption; Page_CaptionLbl)
                    {
                    }
                    column(ANICA__INC_Caption; ANICA__INC_CaptionLbl)
                    {
                    }
                    column(PICK___PACKING_LISTCaption; PICK___PACKING_LISTCaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = sorting("Document No.", "Document Type", "Shelf/Bin No.") order(ascending) where("Document Type" = const(Order));
                        column(ReportForNavId_2844; 2844)
                        {
                        }
                        column(Sales_Line__Sales_Line___No__; "Sales Line"."No.")
                        {
                        }
                        column(PDescrip; PDescrip)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(Sales_Line__Sales_Line___Purchase_Order_No__; "Sales Line"."Purchase Order No.")
                        {
                        }
                        column(PVendorNo; PVendorNo)
                        {
                        }
                        column(PVendorPart; PVendorPart)
                        {
                        }
                        column(PPack; PPack)
                        {
                        }
                        column(PQuanOrd; PQuanOrd)
                        {
                        }
                        column(PWeight; PWeight)
                        {
                            DecimalPlaces = 2 : 2;
                        }
                        column(PUnitFreight; PUnitFreight)
                        {
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(PLandedCost; PLandedCost)
                        {
                        }
                        column(PRetail; PRetail)
                        {
                        }
                        column(PDropShip; PDropShip)
                        {
                        }
                        column(Sales_Line__Shelf_Bin_No__; "Shelf/Bin No.")
                        {
                        }
                        column(Sales_Line__Amount_Including_VAT_; "Amount Including VAT")
                        {
                        }
                        column(TGrossWeight; TGrossWeight)
                        {
                            DecimalPlaces = 0 : 0;
                        }
                        column(Sales_Line_Quantity; Quantity)
                        {
                        }
                        column(TFreight; TFreight)
                        {
                        }
                        column(ANICA_No_Caption; ANICA_No_CaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(Quantity_OrderedCaption; Quantity_OrderedCaptionLbl)
                        {
                        }
                        column(CostCaption; CostCaptionLbl)
                        {
                        }
                        column(Pack_SizeCaption; Pack_SizeCaptionLbl)
                        {
                        }
                        column(Unit_LandCaption; Unit_LandCaptionLbl)
                        {
                        }
                        column(PO_No_Caption; PO_No_CaptionLbl)
                        {
                        }
                        column(VendorCaption; VendorCaptionLbl)
                        {
                        }
                        column(Unit___FillCaption; Unit___FillCaptionLbl)
                        {
                        }
                        column(Product_CodeCaption; Product_CodeCaptionLbl)
                        {
                        }
                        column(Unit_FreightCaption; Unit_FreightCaptionLbl)
                        {
                        }
                        column(Unit_RetailCaption; Unit_RetailCaptionLbl)
                        {
                        }
                        column(Unit_WeightCaption; Unit_WeightCaptionLbl)
                        {
                        }
                        column(Drop_ShipCaption; Drop_ShipCaptionLbl)
                        {
                        }
                        column(Shelf_BinCaption; Shelf_BinCaptionLbl)
                        {
                        }
                        column(EmptyStringCaption; EmptyStringCaptionLbl)
                        {
                        }
                        column(Total_CostCaption; Total_CostCaptionLbl)
                        {
                        }
                        column(Total_FreightCaption; Total_FreightCaptionLbl)
                        {
                        }
                        column(Total_WeightCaption; Total_WeightCaptionLbl)
                        {
                        }
                        column(Total_PiecesCaption; Total_PiecesCaptionLbl)
                        {
                        }
                        column(PIECES__PP_______________________________Caption; PIECES__PP_______________________________CaptionLbl)
                        {
                        }
                        column(REPACK_BOXES______________________________Caption; REPACK_BOXES______________________________CaptionLbl)
                        {
                        }
                        column(DATE________________________________Caption; DATE________________________________CaptionLbl)
                        {
                        }
                        column(DATE________________________________Caption_Control53; DATE________________________________Caption_Control53Lbl)
                        {
                        }
                        column(I_C__BOXES______________________________Caption; I_C__BOXES______________________________CaptionLbl)
                        {
                        }
                        column(Sales_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Sales_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            OnLineNumber := OnLineNumber + 1;

                            if Type = "Sales Line Type"::" " then begin
                                "No." := '';
                                "Unit of Measure" := '';
                                Amount := 0;
                                "Amount Including VAT" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                            end else
                                if Type = Type::"G/L Account" then
                                    "No." := '';

                            if Amount <> "Amount Including VAT" then begin
                                TaxFlag := true;
                                TaxLiable := Amount;
                            end else begin
                                TaxFlag := false;
                                TaxLiable := 0;
                            end;

                            AmountExclInvDisc := Amount + "Inv. Discount Amount";

                            if Quantity = 0 then
                                UnitPriceToPrint := 0  // so it won't print
                            else
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity, 0.00001);

                            //ANICA section to format line output
                            PPack := '';
                            PVendorNo := '';
                            PQuanOrd := '';
                            PLandedCost := '';
                            PRetail := '';
                            PMargin := '';
                            PWeight := 0;
                            PUnitFreight := '';
                            PDropShip := '';
                            PFreight := 0;
                            PVendorPart := '';

                            PDescrip := Description + "Description 2";

                            //Items
                            if "Document Type" = "Sales Document Type"::Order then begin
                                //Output for item lines
                                if ("No." <> '') and (Quantity <> 0) then begin
                                    Item.Get("No.");
                                    PVendorPart := Item."Vendor Item No.";
                                    PPackInt := ROUND(Pack, 1.0);
                                    PPack := Format(PPackInt);
                                    PPack := PPack + ' / ' + "Pack Description";
                                    if "Drop Shipment" = true then begin
                                        CalcFields("Item Vendor No.");
                                        PVendorNo := "Item Vendor No.";
                                    end;
                                    if "Drop Shipment" = true then begin
                                        PDropShip := 'X';
                                        PVendorNo := "Item Vendor No.";
                                    end
                                    else
                                        PVendorNo := '';
                                    PQuanOrd := Format(Quantity, 0, 0);
                                    PWeight := ROUND("Gross Weight", 1.0, '>');
                                    CalcFields("Estimated Freight");
                                    PFreight := ROUND("Estimated Freight" / Quantity, 0.01);
                                    PUnitFreight := Format(PFreight, 0, '<Integer><Decimal,3>');
                                    PLandedCost := Format(ROUND((AmountExclInvDisc / Quantity) + PFreight, 0.01), 0, '<Integer><Decimal,3>');
                                    PRetail := Format("Retail Price Per Unit", 0, '<Integer><Decimal,3>');
                                    PRoundGPM := ROUND("Estimated Margin", 0.01, '>');
                                    PMargin := Format(PRoundGPM, 0, '<Integer><Decimal,3>');
                                    TFreight := "Estimated Freight";
                                    TGrossWeight := ROUND("Gross Weight" * Quantity, 1.0, '>');
                                end;
                            end;

                            //Do not print Other Charges on the sales order other than freight
                            if NumberOfLines = OnLineNumber then PrintFooter := true;
                            if "Calculated Freight Line" = true then CurrReport.Skip;
                            if "Calculated Insurance Line" = true then CurrReport.Skip;
                            if "Calculated Reserve Line" = true then CurrReport.Skip;
                            if "Calculated Fee Line" = true then CurrReport.Skip;

                            /*IF "Sales Line".Quantity = 0 THEN
                              BEGIN
                              //If the last line has a zero quantity this is necessary to print the footer
                              IF OnLineNumber = NumberOfLines THEN PrintFooter := TRUE;
                              CurrReport.SKIP;
                              END;*/

                        end;

                        trigger OnPreDataItem()
                        begin
                            // CurrReport.CreateTotals(TaxLiable,AmountExclInvDisc,Amount,"Amount Including VAT");
                            // CurrReport.CreateTotals(TGrossWeight,TFreight,Quantity);
                            NumberOfLines := Count;
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        //CompanyInformation.GET('');
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then
                            SalesPrinted.Run("Sales Header");
                        CurrReport.Break;
                    end else
                        CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := 'COPY';
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + Abs(NoCopies);
                    if NoLoops <= 0 then
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>>  Warehouse Management - start
                //IF Released  = 1 THEN
                if "Sales Header".Status = "Sales Document Status"::Released then
                    Clear(NotReleased)
                else
                    NotReleased := ' - Not Released';
                //<<  Warehouse Management - end

                //Get Line Data
                SalesLineRecord.SetCurrentkey("Document Type", "Document No.");
                SalesLineRecord.SetRange("Document Type", 1);
                SalesLineRecord.SetRange("Document No.", "Sales Header"."No.");
                if SalesLineRecord.Find('-') then begin
                    VCheckDropShip := SalesLineRecord."Drop Shipment";
                    VPurchOrder := SalesLineRecord."Purchase Order No.";
                    VCheckItem := SalesLineRecord."No.";
                end
                else begin
                    VCheckDropShip := false;
                    VPurchOrder := '';
                end;

                //Get Pick type
                VPickType := 0;
                PrintPick := '';
                if Item.Get(VCheckItem) then VPickType := Item."Pick Type";
                case VPickType of
                    1:
                        PrintPick := '****** Hazardous/Air ******';
                    2:
                        PrintPick := '****** Freeze/Chill ******';
                    else
                        PrintPick := ''
                end;

                //Check for Gottstein
                if PurchHeaderRecord.Get(1, VPurchOrder) then begin
                    if PurchHeaderRecord."Buy-from Vendor No." = 'JBGO001' then CurrReport.Skip;
                end;

                //Check for report triggers
                //Print drop ship orders
                if VPrintDropShip = true then begin
                    if VCheckDropShip <> true then CurrReport.Skip;
                end;

                //Exclude drop ship orders
                if VPrintInventory = true then begin
                    if VCheckDropShip = true then CurrReport.Skip;
                    if "Sales Header"."Sales Order Type" = 3 then CurrReport.Skip;
                end;

                //Print Promotional Orders Only
                if PPromoOnly = true then begin
                    if "Sales Header"."Sales Order Type" <> 3 then CurrReport.Skip;
                end;
                //<<<

                SalesLineRecord.Reset;

                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");

                //Lookup Ship Instruction Lines
                if "Shipping Instruction Code" = '' then
                    Clear(ShipInstructLines)
                else begin
                    PShipHead := 'Shipping Instruction: ' + "Shipping Instruction Code";
                    ShipInstructLines.SetRange("Shipping Instruction Code", "Shipping Instruction Code");
                    ShipInstructLines.Find('-');
                    C := 1;
                    repeat
                    begin
                        ShipLineArray[C] := ShipInstructLines.Instruction;
                        C := C + 1;
                    end
                    until ShipInstructLines.Next = 0;
                end;

                if "Payment Terms Code" = '' then
                    Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");

                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");

                FormatAddress.SalesHeaderSellTo(BillToAddress, "Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddress, ShipToAddress, "Sales Header");
                //CS 03-01-23: Probably need to revisit line above. The second argument is new
                // with BC. Needs "CustAddr", which I'm not sure if is the same as ShipTo.
            end;

            trigger OnPreDataItem()
            begin
                if PrintCompany then begin
                    CompanyInformation.Get('');
                    FormatAddress.Company(CompanyAddress, CompanyInformation);
                end else
                    Clear(CompanyAddress);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(VPrintDropShip; VPrintDropShip)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Drop Ship Only';
                    }
                    field(VPrintInventory; VPrintInventory)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Inventory Only';
                    }
                    field(PPromoOnly; PPromoOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Promotional Only';
                    }
                    field(NoCopies; NoCopies)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompany; PrintCompany)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Company Address';
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
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        SalesPrinted: Codeunit "Sales-Printed";
        FormatAddress: Codeunit "Format Address";
        NotReleased: Text[30];
        ShipInstructLines: Record "Shipping Instruction Lines";
        ShipLineArray: array[10] of Text[60];
        C: Integer;
        PPack: Text[30];
        PPackInt: Integer;
        PVendorNo: Code[10];
        PQuanOrd: Text[30];
        PLandedCost: Text[30];
        PRetail: Text[30];
        PMargin: Text[30];
        PFeeTotal: Decimal;
        POtherChargesTotal: Decimal;
        PRoundGPM: Decimal;
        PDescrip: Text[60];
        PWeight: Decimal;
        PUnitFreight: Text[30];
        PShipHead: Text[30];
        PFreight: Decimal;
        PVendorPart: Code[20];
        PShelfBin: Code[10];
        Ptemp: Boolean;
        Item: Record Item;
        PDropShip: Code[10];
        TGrossWeight: Decimal;
        TFreight: Decimal;
        VPrintDropShip: Boolean;
        VCheckDropShip: Boolean;
        VPrintInventory: Boolean;
        SalesLineRecord: Record "Sales Line";
        PurchHeaderRecord: Record "Purchase Header";
        VPurchOrder: Code[10];
        VCheckItem: Code[20];
        VPickType: Option;
        PrintPick: Text[30];
        PPromoOnly: Boolean;
        Text19022395: label 'Print Promotional Only';
        Sold_To_CaptionLbl: label 'Sold To:';
        Store_No_CaptionLbl: label 'Store No:';
        Order_Number_CaptionLbl: label 'Order Number:';
        Date_CaptionLbl: label 'Date:';
        Page_CaptionLbl: label 'Page:';
        ANICA__INC_CaptionLbl: label 'ANICA, INC.';
        PICK___PACKING_LISTCaptionLbl: label 'PICK / PACKING LIST';
        ANICA_No_CaptionLbl: label 'ANICA No.';
        DescriptionCaptionLbl: label 'Description';
        Quantity_OrderedCaptionLbl: label 'Quantity Ordered';
        CostCaptionLbl: label 'Cost';
        Pack_SizeCaptionLbl: label 'Pack Size';
        Unit_LandCaptionLbl: label 'Unit Land';
        PO_No_CaptionLbl: label 'PO No.';
        VendorCaptionLbl: label 'Vendor';
        Unit___FillCaptionLbl: label 'Unit   Fill';
        Product_CodeCaptionLbl: label 'Product Code';
        Unit_FreightCaptionLbl: label 'Unit Freight';
        Unit_RetailCaptionLbl: label 'Unit Retail';
        Unit_WeightCaptionLbl: label 'Unit Weight';
        Drop_ShipCaptionLbl: label 'Drop Ship';
        Shelf_BinCaptionLbl: label 'Shelf Bin';
        EmptyStringCaptionLbl: label '____________';
        Total_CostCaptionLbl: label 'Total Cost';
        Total_FreightCaptionLbl: label 'Total Freight';
        Total_WeightCaptionLbl: label 'Total Weight';
        Total_PiecesCaptionLbl: label 'Total Pieces';
        PIECES__PP_______________________________CaptionLbl: label 'PIECES (PP) _____________________________';
        REPACK_BOXES______________________________CaptionLbl: label 'REPACK BOXES _____________________________';
        DATE________________________________CaptionLbl: label 'DATE _____/_______/_________________';
        DATE________________________________Caption_Control53Lbl: label 'DATE _____/_______/_________________';
        I_C__BOXES______________________________CaptionLbl: label 'I.C. BOXES _____________________________';
}

