Report 50008 "Warehouse Drop-Ship COGS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Warehouse Drop-Ship COGS.rdlc';

    dataset
    {
        dataitem("G/L Entry";"G/L Entry")
        {
            DataItemTableView = sorting("G/L Account No.","Global Dimension 1 Code","Posting Date") order(ascending) where("G/L Account No."=filter('501-00'..'501-99'),"Global Dimension 1 Code"=const('WHSE'));
            RequestFilterFields = "Posting Date";
            column(ReportForNavId_7069; 7069)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(Today;Today)
            {
            }
            column(Time;Time)
            {
            }
            column(UserId;UserId)
            {
            }
            column(VFilterGroup;VFilterGroup)
            {
            }
            column(G_L_Entry__G_L_Account_No__;"G/L Account No.")
            {
            }
            column(G_L_Entry__Posting_Date_;"Posting Date")
            {
            }
            column(G_L_Entry__Document_No__;"Document No.")
            {
            }
            column(G_L_Entry_Description;Description)
            {
            }
            column(G_L_Entry_Amount;Amount)
            {
            }
            column(VSalesInvoiceNo;VSalesInvoiceNo)
            {
            }
            column(G_L_Entry_Amount_Control11;Amount)
            {
            }
            column(GrandTotal;GrandTotal)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Reset the variables
                VSalesOrderNo := '';
                VSalesInvoiceNo := '';
                InvNumber  := '';

                //Department code WHSE and Sales Accounts 501-00 to 501-99 are in the table view
                InvNumber := "G/L Entry"."Document No.";

                ////Determine if the item is a drop ship
                LookupPostedPurchInvoice;

                //Sales Order number was kept when looking up posted purchase invoice, find the invoice number for the report
                LookupPostedSalesInvoiceHeader;

                //Report Grand Total
                GrandTotal := GrandTotal + "G/L Entry".Amount;
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
        VFilterGroup := 'Posting Date  ' + "G/L Entry".GetFilter("G/L Entry"."Posting Date");
    end;

    var
        PostedPurchInvoiceLines: Record "Purch. Inv. Line";
        PostedSalesInvoiceLines: Record "Sales Invoice Line";
        PostedSalesInvoiceHeader: Record "Sales Invoice Header";
        GLEntry1: Record "G/L Entry";
        InvNumber: Code[20];
        GrandTotal: Decimal;
        VFilterGroup: Text[50];
        VSalesOrderNo: Code[10];
        VSalesInvoiceNo: Code[20];
        CheckGLAccountNo: Code[20];
        CheckPONumber: Text[60];
        PAGECaptionLbl: label 'PAGE';
        Warehouse_Drop_Ship_COGSCaptionLbl: label 'Warehouse Drop Ship COGS';
        ANICA__Inc_CaptionLbl: label 'ANICA, Inc.';
        COGS_AmountCaptionLbl: label 'COGS Amount';
        Estimated_Sales_AmountCaptionLbl: label 'Estimated Sales Amount';
        DifferenceCaptionLbl: label 'Difference';
        Sales_InvoiceCaptionLbl: label 'Sales Invoice';


    procedure LookupPostedPurchInvoice()
    begin
        PostedPurchInvoiceLines.SetCurrentkey("Document No.","Line No.");
        PostedPurchInvoiceLines.SetRange("Document No.",InvNumber);
        if PostedPurchInvoiceLines.Find('-') then
        begin
            VSalesOrderNo := PostedPurchInvoiceLines."Sales Order No.";
            if PostedPurchInvoiceLines."Purchasing Code" <> 'DROP SHIP' then CurrReport.Skip;
        end
        else CurrReport.Skip;
    end;

    local procedure LookupPostedSalesInvoiceHeader()
    begin
        //Lookup sales header by SO number, get sales invoice number
        PostedSalesInvoiceHeader.SetCurrentkey("Order No.");
        PostedSalesInvoiceHeader.SetRange("Order No.",VSalesOrderNo);
        if PostedSalesInvoiceHeader.Find('-') then VSalesInvoiceNo := PostedSalesInvoiceHeader."No.";
    end;
}

