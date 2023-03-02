Report 50161 "Sales Orders Not Ready To Inv."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales Orders Not Ready To Inv..rdlc';

    dataset
    {
        dataitem("Sales Header";"Sales Header")
        {
            DataItemTableView = sorting("Document Type","Document Date","Ready to Invoice") order(ascending) where("Document Type"=const(Order));
            column(ReportForNavId_6640; 6640)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(UserId;UserId)
            {
            }
            column(Sales_Header__No__;"No.")
            {
            }
            column(Sales_Header__Bill_to_Name_;"Bill-to Name")
            {
            }
            column(Sales_Header__Document_Date_;"Document Date")
            {
            }
            column(Sales_Header__Location_Code_;"Location Code")
            {
            }
            column(Sales_Header__Ready_to_Invoice_;"Ready to Invoice")
            {
            }
            column(Shipment_Date;"Sales Header"."Shipment Date")
            {
            }
            column(Sales_Orders_Not_Ready_To_InvoiceCaption;Sales_Orders_Not_Ready_To_InvoiceCaptionLbl)
            {
            }
            column(Sales_Header_Amount;"Sales Header".Amount)
            {
            }
            column(Sales_Header_Document_Type;"Document Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Location Code" <> 'ADC' then
                    CurrReport.Skip;

                LookupSalesLine;

                if vIsDropship then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                SetCurrentkey("Document Type","Document Date","Ready to Invoice");
                SetRange("Document Type",1);
                SetRange("Document Date",0D,vSetDate);
                SetRange("Ready to Invoice",false);
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
                    field(vSetDate;vSetDate)
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

    var
        SalesLine: Record "Sales Line";
        vSetDate: Date;
        vIsDropship: Boolean;
        Sales_Orders_Not_Ready_To_InvoiceCaptionLbl: label 'Sales Orders Not Ready To Invoice';
        CurrReport_PAGENOCaptionLbl: label 'Page';


    procedure LookupSalesLine()
    begin
        SalesLine.SetCurrentkey("Document Type","Document No.","Line No.");
        SalesLine.SetRange("Document No.","Sales Header"."No.");

        if SalesLine.Find('-') then
            if SalesLine."Purchasing Code" <> 'DROP SHIP' then
                vIsDropship := false
            else
                vIsDropship := true;

        Clear(SalesLine);
    end;
}

