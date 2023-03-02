Report 50118 "Daily Out of Stock List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Daily Out of Stock List.rdlc';

    dataset
    {
        dataitem("Telxon Input File"; "Telxon Input File")
        {
            DataItemTableView = sorting(Processed, "Import Error", "Customer Number", Location, "Drop Ship", "Shipping Code", "Vendor No.", "Order Type", "Pick code", Sequence) order(ascending) where(Processed = filter(false));
            RequestFilterFields = Date;
            column(ReportForNavId_9733; 9733)
            {
            }
            column(Today; Today)
            {
            }
            column(VError; VError)
            {
            }
            column(Telxon_Input_File_Store; Store)
            {
            }
            column(Telxon_Input_File_Date; Date)
            {
            }
            column(Telxon_Input_File__Telxon_Vendor_; "Telxon Vendor")
            {
            }
            column(Telxon_Input_File__Order_Item_No__; "Order Item No.")
            {
            }
            column(Telxon_Input_File_Quantity; Quantity)
            {
            }
            column(Telxon_Input_File__Customer_Number_; "Customer Number")
            {
            }
            column(Telxon_Input_File__Pick_code_; "Pick code")
            {
            }
            column(Telxon_Input_File__Item_Description_; "Item Description")
            {
            }
            column(Telxon_Input_File__Unit_Price_; "Unit Price")
            {
            }
            column(VTotal; VTotal)
            {
            }
            column(StatusNote; "Status Note")
            {
            }
            column(Daily_Out_Of_Stock_ListCaption; Daily_Out_Of_Stock_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Telxon_Input_File_StoreCaption; FieldCaption(Store))
            {
            }
            column(Telxon_Input_File_DateCaption; FieldCaption(Date))
            {
            }
            column(Telxon_Input_File__Telxon_Vendor_Caption; FieldCaption("Telxon Vendor"))
            {
            }
            column(Order_Item_No_Caption; Order_Item_No_CaptionLbl)
            {
            }
            column(Telxon_Input_File_QuantityCaption; FieldCaption(Quantity))
            {
            }
            column(Telxon_Input_File__Customer_Number_Caption; FieldCaption("Customer Number"))
            {
            }
            column(Telxon_Input_File__Pick_code_Caption; FieldCaption("Pick code"))
            {
            }
            column(Telxon_Input_File__Item_Description_Caption; FieldCaption("Item Description"))
            {
            }
            column(Telxon_Input_File__Unit_Price_Caption; FieldCaption("Unit Price"))
            {
            }
            column(Total_QtyCaption; Total_QtyCaptionLbl)
            {
            }
            column(Telxon_Input_File_Sequence; Sequence)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Telxon Input File"."Error Remark" <> 'Not enough inventory for order' then
                    CurrReport.Skip;

                VTotal := "Telxon Input File".Quantity + VTotal;
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
        VError := 'Not enough inventory for order';
    end;

    var
        VError: Text[30];
        VTotal: Decimal;
        Daily_Out_Of_Stock_ListCaptionLbl: label 'Daily Out Of Stock List';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Order_Item_No_CaptionLbl: label 'Order Item No.';
        Total_QtyCaptionLbl: label 'Total Qty';
}

