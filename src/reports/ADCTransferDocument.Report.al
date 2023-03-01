Report 50176 "ADC Transfer Document"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ADC Transfer Document.rdlc';

    dataset
    {
        dataitem("Transfer Header";"Transfer Header")
        {
            DataItemTableView = sorting("No.") order(ascending) where("Transfer-to Code"=const('ADC'));
            RequestFilterFields = "Posting Date","No.","Transfer-to Code","Shipment Date","Receipt Date";
            RequestFilterHeading = 'Purchase Order';
            column(ReportForNavId_2957; 2957)
            {
            }
            column(Transfer_Header_No_;"No.")
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
                    column(TransferFromAddr_1_;TransferFromAddr[1])
                    {
                    }
                    column(TransferFromAddr_2_;TransferFromAddr[2])
                    {
                    }
                    column(TransferFromAddr_3_;TransferFromAddr[3])
                    {
                    }
                    column(TransferFromAddr_4_;TransferFromAddr[4])
                    {
                    }
                    column(TransferToAddr_1_;TransferToAddr[1])
                    {
                    }
                    column(TransferToAddr_2_;TransferToAddr[2])
                    {
                    }
                    column(TransferToAddr_3_;TransferToAddr[3])
                    {
                    }
                    column(TransferToAddr_4_;TransferToAddr[4])
                    {
                    }
                    column(Transfer_Header___Transfer_from_Code_;"Transfer Header"."Transfer-from Code")
                    {
                    }
                    column(Transfer_Header___No__;"Transfer Header"."No.")
                    {
                    }
                    column(Transfer_Header___Receipt_Date_;"Transfer Header"."Receipt Date")
                    {
                    }
                    column(CurrReport_PAGENO;CurrReport.PageNo)
                    {
                    }
                    column(Transfer_Header___No___Control1000000002;"Transfer Header"."No.")
                    {
                    }
                    column(Transfer_Header___In_Transit_Code_;"Transfer Header"."In-Transit Code")
                    {
                    }
                    column(Transfer_Header___Transfer_to_Code_;"Transfer Header"."Transfer-to Code")
                    {
                    }
                    column(From_Caption;From_CaptionLbl)
                    {
                    }
                    column(From_Location_Caption;From_Location_CaptionLbl)
                    {
                    }
                    column(To_Caption;To_CaptionLbl)
                    {
                    }
                    column(Transfer_Receipt_Number_Caption;Transfer_Receipt_Number_CaptionLbl)
                    {
                    }
                    column(Transfer_Receipt_Date_Caption;Transfer_Receipt_Date_CaptionLbl)
                    {
                    }
                    column(Page_Caption;Page_CaptionLbl)
                    {
                    }
                    column(ANICA__INC_Caption;ANICA__INC_CaptionLbl)
                    {
                    }
                    column(INTERCOMPANY_TRANSFER_RECEIVERCaption;INTERCOMPANY_TRANSFER_RECEIVERCaptionLbl)
                    {
                    }
                    column(Master_Transfer_Number_Caption;Master_Transfer_Number_CaptionLbl)
                    {
                    }
                    column(In_Transit_Location_Caption;In_Transit_Location_CaptionLbl)
                    {
                    }
                    column(To_Location_Caption;To_Location_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number;Number)
                    {
                    }
                    dataitem("Transfer Line";"Transfer Line")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "Transfer Header";
                        DataItemTableView = sorting("Document No.","Line No.") order(ascending) where("Derived From Line No."=const(0));
                        column(ReportForNavId_9370; 9370)
                        {
                        }
                        column(Transfer_Line__Transfer_Line__Quantity;"Transfer Line".Quantity)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(Transfer_Line__Transfer_Line__Description;"Transfer Line".Description)
                        {
                        }
                        column(Transfer_Line__Transfer_Line___Unit_of_Measure_Code_;"Transfer Line"."Unit of Measure Code")
                        {
                        }
                        column(Transfer_Line__Transfer_Line___Item_No__;"Transfer Line"."Item No.")
                        {
                        }
                        column(PReceiveLine;PReceiveLine)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(PReceiveLine2;PReceiveLine2)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(VendItem;VendItem)
                        {
                        }
                        column(ItemSize;ItemSize)
                        {
                        }
                        column(PReceiveLine_Control1000000015;PReceiveLine)
                        {
                            DecimalPlaces = 0:0;
                        }
                        column(TGrossWeight;TGrossWeight)
                        {
                            DecimalPlaces = 2:2;
                        }
                        column(Transfer_Line_Quantity;Quantity)
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
                        column(Item_NumberCaption;Item_NumberCaptionLbl)
                        {
                        }
                        column(Quan_RecvCaption;Quan_RecvCaptionLbl)
                        {
                        }
                        column(DateCaption;DateCaptionLbl)
                        {
                        }
                        column(MFCaption;MFCaptionLbl)
                        {
                        }
                        column(Init____Caption;Init____CaptionLbl)
                        {
                        }
                        column(Expiration_DateCaption;Expiration_DateCaptionLbl)
                        {
                        }
                        column(Product_CodeCaption;Product_CodeCaptionLbl)
                        {
                        }
                        column(Pack__SizeCaption;Pack__SizeCaptionLbl)
                        {
                        }
                        column(Init____Caption_Control1000000011;Init____Caption_Control1000000011Lbl)
                        {
                        }
                        column(Quan_RecvCaption_Control1000000012;Quan_RecvCaption_Control1000000012Lbl)
                        {
                        }
                        column(DateCaption_Control1000000013;DateCaption_Control1000000013Lbl)
                        {
                        }
                        column(MFCaption_Control1000000014;MFCaption_Control1000000014Lbl)
                        {
                        }
                        column(Total_Weight_Caption;Total_Weight_CaptionLbl)
                        {
                        }
                        column(Total_Quantity_Ordered_Caption;Total_Quantity_Ordered_CaptionLbl)
                        {
                        }
                        column(Transfer_Line_Document_No_;"Document No.")
                        {
                        }
                        column(Transfer_Line_Line_No_;"Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            Item.SetCurrentkey(Item."No.");
                            Item.SetRange(Item."No.","Transfer Line"."Item No.");
                            if Item.Find('-') then
                            begin
                            VendItem := Item."Vendor Item No.";
                            UOMRecord.SetCurrentkey(UOMRecord."Item No.",UOMRecord.Code);
                            UOMRecord.SetRange(UOMRecord."Item No.",Item."No.");
                            UOMRecord.SetRange(UOMRecord.Code,Item."Base Unit of Measure");
                            if UOMRecord.Find('-') then
                            ItemPack := Format(UOMRecord.Pack,5,'<Integer>');
                            ItemSize := ItemPack + '/' + UOMRecord."Pack Description";
                            end;

                            if Quantity = 0 then
                              UnitPriceToPrint := 0  // so it won't print
                            else
                              UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.00001);

                            //ANICA section to format line output


                            //ANICA weight total
                            TPrintWeight := ROUND("Transfer Line"."Gross Weight",1.0,'>');
                            TGrossWeight := ROUND("Transfer Line".Quantity * "Transfer Line"."Gross Weight",1.0,'>');

                            if "Transfer Line"."Line No." = 0 then
                              begin
                              PPrintWeight := '';
                              PReceiveLine := '';
                              PReceiveLine2 := '';
                              end
                              else
                              begin
                              PPrintWeight := Format(TPrintWeight,0,'<Integer><Decimal,3>');
                              PReceiveLine := '_____:_____:__';
                              PReceiveLine2 := '______________';
                              end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CreateTotals("Gross Weight",Quantity);
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


                FormatAddr.TransferHeaderTransferFrom(TransferFromAddr,"Transfer Header");
                FormatAddr.TransferHeaderTransferTo(TransferToAddr,"Transfer Header");
            end;

            trigger OnPreDataItem()
            begin
                if PrintCompany then
                  FormatAddr.Company(CompanyAddress,CompanyInformation)
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get('');
        
        /*//Get user entered filters for Transfers
        DocDateEntered := "Purchase Header".GETFILTER("Document Date");
        MESSAGE('  %1',DocDateEntered);
        PONoEntered := "Purchase Header".GETFILTER("No.");
        MESSAGE('  %1',PONoEntered);*/
        
        
        
        
        ///ReportFilter := SomeRecord.GETFILTERS;

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
        TransferFromAddr: array [8] of Text[50];
        TransferToAddr: array [8] of Text[50];
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
        FormatAddr: Codeunit "Format Address";
        NotReleased: Text[30];
        PShipHead: Text[30];
        ShipLineArray: array [20] of Text[60];
        c: Integer;
        PPack: Text[30];
        PPackint: Integer;
        UOMRecord: Record "Item Unit of Measure";
        TGrossWeight: Decimal;
        TPrintWeight: Decimal;
        PReceiveLine: Text[30];
        PPrintWeight: Text[30];
        DocDateEntered: Text[30];
        PONoEntered: Text[30];
        Item: Record Item;
        VendItem: Code[20];
        ItemPack: Text[15];
        ItemSize: Text[20];
        PReceiveLine2: Text[30];
        From_CaptionLbl: label 'From:';
        From_Location_CaptionLbl: label 'From Location:';
        To_CaptionLbl: label 'To:';
        Transfer_Receipt_Number_CaptionLbl: label 'Transfer Receipt Number:';
        Transfer_Receipt_Date_CaptionLbl: label 'Transfer Receipt Date:';
        Page_CaptionLbl: label 'Page:';
        ANICA__INC_CaptionLbl: label 'ANICA, INC.';
        INTERCOMPANY_TRANSFER_RECEIVERCaptionLbl: label 'INTERCOMPANY TRANSFER RECEIVER';
        Master_Transfer_Number_CaptionLbl: label 'Master Transfer Number:';
        In_Transit_Location_CaptionLbl: label 'In Transit Location:';
        To_Location_CaptionLbl: label 'To Location:';
        DescriptionCaptionLbl: label 'Description';
        Quantity_OrderedCaptionLbl: label 'Quantity Ordered';
        UnitCaptionLbl: label 'Unit';
        Item_NumberCaptionLbl: label 'Item Number';
        Quan_RecvCaptionLbl: label 'Quan Recv';
        DateCaptionLbl: label 'Date';
        MFCaptionLbl: label 'MF';
        Init____CaptionLbl: label 'Init____';
        Expiration_DateCaptionLbl: label 'Expiration Date';
        Product_CodeCaptionLbl: label 'Product Code';
        Pack__SizeCaptionLbl: label 'Pack /Size';
        Init____Caption_Control1000000011Lbl: label 'Init____';
        Quan_RecvCaption_Control1000000012Lbl: label 'Quan Recv';
        DateCaption_Control1000000013Lbl: label 'Date';
        MFCaption_Control1000000014Lbl: label 'MF';
        Total_Weight_CaptionLbl: label 'Total Weight:';
        Total_Quantity_Ordered_CaptionLbl: label 'Total Quantity Ordered:';
}

