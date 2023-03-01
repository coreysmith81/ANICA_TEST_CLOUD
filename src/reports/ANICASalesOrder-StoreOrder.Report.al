Report 50029 "ANICA Sales Order-Store Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ANICA Sales Order-Store Order.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header";"Sales Header")
        {
            DataItemTableView = sorting("Document Type","Sell-to Customer No.","No.") order(ascending) where("Document Type"=const(Order),Status=const(Released));
            RequestFilterFields = "Document Date","No.","Sell-to Customer No.","Bill-to Customer No.","Ship-to Code","No. Printed","Order Created Date";
            RequestFilterHeading = 'Sales Order';
            column(ReportForNavId_6640; 6640)
            {
            }
            column(Sales_Header_Document_Type;"Document Type")
            {
            }
            column(Sales_Header_No_;"No.")
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
                    }
                    column(Sales_Header___Bill_to_Customer_No__;"Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Header___No__;"Sales Header"."No.")
                    {
                    }
                    column(Sales_Header___Document_Date_;"Sales Header"."Document Date")
                    {
                    }
                    column(CurrReport_PAGENO;CurrReport.PageNo)
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
                    column(PShipHead;PShipHead)
                    {
                    }
                    column(VPONumber;VPONumber)
                    {
                    }
                    column(VTotalCost;VTotalCost)
                    {
                    }
                    column(VTotalPieces;VTotalPieces)
                    {
                    }
                    column(VTotalWeight;VTotalWeight)
                    {
                    }
                    column(VAverageGPM;VAverageGPM)
                    {
                    }
                    column(CompanyInformation_Picture;CompanyInformation.Picture)
                    {
                    }
                    column(SoldCaption;SoldCaptionLbl)
                    {
                    }
                    column(To_Caption;To_CaptionLbl)
                    {
                    }
                    column(Customer_IDCaption;Customer_IDCaptionLbl)
                    {
                    }
                    column(Order_Date_Caption;Order_Date_CaptionLbl)
                    {
                    }
                    column(Page_Caption;Page_CaptionLbl)
                    {
                    }
                    column(V206__767_0333Caption;V206__767_0333CaptionLbl)
                    {
                    }
                    column(SEATTLE__WASHINGTON_98134Caption;SEATTLE__WASHINGTON_98134CaptionLbl)
                    {
                    }
                    column(V4634_E__MARGINAL_WAY_S___SUITE_200Caption;V4634_E__MARGINAL_WAY_S___SUITE_200CaptionLbl)
                    {
                    }
                    column(ANICA__INC_Caption;ANICA__INC_CaptionLbl)
                    {
                    }
                    column(SALESCaption;SALESCaptionLbl)
                    {
                    }
                    column(PO_No_Caption;PO_No_CaptionLbl)
                    {
                    }
                    column(ORDER_NO_Caption;ORDER_NO_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number;Number)
                    {
                    }
                    column(DataItem1000000001;PURCHASER_AGREES_TO_PROMPTLY_PAY_FOR_THE_MERCHANDISE_RECEIVED_AND_WAIVES_ANY_CLAIM_OF_SOVEREIGN_IMMUNITY_WITH_RESPECT_THERETOLbl)
                    {
                    }
                    column(Total_Cost_Caption;Total_Cost_CaptionLbl)
                    {
                    }
                    column(Total_Weight_Caption;Total_Weight_CaptionLbl)
                    {
                    }
                    column(Total_Pieces_Caption;Total_Pieces_CaptionLbl)
                    {
                    }
                    dataitem("Sales Line";"Sales Line")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = sorting("Document Type","Document No.","Line No.") where("Document Type"=const(Order));
                        column(ReportForNavId_2844; 2844)
                        {
                        }
                        column(Sales_Line__No__;"No.")
                        {
                        }
                        column(PQuanOrd;PQuanOrd)
                        {
                        }
                        column(UnitPriceToPrint;UnitPriceToPrint)
                        {
                            DecimalPlaces = 2:5;
                        }
                        column(AmountExclInvDisc;AmountExclInvDisc)
                        {
                        }
                        column(PDesc1;PDesc1)
                        {
                        }
                        column(PrintFooter;PrintFooter)
                        {
                        }
                        column(PPack;PPack)
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
                        }
                        column(PUnitFreight;PUnitFreight)
                        {
                        }
                        column(PWeight;PWeight)
                        {
                        }
                        column(PVendItem;PVendItem)
                        {
                        }
                        column(Sales_Line__Purchase_Order_No__;"Purchase Order No.")
                        {
                        }
                        column(PDesc2;PDesc2)
                        {
                        }
                        column(Sales_Line__Amount_Including_VAT_;"Amount Including VAT")
                        {
                        }
                        column(TGrossWeight;TGrossWeight)
                        {
                            DecimalPlaces = 1:1;
                        }
                        column(Sales_Line_Quantity;Quantity)
                        {
                        }
                        column(TotMargin;TotMargin)
                        {
                        }
                        column(ANICA_Item_No_Caption;ANICA_Item_No_CaptionLbl)
                        {
                        }
                        column(DescriptionCaption;DescriptionCaptionLbl)
                        {
                        }
                        column(Quantity_OrderedCaption;Quantity_OrderedCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption;Unit_PriceCaptionLbl)
                        {
                        }
                        column(Extended_CostCaption;Extended_CostCaptionLbl)
                        {
                        }
                        column(Pack_SizeCaption;Pack_SizeCaptionLbl)
                        {
                        }
                        column(Landed_CostCaption;Landed_CostCaptionLbl)
                        {
                        }
                        column(MarginCaption;MarginCaptionLbl)
                        {
                        }
                        column(Unit_FreightCaption;Unit_FreightCaptionLbl)
                        {
                        }
                        column(Unit_WeightCaption;Unit_WeightCaptionLbl)
                        {
                        }
                        column(Unit_RetailCaption;Unit_RetailCaptionLbl)
                        {
                        }
                        column(Vendor_Item_No_Caption;Vendor_Item_No_CaptionLbl)
                        {
                        }
                        column(PO_No_Caption_Control10;PO_No_Caption_Control10Lbl)
                        {
                        }
                        column(Average_GPM_Caption;Average_GPM_CaptionLbl)
                        {
                        }
                        column(EmptyStringCaption;EmptyStringCaptionLbl)
                        {
                        }
                        column(Sales_Line_Document_Type;"Document Type")
                        {
                        }
                        column(Sales_Line_Document_No_;"Document No.")
                        {
                        }
                        column(Sales_Line_Line_No_;"Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            if Type = 0 then begin
                              "No." := '';
                              "Unit of Measure" := '';
                              Amount := 0;
                              "Amount Including VAT" := 0;
                              "Inv. Discount Amount" := 0;
                              Quantity := 0;
                            end else if Type = Type::"G/L Account" then
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
                              UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.00001);
                            ItemFile.SetCurrentkey(ItemFile."No.");
                            ItemFile.SetRange(ItemFile."No.","Sales Line"."No.");
                            if ItemFile.Find('-') then PVendItem := ItemFile."Vendor Item No.";
                            //ANICA section to format line output
                            PPack := '';
                            PVendorNo := '';
                            PQuanOrd := '';
                            PLandedCost := '';
                            PRetail := '';
                            PMargin := '';
                            PWeight := '';
                            PUnitFreight := '';
                            PFreight := 0;
                            PCalcRetail := 0;

                            //PDescrip := Description + "Description 2";
                            PDesc1 := CopyStr("Sales Line".Description,1,30);
                            PDesc2 := CopyStr("Sales Line"."Description 2",1,30);

                            //Items
                            if "Document Type" = 1 then
                            begin
                            //Output for item lines
                               if "No." <> '' then
                               begin
                               PPackInt := ROUND(Pack,1.0);
                               PPack := Format(PPackInt);
                               PPack := PPack + ' / ' + "Pack Description";
                                  if "Drop Shipment" = true then
                                  begin
                                  CalcFields("Item Vendor No.");
                                  PVendorNo := "Item Vendor No.";
                                  end;
                               PQuanOrd := Format(Quantity,0,0);
                               PWeight := Format(ROUND("Gross Weight",0.1),0,'<Integer><Decimal,2>');
                               CalcFields("Estimated Freight");
                               if Quantity <> 0 then PFreight := ROUND("Estimated Freight"/Quantity,0.01,'>');
                               PUnitFreight := Format(PFreight,0,'<Integer><Decimal,3>');
                               if Quantity <> 0 then
                                  PCalcLandedCost := ROUND(PFreight + "Unit Price",0.01)
                                  else PCalcLandedCost := 0;
                               PLandedCost := Format(PCalcLandedCost,0,'<Integer><Decimal,3>');
                               PCalcRetail := ROUND("Retail Price Per Unit",0.01);
                               if "Sales Line"."Store Use" = true then PCalcRetail := 0;
                               PRetail := Format(PCalcRetail,0,'<Integer><Decimal,3>');
                               if (PCalcRetail <> 0) and (Pack <> 0) then
                                  PRoundGPM := ((PCalcRetail - (PCalcLandedCost/Pack)) / PCalcRetail) * 100
                                  else PRoundGPM := 0;
                               PRoundGPM := ROUND(PRoundGPM,0.1,'>');
                               PMargin := Format(PRoundGPM,0,'<Sign><Integer><Decimal,2>');
                               //Create variables for totals
                               TGrossWeight := ROUND(Quantity * "Gross Weight",0.1);
                               TRetail := Quantity * "Retail Price Per Unit" * Pack;
                               TLanded := Quantity * PCalcLandedCost;
                               TotRetail := TotRetail + TRetail;
                               TotLand := TotLand + TLanded;
                               TotPack := TotPack + Pack;



                               end;
                            end;

                            //Do not print Other Charges on the sales order other than freight
                               if OnLineNumber = NumberOfLines then PrintFooter := true;
                               if "Calculated Freight Line" = true then CurrReport.Skip;
                               if "Calculated Insurance Line" = true then CurrReport.Skip;
                               if "Calculated Reserve Line" = true then CurrReport.Skip;
                               if "Calculated Fee Line" = true then CurrReport.Skip;

                            //For 'Average GPM' in footer.
                            if TotRetail <> 0 then
                            begin
                                TotMargin := ((TotRetail - TotLand) / TotRetail);
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            /*CurrReport.CREATETOTALS(TaxLiable,AmountExclInvDisc,Amount,"Amount Including VAT");
                            CurrReport.CREATETOTALS(TGrossWeight,Quantity,TRetail);
                            CurrReport.CREATETOTALS(TLanded);
                            CurrReport.CREATETOTALS(TotLand);
                            CurrReport.CREATETOTALS(TotRetail);
                            CurrReport.CREATETOTALS(TotMargin);*/
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
                    CurrReport.PageNo := 1;

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
                VPONumber := '';

                //Check for drop ships and get po number for vendor
                SalesLine.SetCurrentkey("Document Type","Document No.");
                SalesLine.SetRange("Document Type",1);
                SalesLine.SetRange("Document No.","Sales Header"."No.");
                if SalesLine.Find('-') then
                begin
                VPONumber := SalesLine."Purchase Order No.";
                      if VDropShipOnly = true then
                      begin
                      if not SalesLine."Drop Shipment" then CurrReport.Skip;
                      end;
                end;
                // Per Dan print JBG or C&J occasionally

                if PCJJBG = false then
                begin
                  //Per meeting 1-6-99 do not print JBG or C&J
                  if PurchaseHeader.Get(1,VPONumber) then
                  begin
                     case PurchaseHeader."Buy-from Vendor No." of
                     'C&JT001' : CurrReport.Skip;
                     'JBGO001' : CurrReport.Skip;
                     end;
                  end;
                end;

                //>>  Warehouse Management - start
                //IF Released THEN
                if Status = 1 then
                  Clear(NotReleased)
                else
                  NotReleased := ' - Not Released';
                //<<  Warehouse Management - end

                if "Salesperson Code" = '' then
                  Clear(SalesPurchPerson)
                else
                  SalesPurchPerson.Get("Salesperson Code");

                //Lookup Ship Instruction Lines
                if "Shipping Instruction Code" = '' then
                  Clear(ShipInstructLines)
                else
                  begin
                  PShipHead := 'Shipping Instruction: ' + "Shipping Instruction Code";
                  ShipInstructLines.SetRange("Shipping Instruction Code","Shipping Instruction Code");
                  ShipInstructLines.Find('-');
                  C := 1;
                     repeat
                     begin
                     ShipLineArray[C] := ShipInstructLines.Instruction;
                //     MESSAGE('Shipping Code %1',ShipInstructLines.Instruction);
                     C := C+1;
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

                FormatAddress.SalesHeaderSellTo(BillToAddress,"Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddress,"Sales Header");
            end;

            trigger OnPreDataItem()
            begin
                if PrintCompany then begin
                  CompanyInformation.Get('');
                  FormatAddress.Company(CompanyAddress,CompanyInformation);
                end else
                  Clear(CompanyAddress);

                //CompanyInformation.GET;
                CompanyInformation.CalcFields(Picture);
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
                    field(VDropShipOnly;VDropShipOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drop Ship Only';
                    }
                    field(NoCopies;NoCopies)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Number of Copies';
                        Enabled = true;
                        Visible = true;
                    }
                    field(PCJJBG;PCJJBG)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print CJ Or JBG';
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
        SalesLine: Record "Sales Line";
        PurchaseHeader: Record "Purchase Header";
        CompanyAddress: array [8] of Text[50];
        BillToAddress: array [8] of Text[50];
        ShipToAddress: array [8] of Text[50];
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
        ShipLineArray: array [15] of Text[60];
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
        PWeight: Text[30];
        PUnitFreight: Text[30];
        PShipHead: Text[30];
        Ptemp: Boolean;
        PFreight: Decimal;
        PCalcLandedCost: Decimal;
        TRetail: Decimal;
        TGrossWeight: Decimal;
        PCalcRetail: Decimal;
        VDropShipOnly: Boolean;
        VPONumber: Code[10];
        PCJJBG: Boolean;
        ItemFile: Record Item;
        PVendItem: Text[20];
        TotRetail: Decimal;
        TotLand: Decimal;
        TotMargin: Decimal;
        TotPack: Decimal;
        TLanded: Decimal;
        PDesc1: Text[30];
        PDesc2: Text[30];
        Text19079128: label 'Drop Ship Only';
        Text19058203: label 'Print C&J or JBG';
        SoldCaptionLbl: label 'Sold';
        To_CaptionLbl: label 'To:';
        Customer_IDCaptionLbl: label 'Customer ID';
        Order_Date_CaptionLbl: label 'Order Date:';
        Page_CaptionLbl: label 'Page:';
        V206__767_0333CaptionLbl: label '(206) 767-0333';
        SEATTLE__WASHINGTON_98134CaptionLbl: label 'SEATTLE, WASHINGTON 98106';
        V4634_E__MARGINAL_WAY_S___SUITE_200CaptionLbl: label '4025 Delridge Way SW, Suite 300';
        ANICA__INC_CaptionLbl: label 'ANICA, INC.';
        SALESCaptionLbl: label 'SALES';
        PO_No_CaptionLbl: label 'PO No.';
        ORDER_NO_CaptionLbl: label 'ORDER NO.';
        ANICA_Item_No_CaptionLbl: label 'ANICA Item No.';
        DescriptionCaptionLbl: label 'Description';
        Quantity_OrderedCaptionLbl: label 'Quantity Ordered';
        Unit_PriceCaptionLbl: label 'Unit Price';
        Extended_CostCaptionLbl: label 'Extended Cost';
        Pack_SizeCaptionLbl: label 'Pack Size';
        Landed_CostCaptionLbl: label 'Landed Cost';
        MarginCaptionLbl: label 'Margin';
        Unit_FreightCaptionLbl: label 'Unit Freight';
        Unit_WeightCaptionLbl: label 'Unit Weight';
        Unit_RetailCaptionLbl: label 'Unit Retail';
        Vendor_Item_No_CaptionLbl: label 'Vendor Item No.';
        PO_No_Caption_Control10Lbl: label 'PO No.';
        Total_Cost_CaptionLbl: label 'Total Cost:';
        Total_Weight_CaptionLbl: label 'Total Weight:';
        Total_Pieces_CaptionLbl: label 'Total Pieces:';
        PURCHASER_AGREES_TO_PROMPTLY_PAY_FOR_THE_MERCHANDISE_RECEIVED_AND_WAIVES_ANY_CLAIM_OF_SOVEREIGN_IMMUNITY_WITH_RESPECT_THERETOLbl: label 'PURCHASER AGREES TO PROMPTLY PAY FOR THE MERCHANDISE RECEIVED AND WAIVES ANY CLAIM OF SOVEREIGN IMMUNITY WITH RESPECT THERETO.';
        Average_GPM_CaptionLbl: label 'Average GPM:';
        EmptyStringCaptionLbl: label '%';
        VTotalCost: Decimal;
        VTotalPieces: Integer;
        VTotalWeight: Decimal;
        VAverageGPM: Decimal;
}

