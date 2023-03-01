Report 50197 "JBG New Items"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JBG New Items.rdlc';

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
            column(JBG_Item_Weekly_Table___New_ItemsCaption;JBG_Item_Weekly_Table___New_ItemsCaptionLbl)
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
            column(JBG_Item_Weekly_Table_Import_Date;"Import Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Get the current Vendor Item No.
                VVendorItemNo := "JBG Item Weekly Table"."Vendor Item No";

                //Lookup to see if item no. is in the previous import
                LookupPreviousImport;

                //If it isn't, then skip that record.
                if (VIsNew = false) then
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

                //filter it down to only records with those import dates
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
        CurrentImport: Record "JBG Item Weekly Table";
        PreviousImport: Record "JBG Item Weekly Table";
        VCurrentImportDate: Date;
        VPreviousImportDate: Date;
        VVendorItemNo: Code[10];
        VIsNew: Boolean;
        JBG_Item_Weekly_Table___New_ItemsCaptionLbl: label 'JBG Item Weekly Table - New Items';
        CurrReport_PAGENOCaptionLbl: label 'Page';


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
                VIsNew := false;
            end
        else
            begin
                VIsNew := true;
            end;
    end;
}

