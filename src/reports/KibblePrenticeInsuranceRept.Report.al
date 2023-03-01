Report 50088 "Kibble/Prentice Insurance Rept"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/KibblePrentice Insurance Rept.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header";"Sales Invoice Header")
        {
            CalcFields = Amount;
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.","Posting Date",Amount,"Shipping Instruction Code";
            column(ReportForNavId_5581; 5581)
            {
            }
            column(Today;Today)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(UserId;UserId)
            {
            }
            column(Time;Time)
            {
            }
            column(FilterString;FilterString)
            {
            }
            column(TotalIns;TotalIns)
            {
            }
            column(TotalValue;TotalValue)
            {
            }
            column(TotalAmt;TotalAmt)
            {
            }
            column(INSURANCE_DECLARATION_FOR__KIBBLE___PRENTISE_WESTERNCaption;INSURANCE_DECLARATION_FOR__KIBBLE___PRENTISE_WESTERNCaptionLbl)
            {
            }
            column(PAGECaption;PAGECaptionLbl)
            {
            }
            column(INVOICE_NO_Caption;INVOICE_NO_CaptionLbl)
            {
            }
            column(SHIPMENT_DATECaption;SHIPMENT_DATECaptionLbl)
            {
            }
            column(ORIGINCaption;ORIGINCaptionLbl)
            {
            }
            column(DESTINATIONCaption;DESTINATIONCaptionLbl)
            {
            }
            column(INVOICE_AMOUNTCaption;INVOICE_AMOUNTCaptionLbl)
            {
            }
            column(SHIPPERCaption;SHIPPERCaptionLbl)
            {
            }
            column(INSURANCE_AMOUNTCaption;INSURANCE_AMOUNTCaptionLbl)
            {
            }
            column(INSURANCE_VALUECaption;INSURANCE_VALUECaptionLbl)
            {
            }
            column(GRAND_TOTALCaption;GRAND_TOTALCaptionLbl)
            {
            }
            column(Sales_Invoice_Header_No_;"No.")
            {
            }
            dataitem("Sales Invoice Line";"Sales Invoice Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.","Line No.") order(ascending);
                RequestFilterFields = Amount;
                column(ReportForNavId_1570; 1570)
                {
                }
                column(Sales_Invoice_Header__Amount;"Sales Invoice Header".Amount)
                {
                }
                column(Value;Value)
                {
                }
                column(InsurncAmt;InsurncAmt)
                {
                }
                column(ShipDesc;ShipDesc)
                {
                }
                column(Origin;Origin)
                {
                }
                column(Sales_Invoice_Header___Shipment_Date_;"Sales Invoice Header"."Shipment Date")
                {
                }
                column(Sales_Invoice_Header___No__;"Sales Invoice Header"."No.")
                {
                }
                column(Sales_Invoice_Header___Sell_to_Customer_Name_;"Sales Invoice Header"."Sell-to Customer Name")
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
                    if "Sales Invoice Line"."Calculated Insurance Line" <> true then CurrReport.Skip;
                    InsurncAmt := "Sales Invoice Line".Amount / 2;
                    Value :=  PrtAmt - InsurncAmt;
                    TotalIns := TotalIns + InsurncAmt;
                    TotalValue := TotalValue + Value;
                    TotalAmt := TotalAmt + PrtAmt;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PrtAmt := "Sales Invoice Header".Amount;
                ShipInstruction.SetCurrentkey(ShipInstruction.Code);
                ShipInstruction.SetRange(Code,"Sales Invoice Header"."Shipping Instruction Code");
                if ShipInstruction.Find('-') then
                begin
                ShipDesc := ShipInstruction.Description;
                     if ShipInstruction.Legs = true then
                     begin
                     ShipLegs.SetCurrentkey(ShipLegs."Shipping Instruction Code");
                     ShipLegs.SetRange(ShipLegs."Shipping Instruction Code", ShipInstruction.Code);
                     end;
                     if ShipLegs.Find('-') then
                     begin
                     if ShipLegs."Sea or Anch" = 0 then Origin := 'SEATTLE'
                     else
                     Origin := 'ANCHORAGE';
                     end;
                end;
                PInsuranceRate := "Sales Invoice Header"."Insurance Rate";
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

    trigger OnPreReport()
    begin
        FilterString := CopyStr("Sales Invoice Header".GetFilters,1,MaxStrLen(FilterString));
    end;

    var
        InsurncAmt: Decimal;
        TotalIns: Decimal;
        Value: Decimal;
        TotalValue: Decimal;
        ShipDesc: Text[30];
        ShipInstruction: Record "Shipping Instructions";
        ShipLegs: Record "Shipping Legs";
        Origin: Text[30];
        CustomerFile: Record Customer;
        FromDate: Date;
        ToDate: Date;
        SalesLine: Record "Sales Invoice Line";
        FilterString: Text[100];
        PrtAmt: Decimal;
        TotalAmt: Decimal;
        PInsuranceRate: Decimal;
        INSURANCE_DECLARATION_FOR__KIBBLE___PRENTISE_WESTERNCaptionLbl: label 'INSURANCE DECLARATION FOR: KIBBLE & PRENTISE/WESTERN';
        PAGECaptionLbl: label 'PAGE';
        INVOICE_NO_CaptionLbl: label 'INVOICE NO.';
        SHIPMENT_DATECaptionLbl: label 'SHIPMENT DATE';
        ORIGINCaptionLbl: label 'ORIGIN';
        DESTINATIONCaptionLbl: label 'DESTINATION';
        INVOICE_AMOUNTCaptionLbl: label 'INVOICE AMOUNT';
        SHIPPERCaptionLbl: label 'SHIPPER';
        INSURANCE_AMOUNTCaptionLbl: label 'INSURANCE AMOUNT';
        INSURANCE_VALUECaptionLbl: label 'INSURANCE VALUE';
        GRAND_TOTALCaptionLbl: label 'GRAND TOTAL';
}

