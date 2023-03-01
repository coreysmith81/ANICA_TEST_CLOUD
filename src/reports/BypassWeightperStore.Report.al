Report 50081 "Bypass Weight per Store"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Bypass Weight per Store.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header";"Sales Invoice Header")
        {
            DataItemTableView = sorting("No.") order(ascending);
            RequestFilterFields = "Sell-to Customer No.","Posting Date","No.";
            column(ReportForNavId_5581; 5581)
            {
            }
            column(Today;Today)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(FilterString;FilterString)
            {
            }
            column(Sales_Invoice_Header__No__;"No.")
            {
            }
            column(Sales_Invoice_Header__Shipping_Instruction_Code_;"Shipping Instruction Code")
            {
            }
            column(TotalWt;TotalWt)
            {
            }
            column(RptWt;RptWt)
            {
            }
            column(Bypass_Weight_per_StoreCaption;Bypass_Weight_per_StoreCaptionLbl)
            {
            }
            column(PageCaption;PageCaptionLbl)
            {
            }
            column(Filters_Caption;Filters_CaptionLbl)
            {
            }
            column(Sales_Invoice_Header__No__Caption;FieldCaption("No."))
            {
            }
            column(Sales_Invoice_Header__Shipping_Instruction_Code_Caption;FieldCaption("Shipping Instruction Code"))
            {
            }
            column(Total_WeightCaption;Total_WeightCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ParcelPCde := "Sales Invoice Header"."Shipping Instruction Code";
                LookupParcelPost;
                //MESSAGE('parcel post code %1',VCode);

                TotalWt := 0;
                QtyWt := 0;

                if VCode = 'BYPASS' then
                begin
                SalesInvoiceLine.SetCurrentkey(SalesInvoiceLine."Document No.");
                SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.","Sales Invoice Header"."No.");
                if SalesInvoiceLine.Find('-') then
                repeat
                QtyWt := SalesInvoiceLine."Gross Weight" * SalesInvoiceLine.Quantity;
                TotalWt := TotalWt + QtyWt;
                RptWt := RptWt + QtyWt;
                //Message('order line weight variable %1 %2 %3',SalesInvoiceLine."Gross Weight",TotalWt,"Sales Invoice Header"."No.");
                until SalesInvoiceLine.Next = 0;
                SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.");//clear filter
                end;//bypass code check
            end;

            trigger OnPostDataItem()
            begin
                LineNo := 0;
            end;

            trigger OnPreDataItem()
            begin
                TotalWt := 0;
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
        TotalWt: Decimal;
        ParcelPCde: Code[10];
        VCode: Code[10];
        SalesInvoiceLine: Record "Sales Invoice Line";
        LineNo: Integer;
        QtyWt: Decimal;
        RptWt: Decimal;
        FilterString: Text[120];
        Bypass_Weight_per_StoreCaptionLbl: label 'Bypass Weight per Store';
        PageCaptionLbl: label 'Page';
        Filters_CaptionLbl: label 'Filters:';
        Total_WeightCaptionLbl: label 'Total Weight';


    procedure LookupParcelPost()
    begin
        case ParcelPCde of
        '005': VCode := 'Bypass';
        '006': VCode := 'Bypass';
        '007': VCode := 'Bypass';
        '024': VCode := 'Bypass';
        '025': VCode := 'Bypass';
        '026': VCode := 'Bypass'
        else VCode := 'Not Bypass';
        end;
    end;
}

