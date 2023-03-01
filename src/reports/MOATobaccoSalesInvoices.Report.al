Report 50037 "MOA Tobacco Sales Invoices"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MOA Tobacco Sales Invoices.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header";"Sales Invoice Header")
        {
            DataItemTableView = sorting("No.") order(ascending);
            column(ReportForNavId_5581; 5581)
            {
            }
            column(Sales_Invoice_Header_No_;"No.")
            {
            }
            dataitem(CopyLoop;"Integer")
            {
                DataItemTableView = sorting(Number);
                column(ReportForNavId_5701; 5701)
                {
                }
                dataitem(PageLoop;"Integer")
                {
                    DataItemTableView = sorting(Number) where(Number=const(1));
                    column(ReportForNavId_6455; 6455)
                    {
                    }
                    column(BillToAddress_1_;BillToAddress[1])
                    {
                    }
                    column(BillToAddress_2_;BillToAddress[2])
                    {
                    }
                    column(BillToAddress_3_;BillToAddress[3])
                    {
                    }
                    column(BillToAddress_4_;BillToAddress[4])
                    {
                        IncludeCaption = false;
                    }
                    column(BillToAddress_5_;BillToAddress[5])
                    {
                    }
                    column(BillToAddress_6_;BillToAddress[6])
                    {
                    }
                    column(BillToAddress_7_;BillToAddress[7])
                    {
                    }
                    column(BillToAddress_8_;BillToAddress[8])
                    {
                    }
                    column(Sales_Invoice_Header___Due_Date_;"Sales Invoice Header"."Due Date")
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Customer_No__;"Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Invoice_Header___Order_No__;"Sales Invoice Header"."Order No.")
                    {
                    }
                    column(Sales_Invoice_Header___No__;"Sales Invoice Header"."No.")
                    {
                    }
                    column(Sales_Invoice_Header___Document_Date_;"Sales Invoice Header"."Document Date")
                    {
                    }
                    column(CurrReport_PAGENO;CurrReport.PageNo)
                    {
                    }
                    column(Sales_Invoice_Header___Shipment_Date_;"Sales Invoice Header"."Shipment Date")
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_;"Sales Invoice Header"."Posting Date")
                    {
                    }
                    column(VPONumber;VPONumber)
                    {
                    }
                    column(CompanyInformation_City______CompanyInformation_County_____CompanyInformation__Post_Code_;CompanyInformation.City+', '+CompanyInformation.County+' '+CompanyInformation."Post Code")
                    {
                    }
                    column(CompanyInformation__Phone_No__;CompanyInformation."Phone No.")
                    {
                    }
                    column(CompanyInformation_Address;CompanyInformation.Address)
                    {
                    }
                    column(CompanyInformation_Picture;CompanyInformation.Picture)
                    {
                    }
                    column(BillCaption;BillCaptionLbl)
                    {
                    }
                    column(To_Caption;To_CaptionLbl)
                    {
                    }
                    column(Due_DateCaption;Due_DateCaptionLbl)
                    {
                    }
                    column(Customer_IDCaption;Customer_IDCaptionLbl)
                    {
                    }
                    column(Our_Order_No_Caption;Our_Order_No_CaptionLbl)
                    {
                    }
                    column(Invoice_Number_Caption;Invoice_Number_CaptionLbl)
                    {
                    }
                    column(Invoice_Date_Caption;Invoice_Date_CaptionLbl)
                    {
                    }
                    column(Page_Caption;Page_CaptionLbl)
                    {
                    }
                    column(ANICA__INC_Caption;ANICA__INC_CaptionLbl)
                    {
                    }
                    column(INVOICECaption;INVOICECaptionLbl)
                    {
                    }
                    column(Shipment_DateCaption;Shipment_DateCaptionLbl)
                    {
                    }
                    column(Posting_DateCaption;Posting_DateCaptionLbl)
                    {
                    }
                    column(PO_NO_Caption;PO_NO_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number;Number)
                    {
                    }
                    column(AmountExclInvDiscTotal;AmountExclInvDiscTotal)
                    {
                    }
                    column(PFreightTotal;PFreightTotal)
                    {
                    }
                    column(PFeeTotal;PFeeTotal)
                    {
                    }
                    column(PInsuranceTotal;PInsuranceTotal)
                    {
                    }
                    column(TotMargin;TotMargin)
                    {
                    }
                    column(PReserveTotal;PReserveTotal)
                    {
                    }
                    column(VInvoiceAmount;VInvoiceAmount)
                    {
                    }
                    dataitem("Sales Invoice Line";"Sales Invoice Line")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.","Line No.");
                        column(ReportForNavId_1570; 1570)
                        {
                        }
                        column(Sales_Invoice_Line__No__;"No.")
                        {
                        }
                        column(VType;VType)
                        {
                        }
                        column(VShowLine;VShowLine)
                        {
                        }
                        column(AmountExclInvDisc;AmountExclInvDisc)
                        {
                        }
                        column(PDescrip;PDescrip)
                        {
                        }
                        column(PPack;PPack)
                        {
                        }
                        column(UnitPriceToPrint;UnitPriceToPrint)
                        {
                            DecimalPlaces = 2:5;
                        }
                        column(PWeight;PWeight)
                        {
                        }
                        column(PLandedCost;PLandedCost)
                        {
                        }
                        column(PRetail;PRetail)
                        {
                        }
                        column(PMargin;PMargin)
                        {
                            DecimalPlaces = 1:1;
                        }
                        column(Sales_Invoice_Line__Unit_of_Measure_Code_;"Unit of Measure Code")
                        {
                        }
                        column(PQuanShip;PQuanShip)
                        {
                        }
                        column(PVendorItem;PVendorItem)
                        {
                        }
                        column(AmountExclInvDisc_Control54;AmountExclInvDisc)
                        {
                        }
                        column(Amount_Including_VAT____PFeeTotal___PFreightTotal_PReserveTotal_PInsuranceTotal;"Amount Including VAT" + PFeeTotal + PFreightTotal+PReserveTotal+PInsuranceTotal)
                        {
                        }
                        column(PrintFooter;PrintFooter)
                        {
                        }
                        column(Item_No_Caption;Item_No_CaptionLbl)
                        {
                        }
                        column(DescriptionCaption;DescriptionCaptionLbl)
                        {
                        }
                        column(UnitCaption;UnitCaptionLbl)
                        {
                        }
                        column(Pack_SizeCaption;Pack_SizeCaptionLbl)
                        {
                        }
                        column(Extended_CostCaption;Extended_CostCaptionLbl)
                        {
                        }
                        column(Unit_WeightCaption;Unit_WeightCaptionLbl)
                        {
                        }
                        column(Landed_CostCaption;Landed_CostCaptionLbl)
                        {
                        }
                        column(MarginCaption;MarginCaptionLbl)
                        {
                        }
                        column(Quantity_ShippedCaption;Quantity_ShippedCaptionLbl)
                        {
                        }
                        column(Unit_RetailCaption;Unit_RetailCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption;Unit_PriceCaptionLbl)
                        {
                        }
                        column(Vendor_Item_No_Caption;Vendor_Item_No_CaptionLbl)
                        {
                        }
                        column(MerchandiseCaption;MerchandiseCaptionLbl)
                        {
                        }
                        column(DataItem33;PURCHASER_AGREES_TO_PROMPTLY_PAY_FOR_THE_MERCHANDISE_RECEIVED_AND_WAIVES_ANY_CLAIM_OF_SOVEREIGN_IMMUNITY_WITH_RESPECT_THERETOLbl)
                        {
                        }
                        column(ReserveCaption;ReserveCaptionLbl)
                        {
                        }
                        column(FreightCaption;FreightCaptionLbl)
                        {
                        }
                        column(MiscCaption;MiscCaptionLbl)
                        {
                        }
                        column(InsuranceCaption;InsuranceCaptionLbl)
                        {
                        }
                        column(Invoice_AmountCaption;Invoice_AmountCaptionLbl)
                        {
                        }
                        column(Average_GPM_Caption;Average_GPM_CaptionLbl)
                        {
                        }
                        column(EmptyStringCaption;EmptyStringCaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_Document_No_;"Document No.")
                        {
                        }
                        column(Sales_Invoice_Line_Line_No_;"Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            OnLineNumber := OnLineNumber + 1;

                            //CS: Added to get type of line.
                            //VType := Type;

                            //CS 11-24-15: Added to control what Lines are shown. Variable will be used in "Hidden" expression for lines.
                            VShowLine := true;

                            OrderedQuantity :=  0;
                            if "Sales Invoice Header"."Order No." = '' then
                              OrderedQuantity := Quantity
                            else begin
                               if OrderLine.Get(1,"Sales Invoice Header"."Order No.","Line No.") then
                                  OrderedQuantity := OrderLine.Quantity
                               else begin
                                  ShipmentLine.SetRange("Order No.","Sales Invoice Header"."Order No.");
                                  ShipmentLine.SetRange("Order Line No.","Line No.");
                                  if ShipmentLine.Find('-') then;
                                  repeat
                                    OrderedQuantity := OrderedQuantity + ShipmentLine.Quantity;
                                  until 0=ShipmentLine.Next;
                               end;
                            end;
                            PVendorItem := '';
                            ItemRecord.SetCurrentkey(ItemRecord."No.");
                            ItemRecord.SetRange(ItemRecord."No.","Sales Invoice Line"."No.");
                            if ItemRecord.Find('-') then PVendorItem := ItemRecord."Vendor Item No.";
                            //DescriptionToPrint := COPYSTR("Sales Invoice Line"."Description 2",1,30);
                            DescriptionToPrint := Description;
                            if Type = 0 then begin
                              if OnLineNumber < NumberOfLines then begin
                                Next;
                                if Type = 0 then begin
                                  DescriptionToPrint := CopyStr(DescriptionToPrint + ' ' + Description,1,MaxStrLen(DescriptionToPrint));
                                  OnLineNumber := OnLineNumber + 1;
                                end else
                                  Next(-1);
                              end;
                              "No." := '';
                              "Unit of Measure" := '';
                              Amount := 0;
                              "Amount Including VAT" := 0;
                              "Inv. Discount Amount" := 0;
                              Quantity := 0;
                            end;

                            //Removed by LCC 2-10-00
                            // ELSE IF Type = Type::"Account (G/L)" THEN "No." := '';

                            if "No." = '' then begin
                              HighDescriptionToPrint := DescriptionToPrint;
                              LowDescriptionToPrint := '';
                            end else begin
                              HighDescriptionToPrint := '';
                              LowDescriptionToPrint := DescriptionToPrint;
                            end;

                            if Amount <> "Amount Including VAT" then begin
                              TaxFlag := true;
                              TaxLiable := Amount;
                            end else begin
                              TaxFlag := false;
                              TaxLiable := 0;
                            end;

                            AmountExclInvDisc := Amount + "Inv. Discount Amount";
                            //CS: Added this for the footer of the report
                            //CS: To get the amount of the non-merchandise lines, to fix the invoice amount field in the footer.
                            //IF Type <> Type::"G/L Account" THEN
                            //    AmountExclInvDiscTotal := AmountExclInvDiscTotal + AmountExclInvDisc;


                            if Quantity = 0 then
                              UnitPriceToPrint := 0  // so it won't print
                            else
                              UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.01);


                            //ANICA section to format line output
                            //Skip Lines with no shipped quantity
                            if OnLineNumber = NumberOfLines then PrintFooter := true;
                            if Quantity = 0 then CurrReport.Skip;

                            PPack := '';
                            PVendorNo := '';
                            PQuanOrd := '';
                            PLandedCost := '';
                            PRetail := '';
                            PMargin := '';
                            PWeight := '';
                            PUnitFreight := '';
                            TRetail := 0;
                            PCalcRetail := 0;
                            //PDesc1 := SalesInvoiceLine.Description;
                            //PDescrip := PDesc1 + SalesInvoiceLine."Description 2";
                            //PDescrip := COPYSTR((Description,1,30) + "Description 2");
                            PDescrip := Description + ' ' + "Description 2";
                            //Items
                            if Type = 2 then
                            begin
                            //Output for item lines
                               if "No." <> '' then
                                  begin
                                      PPackInt := ROUND(Pack,1.0);
                                      PPack := Format(PPackInt);
                                      PPack := PPack + ' / ' + "Pack Description";
                                      PQuanOrd := Format(Quantity,0,0);
                                      PQuanShip := Format(Quantity,0,0);
                                      PWeight := Format(ROUND("Gross Weight",0.1),0,'<Integer><Decimal,2>');
                                      if Quantity <> 0 then
                                          PUnitFreight := Format(ROUND("Invoiced Freight"/Quantity,0.01),0,'<Integer><Decimal,3>');
                                      if Quantity <> 0 then
                                         PCalcLandedCost := (ROUND("Invoiced Freight"/Quantity,0.01)) + "Unit Price"
                                      else PCalcLandedCost := 0;
                                      PCalcLandedCost := ROUND(PCalcLandedCost,0.01);
                                      PLandedCost := Format(PCalcLandedCost,0,'<Integer><Decimal,3>');
                                      PCalcRetail := "Retail Price Per Unit";
                                      PCalcRetail := ROUND("Retail Price Per Unit",0.01);
                                      if "Sales Invoice Line"."Store Use" = true then PCalcRetail := 0;
                                      PRetail := Format(PCalcRetail,0,'<Integer><Decimal,3>');
                                      if (PCalcRetail <> 0) and (Pack <> 0) then
                                         PCalcActMargin := ((PCalcRetail - (PCalcLandedCost/Pack)) / PCalcRetail) * 100
                                      else PCalcActMargin := 0;

                                      PRoundGPM := ROUND(PCalcActMargin,0.1,'>');
                                      PMargin := Format(PRoundGPM,0,'<Sign><Integer><Decimal,2>');
                                      TRetail := "Retail Price Per Unit" * Quantity * Pack;
                                      TLanded := Quantity * PCalcLandedCost;
                                      TotRetail := TotRetail + TRetail;
                                      TotLand := TotLand + TLanded;
                                  end;
                            end;

                            //GL Lines
                            if Type = 1 then
                            begin
                            //Output for account lines
                               if "No." <> '' then
                                  begin
                                     //"No." := '';
                                     PPackInt := ROUND(Pack,1.0);
                                     PPack := Format(PPackInt);
                                     PPack := PPack + ' / ' + "Pack Description";
                                  //   PQuanOrd := FORMAT("Orig. Order Qty.",0,0);
                                     PQuanOrd := Format(Quantity,0,0);
                                     PQuanShip := Format(Quantity,0,0);
                                     //PWeight := FORMAT(ROUND("Gross Weight",0.1),0,'<Integer><Decimal,2>');
                                     if Quantity <> 0 then
                                        PUnitFreight := Format(ROUND("Invoiced Freight"/Quantity,0.01),0,'<Integer><Decimal,3>');
                                     if Quantity <> 0 then
                                        PCalcLandedCost := (ROUND("Invoiced Freight"/Quantity,0.01)) + "Unit Price"
                                     else PCalcLandedCost := 0;
                                     PCalcLandedCost := ROUND(PCalcLandedCost,0.01);
                                     PLandedCost := Format(PCalcLandedCost,0,'<Integer><Decimal,3>');
                                     PCalcRetail := "Retail Price Per Unit";
                                     if "Sales Invoice Line"."Store Use" = true then
                                        PCalcRetail := 0;
                                     PRetail := Format(PCalcRetail,0,'<Integer><Decimal,3>');
                                     if (PCalcRetail <> 0) and (Pack <> 0) then
                                        PCalcActMargin := ((PCalcRetail - (PCalcLandedCost/Pack)) / PCalcRetail) * 100
                                     else PCalcActMargin := 0;
                                     PRoundGPM := ROUND(PCalcActMargin,0.1,'>');
                                     PMargin := Format(PRoundGPM,0,'<Integer><Decimal,3>');
                                     TRetail := "Retail Price Per Unit" * Quantity * Pack;
                                  end;
                            end;


                            //Do not print Other Charges on the sales order other than freight

                               if "Calculated Freight Line" = true then
                                  begin
                                      PFreightTotal := PFreightTotal + "Sales Invoice Line"."Amount Including VAT";
                                      VShowLine := false; //so line won't show on print out.
                                  end;

                               if "Calculated Insurance Line" = true then
                                  begin
                                      PInsuranceTotal := PInsuranceTotal + "Sales Invoice Line"."Amount Including VAT";
                                      VShowLine := false; //so line won't show on print out.
                                  end;

                               if "Calculated Reserve Line" = true then
                                  begin
                                      PReserveTotal := PReserveTotal + "Sales Invoice Line"."Amount Including VAT";
                                      VShowLine := false; //so line won't show on print out.
                                  end;

                               if "Calculated Fee Line" = true then
                                  begin
                                      PFeeTotal := PFeeTotal + "Sales Invoice Line"."Amount Including VAT";
                                      VShowLine := false; //so line won't show on print out.
                                  end;

                            //CS 11-24-15: For the "Merchandise" at bottom of page.
                            if VShowLine then
                                AmountExclInvDiscTotal := AmountExclInvDiscTotal + AmountExclInvDisc;

                            //CS: Get total invoice amount for footer:
                            VInvoiceAmount := AmountExclInvDiscTotal + PReserveTotal + PFreightTotal + PFeeTotal + PInsuranceTotal;

                            //CS: For the Average GPM field in the footer.
                            if TotRetail <> 0 then
                                begin
                                    TotMargin := ((TotRetail - TotLand) / TotRetail);
                                end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable,AmountExclInvDisc,Amount,"Amount Including VAT");
                            //CurrReport.CREATETOTALS(TRetail);
                            NumberOfLines := Count;
                            OnLineNumber := 0;
                            PrintFooter := false;
                            PFreightTotal := 0;
                            PReserveTotal := 0;
                            PInsuranceTotal := 0;
                            PFeeTotal := 0;
                            AmountExclInvDiscTotal := 0;
                            TotRetail := 0;
                            TotLand := 0;
                            TotMargin := 0;
                            TLanded := 0;
                            //PDesc1 := '                                                              ';
                            //PDescrip := '                                                            ';
                            //DescriptionToPrint := '                              ';
                            //HighDescriptionToPrint := '';
                            //LowDescriptionToPrint := '';
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        CompanyInformation.Get('');

                        CompanyInformation.CalcFields(Picture);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PageNo := 1;

                    if CopyNo = NoLoops then begin
                      if not CurrReport.Preview then
                        SalesInvPrinted.Run("Sales Invoice Header");
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
                    NoLoops := 1 + Abs(NoCopies) + Customer."Invoice Copies";
                    if NoLoops <= 0 then
                      NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Check if Tobacco is on the order, and if so, make sure its ADC stocked. Or else, SKIP.
                Clear(VIsTobacco);

                VDocumentNo := "No.";

                //check lines for tobacco products.
                CheckForTobacco;

                //If invoice has anything but ADC stocked tobacco products, skip.
                if not VIsTobacco then
                    CurrReport.Skip;



                VPONumber := '';

                SalesInvoiceLine.SetCurrentkey(SalesInvoiceLine."Document No.");
                SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.","Sales Invoice Header"."No.");
                if SalesInvoiceLine.Find('-') then
                begin
                VPONumber := SalesInvoiceLine."Purchase2 Order No.";
                end;

                //Don't print intercompany transfers
                //IF "Sales Invoice Header".InterCompany = TRUE THEN CurrReport.SKIP;

                if "Salesperson Code" = '' then
                  Clear(SalesPurchPerson)
                else
                  SalesPurchPerson.Get("Salesperson Code");

                FormatAddress.SalesInvBillTo(BillToAddress,"Sales Invoice Header");
                FormatAddress.SalesInvShipTo(ShipToAddress,"Sales Invoice Header");

                if "Payment Terms Code" = '' then
                  Clear(PaymentTerms)
                else
                  PaymentTerms.Get("Payment Terms Code");

                if "Shipment Method Code" = '' then
                  Clear(ShipmentMethod)
                else
                  ShipmentMethod.Get("Shipment Method Code");

                Customer.Get("Bill-to Customer No.");
            end;

            trigger OnPreDataItem()
            begin
                if PrintCompany then begin
                  CompanyInformation.Get('');
                  FormatAddress.Company(CompanyAddress,CompanyInformation);
                end else
                  Clear(CompanyAddress);

                CompanyInformation.CalcFields(Picture);

                //Filter to only ADC, CIG invoices in the date range.
                SetRange("Sales Invoice Header"."Posting Date",VStart,VEnd);
                SetRange("Sales Invoice Header"."Location Code",'ADC');
                SetRange("Sales Invoice Header"."Shipping Instruction Code",'CIG');
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
                    field(VStart;VStart)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Start Date';
                    }
                    field(VEnd;VEnd)
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

    trigger OnPreReport()
    begin
        ShipmentLine.SetCurrentkey("Order No.","Order Line No.");
    end;

    var
        TaxLiable: Decimal;
        OrderedQuantity: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        AmountExclInvDiscTotal: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        OrderLine: Record "Sales Line";
        ShipmentLine: Record "Sales Shipment Line";
        CompanyAddress: array [8] of Text[50];
        BillToAddress: array [8] of Text[50];
        ShipToAddress: array [8] of Text[50];
        CopyTxt: Text[10];
        DescriptionToPrint: Text[50];
        HighDescriptionToPrint: Text[110];
        LowDescriptionToPrint: Text[110];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        SalesInvPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddress: Codeunit "Format Address";
        PPack: Text[30];
        PVendorNo: Text[30];
        PQuanOrd: Text[30];
        PLandedCost: Text[30];
        PRetail: Text[30];
        PMargin: Text[30];
        PWeight: Text[30];
        PUnitFreight: Text[30];
        PDescrip: Text[80];
        PPackInt: Integer;
        PCalcLandedCost: Decimal;
        PCalcActMargin: Decimal;
        PRoundGPM: Decimal;
        PQuanShip: Text[30];
        PFreightTotal: Decimal;
        PFeeTotal: Decimal;
        PInsuranceTotal: Decimal;
        PReserveTotal: Decimal;
        TRetail: Decimal;
        PCalcRetail: Decimal;
        VPONumber: Code[10];
        PVendorItem: Code[20];
        ItemRecord: Record Item;
        TotRetail: Decimal;
        TotLand: Decimal;
        TotMargin: Decimal;
        TLanded: Decimal;
        SalesInvoiceLine: Record "Sales Invoice Line";
        IsHidden: Boolean;
        PDesc1: Text[50];
        BillCaptionLbl: label 'Bill';
        To_CaptionLbl: label 'To:';
        Due_DateCaptionLbl: label 'Due Date';
        Customer_IDCaptionLbl: label 'Customer ID';
        Our_Order_No_CaptionLbl: label 'Our Order No.';
        Invoice_Number_CaptionLbl: label 'Invoice Number:';
        Invoice_Date_CaptionLbl: label 'Invoice Date:';
        Page_CaptionLbl: label 'Page:';
        ANICA__INC_CaptionLbl: label 'ANICA, INC.';
        INVOICECaptionLbl: label 'INVOICE';
        Shipment_DateCaptionLbl: label 'Shipment Date';
        Posting_DateCaptionLbl: label 'Posting Date';
        PO_NO_CaptionLbl: label 'PO NO.';
        Item_No_CaptionLbl: label 'Item No.';
        DescriptionCaptionLbl: label 'Description';
        UnitCaptionLbl: label 'Unit';
        Pack_SizeCaptionLbl: label 'Pack Size';
        Extended_CostCaptionLbl: label 'Extended Cost';
        Unit_WeightCaptionLbl: label 'Unit Weight';
        Landed_CostCaptionLbl: label 'Landed Cost';
        MarginCaptionLbl: label 'Margin';
        Quantity_ShippedCaptionLbl: label 'Quantity Shipped';
        Unit_RetailCaptionLbl: label 'Unit Retail';
        Unit_PriceCaptionLbl: label 'Unit Price';
        Vendor_Item_No_CaptionLbl: label 'Vendor Item No.';
        MerchandiseCaptionLbl: label 'Merchandise';
        PURCHASER_AGREES_TO_PROMPTLY_PAY_FOR_THE_MERCHANDISE_RECEIVED_AND_WAIVES_ANY_CLAIM_OF_SOVEREIGN_IMMUNITY_WITH_RESPECT_THERETOLbl: label 'PURCHASER AGREES TO PROMPTLY PAY FOR THE MERCHANDISE RECEIVED AND WAIVES ANY CLAIM OF SOVEREIGN IMMUNITY WITH RESPECT THERETO.';
        ReserveCaptionLbl: label 'Reserve';
        FreightCaptionLbl: label 'Freight';
        MiscCaptionLbl: label 'Misc';
        InsuranceCaptionLbl: label 'Insurance';
        Invoice_AmountCaptionLbl: label 'Invoice Amount';
        Average_GPM_CaptionLbl: label 'Average GPM:';
        EmptyStringCaptionLbl: label '%';
        VType: Integer;
        VInvoiceAmount: Decimal;
        VNonMerchSum: Decimal;
        VShowLine: Boolean;
        Lines: Record "Sales Invoice Line";
        Item: Record Item;
        VDocumentNo: Code[10];
        VCigCount: Integer;
        VCigTotal: Integer;
        VPrice: Decimal;
        VPriceTotal: Decimal;
        VItem: Code[20];
        VItemType: Option;
        VItemsPer: Integer;
        VIsTobacco: Boolean;
        VLastDirectCost: Decimal;
        VStart: Date;
        VEnd: Date;


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
                    VItem := Lines."No.";
                    LookupItem;
                end;
            until Lines.Next = 0;
    end;


    procedure LookupItem()
    begin
        Item.SetCurrentkey("No.");
        Item.SetRange("No.",VItem);

        if Item.Find('-') then
            begin
                //Only the items stocked in the warehouse.
                if Item."Vendor No." = 'JBGO002' then
                    begin
                        VIsTobacco := Item."MSA Reporting";
                    end;
            end;
    end;
}

