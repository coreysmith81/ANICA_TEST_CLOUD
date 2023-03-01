Report 50198 "JBG Changed Items"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JBG Changed Items.rdlc';

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
            column(VPrevUPC;VPrevUPC)
            {
            }
            column(VPrevItemDesc;VPrevItemDesc)
            {
            }
            column(VPrevPack;VPrevPack)
            {
            }
            column(VPrevPackDesc;VPrevPackDesc)
            {
            }
            column(JBG_Item_Weekly_Table__JBG_Item_Weekly_Table__Dept;"JBG Item Weekly Table".Dept)
            {
            }
            column(VUPCChg;VUPCChg)
            {
            }
            column(VDescChg;VDescChg)
            {
            }
            column(VPackChg;VPackChg)
            {
            }
            column(VSizeChg;VSizeChg)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(JBG_Item_Weekly_Table___Changed_ItemsCaption;JBG_Item_Weekly_Table___Changed_ItemsCaptionLbl)
            {
            }
            column(Item_NoCaption;Item_NoCaptionLbl)
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
            column(SizeCaption;SizeCaptionLbl)
            {
            }
            column(Last_UPCCaption;Last_UPCCaptionLbl)
            {
            }
            column(Last_DescriptionCaption;Last_DescriptionCaptionLbl)
            {
            }
            column(Last_PackCaption;Last_PackCaptionLbl)
            {
            }
            column(Last_SizeCaption;Last_SizeCaptionLbl)
            {
            }
            column(DeptCaption;DeptCaptionLbl)
            {
            }
            column(UPCCaption;UPCCaptionLbl)
            {
            }
            column(Desc_Caption;Desc_CaptionLbl)
            {
            }
            column(PackCaption;PackCaptionLbl)
            {
            }
            column(SizeCaption_Control1000000029;SizeCaption_Control1000000029Lbl)
            {
            }
            column(CHANGE_________________Caption;CHANGE_________________CaptionLbl)
            {
            }
            column(JBG_Item_Weekly_Table_Import_Date;"Import Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Reset Variables
                VVendorItemNo := '';
                VCurrPack := 0;
                VCurrPackDesc := '';
                VCurrItemDesc := '';
                VCurrUPC := '';
                VPrevPack := 0;
                VPrevPackDesc := '';
                VPrevItemDesc := '';
                VPrevUPC := '';
                VPackChg := '';
                VSizeChg := '';
                VDescChg := '';
                VUPCChg := '';
                VIsFound := false;

                //Get the current Vendor Item No.
                VVendorItemNo := "Vendor Item No";

                //check for item in previous import, if there then get necessary variables.
                LookupPreviousImport;

                if (VIsFound = true) then
                    begin
                        with "JBG Item Weekly Table" do
                            begin
                                VCurrPack := Pack;
                                VCurrPackDesc := "Pack Descrip";
                                VCurrItemDesc := Description;
                                VCurrUPC := UPC;
                            end;

                        if VCurrPack <> VPrevPack then
                            VPackChg := 'P';

                        if VCurrPackDesc <> VPrevPackDesc then
                            VSizeChg := 'S';

                        if VCurrItemDesc <> VPrevItemDesc then
                            VDescChg :='D';

                        if VCurrUPC <> VPrevUPC then
                            VUPCChg := 'U';

                        if (VPackChg <> 'P') and (VSizeChg <> 'S') and (VDescChg <> 'D') and (VUPCChg <> 'U') then
                            CurrReport.Skip;

                    end
                else
                    CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin
                //Clear filters.
                "JBG Item Weekly Table".SetRange("Import Date",VPreviousImportDate,VCurrentImportDate);
            end;

            trigger OnPreDataItem()
            begin
                //Get the current import date, and the week before.
                LookupImportDates;

                //filter down to only records with those current import date
                "JBG Item Weekly Table".SetCurrentkey("Import Date");
                "JBG Item Weekly Table".SetRange("Import Date",VCurrentImportDate);
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
        PreviousImport: Record "JBG Item Weekly Table";
        VCurrentImportDate: Date;
        VPreviousImportDate: Date;
        VVendorItemNo: Code[10];
        VCurrPack: Integer;
        VCurrPackDesc: Text[10];
        VCurrItemDesc: Text[50];
        VCurrUPC: Text[15];
        VPrevPack: Integer;
        VPrevPackDesc: Text[10];
        VPrevItemDesc: Text[50];
        VPrevUPC: Text[15];
        VIsFound: Boolean;
        VPackChg: Text[30];
        VSizeChg: Text[30];
        VDescChg: Text[30];
        VUPCChg: Text[30];
        CurrReport_PAGENOCaptionLbl: label 'Page';
        JBG_Item_Weekly_Table___Changed_ItemsCaptionLbl: label 'JBG Item Weekly Table - Changed Items';
        Item_NoCaptionLbl: label 'Item No';
        SizeCaptionLbl: label 'Size';
        Last_UPCCaptionLbl: label 'Last UPC';
        Last_DescriptionCaptionLbl: label 'Last Description';
        Last_PackCaptionLbl: label 'Last Pack';
        Last_SizeCaptionLbl: label 'Last Size';
        DeptCaptionLbl: label 'Dept';
        UPCCaptionLbl: label 'UPC';
        Desc_CaptionLbl: label 'Desc.';
        PackCaptionLbl: label 'Pack';
        SizeCaption_Control1000000029Lbl: label 'Size';
        CHANGE_________________CaptionLbl: label '|--------------- CHANGE ---------------|';


    procedure LookupImportDates()
    begin
        //Key 'JBG Item Weekly Table' on "Import Date"
        "JBG Item Weekly Table".SetCurrentkey("Import Date");

        //Look up the last record in the results to get the most recent date
        //  then get previous week's date from that.
        "JBG Item Weekly Table".Find('+');
        VCurrentImportDate := "JBG Item Weekly Table"."Import Date";
        //VCurrentImportDate :=20111205D;
        VPreviousImportDate := VCurrentImportDate - 7;
    end;


    procedure LookupPreviousImport()
    begin
        PreviousImport.SetCurrentkey("Import Date");
        PreviousImport.SetRange("Import Date",VPreviousImportDate);
        PreviousImport.SetRange("Vendor Item No",VVendorItemNo);

        if PreviousImport.Find('+') then
            begin
                VIsFound := true;
                VPrevPack := PreviousImport.Pack;
                VPrevPackDesc := PreviousImport."Pack Descrip";
                VPrevItemDesc := PreviousImport.Description;
                VPrevUPC := PreviousImport.UPC;
            end
        else
            begin
                VIsFound := false;
            end;
    end;
}

