Report 50051 "Kent Purch Order Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Kent Purch Order Receipt.rdlc';

    dataset
    {
        dataitem("Purchase Header";"Purchase Header")
        {
            DataItemTableView = sorting("Document Type","No.") order(ascending) where("Document Type"=const(Order),Status=const(Released));
            RequestFilterFields = "Document Date","No.","Buy-from Vendor No.","Pay-to Vendor No.","No. Printed","Pick Ticket Printed","Shipping Instruction Code";
            RequestFilterHeading = 'Purchase Order';
            column(ReportForNavId_4458; 4458)
            {
            }
            column(Purchase_Header_Document_Type;"Document Type")
            {
            }
            column(Purchase_Header_No_;"No.")
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
                    column(BuyFromAddress_1_;BuyFromAddress[1])
                    {
                    }
                    column(BuyFromAddress_2_;BuyFromAddress[2])
                    {
                    }
                    column(BuyFromAddress_3_;BuyFromAddress[3])
                    {
                    }
                    column(BuyFromAddress_4_;BuyFromAddress[4])
                    {
                    }
                    column(ShipToAddress_1_;ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress_4_;ShipToAddress[4])
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_No__;"Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(Purchase_Header___No__;"Purchase Header"."No.")
                    {
                    }
                    column(Purchase_Header___Document_Date_;"Purchase Header"."Document Date")
                    {
                    }
                    column(CurrReport_PAGENO;CurrReport.PageNo)
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
                    column(ShipToAddress_3_;ShipToAddress[3])
                    {
                    }
                    column(Purchase_Header___Pick_Type_;"Purchase Header"."Pick Type")
                    {
                    }
                    column(From_Caption;From_CaptionLbl)
                    {
                    }
                    column(Vendor_ID_Caption;Vendor_ID_CaptionLbl)
                    {
                    }
                    column(SoldCaption;SoldCaptionLbl)
                    {
                    }
                    column(To_Caption;To_CaptionLbl)
                    {
                    }
                    column(Purchase_Order_Number_Caption;Purchase_Order_Number_CaptionLbl)
                    {
                    }
                    column(Purchase_Order_Date_Caption;Purchase_Order_Date_CaptionLbl)
                    {
                    }
                    column(Page_Caption;Page_CaptionLbl)
                    {
                    }
                    column(ANICA__INC____SEATTLECaption;ANICA__INC____SEATTLECaptionLbl)
                    {
                    }
                    column(PURCHASE_ORDER_RECEIVERCaption;PURCHASE_ORDER_RECEIVERCaptionLbl)
                    {
                    }
                    column(Order_TypeCaption;Order_TypeCaptionLbl)
                    {
                    }
                    column(PageLoop_Number;Number)
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
                        column(PReceiveLine;PReceiveLine)
                        {
                        }
                        column(PReceiveLine_Control33;PReceiveLine)
                        {
                        }
                        column(PReceiveLine_Control35;PReceiveLine)
                        {
                        }
                        column(Purchase_Line_Quantity;Quantity)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(UnitPriceToPrint;UnitPriceToPrint)
                        {
                            DecimalPlaces = 2:5;
                        }
                        column(Purchase_Line_Description;Description)
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
                        column(Purchase_Line__No__;"No.")
                        {
                        }
                        column(PPrintWeight;PPrintWeight)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(PReceiveLine_Control20;PReceiveLine)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(PReceiveLine_Control28;PReceiveLine)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(PReceiveLine_Control32;PReceiveLine)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(PReceiveLine_Control21;PReceiveLine)
                        {
                        }
                        column(TGrossWeight;TGrossWeight)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(Purchase_Line_Quantity_Control47;Quantity)
                        {
                        }
                        column(Product_CodeCaption;Product_CodeCaptionLbl)
                        {
                        }
                        column(DescriptionCaption;DescriptionCaptionLbl)
                        {
                        }
                        column(Quantity_OrderedCaption;Quantity_OrderedCaptionLbl)
                        {
                        }
                        column(UnitCaption;UnitCaptionLbl)
                        {
                        }
                        column(Pack_SizeCaption;Pack_SizeCaptionLbl)
                        {
                        }
                        column(Unit_CostCaption;Unit_CostCaptionLbl)
                        {
                        }
                        column(Item_NumberCaption;Item_NumberCaptionLbl)
                        {
                        }
                        column(Gross_WeightCaption;Gross_WeightCaptionLbl)
                        {
                        }
                        column(Quan_RecvCaption;Quan_RecvCaptionLbl)
                        {
                        }
                        column(DamageCaption;DamageCaptionLbl)
                        {
                        }
                        column(OverageCaption;OverageCaptionLbl)
                        {
                        }
                        column(UnderageCaption;UnderageCaptionLbl)
                        {
                        }
                        column(Total_Weight_Caption;Total_Weight_CaptionLbl)
                        {
                        }
                        column(Total_Quantity_Ordered_Caption;Total_Quantity_Ordered_CaptionLbl)
                        {
                        }
                        column(Purchase_Line_Document_Type;"Document Type")
                        {
                        }
                        column(Purchase_Line_Document_No_;"Document No.")
                        {
                        }
                        column(Purchase_Line_Line_No_;"Line No.")
                        {
                        }
                        column(PrintFooter;PrintFooter)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            if "Vendor Item No." <> '' then
                              ItemNumberToPrint := "Vendor Item No."
                            else
                              ItemNumberToPrint := "No.";

                            if Type = 0 then begin
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
                              UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.00001);

                            //Set to Print Footer if it's the last line.
                            if OnLineNumber = NumberOfLines then
                                begin
                                    PrintFooter := true;
                                end;

                            //ANICA section to format line output

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
                            TPrintWeight := ROUND("Purchase Line"."Gross Weight",1.0,'>');
                            TGrossWeight := ROUND("Purchase Line".Quantity * "Purchase Line"."Gross Weight",1.0,'>');

                            if "Purchase Line"."No." ='' then
                              begin
                              PPrintWeight := '';
                              PReceiveLine := '';
                              end
                              else
                              begin
                              PPrintWeight := Format(TPrintWeight);
                              PReceiveLine := '______________';
                              end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CreateTotals(TaxLiable,AmountExclInvDisc,Amount,"Amount Including VAT");
                            CurrReport.CreateTotals(TGrossWeight,Quantity);
                            NumberOfLines := Count;
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //IF NOT CurrReport.PREVIEW THEN
                        //BEGIN
                        //"Purchase Header"."Pick Ticket Printed" := "Purchase Header"."Pick Ticket Printed" + 1;
                        //"Purchase Header".MODIFY(TRUE);
                        //COMMIT;
                        //END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PageNo := 1;

                    if CopyNo = NoLoops then begin
                      if not CurrReport.Preview then
                      "Purchase Header"."Pick Ticket Printed" := "Purchase Header"."Pick Ticket Printed" + 1;
                    //   PurchasePrinted.RUN("Purchase Header");
                       "Purchase Header".Modify(true);
                       Commit;
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
                PSaveNo := "Purchase Header"."No.";
                //Exclude POs that have not been confirmed
                //IF "Purchase Header".Confirmed = 0 THEN CurrReport.SKIP;
                //Exclude Non Kent Orders - removed by LCC 1-14-11
                //IF ShipInstruct.GET("Purchase Header"."Shipping Instruction Code") THEN
                //IF ShipInstruct."Kent Instruction" <> TRUE THEN CurrReport.SKIP;

                if "Purchase Header"."Shipping Instruction Code" = '' then CurrReport.Skip;

                //Commented out - instructions to exclude drop shipments
                //PurchLineRecord.SETCURRENTKEY("Document Type","Document No.");
                //PurchLineRecord.SETRANGE("Document Type",1);
                //PurchLineRecord.SETRANGE("Document No.","Purchase Header"."No.");
                //IF PurchLineRecord.FIND('-') THEN
                //BEGIN
                //IF PurchLineRecord."Drop Shipment" = TRUE THEN CurrReport.SKIP;
                //END;

                //>>  Warehouse Management - start
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
                //MESSAGE('PO number %1',"Purchase Header"."No.");
                //IF NOT CurrReport.PREVIEW THEN
                //BEGIN
                //"Purchase Header".SETCURRENTKEY("Purchase Header"."Document Type","Purchase Header"."No.");
                //"Purchase Header".SETRANGE("Purchase Header"."Document Type",1);
                //"Purchase Header".SETRANGE("Purchase Header"."No.",PSaveNo);
                //IF "Purchase Header".FIND('-') THEN
                //"Purchase Header"."Pick Ticket Printed" := "Purchase Header"."Pick Ticket Printed" + 1;
                //"Purchase Header".MODIFY(TRUE);
                //COMMIT;
                //END;
                //IF NOT CurrReport.PREVIEW THEN
                //BEGIN
                //PurchHead.SETCURRENTKEY(PurchHead."Document Type",PurchHead."No.");
                //PurchHead.SETRANGE(PurchHead."Document Type",1);
                //PurchHead.SETRANGE(PurchHead."No.","Purchase Header"."No.");
                //PurchHead."Pick Ticket Printed" := PurchHead."Pick Ticket Printed" + 1;
                //PurchHead.MODIFY(TRUE);
                //END;

                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress,"Purchase Header");
                FormatAddress.PurchHeaderShipTo(ShipToAddress,"Purchase Header");
            end;

            trigger OnPostDataItem()
            begin
                //IF NOT CurrReport.PREVIEW THEN
                //"Purchase Header"."Pick Ticket Printed" := "Purchase Header"."Pick Ticket Printed" + 1;
                //"Purchase Header".MODIFY(TRUE);
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
                    field(NoCopies;NoCopies)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Number of Copies';
                        Visible = true;
                    }
                    field(PrintCompany;PrintCompany)
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

    trigger OnPostReport()
    begin
        //"Purchase Header"."Pick Ticket Printed" := "Purchase Header"."Pick Ticket Printed" + 1;
        //"Purchase Header".MODIFY(TRUE);
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.Get('');
    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyAddress: array [8] of Text[50];
        BuyFromAddress: array [8] of Text[50];
        ShipToAddress: array [8] of Text[50];
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
        ShipLineArray: array [20] of Text[60];
        ShipInstruct: Record "Shipping Instructions";
        ShipInstructLines: Record "Shipping Instruction Lines";
        c: Integer;
        PPack: Text[30];
        PPackint: Integer;
        UOMRecord: Record "Item Unit of Measure";
        TGrossWeight: Decimal;
        TPrintWeight: Decimal;
        PurchLineRecord: Record "Purchase Line";
        PReceiveLine: Text[30];
        PPrintWeight: Text[30];
        PurchHead: Record "Purchase Header";
        PSaveNo: Code[20];
        From_CaptionLbl: label 'From:';
        Vendor_ID_CaptionLbl: label 'Vendor ID:';
        SoldCaptionLbl: label 'Sold';
        To_CaptionLbl: label 'To:';
        Purchase_Order_Number_CaptionLbl: label 'Purchase Order Number:';
        Purchase_Order_Date_CaptionLbl: label 'Purchase Order Date:';
        Page_CaptionLbl: label 'Page:';
        ANICA__INC____SEATTLECaptionLbl: label 'ANICA, INC. - SEATTLE';
        PURCHASE_ORDER_RECEIVERCaptionLbl: label 'PURCHASE ORDER RECEIVER';
        Order_TypeCaptionLbl: label 'Order Type';
        Product_CodeCaptionLbl: label 'Product Code';
        DescriptionCaptionLbl: label 'Description';
        Quantity_OrderedCaptionLbl: label 'Quantity Ordered';
        UnitCaptionLbl: label 'Unit';
        Pack_SizeCaptionLbl: label 'Pack Size';
        Unit_CostCaptionLbl: label 'Unit Cost';
        Item_NumberCaptionLbl: label 'Item Number';
        Gross_WeightCaptionLbl: label 'Gross Weight';
        Quan_RecvCaptionLbl: label 'Quan Recv';
        DamageCaptionLbl: label 'Damage';
        OverageCaptionLbl: label 'Overage';
        UnderageCaptionLbl: label 'Underage';
        Total_Weight_CaptionLbl: label 'Total Weight:';
        Total_Quantity_Ordered_CaptionLbl: label 'Total Quantity Ordered:';
}

