Report 50123 "JBG New Inactives Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JBG New Inactives Report.rdlc';

    dataset
    {
        dataitem("JBG Item Weekly Table"; "JBG Item Weekly Table")
        {
            DataItemTableView = sorting("Import Date", "Vendor Item No");
            column(ReportForNavId_8183; 8183)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(VCurrentImportDate; VCurrentImportDate)
            {
            }
            column(UserId; UserId)
            {
            }
            column(JBG_Item_Weekly_Table__Import_Date_; "Import Date")
            {
            }
            column(JBG_Item_Weekly_Table__Vendor_Item_No_; "Vendor Item No")
            {
            }
            column(JBG_Item_Weekly_Table_Description; Description)
            {
            }
            column(JBG_Item_Weekly_Table__Post_Indicator_; "Post Indicator")
            {
            }
            column(JBG_Item_Weekly_Table_Change; Change)
            {
            }
            column(JBG_Item_Weekly_Table_Discontinued; Discontinued)
            {
            }
            column(JBG_New_Inactive_Items_for_Caption; JBG_New_Inactive_Items_for_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(JBG_Item_Weekly_Table__Import_Date_Caption; FieldCaption("Import Date"))
            {
            }
            column(JBG_Item_Weekly_Table__Vendor_Item_No_Caption; FieldCaption("Vendor Item No"))
            {
            }
            column(JBG_Item_Weekly_Table_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(JBG_Item_Weekly_Table__Post_Indicator_Caption; FieldCaption("Post Indicator"))
            {
            }
            column(JBG_Item_Weekly_Table_ChangeCaption; FieldCaption(Change))
            {
            }
            column(JBG_Item_Weekly_Table_DiscontinuedCaption; FieldCaption(Discontinued))
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

                VVendorItemNo := "Vendor Item No";
                VCurrPost := "Post Indicator";
                VCurrChange := Change;
                VCurrDiscont := Discontinued;

                if (VCurrChange <> 'D') and (VCurrPost <> '8') and (VCurrDiscont <> '1') then
                    CurrReport.Skip;

                LookupPreviousImport;

                if (VCurrPost = VPrevPost) and (VCurrChange = VPrevChange) and (VCurrDiscont = VPrevDiscont) then
                    CurrReport.Skip;
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
                "JBG Item Weekly Table".SetRange("Import Date", VCurrentImportDate);

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
        CurrentImport: Record "JBG Item Weekly Table";
        PreviousImport: Record "JBG Item Weekly Table";
        VCurrentImportDate: Date;
        VPreviousImportDate: Date;
        VVendorItemNo: Code[10];
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        VCurrPost: Code[10];
        VCurrChange: Code[10];
        VCurrDiscont: Code[10];
        VIsChanged: Boolean;
        VPrevPost: Code[10];
        VPrevChange: Code[10];
        VPrevDiscont: Code[10];
        JBG_New_Inactive_Items_for_CaptionLbl: label 'JBG New Inactive Items for:';
        CurrReport_PAGENOCaptionLbl: label 'Page';


    procedure LookupImportDates()
    begin
        //Key 'JBG Item Weekly Table' on "Import Date"
        "JBG Item Weekly Table".SetCurrentkey("Import Date");

        //Look up the last record in the results to get the most recent date
        "JBG Item Weekly Table".Find('+');
        VCurrentImportDate := "JBG Item Weekly Table"."Import Date";
        VPreviousImportDate := VCurrentImportDate - 7;
    end;


    procedure LookupPreviousImport()
    begin
        PreviousImport.SetCurrentkey("Import Date");
        PreviousImport.SetRange("Import Date", VPreviousImportDate);
        PreviousImport.SetRange("Vendor Item No", VVendorItemNo);

        //if the item is found
        if PreviousImport.Find('+') then begin
            VPrevPost := PreviousImport."Post Indicator";
            VPrevChange := PreviousImport.Change;
            VPrevDiscont := PreviousImport.Discontinued;
        end
        else
            CurrReport.Skip;
    end;
}

