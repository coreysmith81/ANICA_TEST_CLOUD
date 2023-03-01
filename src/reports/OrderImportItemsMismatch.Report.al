Report 50124 "Order/Import Items Mismatch"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/OrderImport Items Mismatch.rdlc';

    dataset
    {
        dataitem("Telxon Input File";"Telxon Input File")
        {
            RequestFilterFields = Store,Date;
            column(ReportForNavId_9733; 9733)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(VDateRange;VDateRange)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(UserId;UserId)
            {
            }
            column(Telxon_Input_File_Store;Store)
            {
            }
            column(Telxon_Input_File_Date;Date)
            {
            }
            column(Telxon_Input_File__Sales_Order_No__;"Sales Order No.")
            {
            }
            column(Telxon_Input_File__Sales_Line_No__;"Sales Line No.")
            {
            }
            column(Telxon_Input_File__Import_Item_No__;"Import Item No.")
            {
            }
            column(Telxon_Input_File__Order_Item_No__;"Order Item No.")
            {
            }
            column(Telxon_Input_File__Item_Description_;"Item Description")
            {
            }
            column(Telxon_Input_File_Pack;Pack)
            {
            }
            column(Telxon_Input_File__Pack_Description_;"Pack Description")
            {
            }
            column(VImportItemDesc;VImportItemDesc)
            {
            }
            column(Order_Lines_w___Order_Item_No____Import_Item_No___MismatchCaption;Order_Lines_w___Order_Item_No____Import_Item_No___MismatchCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Telxon_Input_File_StoreCaption;FieldCaption(Store))
            {
            }
            column(Telxon_Input_File__Item_Description_Caption;FieldCaption("Item Description"))
            {
            }
            column(Telxon_Input_File__Order_Item_No__Caption;FieldCaption("Order Item No."))
            {
            }
            column(Telxon_Input_File__Import_Item_No__Caption;FieldCaption("Import Item No."))
            {
            }
            column(LineCaption;LineCaptionLbl)
            {
            }
            column(Order_Caption;Order_CaptionLbl)
            {
            }
            column(Telxon_Input_File_DateCaption;FieldCaption(Date))
            {
            }
            column(Telxon_Input_File_PackCaption;FieldCaption(Pack))
            {
            }
            column(Pack_Desc_Caption;Pack_Desc_CaptionLbl)
            {
            }
            column(Item_DescriptionCaption;Item_DescriptionCaptionLbl)
            {
            }
            column(Telxon_Input_File_Sequence;Sequence)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For Progress Bar
                begin
                    CurRec := CurRec + 1;
                    if (TotalRec <> 0) then
                        Window.Update(1,ROUND(CurRec * 10000 / TotalRec,1));
                end;


                VOrderItemNo := "Order Item No.";
                VImportItemNo := "Import Item No.";
                VItemNoLength := StrLen(VImportItemNo);

                //Adding this to skip UPC's
                if VItemNoLength > 10 then
                    CurrReport.Skip;

                if (VOrderItemNo <> VImportItemNo) then
                    begin
                        VCheckFirst2Import := CopyStr(VImportItemNo,1,2);
                        VCheckFirst2Order := CopyStr(VOrderItemNo,1,2);

                        if (VCheckFirst2Import = 'G-') or (VCheckFirst2Order = 'G-') then
                            begin
                                if VCheckFirst2Import = 'G-' then
                                    VImportItemNo := CopyStr(VImportItemNo,3,6);

                                if VCheckFirst2Order = 'G-' then
                                    VOrderItemNo := CopyStr(VOrderItemNo,3,6);

                                if VImportItemNo = VOrderItemNo then
                                    CurrReport.Skip;
                            end

                    end
                else
                    CurrReport.Skip;

                GetImportItemDescription;
            end;

            trigger OnPostDataItem()
            begin
                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                "Telxon Input File".SetCurrentkey(Date,Store);
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
        VItemNoLength: Integer;
        VNewOrderItemNo: Text[30];
        VNewImportItemNo: Text[30];
        VImportItemDesc: Text[30];
        VDateRange: Text[100];
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        Order_Lines_w___Order_Item_No____Import_Item_No___MismatchCaptionLbl: label 'Order Lines w/ "Order Item No."-"Import Item No." Mismatch';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        LineCaptionLbl: label 'Line';
        Order_CaptionLbl: label 'Order#';
        Pack_Desc_CaptionLbl: label 'Pack Desc.';
        Item_DescriptionCaptionLbl: label 'Item Description';


    procedure GetImportItemDescription()
    begin
        Item.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        Item.SetRange("Vendor Item No.",VImportItemNo);

        if Item.Find('+') then
            VImportItemDesc := Item.Description
        else
            begin
                Clear(Item);
                Item.SetCurrentkey("No.");
                Item.SetRange("No.",VImportItemNo);

                if Item.Find('+') then
                    VImportItemDesc := Item.Description
                else
                    VImportItemDesc := 'Not Found';
            end;

        Clear(Item);
    end;
}

