Report 50094 "Check Run Preview"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Check Run Preview.rdlc';
    ProcessingOnly = false;
    UseRequestPage = true;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Account No.", "Line No.") where("Journal Template Name" = const('PAYMENT'), "Journal Batch Name" = const('CHECKS'));
            PrintOnlyIfDetail = false;
            column(ReportForNavId_7024; 7024)
            {
            }
            column(Today; Today)
            {
            }
            column(Time; Time)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Gen__Journal_Line__Account_No__; "Account No.")
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(VendorTerms; VendorTerms)
            {
            }
            column(Gen__Journal_Line_Amount; Amount)
            {
            }
            column(Gen__Journal_Line__Payment_Discount_; "Payment Discount")
            {
            }
            column(Payment_Discount____Amount; "Payment Discount" + Amount)
            {
            }
            column(Gen__Journal_Line__Vendor_Invoice_No__; "Vendor Invoice No.")
            {
            }
            column(Gen__Journal_Line_Amount_Control9; Amount)
            {
            }
            column(Gen__Journal_Line__Payment_Discount__Control10; "Payment Discount")
            {
            }
            column(Payment_Discount____Amount_Control4; "Payment Discount" + Amount)
            {
            }
            column(Gen__Journal_Line_Amount_Control25; Amount)
            {
            }
            column(Gen__Journal_Line__Payment_Discount__Control26; "Payment Discount")
            {
            }
            column(Payment_Discount____Amount_Control27; "Payment Discount" + Amount)
            {
            }
            column(Checks_Selected_PreviewCaption; Checks_Selected_PreviewCaptionLbl)
            {
            }
            column(ANICA__Inc_Caption; ANICA__Inc_CaptionLbl)
            {
            }
            column(PAGECaption; PAGECaptionLbl)
            {
            }
            column(DiscountCaption; DiscountCaptionLbl)
            {
            }
            column(Net_CheckCaption; Net_CheckCaptionLbl)
            {
            }
            column(GrossCaption; GrossCaptionLbl)
            {
            }
            column(Gen__Journal_Line__Vendor_Invoice_No__Caption; FieldCaption("Vendor Invoice No."))
            {
            }
            column(Default_TermsCaption; Default_TermsCaptionLbl)
            {
            }
            column(Check_TotalsCaption; Check_TotalsCaptionLbl)
            {
            }
            column(Report_TotalsCaption; Report_TotalsCaptionLbl)
            {
            }
            column(Gen__Journal_Line_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Gen__Journal_Line_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(Gen__Journal_Line_Line_No_; "Line No.")
            {
            }
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
        VendorRecord: Record Vendor;
        VendorName: Text[30];
        VendorTerms: Code[10];
        Checks_Selected_PreviewCaptionLbl: label 'Checks Selected Preview';
        ANICA__Inc_CaptionLbl: label 'ANICA, Inc.';
        PAGECaptionLbl: label 'PAGE';
        DiscountCaptionLbl: label 'Discount';
        Net_CheckCaptionLbl: label 'Net Check';
        GrossCaptionLbl: label 'Gross';
        Default_TermsCaptionLbl: label 'Default Terms';
        Check_TotalsCaptionLbl: label 'Check Totals';
        Report_TotalsCaptionLbl: label 'Report Totals';
}

