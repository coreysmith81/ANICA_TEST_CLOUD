Report 50135 "Telxon Not Enough Inventory"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Telxon Not Enough Inventory.rdlc';

    dataset
    {
        dataitem("Telxon Input File"; "Telxon Input File")
        {
            DataItemTableView = sorting(Date, Store) order(ascending);
            RequestFilterFields = Store, Date;
            column(ReportForNavId_9733; 9733)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(VDateRange; VDateRange)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Telxon_Input_File_Store; Store)
            {
            }
            column(Telxon_Input_File_Date; Date)
            {
            }
            column(Telxon_Input_File__Error_Remark_; "Error Remark")
            {
            }
            column(Telxon_Input_File__Import_Item_No__; "Import Item No.")
            {
            }
            column(Telxon_Input_File__Order_Item_No__; "Order Item No.")
            {
            }
            column(Telxon_Input_File__Item_Description_; "Item Description")
            {
            }
            column(Telxon_Input_File_Pack; Pack)
            {
            }
            column(Telxon_Input_File__Pack_Description_; "Pack Description")
            {
            }
            column(Telxon_Input_File_Quantity; Quantity)
            {
            }
            column(VStatusNote; VStatusNote)
            {
            }
            column(Telxon_Lines_w___Not_enough_inventory_for_order__Error_RemarkCaption; Telxon_Lines_w___Not_enough_inventory_for_order__Error_RemarkCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Telxon_Input_File_StoreCaption; FieldCaption(Store))
            {
            }
            column(Telxon_Input_File__Item_Description_Caption; FieldCaption("Item Description"))
            {
            }
            column(Telxon_Input_File__Order_Item_No__Caption; FieldCaption("Order Item No."))
            {
            }
            column(Telxon_Input_File__Import_Item_No__Caption; FieldCaption("Import Item No."))
            {
            }
            column(Telxon_Input_File__Error_Remark_Caption; FieldCaption("Error Remark"))
            {
            }
            column(Telxon_Input_File_DateCaption; FieldCaption(Date))
            {
            }
            column(Telxon_Input_File_PackCaption; FieldCaption(Pack))
            {
            }
            column(Pack_Descr_Caption; Pack_Descr_CaptionLbl)
            {
            }
            column(Qty_Caption; Qty_CaptionLbl)
            {
            }
            column(Status_NoteCaption; Status_NoteCaptionLbl)
            {
            }
            column(Telxon_Input_File_Sequence; Sequence)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For Progress Bar
                begin
                    CurRec := CurRec + 1;
                    if (TotalRec <> 0) then
                        Window.Update(1, ROUND(CurRec * 10000 / TotalRec, 1));
                end;


                VOrderItemNo := "Order Item No.";
                VImportItemNo := "Import Item No.";


                if "Error Remark" <> 'Not enough inventory for order' then
                    CurrReport.Skip;

                GetStatusNote;
            end;

            trigger OnPostDataItem()
            begin
                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                "Telxon Input File".SetCurrentkey(Date, Store);
                //"Telxon Input FIle".SETRANGE(Date,20120311D);

                VDateRange := "Telxon Input File".GetFilters;

                //For progress bar
                begin
                    Clear(Window);
                    Window.Open('Processing @1@@@@@@@@');
                    TotalRec := COUNTAPPROX;
                    CurRec := 0;
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

    var
        Item: Record Item;
        VCheckFirst2Import: Text[30];
        VCheckFirst2Order: Text[30];
        VOrderItemNo: Text[30];
        VImportItemNo: Text[30];
        VNewOrderItemNo: Text[30];
        VNewImportItemNo: Text[30];
        VDateRange: Text[100];
        VStatusNote: Text[60];
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        Telxon_Lines_w___Not_enough_inventory_for_order__Error_RemarkCaptionLbl: label 'Telxon Lines w/ ''Not enough inventory for order'' Error Remark';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Pack_Descr_CaptionLbl: label 'Pack Descr.';
        Qty_CaptionLbl: label 'Qty.';
        Status_NoteCaptionLbl: label 'Status Note';


    procedure GetStatusNote()
    begin
        Item.SetCurrentkey("No.");
        Item.SetRange("No.", VOrderItemNo);

        if Item.Find('-') then
            VStatusNote := Item."Status Note"
        else
            VStatusNote := '';
    end;
}

