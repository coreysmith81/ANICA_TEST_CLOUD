Report 50119 "Description Verifications"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Description Verifications.rdlc';

    dataset
    {
        dataitem("JBG Item Weekly Table";"JBG Item Weekly Table")
        {
            RequestFilterFields = "Import Date";
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
            column(JBG_Item_Weekly_Table_Description;Description)
            {
            }
            column(VNSDescription;VNSDescription)
            {
            }
            column(VItemDescription;VItemDescription)
            {
            }
            column(Description__VerificationsCaption;Description__VerificationsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(JBG_Item_Weekly_Table__Vendor_Item_No_Caption;FieldCaption("Vendor Item No"))
            {
            }
            column(JBG_Item_Weekly_Table_DescriptionCaption;FieldCaption(Description))
            {
            }
            column(Nonstock_Item_DescriptionCaption;Nonstock_Item_DescriptionCaptionLbl)
            {
            }
            column(Item_DescriptionCaption;Item_DescriptionCaptionLbl)
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

                VVendorItemNo := "JBG Item Weekly Table"."Vendor Item No";
                VJBGUPC := "JBG Item Weekly Table".UPC;

                GetNSValues;
                GetItemValues;

                if ("JBG Item Weekly Table".Description = VNSDescription) and ("JBG Item Weekly Table".Description = VItemDescription) then
                    CurrReport.Skip;

                if (VJBGUPC = VNSUPC) and (VJBGUPC = VItemUPC) then
                    CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin
                //clear filters.
                Clear("JBG Item Weekly Table");

                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                LookupImportDates;

                "JBG Item Weekly Table".SetCurrentkey("Import Date");
                "JBG Item Weekly Table".SetRange("Import Date",VCurrentImportDate);
                //"JBG Item Weekly Table".SETRANGE(Change,'Y');
                //"JBG Item Weekly Table".SETRANGE("Vendor Item No",'095886');

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
        NonstockRecord: Record "Nonstock Item";
        ItemRecord: Record Item;
        VNSDescription: Text[35];
        VItemDescription: Text[35];
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        VCurrentImportDate: Date;
        VVendorItemNo: Text[10];
        VJBGUPC: Text[15];
        VNSUPC: Text[15];
        VItemUPC: Text[15];
        Description__VerificationsCaptionLbl: label 'Description  Verifications';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Nonstock_Item_DescriptionCaptionLbl: label 'Nonstock Item Description';
        Item_DescriptionCaptionLbl: label 'Item Description';


    procedure LookupImportDates()
    begin
        //Key 'JBG Item Weekly Table' on "Import Date"
        "JBG Item Weekly Table".SetCurrentkey("Import Date");

        //Look up the last record in the results to get the most recent date
        "JBG Item Weekly Table".Find('+');
        VCurrentImportDate := "JBG Item Weekly Table"."Import Date";
        //VPrevImportDate := VCurrentImportDate - 7;

        Clear("JBG Item Weekly Table");
    end;


    procedure GetNSValues()
    begin
        NonstockRecord.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        NonstockRecord.SetRange("Vendor Item No.",VVendorItemNo);
        NonstockRecord.SetRange("Manufacturer Code",'G');

        if NonstockRecord.Find('+') then
            begin
                VNSDescription := NonstockRecord.Description;
                VNSUPC := NonstockRecord."UPC Code for SMS";
            end
        else
            CurrReport.Skip;

        Clear(NonstockRecord);
    end;


    procedure GetItemValues()
    begin
        ItemRecord.SetCurrentkey("Vendor Item No.","Manufacturer Code");
        ItemRecord.SetRange("Vendor Item No.",VVendorItemNo);
        ItemRecord.SetRange("Manufacturer Code",'G');

        if ItemRecord.Find('+') then
            begin
                VItemDescription := ItemRecord.Description;
                VItemUPC := ItemRecord."UPC for SMS";
            end
        else
            CurrReport.Skip;

        Clear(ItemRecord);
    end;
}

