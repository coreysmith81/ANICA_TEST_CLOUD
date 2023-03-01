Report 50050 "ADC Grocery Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ADC Grocery Purchase Order.rdlc';
    PreviewMode = PrintLayout;
    UseSystemPrinter = true;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") order(ascending) where("Document Type" = const(Order), Status = const(Released));
            RequestFilterFields = "Document Date", "Location Code", "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(ReportForNavId_4458; 4458)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
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
                    column(BuyFromAddress_1_; BuyFromAddress[1])
                    {
                    }
                    column(BuyFromAddress_2_; BuyFromAddress[2])
                    {
                    }
                    column(BuyFromAddress_3_; BuyFromAddress[3])
                    {
                    }
                    column(BuyFromAddress_4_; BuyFromAddress[4])
                    {
                    }
                    column(SellToAddress_1_; SellToAddress[1])
                    {
                    }
                    column(SellToAddress_4_; SellToAddress[4])
                    {
                    }
                    column(SellToAddress_3_; SellToAddress[3])
                    {
                    }
                    column(SellToAddress_2_; SellToAddress[2])
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(Purchase_Header___No__; "Purchase Header"."No.")
                    {
                    }
                    column(Purchase_Header___Document_Date_; "Purchase Header"."Document Date")
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(PShipHead; PShipHead)
                    {
                    }
                    column(ShipLineArray_1_; ShipLineArray[1])
                    {
                    }
                    column(ShipLineArray_2_; ShipLineArray[2])
                    {
                    }
                    column(ShipLineArray_3_; ShipLineArray[3])
                    {
                    }
                    column(ShipLineArray_4_; ShipLineArray[4])
                    {
                    }
                    column(ShipLineArray_5_; ShipLineArray[5])
                    {
                    }
                    column(ShipLineArray_6_; ShipLineArray[6])
                    {
                    }
                    column(Purchase_Header___Sell_to_Customer_No__; "Purchase Header"."Sell-to Customer No.")
                    {
                    }
                    column(Purchase_Header___Requested_Receipt_Date_; "Purchase Header"."Requested Receipt Date")
                    {
                    }
                    column(BuyFromAddress_5_; BuyFromAddress[5])
                    {
                    }
                    column(CompanyInformation__Phone_No__; CompanyInformation."Phone No.")
                    {
                    }
                    column(CompanyInformation_City______CompanyInformation_County_____CompanyInformation__Post_Code_; CompanyInformation.City + ', ' + CompanyInformation.County + ' ' + CompanyInformation."Post Code")
                    {
                    }
                    column(CompanyInformation_Address; CompanyInformation.Address)
                    {
                    }
                    column(CompanyInformation_Picture; CompanyInformation.Picture)
                    {
                    }
                    column(Backorder_Policy; "Purchase Header"."Backorder Checkmark")
                    {
                    }
                    column(To_Caption; To_CaptionLbl)
                    {
                    }
                    column(Vendor_ID_Caption; Vendor_ID_CaptionLbl)
                    {
                    }
                    column(SoldCaption; SoldCaptionLbl)
                    {
                    }
                    column(To_Caption_Control89; To_Caption_Control89Lbl)
                    {
                    }
                    column(Purchase_Order_Number_Caption; Purchase_Order_Number_CaptionLbl)
                    {
                    }
                    column(Purchase_Order_Date_Caption; Purchase_Order_Date_CaptionLbl)
                    {
                    }
                    column(Page_Caption; Page_CaptionLbl)
                    {
                    }
                    column(Invoicing_InstructionsCaption; Invoicing_InstructionsCaptionLbl)
                    {
                    }
                    column(THESE_INSTRUCTIONS_MUST_BECaption; THESE_INSTRUCTIONS_MUST_BECaptionLbl)
                    {
                    }
                    column(FOLLOWED_FOR_PAYMENTCaption; FOLLOWED_FOR_PAYMENTCaptionLbl)
                    {
                    }
                    column(Send_1_Copy_of_Invoice_Showing_Store_and_PO_Caption; Send_1_Copy_of_Invoice_Showing_Store_and_PO_CaptionLbl)
                    {
                    }
                    column(number_covering_each_order_to_Caption; number_covering_each_order_to_CaptionLbl)
                    {
                    }
                    column(ANICA__INC_Caption; ANICA__INC_CaptionLbl)
                    {
                    }
                    column(Store_No_Caption; Store_No_CaptionLbl)
                    {
                    }
                    column(Requested_Delivery_DateCaption; Requested_Delivery_DateCaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where("Document Type" = const(Order));
                        column(ReportForNavId_6547; 6547)
                        {
                        }
                        column(Purchase_Line_Quantity; Quantity)
                        {
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(Purchase_Line_Description; Description)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(PPack; PPack)
                        {
                        }
                        column(Purchase_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                        {
                        }
                        column(Purchase_Line__Vendor_Item_No__; "Vendor Item No.")
                        {
                        }
                        column(PVendorItemNo; PVendorItemNo)
                        {
                        }
                        column(PWeight; PWeight)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(PrintRetail; PrintRetail)
                        {
                        }
                        column(Purchase_Line__Description_2_; "Description 2")
                        {
                        }
                        column(Purchase_Line__Amount_Including_VAT_; "Amount Including VAT")
                        {
                        }
                        column(TGrossWeight; TGrossWeight)
                        {
                            DecimalPlaces = 1 : 1;
                        }
                        column(Purchase_Line_Quantity_Control47; Quantity)
                        {
                        }
                        column(Text1; Text1)
                        {
                        }
                        column(Text2; Text2)
                        {
                        }
                        column(Text3; Text3)
                        {
                        }
                        column(Text4; Text4)
                        {
                        }
                        column(Box1; Box1)
                        {
                        }
                        column(Box2; Box2)
                        {
                        }
                        column(Order_No___Product_CodeCaption; Order_No___Product_CodeCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(Quantity_OrderedCaption; Quantity_OrderedCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(Pack_SizeCaption; Pack_SizeCaptionLbl)
                        {
                        }
                        column(Unit_CostCaption; Unit_CostCaptionLbl)
                        {
                        }
                        column(Extended_CostCaption; Extended_CostCaptionLbl)
                        {
                        }
                        column(Total_Cost_Caption; Total_Cost_CaptionLbl)
                        {
                        }
                        column(Total_Weight_Caption; Total_Weight_CaptionLbl)
                        {
                        }
                        column(Total_Quantity_Ordered_Caption; Total_Quantity_Ordered_CaptionLbl)
                        {
                        }
                        column(Purchase_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Purchase_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Purchase_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            PRetailHeading := '';
                            PrintRetail := '';

                            if "Vendor Item No." <> '' then
                                ItemNumberToPrint := "Vendor Item No."
                            else
                                ItemNumberToPrint := "No.";

                            if Type = "Purchase Line Type"::" " then begin
                                ItemNumberToPrint := '';
                                "Unit of Measure" := '';
                                Amount := 0;
                                "Amount Including VAT" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                            end;

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

                            //Set to Print Footer if it's the last line.
                            if OnLineNumber = NumberOfLines then begin
                                PrintFooter := true;
                            end;

                            //ANICA section to format line output
                            if ("Purchase Header"."Buy-from Vendor No." = 'C&JT001')
                              or ("Purchase Header"."Buy-from Vendor No." = 'C&JT002') then begin
                                SalesLineRecord.SetCurrentkey("Document Type", "Document No.", "Line No.");
                                SalesLineRecord.SetRange("Document Type", 1);
                                SalesLineRecord.SetRange("Document No.", "Purchase Line"."Sales Order No.");
                                SalesLineRecord.SetRange("Line No.", "Purchase Line"."Sales Order Line No.");
                                if SalesLineRecord.Find('+') then PRetail := SalesLineRecord."Retail Price Per Unit";
                                PrintRetail := Format(PRetail);
                                PRetailHeading := 'Retail';
                            end
                            else begin
                                PRetailHeading := '';
                                PrintRetail := '';
                            end;

                            //ANICA LCC 12-6-10, do not print vendor item number if there is no ANICA item no.
                            if "Purchase Line"."No." <> '' then
                                PVendorItemNo := "Purchase Line"."Vendor Item No."
                            else
                                PVendorItemNo := '';

                            //Lookup Items for Pack
                            PPack := '';
                            if "No." <> '' then begin
                                UOMRecord.SetCurrentkey("Item No.", Code);
                                UOMRecord.SetRange("Item No.", "No.");
                                UOMRecord.SetRange(Code, "Unit of Measure Code");
                                if UOMRecord.Find('+') then begin
                                    PPackint := ROUND(UOMRecord.Pack, 1.0);
                                    PPack := Format(PPackint);
                                    PPack := PPack + ' / ' + UOMRecord."Pack Description";
                                end;
                            end;
                            //ANICA weight total

                            PWeight := ROUND("Purchase Line"."Gross Weight", 1.0, '>');
                            TGrossWeight := "Purchase Line".Quantity * ROUND("Purchase Line"."Gross Weight", 1.0, '>');
                        end;

                        trigger OnPreDataItem()
                        begin
                            // CurrReport.CreateTotals(TaxLiable,AmountExclInvDisc,Amount,"Amount Including VAT");
                            // CurrReport.CreateTotals(TGrossWeight,Quantity);
                            NumberOfLines := Count;
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    // CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then
                            PurchasePrinted.Run("Purchase Header");
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
                //Limit to grocery PO's
                if "Purchase Header"."Buy-from Vendor No." = '' then CurrReport.Skip;
                VendorRecord.Get("Purchase Header"."Buy-from Vendor No.");
                if VendorRecord."Vendor Type Code" <> 2 then CurrReport.Skip;

                //Get Sell To customer
                if CustomerRecord.Get("Purchase Header"."Sell-to Customer No.") then begin
                    //Message('Sell to customer %1',"Purchase Header"."Sell-to Customer No.");
                    SellToAddress[1] := CustomerRecord.Name;
                    SellToAddress[2] := CustomerRecord.Address;
                    SellToAddress[3] := CustomerRecord."Address 2";
                    SellToAddress[4] := CustomerRecord.City + ' ' + CustomerRecord.County + ' ' + CustomerRecord."Post Code";
                    CompressArray(SellToAddress);
                end
                else begin
                    //Message('no customer found PO no %1 %2',"Purchase Header"."Sell-to Customer No.","Purchase Header"."No.");
                    SellToAddress[1] := '';
                    SellToAddress[2] := '';
                    SellToAddress[3] := '';
                    SellToAddress[4] := '';
                end;


                //>>  Warehouse Management - start
                //IF Released THEN
                if Status = "Purchase Document Status"::Released then
                    Clear(NotReleased)
                else
                    NotReleased := '- Not Released';

                //Lookup Ship Instruction Lines
                if "Shipping Instruction Code" = '' then
                    Clear(ShipInstructLines)
                else begin
                    //CS 09-04-19: Clear out Array before beginning
                    ShipLineArray[1] := '';
                    ShipLineArray[2] := '';
                    ShipLineArray[3] := '';
                    ShipLineArray[4] := '';
                    ShipLineArray[5] := '';
                    ShipLineArray[6] := '';

                    PShipHead := 'Shipping Instruction: ' + "Shipping Instruction Code";
                    ShipInstructLines.SetRange("Shipping Instruction Code", "Shipping Instruction Code");
                    ShipInstructLines.Find('-');
                    c := 1;
                    repeat
                    begin
                        ShipLineArray[c] := ShipInstructLines.Instruction;
                        c := c + 1;
                    end
                    until ShipInstructLines.Next = 0;
                end;

                if "Purchaser Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Purchaser Code");

                if "Payment Terms Code" = '' then
                    Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");

                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");

                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress, "Purchase Header");
                FormatAddress.PurchHeaderShipTo(ShipToAddress, "Purchase Header");

                //CS 09/24/15: Everything below was in the base version, but not ours after upgrade.
                if not CurrReport.Preview then begin
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", Database::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    end;
                end;

                if "Posting Date" <> 0D then
                    UseDate := "Posting Date"
                else
                    UseDate := WorkDate;
            end;

            trigger OnPreDataItem()
            begin
                if PrintCompany then
                    FormatAddress.Company(CompanyAddress, CompanyInformation)
                else
                    Clear(CompanyAddress);

                //CompanyInformation.GET;
                //CompanyInformation.CALCFIELDS(Picture);
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get('');
        CompanyInformation.CalcFields(Picture);
    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyAddress: array[8] of Text[50];
        BuyFromAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[20];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchasePrinted: Codeunit "Purch.Header-Printed";
        FormatAddress: Codeunit "Format Address";
        NotReleased: Text[30];
        PShipHead: Text[30];
        ShipLineArray: array[20] of Text[60];
        ShipInstructLines: Record "Shipping Instruction Lines";
        c: Integer;
        PPack: Text[30];
        PPackint: Integer;
        PVendorItemNo: Code[30];
        UOMRecord: Record "Item Unit of Measure";
        TGrossWeight: Decimal;
        VPrintGrocery: Boolean;
        VendorRecord: Record Vendor;
        CustomerRecord: Record Customer;
        SellToAddress: array[8] of Text[50];
        PDescription: Text[50];
        PDescription2: Text[50];
        Text1: Text[120];
        Text2: Text[120];
        Text3: Text[120];
        Text4: Text[120];
        Box1: Text[30];
        Box2: Text[25];
        To_CaptionLbl: label 'To:';
        Vendor_ID_CaptionLbl: label 'Vendor ID:';
        SoldCaptionLbl: label 'Sold';
        To_Caption_Control89Lbl: label 'To:';
        Purchase_Order_Number_CaptionLbl: label 'Purchase Order Number:';
        Purchase_Order_Date_CaptionLbl: label 'Purchase Order Date:';
        Page_CaptionLbl: label 'Page:';
        Invoicing_InstructionsCaptionLbl: label 'Invoicing Instructions';
        THESE_INSTRUCTIONS_MUST_BECaptionLbl: label 'THESE INSTRUCTIONS MUST BE';
        FOLLOWED_FOR_PAYMENTCaptionLbl: label 'FOLLOWED FOR PAYMENT';
        Send_1_Copy_of_Invoice_Showing_Store_and_PO_CaptionLbl: label 'Send 1 Copy of Invoice Showing Store and PO ';
        number_covering_each_order_to_CaptionLbl: label 'number covering each order to:';
        ANICA__INC_CaptionLbl: label 'ANICA, INC.';
        Store_No_CaptionLbl: label 'Store No:';
        Requested_Delivery_DateCaptionLbl: label 'Requested Delivery Date';
        Order_No___Product_CodeCaptionLbl: label 'Order No./ Product Code';
        DescriptionCaptionLbl: label 'Description';
        Quantity_OrderedCaptionLbl: label 'Quantity Ordered';
        UnitCaptionLbl: label 'Unit';
        Pack_SizeCaptionLbl: label 'Pack Size';
        Unit_CostCaptionLbl: label 'Unit Cost';
        Extended_CostCaptionLbl: label 'Extended Cost';
        Total_Cost_CaptionLbl: label 'Total Cost:';
        Total_Weight_CaptionLbl: label 'Total Weight:';
        Total_Quantity_Ordered_CaptionLbl: label 'Total Quantity Ordered:';
        PWeight: Decimal;
        PRetailHeading: Text[30];
        PRetail: Decimal;
        PrintRetail: Text[30];
        SalesLineRecord: Record "Sales Line";
        ArchiveManagement: Codeunit ArchiveManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        SegManagement: Codeunit SegManagement;
        UseDate: Date;
}

