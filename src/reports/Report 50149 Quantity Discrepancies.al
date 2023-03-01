Report 50149 "Quantity Discrepancies"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Quantity Discrepancies.rdlc';

    dataset
    {
        dataitem("Telxon Input File";"Telxon Input File")
        {
            DataItemTableView = sorting("Processed Date",Store,Processed);
            RequestFilterFields = "Processed Date",Store;
            column(ReportForNavId_9733; 9733)
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
            column(Telxon_Input_File_Sequence;Sequence)
            {
            }
            column(Telxon_Input_File_Store;Store)
            {
            }
            column(Telxon_Input_File_Date;Date)
            {
            }
            column(Telxon_Input_File__Telxon_Vendor_;"Telxon Vendor")
            {
            }
            column(Telxon_Input_File__Order_Item_No__;"Order Item No.")
            {
            }
            column(Telxon_Input_File__Item_Description_;"Item Description")
            {
            }
            column(Telxon_Input_File__Import_Quantity_;"Import Quantity")
            {
            }
            column(Telxon_Input_File__Inventory_Fill_Amount_;"Inventory Fill Amount")
            {
            }
            column(Telxon_Input_File_Quantity;Quantity)
            {
            }
            column(Telxon_Input_File__Sales_Order_Quantity_;"Sales Order Quantity")
            {
            }
            column(Sales_Order_Quanity_DiscrepanciesCaption;Sales_Order_Quanity_DiscrepanciesCaptionLbl)
            {
            }
            column(Control1000000005Caption;Control1000000005CaptionLbl)
            {
            }
            column(Telxon_Input_File_SequenceCaption;FieldCaption(Sequence))
            {
            }
            column(Telxon_Input_File_StoreCaption;FieldCaption(Store))
            {
            }
            column(Telxon_Input_File_DateCaption;FieldCaption(Date))
            {
            }
            column(Telxon_Input_File__Telxon_Vendor_Caption;FieldCaption("Telxon Vendor"))
            {
            }
            column(Telxon_Input_File__Order_Item_No__Caption;FieldCaption("Order Item No."))
            {
            }
            column(Telxon_Input_File__Item_Description_Caption;FieldCaption("Item Description"))
            {
            }
            column(Telxon_Input_File__Import_Quantity_Caption;FieldCaption("Import Quantity"))
            {
            }
            column(Telxon_Input_File__Inventory_Fill_Amount_Caption;FieldCaption("Inventory Fill Amount"))
            {
            }
            column(Telxon_Input_File__Sales_Order_Quantity_Caption;FieldCaption("Sales Order Quantity"))
            {
            }
            column(QuantityCaption;QuantityCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Location <> 'ADC' then
                    CurrReport.Skip;

                if "On Hold" then
                    CurrReport.Skip;

                if "Import Quantity" = 0 then
                    CurrReport.Skip;

                if "Import Quantity" = "Sales Order Quantity" then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                SetRange(Processed,true);
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Sales_Order_Quanity_DiscrepanciesCaptionLbl: label 'Sales Order Quanity Discrepancies';
        Control1000000005CaptionLbl: label 'Label1000000005';
        QuantityCaptionLbl: label 'Quantity';
}

