Report 50115 "Cash Require by Due Date ANICA"
{
    // ANICA 8-3-15 LCC Added totals by 30, 60 and Balance for daily cash report
    //       Section only prints when no detail is selected.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Cash Require by Due Date ANICA.rdlc';

    Caption = 'Cash Requirements by Due Date';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = sorting(Open, "Due Date", "Vendor No.", "External Document No.") where(Open = const(true), "On Hold" = const(''));
            RequestFilterFields = "Vendor No.", "Due Date", "Purchaser Code", "Document Type";
            column(ReportForNavId_4114; 4114)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Time; Time)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Subtitle; Subtitle)
            {
            }
            column(PrintDetail; PrintDetail)
            {
            }
            column(UseExternalDocNo; UseExternalDocNo)
            {
            }
            column(Vendor_TABLECAPTION__________FilterString; Vendor.TableCaption + ': ' + FilterString)
            {
            }
            column(Document_Number_is______Vendor_Ledger_Entry__FIELDCAPTION__External_Document_No___; 'Document Number is ' + "Vendor Ledger Entry".FieldCaption("External Document No."))
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(Vendor_Ledger_Entry__Due_Date_; "Due Date")
            {
            }
            column(Vendor_Ledger_Entry__Vendor_No__; "Vendor No.")
            {
            }
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(Vendor_Ledger_Entry__Document_Type_; "Document Type")
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(Vendor_Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Vendor_Ledger_Entry__Pmt__Discount_Date_; "Pmt. Discount Date")
            {
            }
            column(Remaining_Amt___LCY__; -"Remaining Amt. (LCY)")
            {
            }
            column(PaymentDiscToPrint; -PaymentDiscToPrint)
            {
            }
            column(NetRequired; -NetRequired)
            {
            }
            column(Vendor_Ledger_Entry__Due_Date__Control43; "Due Date")
            {
            }
            column(Remaining_Amt___LCY___Control44; -"Remaining Amt. (LCY)")
            {
            }
            column(PaymentDiscToPrint_Control45; -PaymentDiscToPrint)
            {
            }
            column(NetRequired_Control46; -NetRequired)
            {
            }
            column(RequiredToDate; -RequiredToDate)
            {
            }
            column(Vendor_Ledger_Entry__Due_Date__Control49; "Due Date")
            {
            }
            column(Remaining_Amt___LCY___Control50; -"Remaining Amt. (LCY)")
            {
            }
            column(PaymentDiscToPrint_Control51; -PaymentDiscToPrint)
            {
            }
            column(NetRequired_Control52; -NetRequired)
            {
            }
            column(RequiredToDate_Control53; -RequiredToDate)
            {
            }
            column(Remaining_Amt___LCY___Control54; -"Remaining Amt. (LCY)")
            {
            }
            column(PaymentDiscToPrint_Control55; -PaymentDiscToPrint)
            {
            }
            column(NetRequired_Control56; -NetRequired)
            {
            }
            column(VNextDay; -VNextDay)
            {
            }
            column(V30Days; -V30Days)
            {
            }
            column(V60Days; -V60Days)
            {
            }
            column(VBalance; -VBalance)
            {
            }
            column(VNextDay___V30Days___V60Days___VBalance_; -(VNextDay + V30Days + V60Days + VBalance))
            {
            }
            column(Remaining_Amt___LCY___Control58; -"Remaining Amt. (LCY)")
            {
            }
            column(PaymentDiscToPrint_Control59; -PaymentDiscToPrint)
            {
            }
            column(NetRequired_Control60; -NetRequired)
            {
            }
            column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Cash_Requirements_by_Due_DateCaption; Cash_Requirements_by_Due_DateCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Due_Date__Control49Caption; FieldCaption("Due Date"))
            {
            }
            column(Remaining_Amt___LCY___Control50Caption; Remaining_Amt___LCY___Control50CaptionLbl)
            {
            }
            column(PaymentDiscToPrint_Control51Caption; PaymentDiscToPrint_Control51CaptionLbl)
            {
            }
            column(NetRequired_Control52Caption; NetRequired_Control52CaptionLbl)
            {
            }
            column(RequiredToDate_Control53Caption; RequiredToDate_Control53CaptionLbl)
            {
            }
            column(Due_DateCaption; Due_DateCaptionLbl)
            {
            }
            column(VendorCaption; VendorCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Document_Type_Caption; Vendor_Ledger_Entry__Document_Type_CaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Posting_Date_Caption; FieldCaption("Posting Date"))
            {
            }
            column(Discount_DateCaption; Discount_DateCaptionLbl)
            {
            }
            column(Amount_DueCaption; Amount_DueCaptionLbl)
            {
            }
            column(PaymentDiscToPrintCaption; PaymentDiscToPrintCaptionLbl)
            {
            }
            column(NetRequiredCaption; NetRequiredCaptionLbl)
            {
            }
            column(Cash_Req__to_DateCaption; Cash_Req__to_DateCaptionLbl)
            {
            }
            column(DocNoCaption; DocNoCaptionLbl)
            {
            }
            column(DocumentCaption; DocumentCaptionLbl)
            {
            }
            column(Date_TotalCaption; Date_TotalCaptionLbl)
            {
            }
            column(Report_TotalCaption; Report_TotalCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Remaining Amount", "Remaining Amt. (LCY)");
                if BeginProjectionDate > "Pmt. Discount Date" then
                    PaymentDiscToPrint := 0
                else begin
                    if "Currency Code" = '' then begin
                        //ANICA<< 9-3-15 changed to remaining pmt disc possible
                        //PaymentDiscToPrint := "Original Pmt. Disc. Possible"
                        PaymentDiscToPrint := "Vendor Ledger Entry"."Remaining Pmt. Disc. Possible";
                        //ANICA >>
                    end
                    else
                        if "Remaining Amount" <> 0 then begin
                            //ANICA<< 9-3-15 changed to remaining pmt disc possible
                            //PaymentDiscToPrint := "Original Pmt. Disc. Possible" * "Remaining Amt. (LCY)" / "Remaining Amount"
                            PaymentDiscToPrint := "Vendor Ledger Entry"."Remaining Pmt. Disc. Possible" * "Remaining Amt. (LCY)" / "Remaining Amount"
                            //ANICA >>
                        end
                        else
                            PaymentDiscToPrint := 0;   // should never happen, since trx is open anyway
                end;

                if not Vendor.Get("Vendor No.") then
                    Clear(Vendor);
                NetRequired := "Remaining Amt. (LCY)" - PaymentDiscToPrint;

                if UseExternalDocNo then
                    DocNo := "External Document No."
                else
                    DocNo := "Document No.";

                //<ANICA added LCC 6-14-12>
                if "Vendor Ledger Entry"."Due Date" = BeginProjectionDate then VNextDay := VNextDay + NetRequired;
                if ("Vendor Ledger Entry"."Due Date" >= V30StartDate) and ("Vendor Ledger Entry"."Due Date" < V30EndDate)
                   then
                    V30Days := V30Days + NetRequired;
                if ("Vendor Ledger Entry"."Due Date" >= V60StartDate) and
                ("Vendor Ledger Entry"."Due Date" <= V60EndDate) then
                    V60Days := V60Days + NetRequired;
                if "Vendor Ledger Entry"."Due Date" > VOver60Date then VBalance := VBalance + NetRequired;
                //Added to account for any payments before the report date
                if ("Vendor Ledger Entry"."Due Date" >= VBeforeStartDate) and ("Vendor Ledger Entry"."Due Date" <= VBeforeEndDate)
                   then
                    V30Days := V30Days + NetRequired;

                //<End ANICA>


                RequiredToDate := RequiredToDate + NetRequired;
            end;

            trigger OnPreDataItem()
            begin
                RequiredToDate := 0;
                //Removing all CreateTotals, will handle in Report Designer.
                //CurrReport.CreateTotals("Remaining Amt. (LCY)",PaymentDiscToPrint,NetRequired);
                SetRange("Date Filter", 0D, BeginProjectionDate);

                //>>ANICA
                V30StartDate := BeginProjectionDate + 1;
                V30EndDate := BeginProjectionDate + 30;
                V60StartDate := BeginProjectionDate + 31;
                V60EndDate := BeginProjectionDate + 60;
                VOver60Date := BeginProjectionDate + 61;
                //Had to add a range for items before the check day
                VBeforeStartDate := BeginProjectionDate - 365;
                VBeforeEndDate := BeginProjectionDate - 1;
                //<<

                if PrintDetail then
                    Subtitle := '(' + Format(Text000) + ' '
                else
                    Subtitle := '(' + Format(Text001) + ' ';
                Subtitle := Subtitle + Format(BeginProjectionDate, 0, 4) + ')';
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ForPaymentOn; BeginProjectionDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'For Payment On';
                    }
                    field(PrintDetail; PrintDetail)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Detail';
                    }
                    field(UseExternalDocNo; UseExternalDocNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Use External Doc. No.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if BeginProjectionDate = 0D then
                BeginProjectionDate := WorkDate;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        FilterString := "Vendor Ledger Entry".GetFilters;
    end;

    var
        FilterString: Text;
        Subtitle: Text[88];
        Vendor: Record Vendor;
        NetRequired: Decimal;
        RequiredToDate: Decimal;
        PaymentDiscToPrint: Decimal;
        BeginProjectionDate: Date;
        PrintDetail: Boolean;
        CompanyInformation: Record "Company Information";
        UseExternalDocNo: Boolean;
        DocNo: Code[50];
        Text000: label 'Detail for payments as of';
        Text001: label 'Summary for payments as of';
        Cash_Requirements_by_Due_DateCaptionLbl: label 'Cash Requirements by Due Date';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Remaining_Amt___LCY___Control50CaptionLbl: label 'Amount Due';
        PaymentDiscToPrint_Control51CaptionLbl: label 'Discount Available';
        NetRequired_Control52CaptionLbl: label 'Net Cash Required';
        RequiredToDate_Control53CaptionLbl: label 'Cash Required to Date';
        Due_DateCaptionLbl: label 'Due Date';
        VendorCaptionLbl: label 'Vendor';
        NameCaptionLbl: label 'Name';
        Vendor_Ledger_Entry__Document_Type_CaptionLbl: label 'Type';
        Discount_DateCaptionLbl: label 'Discount Date';
        Amount_DueCaptionLbl: label 'Amount Due';
        PaymentDiscToPrintCaptionLbl: label 'Discount Available';
        NetRequiredCaptionLbl: label 'Net Cash Required';
        Cash_Req__to_DateCaptionLbl: label 'Cash Req. to Date';
        DocNoCaptionLbl: label 'Number';
        DocumentCaptionLbl: label 'Document';
        Date_TotalCaptionLbl: label 'Date Total';
        Report_TotalCaptionLbl: label 'Report Total';
        TotalCaptionLbl: label 'Total';
        VNextDay: Decimal;
        V30Days: Decimal;
        V60Days: Decimal;
        VBalance: Decimal;
        V30StartDate: Date;
        V30EndDate: Date;
        V60StartDate: Date;
        V60EndDate: Date;
        VOver60Date: Date;
        VBeforeStartDate: Date;
        VBeforeEndDate: Date;
}

