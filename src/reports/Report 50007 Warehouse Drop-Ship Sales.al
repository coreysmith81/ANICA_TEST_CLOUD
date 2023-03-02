Report 50007 "Warehouse Drop-Ship Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Warehouse Drop-Ship Sales.rdlc';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("G/L Account No.", "Posting Date") order(ascending) where("G/L Account No." = filter('401-00' .. '401-99'), "Global Dimension 1 Code" = const('WHSE'));
            RequestFilterFields = "Posting Date";
            column(ReportForNavId_7069; 7069)
            {
            }
            column(Today; Today)
            {
            }
            column(Time; Time)
            {
            }
            column(UserId; UserId)
            {
            }
            column(G_L_Entry__G_L_Account_No__; "G/L Entry"."G/L Account No.")
            {
            }
            column(G_L_Entry__Posting_Date_; "G/L Entry"."Posting Date")
            {
            }
            column(G_L_Entry__Document_No__; "G/L Entry"."Document No.")
            {
            }
            column(G_L_Entry_Description; "G/L Entry".Description)
            {
            }
            column(G_L_Entry_Amount; "G/L Entry".Amount)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(VFilterGroup; VFilterGroup)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Department code WHSE and Sales Accounts 401-00 to 401-99 are in the table view
                InvNumber := "G/L Entry"."Document No.";
                //Determine if the item is a drop ship
                LookupPostedSalesInvoice;
                GrandTotal := GrandTotal + "G/L Entry".Amount;
            end;

            trigger OnPreDataItem()
            begin
                VFilterGroup := 'Posting Dates ' + "G/L Entry".GetFilter("G/L Entry"."Posting Date");
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

    var
        PostedSalesInvoiceLines: Record "Sales Invoice Line";
        InvNumber: Code[20];
        GrandTotal: Decimal;
        PAGECaptionLbl: label 'PAGE';
        Warehouse_Drop_Ship_SalesCaptionLbl: label 'Warehouse Drop Ship Sales';
        ANICA__Inc_CaptionLbl: label 'ANICA, Inc.';
        VFilterGroup: Text[50];


    procedure LookupPostedSalesInvoice()
    begin
        PostedSalesInvoiceLines.SetCurrentkey("Document No.", "Line No.");
        PostedSalesInvoiceLines.SetRange("Document No.", InvNumber);
        if PostedSalesInvoiceLines.Find('-') then begin
            if PostedSalesInvoiceLines."Drop Shipment" = false then CurrReport.Skip;
        end
        else
            CurrReport.Skip;
    end;
}

