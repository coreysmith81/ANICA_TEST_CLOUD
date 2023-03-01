Report 50184 "Item Description Correction"
{
    // //This program checks every Gottstein (Manuf. Code 'G') Nonstock Item for a counterpart in the
    // // Item table.  And updates any description that is different.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Item Description Correction.rdlc';


    dataset
    {
        dataitem("Nonstock Item";"Nonstock Item")
        {
            DataItemTableView = sorting("Entry No.");
            column(ReportForNavId_7742; 7742)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(UserId;UserId)
            {
            }
            column(Nonstock_Item__Entry_No__;"Entry No.")
            {
            }
            column(Nonstock_Item__Manufacturer_Code_;"Manufacturer Code")
            {
            }
            column(Nonstock_Item__Vendor_Item_No__;"Vendor Item No.")
            {
            }
            column(Nonstock_Item_Description;Description)
            {
            }
            column(VItemDesc;VItemDesc)
            {
            }
            column(Nonstock_ItemCaption;Nonstock_ItemCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Nonstock_Item__Entry_No__Caption;FieldCaption("Entry No."))
            {
            }
            column(Nonstock_Item__Manufacturer_Code_Caption;FieldCaption("Manufacturer Code"))
            {
            }
            column(Nonstock_Item__Vendor_Item_No__Caption;FieldCaption("Vendor Item No."))
            {
            }
            column(Nonstock_DescriptionCaption;Nonstock_DescriptionCaptionLbl)
            {
            }
            column(Item_DescriptionCaption;Item_DescriptionCaptionLbl)
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

                Clear(VItemNo);
                Clear(VNSDesc);
                Clear(VItemDesc);
                Clear(VIsFound);

                //Get Item Number (ie. G-######)
                VItemNo := "Nonstock Item"."Item No.";
                VNSDesc := "Nonstock Item".Description;


                LookupItem;

                if VIsFound = true then
                    begin
                        if VNSDesc <> VItemDesc then
                            UpdateItemRecord
                        else
                            CurrReport.Skip;
                    end
                else
                    CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin
                Clear("Nonstock Item");

                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                "Nonstock Item".SetCurrentkey("Entry No.");
                "Nonstock Item".SetRange("Manufacturer Code",'G');
                "Nonstock Item".SetRange("ANICA Inactive",false);

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
        ItemRecord: Record Item;
        VItemNo: Text[8];
        VNSDesc: Text[50];
        VItemDesc: Text[50];
        VIsFound: Boolean;
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        Nonstock_ItemCaptionLbl: label 'Nonstock Item';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Nonstock_DescriptionCaptionLbl: label 'Nonstock Description';
        Item_DescriptionCaptionLbl: label 'Item Description';


    procedure LookupItem()
    begin
        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",VItemNo);

        if ItemRecord.Find('+') then
            begin
                VIsFound := true;
                VItemDesc := ItemRecord.Description;
            end
        else
            VIsFound := false;

        Clear(ItemRecord);
    end;


    procedure UpdateItemRecord()
    begin
        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",VItemNo);

        if ItemRecord.Find('+') then
            begin
                ItemRecord.Description := VNSDesc;
                ItemRecord."Search Description" := '';
                ItemRecord.Modify(true);
            end
    end;
}

