Report 50188 "JBG Price Changes - Calculate"
{
    // //This CALCULATES the percent and price fields in the JBG Item Weekly Table.
    // //This is called from Report 50192 (JBG Price Changes - Report)

    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("JBG Item Weekly Table"; "JBG Item Weekly Table")
        {
            column(ReportForNavId_8183; 8183)
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

                //Reset Variables
                VVendorItemNo := '';
                VIsFound := false;
                VPrevRetail := 0;
                VCurrRetail := 0;
                VPriceChgPct := 0;
                VPriceChg := 0;

                //Get the current Vendor Item No.
                VVendorItemNo := "Vendor Item No";

                //check for item in previous import, if there then get necessary variables.
                LookupPreviousImport;

                if (VIsFound = true) then begin
                    begin
                        VCurrRetail := "Target Retail"
                    end;

                    if (VPrevRetail > 0) and (VCurrRetail > 0) then begin
                        VPriceChgPct := ((VCurrRetail - VPrevRetail) / VPrevRetail) * 100;

                        //If % is less than 5, ignore.
                        if VPriceChgPct > 5 then
                            "Percent Change" := VPriceChgPct
                        else
                            CurrReport.Skip;

                        VPriceChg := VCurrRetail - VPrevRetail;

                        //If there was no change in price, ignore.
                        if VPriceChg <> 0 then
                            "Price Change" := VPriceChg
                        else
                            CurrReport.Skip;

                        Modify(true);
                    end
                    else
                        CurrReport.Skip;
                end
                else
                    CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin
                //Clear filters.
                "JBG Item Weekly Table".SetRange("Import Date");

                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                //Get the current import date, and the week before.
                LookupImportDates;

                //filter down to only records with those current import date
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
        PreviousImport: Record "JBG Item Weekly Table";
        VCurrentImportDate: Date;
        VPreviousImportDate: Date;
        VVendorItemNo: Code[10];
        VCurrRetail: Decimal;
        VPrevRetail: Decimal;
        VPriceChg: Decimal;
        VPriceChgPct: Decimal;
        VIsFound: Boolean;
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;


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
        PreviousImport.SetRange("Import Date", VPreviousImportDate);
        PreviousImport.SetRange("Vendor Item No", VVendorItemNo);

        if PreviousImport.Find('+') then begin
            VIsFound := true;
            VPrevRetail := PreviousImport."Target Retail";
        end
        else begin
            VIsFound := false;
        end;
    end;
}

