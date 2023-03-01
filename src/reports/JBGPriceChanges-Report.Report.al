Report 50192 "JBG Price Changes - Report"
{
    // //This produces the pritable REPORT for JBG Price Changes
    // //This program calls Report 50188 (JBG Price Changes - Calculate)
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JBG Price Changes - Report.rdlc';


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
            column(JBG_Item_Weekly_Table__Zone_1_2_;"Target Retail")
            {
            }
            column(VPrevPack;VPrevPack)
            {
            }
            column(VPrevPackDesc;VPrevPackDesc)
            {
            }
            column(VPrevRetail;VPrevRetail)
            {
            }
            column(JBG_Item_Weekly_Table__Price_Change_;"Price Change")
            {
            }
            column(JBG_Item_Weekly_Table__Percent_Change_;"Percent Change")
            {
                AutoFormatType = 1;
            }
            column(JBG_Item_Weekly_Table___Price_ChangesCaption;JBG_Item_Weekly_Table___Price_ChangesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_No_Caption;Item_No_CaptionLbl)
            {
            }
            column(UPCCaption;UPCCaptionLbl)
            {
            }
            column(JBG_Item_Weekly_Table_DescriptionCaption;FieldCaption(Description))
            {
            }
            column(New_PackCaption;New_PackCaptionLbl)
            {
            }
            column(New_SizeCaption;New_SizeCaptionLbl)
            {
            }
            column(JBG_Item_Weekly_Table_DeptCaption;FieldCaption(Dept))
            {
            }
            column(New_RetailCaption;New_RetailCaptionLbl)
            {
            }
            column(Old_PackCaption;Old_PackCaptionLbl)
            {
            }
            column(Old_SizeCaption;Old_SizeCaptionLbl)
            {
            }
            column(Old_RetailCaption;Old_RetailCaptionLbl)
            {
            }
            column(Change____Caption;Change____CaptionLbl)
            {
            }
            column(Change____Caption_Control1000000031;Change____Caption_Control1000000031Lbl)
            {
            }
            column(JBG_Item_Weekly_Table_Import_Date;"Import Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Reset Variables
                VVendorItemNo := '';
                VPrevPack := 0;
                VPrevPackDesc := '';
                VPrevItemDesc := '';
                VPrevRetail := 0;
                VPriceChgPct := 0;
                VPriceChg := 0;

                if "JBG Item Weekly Table"."Percent Change" >= 5 then
                    begin
                        //Get the current Vendor Item No.
                        VVendorItemNo := "Vendor Item No";

                        //check for item in previous import, if there then get necessary variables.
                        LookupPreviousImport;
                    end

                else
                    CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin
                //Clear filters."JBG Item Weekly Table".SETRANGE("Import Date");
            end;

            trigger OnPreDataItem()
            begin
                //Get the current import date, and the week before.
                LookupImportDates;

                //filter down to only records with those current import date, and "percent change" > 5.
                "JBG Item Weekly Table".SetCurrentkey("Percent Change");
                "JBG Item Weekly Table".Ascending(false);
                "JBG Item Weekly Table".SetRange("Import Date",VCurrentImportDate);
                "JBG Item Weekly Table".SetRange("Percent Change",5,500);
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
        Report.RunModal(50188);
        ClearAll;
    end;

    var
        PreviousImport: Record "JBG Item Weekly Table";
        VCurrentImportDate: Date;
        VPreviousImportDate: Date;
        VVendorItemNo: Code[10];
        VCurrPack: Integer;
        VCurrPackDesc: Text[10];
        VCurrItemDesc: Text[50];
        VCurrUPC: Text[15];
        VCurrRetail: Decimal;
        VPrevPack: Integer;
        VPrevPackDesc: Text[10];
        VPrevItemDesc: Text[50];
        VPrevRetail: Decimal;
        VPriceChg: Decimal;
        VPriceChgText: Code[10];
        VPriceChgPct: Decimal;
        VPriceChgPctText: Code[10];
        VIsFound: Boolean;
        VIsPriceChg: Boolean;
        JBG_Item_Weekly_Table___Price_ChangesCaptionLbl: label 'JBG Item Weekly Table - Price Changes';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Item_No_CaptionLbl: label 'Item No.';
        UPCCaptionLbl: label 'UPC';
        New_PackCaptionLbl: label 'New Pack';
        New_SizeCaptionLbl: label 'New Size';
        New_RetailCaptionLbl: label 'New Retail';
        Old_PackCaptionLbl: label 'Old Pack';
        Old_SizeCaptionLbl: label 'Old Size';
        Old_RetailCaptionLbl: label 'Old Retail';
        Change____CaptionLbl: label 'Change ($)';
        Change____Caption_Control1000000031Lbl: label 'Change (%)';


    procedure LookupImportDates()
    begin
        //Key 'JBG Item Weekly Table' on "Import Date"
        "JBG Item Weekly Table".SetCurrentkey("Import Date");

        //Look up the last record in the results to get the most recent date
        //  then get previous week's date from that.
        "JBG Item Weekly Table".Find('+');
        VCurrentImportDate := "JBG Item Weekly Table"."Import Date";
        //VCurrentImportDate := 20111128D;
        VPreviousImportDate := VCurrentImportDate - 7;
    end;


    procedure LookupPreviousImport()
    begin
        PreviousImport.SetCurrentkey("Import Date");
        PreviousImport.SetRange("Import Date",VPreviousImportDate);
        PreviousImport.SetRange("Vendor Item No",VVendorItemNo);

        if PreviousImport.Find('+') then
            begin
                VPrevPack := PreviousImport.Pack;
                VPrevPackDesc := PreviousImport."Pack Descrip";
                VPrevItemDesc := PreviousImport.Description;
                VPrevRetail := PreviousImport."Target Retail";
            end;
    end;
}

