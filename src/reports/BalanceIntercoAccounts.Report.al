Report 50072 "Balance Interco Accounts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Balance Interco Accounts.rdlc';

    dataset
    {
        dataitem("G/L Account";"G/L Account")
        {
            DataItemTableView = sorting("No.") order(ascending) where("Account Type"=const(Posting));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Date Filter";
            column(ReportForNavId_6710; 6710)
            {
            }
            column(CreditTotal;CreditTotal)
            {
            }
            column(DebitTotal;DebitTotal)
            {
            }
            column(ANICAAmount_19_;ANICAAmount[19])
            {
            }
            column(ANICAAmount_20_;ANICAAmount[20])
            {
            }
            column(WHSEAmount_19_;WHSEAmount[19])
            {
            }
            column(WHSEAmount_20_;WHSEAmount[20])
            {
            }
            column(SKENTAmount_19_;SKENTAmount[19])
            {
            }
            column(SKENTAmount_20_;SKENTAmount[20])
            {
            }
            column(DebitTotal_CreditTotal;DebitTotal+CreditTotal)
            {
            }
            column(ANICAAmount_19__ANICAAmount_20__;-(ANICAAmount[19]+ANICAAmount[20]))
            {
            }
            column(WHSEAmount_19__WHSEAmount_20__;-(WHSEAmount[19]+WHSEAmount[20]))
            {
            }
            column(SKENTAmount_19__SKENTAmount_20__;-(SKENTAmount[19]+SKENTAmount[20]))
            {
            }
            column(AccountAmount_6_;AccountAmount[6])
            {
            }
            column(ANICAAmount_6_;ANICAAmount[6])
            {
            }
            column(WHSEAmount_6_;WHSEAmount[6])
            {
            }
            column(SKENTAmount_7_;SKENTAmount[7])
            {
            }
            column(WHSEAmount_7_;WHSEAmount[7])
            {
            }
            column(SKENTAmount_6_;SKENTAmount[6])
            {
            }
            column(AccountAmount_7_;AccountAmount[7])
            {
            }
            column(ANICAAmount_7_;ANICAAmount[7])
            {
            }
            column(AccountAmount_9_;AccountAmount[9])
            {
            }
            column(AccountAmount_8_;AccountAmount[8])
            {
            }
            column(GroupTotal_1__GroupTotal_3__AccountAmount_6__AccountAmount_8__AccountAmount_10_;GroupTotal[1]+GroupTotal[3]+AccountAmount[6]+AccountAmount[8]-AccountAmount[10])
            {
            }
            column(ELIMAmount_8_;ELIMAmount[8])
            {
            }
            column(ELIMAmount_9_;ELIMAmount[9])
            {
            }
            column(GroupTotal_1__GroupTotal_3__AccountAmount_6__AccountAmount_10_;GroupTotal[1]+GroupTotal[3]+AccountAmount[6]-AccountAmount[10])
            {
            }
            column(GroupTotal_5__AccountAmount_7__AccountAmount_10_;GroupTotal[5]+AccountAmount[7]+AccountAmount[10])
            {
            }
            column(DateToPrint;DateToPrint)
            {
            }
            column(Balance_Intercompany_Accounts_;'Balance Intercompany Accounts')
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(UserId;UserId)
            {
            }
            column(Time;Time)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(Balance_Company_Balance_SheetsCaption;Balance_Company_Balance_SheetsCaptionLbl)
            {
            }
            column(V130_98Caption;V130_98CaptionLbl)
            {
            }
            column(Company_Asset_TotalCaption;Company_Asset_TotalCaptionLbl)
            {
            }
            column(Company_Liability_TotalCaption;Company_Liability_TotalCaptionLbl)
            {
            }
            column(Balance_IntercompanyCaption;Balance_IntercompanyCaptionLbl)
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            column(ANICACaption;ANICACaptionLbl)
            {
            }
            column(WHSECaption;WHSECaptionLbl)
            {
            }
            column(KENTCaption;KENTCaptionLbl)
            {
            }
            column(Balance_IntercompanyCaption_Control68;Balance_IntercompanyCaption_Control68Lbl)
            {
            }
            column(V284_99Caption;V284_99CaptionLbl)
            {
            }
            column(Adjustment_NecessaryCaption;Adjustment_NecessaryCaptionLbl)
            {
            }
            column(Intercompany_EliminationCaption;Intercompany_EliminationCaptionLbl)
            {
            }
            column(Eliminate_Interco_ReceivablesCaption;Eliminate_Interco_ReceivablesCaptionLbl)
            {
            }
            column(Eliminate_Intercompany_PayablesCaption;Eliminate_Intercompany_PayablesCaptionLbl)
            {
            }
            column(Adjustment_NecessaryCaption_Control161;Adjustment_NecessaryCaption_Control161Lbl)
            {
            }
            column(TotalCaption_Control165;TotalCaption_Control165Lbl)
            {
            }
            column(V129_99Caption;V129_99CaptionLbl)
            {
            }
            column(V282_02Caption;V282_02CaptionLbl)
            {
            }
            column(Total_Intercompany_ReceivablesCaption;Total_Intercompany_ReceivablesCaptionLbl)
            {
            }
            column(Total_Intercompany_ReceivablesCaption_Control177;Total_Intercompany_ReceivablesCaption_Control177Lbl)
            {
            }
            column(ELIMCaption;ELIMCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(DataItem1000000002;If_ANICA_or_WHSE_have_a_net_debit__balance_adjust_it_to130_98__if_a_net_credit_balance_adjust_to_284_99__combine_WHSE_and_KENLbl)
            {
            }
            column(G_L_Account_No_;"No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                CurrReport.SHOWOUTPUT(false);

                //Array number 19 is all of the asset totals
                //Array number 20 is all of the liability totals

                case "G/L Account"."No." of
                '128-01' : ArrayCounter := 1;
                '128-02' : ArrayCounter := 2;
                '129-01' : ArrayCounter := 3;
                '129-02' : ArrayCounter := 4;
                '282-00' : ArrayCounter := 5;
                '130-98' : ArrayCounter := 6;
                '284-99' : ArrayCounter := 7;
                '129-99' : ArrayCounter := 8;
                '282-02' : ArrayCounter := 9;
                '284-00'..'284-09' : ArrayCounter := 10;
                else ArrayCounter := 18;
                end;

                case ArrayCounter of
                1 : GroupCounter := 1;
                2 : GroupCounter := 1;
                3 : GroupCounter := 3;
                4 : GroupCounter := 3;
                5 : GroupCounter := 5;
                6 : GroupCounter := 6;
                7 : GroupCounter := 6;
                8 : GroupCounter := 8;
                9 : GroupCounter := 8;
                else GroupCounter := 18;
                end;


                //ANICA Amount
                SetFilter("Global Dimension 1 Filter",'ANICA');
                CalcFields("Balance at Date");
                ANICAAmount[ArrayCounter] := "Balance at Date";
                AccountAmount[ArrayCounter] := AccountAmount[ArrayCounter] + ANICAAmount[ArrayCounter];
                //Compute balance sheet total debits and credits
                case "G/L Account"."No." of
                '100-00'..'199-99' : ANICAAmount[19] := ANICAAmount[19] + "Balance at Date";
                '200-00'..'999-99' : ANICAAmount[20] := ANICAAmount[20] + "Balance at Date";
                end;

                //WHSE Amount
                SetFilter("Global Dimension 1 Filter",'WHSE');
                CalcFields("Balance at Date");
                WHSEAmount[ArrayCounter] := "Balance at Date";
                AccountAmount[ArrayCounter] := AccountAmount[ArrayCounter] + WHSEAmount[ArrayCounter];
                //Compute balance sheet total debits and credits
                case "G/L Account"."No." of
                '100-00'..'199-99' : WHSEAmount[19] := WHSEAmount[19] + "Balance at Date";
                '200-00'..'999-99' : WHSEAmount[20] := WHSEAmount[20] + "Balance at Date";
                end;

                //KENT Amount
                SetFilter("Global Dimension 1 Filter",'S-KENT');
                CalcFields("Balance at Date");
                SKENTAmount[ArrayCounter] := "Balance at Date";
                AccountAmount[ArrayCounter] := AccountAmount[ArrayCounter] + SKENTAmount[ArrayCounter];
                //Compute balance sheet total debits and credits
                case "G/L Account"."No." of
                '100-00'..'199-99' : SKENTAmount[19] := SKENTAmount[19] + "Balance at Date";
                '200-00'..'999-99' : SKENTAmount[20] := SKENTAmount[20] + "Balance at Date";
                end;

                //ELIM Amount
                SetFilter("Global Dimension 1 Filter",'ELIM');
                CalcFields("Balance at Date");
                ELIMAmount[ArrayCounter] := "Balance at Date";
                AccountAmount[ArrayCounter] := AccountAmount[ArrayCounter] + ELIMAmount[ArrayCounter];
                //Compute balance sheet total debits and credits
                case "G/L Account"."No." of
                '100-00'..'199-99' : ELIMAmount[19] := ELIMAmount[19] + "Balance at Date";
                '200-00'..'999-99' : ELIMAmount[20] := ELIMAmount[20] + "Balance at Date";
                end;

                GroupTotal[GroupCounter] := GroupTotal[GroupCounter] + AccountAmount[ArrayCounter];
                DebitTotal := ANICAAmount[19] + WHSEAmount[19] +  SKENTAmount[19];
                CreditTotal := ANICAAmount[20] + WHSEAmount[20] +  SKENTAmount[20];
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

    trigger OnPreReport()
    begin
        //See if a date filter has been entered
        if "G/L Account".GetFilter("Date Filter") = '' then Error('Please enter a date filter');
        DateToPrint := "G/L Account".GetFilter("Date Filter");
    end;

    var
        AccountAmount: array [20] of Decimal;
        ANICAAmount: array [20] of Decimal;
        ELIMAmount: array [20] of Decimal;
        RIVERAmount: array [20] of Decimal;
        WHSEAmount: array [20] of Decimal;
        SKENTAmount: array [20] of Decimal;
        GroupTotal: array [20] of Decimal;
        ArrayCounter: Integer;
        GroupCounter: Integer;
        DebitTotal: Decimal;
        CreditTotal: Decimal;
        DateToPrint: Text[30];
        Balance_Company_Balance_SheetsCaptionLbl: label 'Balance Company Balance Sheets';
        V130_98CaptionLbl: label '130-98';
        Company_Asset_TotalCaptionLbl: label 'Company Asset Total';
        Company_Liability_TotalCaptionLbl: label 'Company Liability Total';
        Balance_IntercompanyCaptionLbl: label 'Balance Intercompany';
        TotalCaptionLbl: label 'Total';
        ANICACaptionLbl: label 'ANICA';
        FAMCaptionLbl: label 'FAM';
        RIVERCaptionLbl: label 'RIVER';
        BPPCaptionLbl: label 'BPP';
        WHSECaptionLbl: label 'WHSE';
        KENTCaptionLbl: label 'KENT';
        KNSCaptionLbl: label 'KNS';
        Balance_IntercompanyCaption_Control68Lbl: label 'Balance Intercompany';
        V284_99CaptionLbl: label '284-99';
        Adjustment_NecessaryCaptionLbl: label 'Adjustment Necessary';
        Intercompany_EliminationCaptionLbl: label 'Intercompany Elimination';
        Eliminate_Interco_ReceivablesCaptionLbl: label 'Eliminate Interco Receivables';
        Eliminate_Intercompany_PayablesCaptionLbl: label 'Eliminate Intercompany Payables';
        Adjustment_NecessaryCaption_Control161Lbl: label 'Adjustment Necessary';
        TotalCaption_Control165Lbl: label 'Total';
        V129_99CaptionLbl: label '129-99';
        V282_02CaptionLbl: label '282-02';
        Total_Intercompany_ReceivablesCaptionLbl: label 'Total Intercompany Receivables';
        Total_Intercompany_ReceivablesCaption_Control177Lbl: label 'Total Intercompany Receivables';
        ELIMCaptionLbl: label 'ELIM';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        If_ANICA_or_WHSE_have_a_net_debit__balance_adjust_it_to130_98__if_a_net_credit_balance_adjust_to_284_99__combine_WHSE_and_KENLbl: label 'If ANICA or WHSE have a net debit  balance adjust it to130-98, if a net credit balance adjust to 284-99, combine WHSE and KENT for this determination';
}

