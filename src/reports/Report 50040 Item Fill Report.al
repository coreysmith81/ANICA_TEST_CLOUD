Report 50040 "Item Fill Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Item Fill Report.rdlc';

    dataset
    {
        dataitem("Telxon Input File"; "Telxon Input File")
        {
            DataItemTableView = sorting(Processed, "Import Error", "Customer Number", Location, "Drop Ship", "Shipping Code", "Vendor No.", "Order Type", "Pick code", Sequence) order(ascending) where("Telxon Vendor" = const('1000'), "Drop Ship" = const(false), Processed = const(false));
            RequestFilterFields = "Vendor No.", "Pick code", Location, "Drop Ship";
            column(ReportForNavId_9733; 9733)
            {
            }
            column(Today; Today)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(Telxon_Input_File__Order_Item_No__; "Order Item No.")
            {
            }
            column(Telxon_Input_File__Item_Description_; "Item Description")
            {
            }
            column(Telxon_Input_File_Quantity; Quantity)
            {
            }
            column(Telxon_Input_File__Pick_code_; "Pick code")
            {
            }
            column(Telxon_Input_File__Error_Remark_; "Error Remark")
            {
            }
            column(Telxon_Input_File__Unit_Price_; "Unit Price")
            {
            }
            column(Total; Total)
            {
            }
            column(Total2; Total2)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Qty_OrderedCaption; Qty_OrderedCaptionLbl)
            {
            }
            column(ITEM_FILL_REPORTCaption; ITEM_FILL_REPORTCaptionLbl)
            {
            }
            column(PAGECaption; PAGECaptionLbl)
            {
            }
            column(Pick_CodeCaption; Pick_CodeCaptionLbl)
            {
            }
            column(Telxon_Input_File__Order_Item_No__Caption; FieldCaption("Order Item No."))
            {
            }
            column(Telxon_Input_File__Error_Remark_Caption; FieldCaption("Error Remark"))
            {
            }
            column(Telxon_Input_File__Unit_Price_Caption; FieldCaption("Unit Price"))
            {
            }
            column(TOTAL_QTYCaption; TOTAL_QTYCaptionLbl)
            {
            }
            column(FILL_RATECaption; FILL_RATECaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Telxon_Input_File_Sequence; Sequence)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //PQty := 0;
                //IF "Telxon Input File".Processed = TRUE THEN CurrReport.SKIP;
                if "Telxon Input File"."Error Remark" = 'Item No is Blocked' then CurrReport.Skip;
                if "Telxon Input File"."Error Remark" = 'Not enough inventory for order' then
                    TotalError := "Telxon Input File".Quantity + TotalError
                else
                    TotalFreeze := "Telxon Input File".Quantity + TotalFreeze;
                Total := TotalError + TotalFreeze;

                if TotalError = 0 then begin
                    Total2 := 1;
                end
                else begin
                    TotalFill := TotalError / Total;
                    TotalFill2 := 1 - TotalFill;
                    Total2 := TotalFill2;
                end;
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
        FilterString := CopyStr("Telxon Input File".GetFilters, 1, MaxStrLen(FilterString));
    end;

    var
        TotalFreeze: Decimal;
        TotalDry: Decimal;
        TotalError: Decimal;
        VPickType: Integer;
        TotalErrDry: Decimal;
        Total: Decimal;
        Total2: Decimal;
        TotalFill: Decimal;
        TotalFill2: Decimal;
        GroupDry: Decimal;
        GroupFreeze: Decimal;
        PQty: Decimal;
        FilterString: Text[100];
        Item_DescriptionCaptionLbl: label 'Item Description';
        Qty_OrderedCaptionLbl: label 'Qty Ordered';
        ITEM_FILL_REPORTCaptionLbl: label 'ITEM FILL REPORT';
        PAGECaptionLbl: label 'PAGE';
        Pick_CodeCaptionLbl: label 'Pick Code';
        TOTAL_QTYCaptionLbl: label 'TOTAL QTY';
        FILL_RATECaptionLbl: label 'FILL RATE';
        EmptyStringCaptionLbl: label '%';
}

