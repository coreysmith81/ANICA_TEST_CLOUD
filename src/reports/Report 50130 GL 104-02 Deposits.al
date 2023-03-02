Report 50130 "G/L 104-02 Deposits"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/GL 104-02 Deposits.rdlc';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Entry No.";
            column(ReportForNavId_7069; 7069)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(G_L_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(G_L_Entry__Document_No__; "Document No.")
            {
            }
            column(G_L_Entry_Description; Description)
            {
            }
            column(G_L_Entry_Amount; Amount)
            {
            }
            column(G_L_104_02_DepositsCaption; G_L_104_02_DepositsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Entry__Posting_Date_Caption; FieldCaption("Posting Date"))
            {
            }
            column(G_L_Entry__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(G_L_Entry_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(G_L_Entry_AmountCaption; FieldCaption(Amount))
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
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
            end;

            trigger OnPostDataItem()
            begin
                Clear("G/L Entry");

                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                "G/L Entry".SetCurrentkey("Posting Date", "G/L Account No.", Description);
                //"G/L Entry".SETFILTER("Posting Date",'>=%1',20110101D);
                "G/L Entry".SetFilter("G/L Account No.", '104-02');
                //"G/L Entry".SETRANGE("Document Type",1);
                "G/L Entry".SetFilter(Description, 'DEPOSIT - KEY BANK|DIRECT DEPOSIT');

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
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        G_L_104_02_DepositsCaptionLbl: label 'G/L 104-02 Deposits';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}

