Report 50199 "New ADC Groc Purch Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/New ADC Groc Purch Order.rdlc';
    Caption = 'Purchase Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header";"Purchase Header")
        {
            DataItemTableView = sorting("Document Type","No.") order(ascending) where("Document Type"=const(Order),Status=const(Released));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Document Date","Location Code","No.","Buy-from Vendor No.","Pay-to Vendor No.","No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(ReportForNavId_4458; 4458)
            {
            }
            column(No_PurchaseHeader;"No.")
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
                    column(CompanyAddress1;CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress2;CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress3;CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress4;CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress5;CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress6;CompanyAddress[6])
                    {
                    }
                    column(CopyTxt;CopyTxt)
                    {
                    }
                    column(BuyFromAddress1;BuyFromAddress[1])
                    {
                    }
                    column(BuyFromAddress2;BuyFromAddress[2])
                    {
                    }
                    column(BuyFromAddress3;BuyFromAddress[3])
                    {
                    }
                    column(BuyFromAddress4;BuyFromAddress[4])
                    {
                    }
                    column(BuyFromAddress5;BuyFromAddress[5])
                    {
                    }
                    column(BuyFromAddress6;BuyFromAddress[6])
                    {
                    }
                    column(BuyFromAddress7;BuyFromAddress[7])
                    {
                    }
                    column(ExptRecptDt_PurchaseHeader;"Purchase Header"."Expected Receipt Date")
                    {
                    }
                    column(ShipToAddress1;ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2;ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3;ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4;ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5;ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6;ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7;ShipToAddress[7])
                    {
                    }
                    column(BuyfrVendNo_PurchaseHeader;"Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(YourRef_PurchaseHeader;"Purchase Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName;SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchaseHeader;"Purchase Header"."No.")
                    {
                    }
                    column(OrderDate_PurchaseHeader;"Purchase Header"."Order Date")
                    {
                    }
                    column(CompanyAddress7;CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8;CompanyAddress[8])
                    {
                    }
                    column(BuyFromAddress8;BuyFromAddress[8])
                    {
                    }
                    column(ShipToAddress8;ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDescription;ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDescription;PaymentTerms.Description)
                    {
                    }
                    column(CopyNo;CopyNo)
                    {
                    }
                    column(PShipHead;PShipHead)
                    {
                    }
                    column(ShipLineArray_1_;ShipLineArray[1])
                    {
                    }
                    column(ShipLineArray_2_;ShipLineArray[2])
                    {
                    }
                    column(ShipLineArray_3_;ShipLineArray[3])
                    {
                    }
                    column(ShipLineArray_4_;ShipLineArray[4])
                    {
                    }
                    column(ShipLineArray_5_;ShipLineArray[5])
                    {
                    }
                    column(ShipLineArray_6_;ShipLineArray[6])
                    {
                    }
                    column(Purchase_Header___Sell_to_Customer_No__;"Purchase Header"."Sell-to Customer No.")
                    {
                    }
                    column(Purchase_Header___Requested_Receipt_Date_;"Purchase Header"."Requested Receipt Date")
                    {
                    }
                    column(CompanyInformation_PhoneNo;CompanyInformation."Phone No.")
                    {
                    }
                    column(CompanyInformation_City_State_Post_Zip_;CompanyInformation.City+', '+CompanyInformation.County+' '+CompanyInformation."Post Code")
                    {
                    }
                    column(CompanyInformation_Address;CompanyInformation.Address)
                    {
                    }
                    column(CompanyInformation_Picture;CompanyInformation.Picture)
                    {
                    }
                    column(VendTaxIdentificationType;Format(Vend."Tax Identification Type"))
                    {
                    }
                    column(ToCaption;ToCaptionLbl)
                    {
                    }
                    column(ReceiveByCaption;ReceiveByCaptionLbl)
                    {
                    }
                    column(VendorIDCaption;VendorIDCaptionLbl)
                    {
                    }
                    column(ConfirmToCaption;ConfirmToCaptionLbl)
                    {
                    }
                    column(BuyerCaption;BuyerCaptionLbl)
                    {
                    }
                    column(ShipCaption;ShipCaptionLbl)
                    {
                    }
                    column(ToCaption1;ToCaption1Lbl)
                    {
                    }
                    column(PurchOrderCaption;PurchOrderCaptionLbl)
                    {
                    }
                    column(PurchOrderNumCaption;PurchOrderNumCaptionLbl)
                    {
                    }
                    column(PurchOrderDateCaption;PurchOrderDateCaptionLbl)
                    {
                    }
                    column(PageCaption;PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption;ShipViaCaptionLbl)
                    {
                    }
                    column(TermsCaption;TermsCaptionLbl)
                    {
                    }
                    column(PhoneNoCaption;PhoneNoCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption;TaxIdentTypeCaptionLbl)
                    {
                    }
                    dataitem("Purchase Line";"Purchase Line")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("Document Type","Document No.","Line No.") where("Document Type"=const(Order));
                        column(ReportForNavId_6547; 6547)
                        {
                        }
                        column(AmountExclInvDisc;AmountExclInvDisc)
                        {
                        }
                        column(ItemNumberToPrint;ItemNumberToPrint)
                        {
                        }
                        column(UnitofMeasure_PurchaseLine;"Unit of Measure")
                        {
                        }
                        column(Quantity_PurchaseLine;Quantity)
                        {
                        }
                        column(UnitPriceToPrint;UnitPriceToPrint)
                        {
                            DecimalPlaces = 2:5;
                        }
                        column(Description_PurchaseLine;Description)
                        {
                        }
                        column(PrintFooter;PrintFooter)
                        {
                        }
                        column(InvDiscountAmt_PurchaseLine;"Inv. Discount Amount")
                        {
                        }
                        column(TaxAmount;TaxAmount)
                        {
                        }
                        column(LineAmtTaxAmtInvDiscountAmt;"Line Amount" + TaxAmount - "Inv. Discount Amount")
                        {
                        }
                        column(TotalTaxLabel;TotalTaxLabel)
                        {
                        }
                        column(BreakdownTitle;BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1;BreakdownLabel[1])
                        {
                        }
                        column(BreakdownAmt1;BreakdownAmt[1])
                        {
                        }
                        column(BreakdownLabel2;BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt2;BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel3;BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt3;BreakdownAmt[3])
                        {
                        }
                        column(BreakdownAmt4;BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4;BreakdownLabel[4])
                        {
                        }
                        column(PPack;PPack)
                        {
                        }
                        column(Purchase_Line__Unit_of_Measure_Code_;"Unit of Measure Code")
                        {
                        }
                        column(Purchase_Line__Vendor_Item_No__;"Vendor Item No.")
                        {
                        }
                        column(PVendorItemNo;PVendorItemNo)
                        {
                        }
                        column(PWeight;PWeight)
                        {
                            DecimalPlaces = 2:5;
                        }
                        column(PrintRetail;PrintRetail)
                        {
                        }
                        column(Purchase_Line__Description_2_;"Description 2")
                        {
                        }
                        column(Purchase_Line__Amount_Including_VAT_;"Amount Including VAT")
                        {
                        }
                        column(TGrossWeight;TGrossWeight)
                        {
                            DecimalPlaces = 1:1;
                        }
                        column(Purchase_Line_Document_Type;"Document Type")
                        {
                        }
                        column(Purchase_Line_Line_No_;"Line No.")
                        {
                        }
                        column(DocumentNo_PurchaseLine;"Document No.")
                        {
                        }
                        column(ItemNoCaption;ItemNoCaptionLbl)
                        {
                        }
                        column(UnitCaption;UnitCaptionLbl)
                        {
                        }
                        column(DescriptionCaption;DescriptionCaptionLbl)
                        {
                        }
                        column(QuantityCaption;QuantityCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption;UnitPriceCaptionLbl)
                        {
                        }
                        column(TotalPriceCaption;TotalPriceCaptionLbl)
                        {
                        }
                        column(SubtotalCaption;SubtotalCaptionLbl)
                        {
                        }
                        column(InvDiscCaption;InvDiscCaptionLbl)
                        {
                        }
                        column(TotalCaption;TotalCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            PRetailHeading := '';
                            PrintRetail := '';

                            if ("Purchase Header"."Tax Area Code" <> '') and not UseExternalTaxEngine then
                              SalesTaxCalc.AddPurchLine("Purchase Line");

                            if "Vendor Item No." <> '' then
                              ItemNumberToPrint := "Vendor Item No."
                            else
                              ItemNumberToPrint := "No.";

                            if Type = 0 then begin
                              ItemNumberToPrint := '';
                              "Unit of Measure" := '';
                              Amount := 0; //added from previous version. CS
                              "Amount Including VAT" := 0; //added from previous version. CS
                              "Line Amount" := 0;
                              "Inv. Discount Amount" := 0;
                              Quantity := 0;
                            end;

                            //AmountExclInvDisc := "Line Amount";
                            AmountExclInvDisc := Amount + "Inv. Discount Amount"; //from old version. CS

                            if Quantity = 0 then
                              UnitPriceToPrint := 0 // so it won't print
                            else
                              UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.00001);

                            if OnLineNumber = NumberOfLines then begin
                              PrintFooter := true;

                              if "Purchase Header"."Tax Area Code" <> '' then begin
                                if UseExternalTaxEngine then
                                  SalesTaxCalc.CallExternalTaxEngineForPurch("Purchase Header",true)
                                else
                                  SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                                SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                                BrkIdx := 0;
                                PrevPrintOrder := 0;
                                PrevTaxPercent := 0;
                                TaxAmount := 0;
                                with TempSalesTaxAmtLine do begin
                                  Reset;
                                  SetCurrentkey("Print Order","Tax Area Code for Key","Tax Jurisdiction Code");
                                  if Find('-') then
                                    repeat
                                      if ("Print Order" = 0) or
                                         ("Print Order" <> PrevPrintOrder) or
                                         ("Tax %" <> PrevTaxPercent)
                                      then begin
                                        BrkIdx := BrkIdx + 1;
                                        if BrkIdx > 1 then begin
                                          if TaxArea."Country/Region" = TaxArea."country/region"::CA then
                                            BreakdownTitle := Text006
                                          else
                                            BreakdownTitle := Text003;
                                        end;
                                        if BrkIdx > ArrayLen(BreakdownAmt) then begin
                                          BrkIdx := BrkIdx - 1;
                                          BreakdownLabel[BrkIdx] := Text004;
                                        end else
                                          BreakdownLabel[BrkIdx] := StrSubstNo("Print Description","Tax %");
                                      end;
                                      BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + "Tax Amount";
                                      TaxAmount := TaxAmount + "Tax Amount";
                                    until Next = 0;
                                end;
                                if BrkIdx = 1 then begin
                                  Clear(BreakdownLabel);
                                  Clear(BreakdownAmt);
                                end;
                              end;
                            end;

                            //ANICA section to format line output
                            if ("Purchase Header"."Buy-from Vendor No." = 'C&JT001')
                              or ("Purchase Header"."Buy-from Vendor No." = 'C&JT002') then
                              begin
                              SalesLineRecord.SetCurrentkey("Document Type","Document No.","Line No.");
                              SalesLineRecord.SetRange("Document Type",1);
                              SalesLineRecord.SetRange("Document No.","Purchase Line"."Sales Order No.");
                              SalesLineRecord.SetRange("Line No.","Purchase Line"."Sales Order Line No.");
                              if SalesLineRecord.Find('+') then PRetail := SalesLineRecord."Retail Price Per Unit";
                              PrintRetail := Format(PRetail);
                              PRetailHeading := 'Retail';
                              end
                              else
                              begin
                              PRetailHeading := '';
                              PrintRetail := '';
                              end;

                            //ANICA LCC 12-6-10, do not print vendor item number if there is no ANICA item no.
                            if "Purchase Line"."No." <> '' then
                            PVendorItemNo := "Purchase Line"."Vendor Item No."
                            else PVendorItemNo := '';

                            //Lookup Items for Pack
                            PPack := '';
                            if "No." <> '' then
                              begin
                              UOMRecord.SetCurrentkey("Item No.",Code);
                              UOMRecord.SetRange("Item No.","No.");
                              UOMRecord.SetRange(Code,"Unit of Measure Code");
                                 if UOMRecord.Find('+') then
                                 begin
                                 PPackint := ROUND(UOMRecord.Pack,1.0);
                                 PPack := Format(PPackint);
                                 PPack := PPack + ' / ' + UOMRecord."Pack Description";
                                 end;
                              end;
                            //ANICA weight total

                            PWeight := ROUND("Purchase Line"."Gross Weight",1.0,'>');
                            TGrossWeight := "Purchase Line".Quantity * ROUND("Purchase Line"."Gross Weight",1.0,'>');
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CreateTotals(AmountExclInvDisc,"Line Amount","Inv. Discount Amount");
                            NumberOfLines := Count;
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                      if not CurrReport.Preview then
                        PurchasePrinted.Run("Purchase Header");
                      CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                      Clear(CopyTxt)
                    else
                      CopyTxt := Text000;
                    TaxAmount := 0;

                    Clear(BreakdownTitle);
                    Clear(BreakdownLabel);
                    Clear(BreakdownAmt);
                    TotalTaxLabel := Text008;
                    if "Purchase Header"."Tax Area Code" <> '' then begin
                      TaxArea.Get("Purchase Header"."Tax Area Code");
                      case TaxArea."Country/Region" of
                        TaxArea."country/region"::US:
                          TotalTaxLabel := Text005;
                        TaxArea."country/region"::CA:
                          TotalTaxLabel := Text007;
                      end;
                      UseExternalTaxEngine := TaxArea."Use External Tax Engine";
                      SalesTaxCalc.StartSalesTaxCalculation;
                    end;
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
                if "Purchase Header"."Buy-from Vendor No." ='' then
                    CurrReport.Skip;

                VendorRecord.Get("Purchase Header"."Buy-from Vendor No.");

                if VendorRecord."Vendor Type Code" <> 2 then
                    CurrReport.Skip;

                if PrintCompany then
                  if RespCenter.Get("Responsibility Center") then begin
                    FormatAddress.RespCenter(CompanyAddress,RespCenter);
                    CompanyInformation."Phone No." := RespCenter."Phone No.";
                    CompanyInformation."Fax No." := RespCenter."Fax No.";
                  end;
                CurrReport.Language := Language.GetLanguageID("Language Code");

                //>>  Warehouse Management - start
                //IF Released THEN
                if Status = 1 then
                  Clear(NotReleased)
                else
                  NotReleased := '- Not Released';

                //Lookup Ship Instruction Lines
                if "Shipping Instruction Code" = '' then
                  Clear(ShipInstructLines)
                else
                  begin
                  PShipHead := 'Shipping Instruction: ' + "Shipping Instruction Code";
                  ShipInstructLines.SetRange("Shipping Instruction Code","Shipping Instruction Code");
                  ShipInstructLines.Find('-');
                  c := 1;
                     repeat
                     begin
                     ShipLineArray[c] := ShipInstructLines.Instruction;
                     c := c+1;
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

                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress,"Purchase Header");
                FormatAddress.PurchHeaderShipTo(ShipToAddress,"Purchase Header");

                if not CurrReport.Preview then begin
                  if ArchiveDocument then
                    ArchiveManagement.StorePurchDocument("Purchase Header",LogInteraction);

                  if LogInteraction then begin
                    CalcFields("No. of Archived Versions");
                    SegManagement.LogDocument(
                      13,"No.","Doc. No. Occurrence","No. of Archived Versions",Database::Vendor,"Buy-from Vendor No.",
                      "Purchaser Code",'',"Posting Description",'');
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
                  FormatAddress.Company(CompanyAddress,CompanyInformation)
                else
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
                    field(NumberOfCopies;NoCopies)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompanyAddress;PrintCompany)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Company Address';
                    }
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                              LogInteraction := false;
                        end;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                              ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
            ArchiveDocumentEnable := true;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := ArchiveManagement.PurchaseDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
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
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Vend: Record Vendor;
        CompanyAddress: array [8] of Text[50];
        BuyFromAddress: array [8] of Text[50];
        ShipToAddress: array [8] of Text[50];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[20];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchasePrinted: Codeunit "Purch.Header-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        TaxAmount: Decimal;
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array [4] of Text[30];
        BreakdownAmt: array [4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        UseDate: Date;
        Text000: label 'COPY';
        Text003: label 'Sales Tax Breakdown:';
        Text004: label 'Other Taxes';
        Text005: label 'Total Sales Tax:';
        Text006: label 'Tax Breakdown:';
        Text007: label 'Total Tax:';
        Text008: label 'Tax:';
        UseExternalTaxEngine: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        ToCaptionLbl: label 'To:';
        ReceiveByCaptionLbl: label 'Receive By';
        VendorIDCaptionLbl: label 'Vendor ID';
        ConfirmToCaptionLbl: label 'Confirm To';
        BuyerCaptionLbl: label 'Buyer';
        ShipCaptionLbl: label 'Ship';
        ToCaption1Lbl: label 'To:';
        PurchOrderCaptionLbl: label 'PURCHASE ORDER';
        PurchOrderNumCaptionLbl: label 'Purchase Order Number:';
        PurchOrderDateCaptionLbl: label 'Purchase Order Date:';
        PageCaptionLbl: label 'Page:';
        ShipViaCaptionLbl: label 'Ship Via';
        TermsCaptionLbl: label 'Terms';
        PhoneNoCaptionLbl: label 'Phone No.';
        TaxIdentTypeCaptionLbl: label 'Tax Ident. Type';
        ItemNoCaptionLbl: label 'Item No.';
        UnitCaptionLbl: label 'Unit';
        DescriptionCaptionLbl: label 'Description';
        QuantityCaptionLbl: label 'Quantity';
        UnitPriceCaptionLbl: label 'Unit Price';
        TotalPriceCaptionLbl: label 'Total Price';
        SubtotalCaptionLbl: label 'Subtotal:';
        InvDiscCaptionLbl: label 'Invoice Discount:';
        TotalCaptionLbl: label 'Total:';
        NotReleased: Text[30];
        PShipHead: Text[30];
        ShipLineArray: array [20] of Text[60];
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
        SellToAddress: array [8] of Text[50];
        PDescription: Text[50];
        PDescription2: Text[50];
        Text1: Text[120];
        Text2: Text[120];
        Text3: Text[120];
        Text4: Text[120];
        Box1: Text[30];
        Box2: Text[25];
        PWeight: Decimal;
        PRetailHeading: Text[30];
        PRetail: Decimal;
        PrintRetail: Text[30];
        SalesLineRecord: Record "Sales Line";
}

