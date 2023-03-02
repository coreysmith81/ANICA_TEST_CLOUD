Report 50037 "MOA Tobacco Sales Invoices"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MOA Tobacco Sales Invoices.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.") order(ascending);
            column(ReportForNavId_5581; 5581)
            {
            }
            column(Sales_Invoice_Header_No_; "No.")
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
                    column(BillToAddress_2_; BillToAddress[2])
                    {
                    }
                    column(BillToAddress_3_; BillToAddress[3])
                    {
                    }
                    column(BillToAddress_4_; BillToAddress[4])
                    {
                        IncludeCaption = false;
                    }
                    column(BillToAddress_5_; BillToAddress[5])
                    {
                    }
                    column(BillToAddress_6_; BillToAddress[6])
                    {
                    }
                    column(BillToAddress_7_; BillToAddress[7])
                    {
                    }
                    column(BillToAddress_8_; BillToAddress[8])
                    {
                    }
                    column(Sales_Invoice_Header___Due_Date_; "Sales Invoice Header"."Due Date")
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Customer_No__; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Invoice_Header___Order_No__; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(Sales_Invoice_Header___No__; "Sales Invoice Header"."No.")
                    {
                    }
                    column(Sales_Invoice_Header___Document_Date_; "Sales Invoice Header"."Document Date")
                    {
                    }
                    column(Sales_Invoice_Head er___Shipment_Date_;"Sales Invoice Header"."Shipment Date")
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_;" Sales Invoice Header"."Posting Date")
                    {
                    }
                    column(VPONumber;VPONumber) 
                    {
                    }
                    column(CompanyInf ormation_City______CompanyInformation_County_____CompanyInformation__Post_Code_;CompanyInformation.City+', '+CompanyInformation.County+' '+CompanyInformation."Post Code")
                    {
                    }
                    column(CompanyInformation__Phone_No__;CompanyInformation."Phone No.")  + ', ' +  + ' ' + 
                    {
                    }
                    column(CompanyInformation_Address;Comp anyInformation.Address)
                    {
                    }
                    column(CompanyInformation_Picture; CompanyInformation.Picture)
                    {
                    }
                    column(BillCaption;BillCaptionLbl) 
                    {
                    }
                    column(To_Caption;T o_CaptionLbl)
                    {
                    }
                    column(Due_DateCap tion;Due_DateCaptionLbl)
                    {
                    }
                    column(Customer_IDCapti on;Customer_IDCaptionLbl)
                    {
                    }
                    column(Our_Order_No_Captio n;Our_Order_No_CaptionLbl)
                    {
                    }
                    column(Invoice_Number_Captio n;Invoice_Number_CaptionLbl)
                    {
                    }
                    column(Invoice_Date_Caption;In voice_Date_CaptionLbl)
                    {
                    }
                    column(Page_Caption;Page_Cap tionLbl)
                    {
                    }
                    column(ANICA__INC_Ca ption;ANICA__INC_CaptionLbl)
                    {
                    }
                    column(INVOICECaption;INVO ICECaptionLbl)
                    {
                    }
                    column(Shipment_DateCa ption;Shipment_DateCaptionLbl)
                    {
                    }
                    column(Posting_DateCaption;P osting_DateCaptionLbl)
                    {
                    }
                    column(PO_NO_Caption;PO_NO_ CaptionLbl)
                    {
                    }
                    column(PageLoop_Numbe r;Number)
                    {
                    }
                    column(AmountExclInvDis cTotal;AmountExclInvDiscTotal)
                    {
                    }
                    column(PFreightTotal;PFreightT otal)
                    {
                    }
                    column(PFeeTotal;PFee Total)
                    {
                    }
                    column(PInsurance Total;PInsuranceTotal)
                    {
                    }
                    column(TotMargin;TotMar gin)
                    {
                    }
                    column(PReserveTo tal;PReserveTotal)
                    {
                    }
                    column(VInvoiceAmount ;VInvoiceAmount)
                    {
                    }
                    dataitem("Sales Invoic e Line";"Sales Invoice Line")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "S "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.", 
                        column(Sales_Invoice_Line__No__;"No.")
                        {
                        }
                        column(VType;VType) 
                        {
                        }
                        column(VShowL ine;VShowLine)
                        {
                        }
                        column(AmountExcl InvDisc;AmountExclInvDisc)
                        {
                        }
                        column(PDescrip;PDescrip) 
                        {
                        }
                        column(PPack;PPa ck)
                        {
                        }
                        column(UnitPr iceToPrint;UnitPriceToPrint)
                        {
                            DecimalPlaces = 2:5;
                        } 
                        column(PWeight;PWeight)
                        { : 
                        }
                        column(PLandedC ost;PLandedCost)
                        {
                        }
                        column(PRetail;PRet ail)
                        {
                        }
                        column(PMargin; PMargin)
                        {
                            //DecimalPlaces = 1:1;
                        } 
                        column(Sales_Invoice_Line__Unit_of_Measure_Code_;"Unit of Measure Code")
                        { : 
                        }
                        column(PQuanShip;PQuanShip) 
                        {
                        }
                        column(PVendorIte m;PVendorItem)
                        {
                        }
                        column(AmountExclIn vDisc_Control54;AmountExclInvDisc)
                        {
                        }
                        column(Amount_Including_VAT____PFee Total___PFreightTotal_PReserveTotal_PInsuranceTotal;"Amount Including VAT" + PFeeTotal + PFreightTotal+PReserveTotal+PInsuranceTotal)
                        {
                        }
                        column(PrintFooter;PrintFooter)  + PReserveTotal + 
                        {
                        }
                        column(Item_No_Capt ion;Item_No_CaptionLbl)
                        {
                        }
                        column(DescriptionCapti on;DescriptionCaptionLbl)
                        {
                        }
                        column(UnitCaption;UnitCap tionLbl)
                        {
                        }
                        column(Pack_SizeCap tion;Pack_SizeCaptionLbl)
                        {
                        }
                        column(Extended_CostCapt ion;Extended_CostCaptionLbl)
                        {
                        }
                        column(Unit_WeightCaption;Un it_WeightCaptionLbl)
                        {
                        }
                        column(Landed_CostCaption; Landed_CostCaptionLbl)
                        {
                        }
                        column(MarginCaption;Margi nCaptionLbl)
                        {
                        }
                        column(Quantity_Shipp edCaption;Quantity_ShippedCaptionLbl)
                        {
                        }
                        column(Unit_RetailCaption;Unit_ RetailCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption;U nit_PriceCaptionLbl)
                        {
                        }
                        column(Vendor_Item_No_Cap tion;Vendor_Item_No_CaptionLbl)
                        {
                        }
                        column(MerchandiseCaption;Merc handiseCaptionLbl)
                        {
                        }
                        column(DataItem33;PURCHASE R_AGREES_TO_PROMPTLY_PAY_FOR_THE_MERCHANDISE_RECEIVED_AND_WAIVES_ANY_CLAIM_OF_SOVEREIGN_IMMUNITY_WITH_RESPECT_THERETOLbl)
                        {
                        }
                        column(ReserveCapt ion;ReserveCaptionLbl)
                        {
                        }
                        column(FreightCaption; FreightCaptionLbl)
                        {
                        }
                        column(MiscCaption;Mis cCaptionLbl)
                        {
                        }
                        column(InsuranceCap tion;InsuranceCaptionLbl)
                        {
                        }
                        column(Invoice_AmountCap tion;Invoice_AmountCaptionLbl)
                        {
                        }
                        column(Average_GPM_Caption;Av erage_GPM_CaptionLbl)
                        {
                        }
                        column(EmptyStringCaption;E mptyStringCaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_ Document_No_;"Document No.")
                        {
                        }
                        column(Sales_Invoice_Line_Line_No_;"Lin e No.")
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
                            else begin0;
                            if "Sales Invoice Header"."Order No." = '' then
                                OrderedQuantity := Quantity
                            else begin
                                if OrderLine.Get(1, "Sales Invoice Header"."Order No.", "Line No.") then
                                    OrderedQuantity := OrderLine.Quantity
                                else begin
                                    ShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
                                    ShipmentLine.SetRange("Order Line No.", "Line No.");
                                    if ShipmentLine.Find('-') then;
                                    repeat
                                        OrderedQuantity := OrderedQuantity + ShipmentLine.Quantity;
                                    until 0 = ShipmentLine.Next;
                             ItemRecord.SetCurrentkey(ItemRecord."No.");
                            ItemRecord.SetRange(ItemRecord."No.","Sales Invoice Line"."No.");
                            if ItemRecord.Find('-') then PVendorItem := ItemRecord."Vendor Item No.";
                            //DescriptionToPrint := COPYSTR("Sales Invoice Line"."Description 2",1,30);
                            DescriptionToPrint := Description; 
                            if Type = "Sales Line Type"::" " then begin
                              if OnLineNumber < NumberOfLines then begin
                                Next;
                                if Type = "Sales Line Type"::" " then begin
                                    DescriptionToPrint := CopyStr(DescriptionToPrint + ' ' + Description,1,MaxStrLen(DescriptionToPrint));
                                    Next;
                                    end else
                                        Next(-1); 1, 
                              end;      
                              "N    end else
                                        Next(-1);
                                end;
                                "Amount Including VAT" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                            en  d;
  
                            //  Removed by LCC 2-10-00
                            // ELSE IF Type = Type::"Account (G/L)" THEN "No." := '';

                            if "No." = '' then begin
                              HighDescriptionToPrint := DescriptionToPrint;
                              LowDescriptionToPrint := '';
                            end else begin
                                HighDescriptionToPrint := '';
                                LowDescriptionToPrint := DescriptionToPrint;
                            end;
  
                            if   Amount <> "Amount Including VAT" then begin
                              TaxFlag := true;
                              TaxLiable := Amount;
                            end else begin
                                TaxFlag := false;
                                TaxLiable := 0;
                            end;
  
                            Am  ountExclInvDisc := Amount + "Inv. Discount Amount";
                            //CS: Added this for the footer of the report
                            //CS: To get the amount of the non-merchandise lines, to fix the invoice amount field in the footer.
                            //IF Type <> Type::"G/L Account" THEN
                            //    AmountExclInvDiscTotal := AmountExclInvDiscTotal + AmountExclInvDisc;


                            if Quantity = 0 then
                              UnitPriceToPrint := 0  // so it won't print
                            else
                              UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.01);
  

                            //  ANICA section to format line output 
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
                            if Type = "Sales Line Type"::Item then
                            begin
                            //Output for item lines
                               if "No." <> ' begin
                                //Output for item lines
                                       PPack := For begin
                                    PQuanOrd := Format(Quan tity,0,0);
                                    PQuanShip := Format(Quantity,0,0);
                                    PWeight := Format(ROUND("Gross Weight",0.1),0,'<Integer><Decimal,2>');
                                    if Quantity <> 0 then 0, 
                                        PUnitFreight := Format(RO 0, D("Invoiced Freight"/Quantity,0.01),0,'<Integer><Decimal,3>');
                                    if Quantity <> 0 then  0, 
                                       PCalcLandedCost := (ROUND("Invoiced Freight"/Quantity,0.01)) + "Unit Price"
                                      el PCalcLandedCost := 0; / Quantity,  0, 
                                    PCalcLandedCost := ROUND(PCalcLandedCost,0.01);
                                      PLndedCost := Format(PCalcLandedCost,0,'<Integ / Quantity, l,3>');
                                    else
                                       cRetail := "Retail Price Per Unit";
                                    PCalcRetail := ROUND("Retail Price Per Un it",0.01);
                                    if "Sales Invoice Line"."Store Use" =  0, ue then PCalcRetail := 0;
                                    PRetail := Format(PCalcRetail,0,'<Integer><Decimal,3>');
                                    if (PCalcRetail <> 0) and (Pack <> 0) then 
                                       PCalcActMargin := ((PCalcRetail - (PCalcLandedCost/Pack)) / PCalcRetail) * 100
                                    else PCalcActMargin := 0; 0, 

                                      PRundGPM := ROUND(PCalcActMargin,0.1,'>'); / 
                                    else
                                       gin := Format(PRoundGPM,0,'<Sign><Integer><Decimal,2>');
                                      TRetail := "Retail Price Per Unit" * Quantity * Pack;
                                    TLanded := Quantity * PCalcLandedC 0.1, 
                                    TotRetail := TotRetail + TRe 0, il;
                                    TotLand := TotLand + TLanded;
                                  en
                            end;

                            //GLines
                            if Type = "Sales Line Type"::"G/L Account" then
                            begin
                            //Output for account lines
                               if "No." <> ' begin
                                //Output for account lines
                                      PPackInt := R begin
                                    //"No." := '';
                                 //   PQuanOrd := FORMAT("O rig. Order Qty.",0,0);
                                    PQuanOrd := Format(Quantity,0,0);
                                    PQuanShip := Format(Quantity,0,0);
                                    //   PQuanOrd := FORMAT("Orig. Order Qty.",0,0);
                                    if Quantity <> 0 then 0, 
                                       PUnitFreight := Format(ROU 0, ("Invoiced Freight"/Quantity,0.01),0,'<Integer><Decimal,3>');
                                    //PWeight := FORMAT(ROUND("Gross Weight",0.1),0,'<Integer><Decimal,2>');
                                       PCalcLandedCost := (ROUND("Invoiced Freight"/Quantity,0.01)) + "Unit Price"
                                     else PCalcLandedCost := 0; / Quantity,  0, 
                                    PCalcLandedCost := ROUND(PCalcLandedCost,0.01);
                                     PLandedCost := Format(PCalcLandedCost,0,'<Integ / Quantity, l,3>');
                                    else
                                       cRetail := "Retail Price Per Unit";
                                    if "Sales Invoice Line"."Store Use" = tru e then
                                       PCalcRetail := 0; 0, 
                                    PRetail := Format(PCalcRetail,0,'<Integer><Decimal,3>');
                                    if (PCalcRetail <> 0) and (Pack <> 0) then
                                        PCalcActMargin := ((PCalcRetail - (PCalcLandedCost/Pack)) / PCalcRetail) * 100
                                    else PCalcActMargin := 0; 0, 
                                    PRoundGPM := ROUND(PCalcActMargin,0.1,'>');
                                     PMargin := Format(PRoundGPM,0,'<Integer><Decimal,3>') / 
                                    else
                                       ail := "Retail Price Per Unit" * Quantity * Pack;
                                  en; 0.1, 
                            end; 0, 


                            //Do not print Other Charges on the sales order other than freight

                               if "Calculated Freight Line" = true then
                                  begin
                                      PFreightTotal := PFreightTotal + "Sales Invoice Line"."Amount Including VAT";
                                   VShowLine := false; //so line won begin

                               iculated Insurance Line" = true then
                            end;

                            if "Calculated Insurance Line" = true then begin
                                PInsuranceTotal := PInsuranceTotal + "Sales Invoice Line"."Amount Including VAT";
                                VShowLine := false; //so line won't show on print out.
                            end;

                            if "Calculated Reserve Line" = true then begin
                                PReserveTotal := PReserveTotal + "Sales Invoice Line"."Amount Including VAT";
                                VShowLine := false; //so line won't show on print out.
                            end;

                            if "Calculated Fee Line" = true then begin
                                PFeeTotal := PFeeTotal + "Sales Invoice Line"."Amount Including VAT";
                                VShowLine := false; //so line won't show on print out.
                      if VShowLine then
                                AmountExclInvDiscTotal := AmountExclInvDiscTotal + AmountExclInvDisc;

                            //CS: Get total invoice amount for footer:
                            VInvoiceAmount := AmountExclInvDiscTotal + PReserveTotal + PFreightTotal + PFeeTotal + PInsuranceTotal;

                            //CS: For the Average GPM field in the footer.
                            if TotRetail <> 0 then
                                begin
                                    TotMargin := ((TotRetail - TotLand) / TotRetail);
                                end; begin

                        trigOnPreDataItem()
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
                    //CurrReport.PageNo := 1; //PageNo Deprecated. Handle in Report Designer.

                    if CopyNo = NoLoops then begin
                      if not CurrReport.Preview then
                        SalesInvPrinted.Run("Sales Invoice Header");
                      CurrReport.Break;
                    en  d else
                      Co    pyNo := CopyNo + 1;
                    if   CopyNo = 1 then // Original
                      Clear(CopyTxt)
                    el  se
                      CopyTxt := 'COPY';
                end;  

                trigge  r OnPreDataItem()
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
                end; begin
                    //Don't print intercompany transfers
                //IF "Sales Invoice Header".InterCompany = TRUE THEN CurrReport.SKIP;

                if "Salesperson Code" = '' then
                  Clear(SalesPurchPerson)
                else
                  SalesPurchPerson.Get("Salesperson Code");
  
                FormatAddress.SalesInvBillTo(BillToAddress,"Sales Invoice Header");
                Fo  rmatAddress.SalesInvShipTo(ShipToAddress,ShipToAddress,"Sales Invoice Header"); //A third argument (2nd one) was added. 
                                                                                                   // Need to make sure ShipToAddress works here.                 
 
                if "Payment Terms Code" = '' then 
                  Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");

                if   "Shipment Method Code" = '' then
                  Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");

                Cu  stomer.Get("Bill-to Customer No.");
            end;

            trigger OnPreDataItem()
            begin
                if PrintCompany then begin
                  CompanyInformation.Get('');
                  FormatAddress.Company(CompanyAddress,CompanyInformation);
                en  d else
                    Clear(CompanyAddress); 

                Co  mpanyInformation.CalcFields(Picture);

                //Filter to only ADC, CIG invoices in the date range.
                SetRange("Sales Invoice Header"."Posting Date",VStart,VEnd);
                SetRange("Sales Invoice Header"."Location Code",'ADC');
                SetRange("Sales Invoice Header"."Shipping Instr VStart, Code",'CIG');
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
                        Applicati onArea = Basic;
                        Caption = 'Start Date';
                    }
                    field(VEnd;VEnd)
                    {
                        Applica tionArea = Basic;
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
        ShipToAddress: array 8] of Text[50];
        CopyTxt: Text[10];
        DescriptionToPrint: ext[50];
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
            begin

                LookupItem;

            end
            until Liexit;
end;


    procedure LookupLines()
    begin
        Lines.SetCurrentkey("Document No.","Line No.");
        Lines.SetRange("Document No.",VDocumentNo);
 
        if Lines.Find('-') then 
            repeat
                begin
                    VItem := Lines."No.";
            begin
            end;
            untiLookupItem;
end;


    procedure LookupItem()
    begin
        Item.SetCurrentkey("No.");
        Item.SetRange("No.",VItem);

        if Item.Find('-') th en
            begin
                //Only the ite begin
            //Only the items stocked in the warehouse.
                    VIsTobacco := Item."MSA Repor begin
    end;
    end;end;


