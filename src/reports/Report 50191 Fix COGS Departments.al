Report 50191 "Fix COGS Departments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Fix COGS Departments.rdlc';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("G/L Account No.", "Global Dimension 1 Code", "Posting Date") order(ascending) where("G/L Account No." = filter('506-00' .. '506-40' | '504-00' .. '504-40'));
            RequestFilterFields = "Posting Date";
            column(ReportForNavId_6710; 6710)
            {
            }
            column(ANICA__Inc__; 'ANICA, Inc.')
            {
            }
            column(Fix_COGS_Accounts_; 'Fix COGS Accounts')
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(UserId; UserId)
            {
            }
            column(Time; Time)
            {
            }
            column(G_L_Entry__TABLENAME_________GLFilter; "G/L Entry".TableName + ': ' + GLFilter)
            {
            }
            column(GLEntryAcctNo; "G/L Entry"."G/L Account No.")
            {
            }
            column(GLEntryPostingDate; "G/L Entry"."Posting Date")
            {
            }
            column(GLEntryDocNumber; "G/L Entry"."Document No.")
            {
            }
            column(GLEntryGlobalDim1; "G/L Entry"."Global Dimension 1 Code")
            {
            }
            column(GLEntryAmount; "G/L Entry".Amount)
            {
            }
            column(TotAmount_2_3_; TotAmount[2, 3])
            {
            }
            column(TotAmount_2_2_; TotAmount[2, 2])
            {
            }
            column(TotAmount_2_1_; TotAmount[2, 1])
            {
            }
            column(TotAccount_2_; TotAccount[2])
            {
            }
            column(TotAmount_3_3_; TotAmount[3, 3])
            {
            }
            column(TotAmount_3_2_; TotAmount[3, 2])
            {
            }
            column(TotAmount_3_1_; TotAmount[3, 1])
            {
            }
            column(TotAccount_3_; TotAccount[3])
            {
            }
            column(TotAmount_4_3_; TotAmount[4, 3])
            {
            }
            column(TotAmount_4_2_; TotAmount[4, 2])
            {
            }
            column(TotAmount_4_1_; TotAmount[4, 1])
            {
            }
            column(TotAccount_4_; TotAccount[4])
            {
            }
            column(TotAmount_5_3_; TotAmount[5, 3])
            {
            }
            column(TotAmount_5_2_; TotAmount[5, 2])
            {
            }
            column(TotAmount_5_1_; TotAmount[5, 1])
            {
            }
            column(TotAccount_5_; TotAccount[5])
            {
            }
            column(TotAmount_6_3_; TotAmount[6, 3])
            {
            }
            column(TotAmount_6_2_; TotAmount[6, 2])
            {
            }
            column(TotAmount_6_1_; TotAmount[6, 1])
            {
            }
            column(TotAccount_6_; TotAccount[6])
            {
            }
            column(TotAmount_7_3_; TotAmount[7, 3])
            {
            }
            column(TotAmount_7_2_; TotAmount[7, 2])
            {
            }
            column(TotAmount_7_1_; TotAmount[7, 1])
            {
            }
            column(TotAccount_7_; TotAccount[7])
            {
            }
            column(TotAmount_8_3_; TotAmount[8, 3])
            {
            }
            column(TotAmount_8_2_; TotAmount[8, 2])
            {
            }
            column(TotAmount_8_1_; TotAmount[8, 1])
            {
            }
            column(TotAccount_8_; TotAccount[8])
            {
            }
            column(TotAmount_9_3_; TotAmount[9, 3])
            {
            }
            column(TotAmount_9_2_; TotAmount[9, 2])
            {
            }
            column(TotAmount_9_1_; TotAmount[9, 1])
            {
            }
            column(TotAccount_9_; TotAccount[9])
            {
            }
            column(TotAmount_10_3_; TotAmount[10, 3])
            {
            }
            column(TotAmount_10_2_; TotAmount[10, 2])
            {
            }
            column(TotAmount_10_1_; TotAmount[10, 1])
            {
            }
            column(TotAccount_10_; TotAccount[10])
            {
            }
            column(TotAmount_11_3_; TotAmount[11, 3])
            {
            }
            column(TotAmount_11_2_; TotAmount[11, 2])
            {
            }
            column(TotAmount_11_1_; TotAmount[11, 1])
            {
            }
            column(TotAccount_11_; TotAccount[11])
            {
            }

            trigger OnAfterGetRecord()
            begin

                case "G/L Entry"."G/L Account No." of
                    '504-00':
                        I := 1;
                    '504-04':
                        I := 2;
                    '504-08':
                        I := 3;
                    '504-12':
                        I := 4;
                    '504-16':
                        I := 5;
                    '504-20':
                        I := 6;
                    '504-24':
                        I := 7;
                    '504-28':
                        I := 8;
                    '504-32':
                        I := 9;
                    '504-36':
                        I := 10;
                    '504-40':
                        I := 11;
                    '506-00':
                        I := 1;
                    '506-04':
                        I := 2;
                    '506-08':
                        I := 3;
                    '506-12':
                        I := 4;
                    '506-16':
                        I := 5;
                    '506-20':
                        I := 6;
                    '506-24':
                        I := 7;
                    '506-28':
                        I := 8;
                    '506-32':
                        I := 9;
                    '506-36':
                        I := 10;
                    '506-40':
                        I := 11;
                end;

                case "G/L Entry"."Global Dimension 1 Code" of
                    'ANICA':
                        P := 1;
                    'WHSE':
                        P := 2;
                    'S-KENT':
                        P := 3;
                end;

                TotAccount[I] := "G/L Entry"."G/L Account No.";
                TotAmount[I, P] := TotAmount[I, P] + "G/L Entry".Amount;
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
        GLFilter := "G/L Entry".GetFilters;
        P := 1;
        I := 1;
    end;

    var
        GLFilter: Text[250];
        I: Integer;
        P: Integer;
        TotAccount: array[100] of Code[10];
        TotAmount: array[200, 200] of Decimal;
}

