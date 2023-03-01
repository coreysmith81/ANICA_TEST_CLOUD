Report 50107 "JBG Weekly Dropped Items"
{
    // //This program checks for dropped items, and marks as "ANICA Inactive" if it was dropped.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JBG Weekly Dropped Items.rdlc';


    dataset
    {
        dataitem("JBG Item Weekly Table";"JBG Item Weekly Table")
        {
            DataItemTableView = sorting("Import Date","Vendor Item No");
            column(ReportForNavId_8183; 8183)
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
            column(JBG_Item_Weekly_Table__Vendor_Item_No_;"Vendor Item No")
            {
            }
            column(JBG_Item_Weekly_Table_UPC;UPC)
            {
            }
            column(JBG_Item_Weekly_Table_Description;Description)
            {
            }
            column(JBG_Item_Weekly_Table_Pack;Pack)
            {
            }
            column(JBG_Item_Weekly_Table__Pack_Descrip_;"Pack Descrip")
            {
            }
            column(JBG_Item_Weekly_Table_Dept;Dept)
            {
            }
            column(JBG_Item_Weekly_Table_NCoGroup;NCoGroup)
            {
            }
            column(JBG_Weekly_Update_Dropped_ItemsCaption;JBG_Weekly_Update_Dropped_ItemsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(JBG_Item_Weekly_Table__Vendor_Item_No_Caption;FieldCaption("Vendor Item No"))
            {
            }
            column(JBG_Item_Weekly_Table_UPCCaption;FieldCaption(UPC))
            {
            }
            column(JBG_Item_Weekly_Table_DescriptionCaption;FieldCaption(Description))
            {
            }
            column(JBG_Item_Weekly_Table_PackCaption;FieldCaption(Pack))
            {
            }
            column(JBG_Item_Weekly_Table__Pack_Descrip_Caption;FieldCaption("Pack Descrip"))
            {
            }
            column(JBG_Item_Weekly_Table_DeptCaption;FieldCaption(Dept))
            {
            }
            column(JBG_Item_Weekly_Table_NCoGroupCaption;FieldCaption(NCoGroup))
            {
            }
            column(JBG_Item_Weekly_Table_Import_Date;"Import Date")
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

                VCheckItem := '';
                VVendorItemNo := '';
                VIsDropped := false;

                //Get the current Vendor Item No.
                VVendorItemNo := "JBG Item Weekly Table"."Vendor Item No";

                //Lookup to see if item no. is in the current (this week's) import
                LookupCurrentImport;

                //If it isn't, then skip that record ... else update Nonstock and Item tables.
                if (VIsDropped = false) then
                    CurrReport.Skip
                else
                    begin
                        LookupNonStockItem;

                        if VCheckItem <> '' then
                            LookupItem;
                    end;
            end;

            trigger OnPostDataItem()
            begin
                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                //Get the current import date, and the week before.
                LookupImportDates;

                //filter it down to only records with those import dates
                "JBG Item Weekly Table".SetCurrentkey("Import Date");
                "JBG Item Weekly Table".SetRange("Import Date",VPreviousImportDate);

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

    trigger OnInitReport()
    begin
        VReportCheckbox := true;
    end;

    var
        NonStockRecord: Record "Nonstock Item";
        ItemRecord: Record Item;
        CurrentImport: Record "JBG Item Weekly Table";
        PreviousImport: Record "JBG Item Weekly Table";
        VCurrentImportDate: Date;
        VPreviousImportDate: Date;
        VVendorItemNo: Code[10];
        VIsDropped: Boolean;
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        VCheckItem: Code[20];
        VReportCheckbox: Boolean;
        JBG_Weekly_Update_Dropped_ItemsCaptionLbl: label 'JBG Weekly Update Dropped Items';
        CurrReport_PAGENOCaptionLbl: label 'Page';


    procedure LookupImportDates()
    begin
        //Key 'JBG Item Weekly Table' on "Import Date"
        "JBG Item Weekly Table".SetCurrentkey("Import Date");

        //Look up the last record in the results to get the most recent date
        //  then get previous week's date from that.
        "JBG Item Weekly Table".Find('+');
        VCurrentImportDate := "JBG Item Weekly Table"."Import Date";
        //VCurrentImportDate :=20111114D;
        VPreviousImportDate := VCurrentImportDate - 7;
    end;


    procedure LookupCurrentImport()
    begin
        CurrentImport.SetCurrentkey("Import Date");
        CurrentImport.SetRange("Import Date",VCurrentImportDate);
        CurrentImport.SetRange("Vendor Item No",VVendorItemNo);

        //if the item is found, item is not dropped.
        if CurrentImport.Find('+') then
            begin
                VIsDropped := false;
            end
        else
            begin
                VIsDropped := true;
            end;
    end;


    procedure LookupNonStockItem()
    begin
        NonStockRecord.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        NonStockRecord.SetRange("Vendor Item No.",VVendorItemNo);
        NonStockRecord.SetRange("Manufacturer Code", 'G');

        if NonStockRecord.Find('+') then
            begin
                NonStockRecord."ANICA Inactive" := true;
                NonStockRecord.Modify(true);
                VCheckItem := NonStockRecord."Item No.";
            end;
    end;


    procedure LookupItem()
    begin
        ItemRecord.SetCurrentkey("No.");
        ItemRecord.SetRange("No.",VCheckItem);

        if ItemRecord.Find('+') then
            begin
                ItemRecord."ANICA Inactive" := true;
                ItemRecord.Modify(true);
            end;
    end;
}

