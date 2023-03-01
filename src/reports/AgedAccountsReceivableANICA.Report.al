Report 50054 "Aged Accounts Receivable ANICA"
{
    // ANICA This report is based on the stock report 10040 with the folling changes:
    // 
    // ANICA LCC 10-20-16 In report layout, removed 'over limit' line, deleted customer phone and contact fields
    // 
    // ANICA LCC 10-20-16 To speed up report added DATAITEM <Detailed Cust. Ledg. Entry> after <Cust. Ledger Entry> with the following properties:
    //     Indentation    1
    //     DataItemTable   Detailed Cust. Ledg. Entry
    //     DataItemTableView    SORTING(Customer No.,Currency Code,Initial Entry Global Dim. 1,Initial Entry Global Dim. 2,Initial Entry Due Date,Posting Date) WHERE(Entry Type=CONST(Application))
    //     DataItemLinkReference    <Customer>
    //     DataItemLinkCustomer     No.=FIELD(No.)
    //   Also added code to <Detailed Cust. Ledg. Entry> OnPreDataItem() and OnAfterGetRecord() to add amounts that were open as of the selected period ending date
    //   Also Changed <Cust. Ledger Entry> DataItemTableView to show only OPEN items as follows:
    //     DataItemTableView  SORTING(Customer No.,Open,Positive,Due Date,Currency Code) WHERE(Open=CONST(Yes))
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Aged Accounts Receivable ANICA.rdlc';

    Caption = 'Aged Accounts Receivable';

    dataset
    {
        dataitem(Customer;Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.","Customer Posting Group","Payment Terms Code","Salesperson Code";
            column(ReportForNavId_6836; 6836)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(Time;Time)
            {
            }
            column(CompanyInformation_Name;CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(UserId;UserId)
            {
            }
            column(SubTitle;SubTitle)
            {
            }
            column(DateTitle;DateTitle)
            {
            }
            column(Customer_TABLECAPTION__________FilterString;Customer.TableCaption + ': ' + FilterString)
            {
            }
            column(ColumnHeadHead;ColumnHeadHead)
            {
            }
            column(ColumnHead_1_;ColumnHead[1])
            {
            }
            column(ColumnHead_2_;ColumnHead[2])
            {
            }
            column(ColumnHead_3_;ColumnHead[3])
            {
            }
            column(ColumnHead_4_;ColumnHead[4])
            {
            }
            column(PrintDetail;PrintDetail)
            {
            }
            column(PrintToExcel;PrintToExcel)
            {
            }
            column(PrintAmountsInLocal;PrintAmountsInLocal)
            {
            }
            column(ShowAllForOverdue;ShowAllForOverdue)
            {
            }
            column(FilterString;FilterString)
            {
            }
            column(ColumnHeadHead_Control21;ColumnHeadHead)
            {
            }
            column(ShortDateTitle;ShortDateTitle)
            {
            }
            column(ColumnHead_1__Control26;ColumnHead[1])
            {
            }
            column(ColumnHead_2__Control27;ColumnHead[2])
            {
            }
            column(ColumnHead_3__Control28;ColumnHead[3])
            {
            }
            column(ColumnHead_4__Control29;ColumnHead[4])
            {
            }
            column(Customer__No__;"No.")
            {
            }
            column(Customer_Name;Name)
            {
            }
            column(Customer__Phone_No__;"Phone No.")
            {
            }
            column(Customer_Contact;Contact)
            {
            }
            column(BlockedDescription;BlockedDescription)
            {
            }
            column(OverLimitDescription;OverLimitDescription)
            {
            }
            column(TotalBalanceDue__;"TotalBalanceDue$")
            {
            }
            column(BalanceDue___1_;"BalanceDue$"[1])
            {
            }
            column(BalanceDue___2_;"BalanceDue$"[2])
            {
            }
            column(BalanceDue___3_;"BalanceDue$"[3])
            {
            }
            column(BalanceDue___4_;"BalanceDue$"[4])
            {
            }
            column(PercentString_1_;PercentString[1])
            {
            }
            column(PercentString_2_;PercentString[2])
            {
            }
            column(PercentString_3_;PercentString[3])
            {
            }
            column(PercentString_4_;PercentString[4])
            {
            }
            column(TotalBalanceDue___Control30;"TotalBalanceDue$")
            {
            }
            column(BalanceDue___1__Control48;"BalanceDue$"[1])
            {
            }
            column(BalanceDue___2__Control94;"BalanceDue$"[2])
            {
            }
            column(PercentString_1__Control95;PercentString[1])
            {
            }
            column(PercentString_2__Control96;PercentString[2])
            {
            }
            column(BalanceDue___3__Control97;"BalanceDue$"[3])
            {
            }
            column(PercentString_3__Control98;PercentString[3])
            {
            }
            column(BalanceDue___4__Control99;"BalanceDue$"[4])
            {
            }
            column(PercentString_4__Control100;PercentString[4])
            {
            }
            column(Customer_Global_Dimension_2_Filter;"Global Dimension 2 Filter")
            {
            }
            column(Customer_Global_Dimension_1_Filter;"Global Dimension 1 Filter")
            {
            }
            column(Aged_Accounts_ReceivableCaption;Aged_Accounts_ReceivableCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Aged_byCaption;Aged_byCaptionLbl)
            {
            }
            column(Control11Caption;CaptionClassTranslate('101,1,' + Text021))
            {
            }
            column(Customer__No__Caption;FieldCaption("No."))
            {
            }
            column(Customer_NameCaption;FieldCaption(Name))
            {
            }
            column(AmountDueToPrint_Control74Caption;AmountDueToPrint_Control74CaptionLbl)
            {
            }
            column(Credit_LimitCaption;Credit_LimitCaptionLbl)
            {
            }
            column(Customer__No__Caption_Control22;FieldCaption("No."))
            {
            }
            column(NameCaption;NameCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry___Document_No__Caption;Cust__Ledger_Entry___Document_No__CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__DescriptionCaption;Cust__Ledger_Entry__DescriptionCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry___Document_Type_Caption;Cust__Ledger_Entry___Document_Type_CaptionLbl)
            {
            }
            column(AmountDueToPrint_Control63Caption;AmountDueToPrint_Control63CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry___Currency_Code_Caption;Cust__Ledger_Entry___Currency_Code_CaptionLbl)
            {
            }
            column(DocumentCaption;DocumentCaptionLbl)
            {
            }
            column(Customer__Phone_No__Caption;FieldCaption("Phone No."))
            {
            }
            column(Customer_ContactCaption;FieldCaption(Contact))
            {
            }
            column(Control1020000Caption;CaptionClassTranslate(GetCurrencyCaptionCode("Currency Code")))
            {
            }
            column(Control47Caption;CaptionClassTranslate('101,0,' + Text022))
            {
            }
            column(Control8Caption;CaptionClassTranslate('101,0,' + Text022))
            {
            }
            column(GrandTotalBalanceDue_;GrandTotalBalanceDue)
            {
            }
            column(GrandBalanceDue_1_;GrandBalanceDue[1])
            {
            }
            column(GrandBalanceDue_2_;GrandBalanceDue[2])
            {
            }
            column(GrandBalanceDue_3_;GrandBalanceDue[3])
            {
            }
            column(GrandBalanceDue_4_;GrandBalanceDue[4])
            {
            }
            dataitem("Cust. Ledger Entry";"Cust. Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No."),"Global Dimension 2 Code"=field("Global Dimension 2 Filter"),"Global Dimension 1 Code"=field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Customer No.",Open,Positive,"Due Date","Currency Code") where(Open=const(true));
                column(ReportForNavId_8503; 8503)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SetRange("Date Filter",0D,PeriodEndingDate[1]);
                    CalcFields("Remaining Amount");
                    if "Remaining Amount" <> 0 then
                      InsertTemp("Cust. Ledger Entry");
                    CurrReport.Skip;    // this fools the system into thinking that no details "printed"...yet
                end;

                trigger OnPreDataItem()
                begin
                    // Find ledger entries which are posted before the date of the aging
                    SetRange("Posting Date",0D,PeriodEndingDate[1]);

                    if (Format(ShowOnlyOverDueBy) <> '') and not ShowAllForOverdue then
                      SetRange("Due Date",0D,CalculatedDate);
                end;
            }
            dataitem("Detailed Cust. Ledg. Entry";"Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Customer No."=field("No.");
                DataItemTableView = sorting("Customer No.","Currency Code","Initial Entry Global Dim. 1","Initial Entry Global Dim. 2","Initial Entry Due Date","Posting Date") where("Entry Type"=const(Application));
                column(ReportForNavId_1000000000; 1000000000)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //<ANICA LCC 10-20-16
                    "Cust. Ledger Entry".Reset;
                    if not "Cust. Ledger Entry".Get("Cust. Ledger Entry No.") then
                       CurrReport.Skip;

                    if "Cust. Ledger Entry".Open then
                       CurrReport.Skip;

                    "Cust. Ledger Entry".SetRange("Date Filter",0D,PeriodEndingDate[1]);
                    "Cust. Ledger Entry".CalcFields("Remaining Amount");
                    if "Cust. Ledger Entry"."Remaining Amount" <> 0 then
                      InsertTemp("Cust. Ledger Entry");

                    CurrReport.Skip;    // this fools the system into thinking that no details "printed"...yet
                    //>ANICA
                end;

                trigger OnPreDataItem()
                begin
                    //<ANICA LCC 10-20-16
                    SetFilter("Posting Date",'%1..',PeriodEndingDate[1]+1);
                    //>ANICA
                end;
            }
            dataitem(Totals;"Integer")
            {
                DataItemTableView = sorting(Number);
                column(ReportForNavId_9725; 9725)
                {
                }
                column(AmountDueToPrint;AmountDueToPrint)
                {
                }
                column(AmountDue_1_;AmountDue[1])
                {
                }
                column(AmountDue_2_;AmountDue[2])
                {
                }
                column(AmountDue_3_;AmountDue[3])
                {
                }
                column(AmountDue_4_;AmountDue[4])
                {
                }
                column(AgingDate;AgingDate)
                {
                }
                column(Cust__Ledger_Entry__Description;"Cust. Ledger Entry".Description)
                {
                }
                column(Cust__Ledger_Entry___Document_Type_;"Cust. Ledger Entry"."Document Type")
                {
                }
                column(Cust__Ledger_Entry___Document_No__;"Cust. Ledger Entry"."Document No.")
                {
                }
                column(AmountDueToPrint_Control63;AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control64;AmountDue[1])
                {
                }
                column(AmountDue_2__Control65;AmountDue[2])
                {
                }
                column(AmountDue_3__Control66;AmountDue[3])
                {
                }
                column(AmountDue_4__Control67;AmountDue[4])
                {
                }
                column(Cust__Ledger_Entry___Currency_Code_;"Cust. Ledger Entry"."Currency Code")
                {
                }
                column(AmountDueToPrint_Control68;AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control69;AmountDue[1])
                {
                }
                column(AmountDue_2__Control70;AmountDue[2])
                {
                }
                column(AmountDue_3__Control71;AmountDue[3])
                {
                }
                column(AmountDue_4__Control72;AmountDue[4])
                {
                }
                column(AmountDueToPrint_Control74;AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control75;AmountDue[1])
                {
                }
                column(AmountDue_2__Control76;AmountDue[2])
                {
                }
                column(AmountDue_3__Control77;AmountDue[3])
                {
                }
                column(AmountDue_4__Control78;AmountDue[4])
                {
                }
                column(CreditLimitToPrint;CreditLimitToPrint)
                {
                }
                column(PercentString_1__Control4;PercentString[1])
                {
                }
                column(PercentString_2__Control5;PercentString[2])
                {
                }
                column(PercentString_3__Control6;PercentString[3])
                {
                }
                column(PercentString_4__Control7;PercentString[4])
                {
                }
                column(Customer__No___Control80;Customer."No.")
                {
                }
                column(AmountDueToPrint_Control81;AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control82;AmountDue[1])
                {
                }
                column(AmountDue_2__Control83;AmountDue[2])
                {
                }
                column(AmountDue_3__Control84;AmountDue[3])
                {
                }
                column(AmountDue_4__Control85;AmountDue[4])
                {
                }
                column(CreditLimitToPrint_Control88;CreditLimitToPrint)
                {
                }
                column(PercentString_1__Control89;PercentString[1])
                {
                }
                column(PercentString_2__Control90;PercentString[2])
                {
                }
                column(PercentString_3__Control91;PercentString[3])
                {
                }
                column(PercentString_4__Control92;PercentString[4])
                {
                }
                column(Totals_Number;Number)
                {
                }
                column(Balance_ForwardCaption;Balance_ForwardCaptionLbl)
                {
                }
                column(Balance_to_Carry_ForwardCaption;Balance_to_Carry_ForwardCaptionLbl)
                {
                }
                column(Total_Amount_DueCaption;Total_Amount_DueCaptionLbl)
                {
                }
                column(Total_Amount_DueCaption_Control86;Total_Amount_DueCaption_Control86Lbl)
                {
                }
                column(Credit_Limit_Caption;Credit_Limit_CaptionLbl)
                {
                }
                column(Control1020001Caption;CaptionClassTranslate(GetCurrencyCaptionCode(Customer."Currency Code")))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CalcPercents(AmountDueToPrint,AmountDue);

                    if Number = 1 then
                      TempCustLedgEntry.Find('-')
                    else
                      TempCustLedgEntry.Next;
                    TempCustLedgEntry.SetRange("Date Filter",0D,PeriodEndingDate[1]);
                    TempCustLedgEntry.CalcFields("Remaining Amount","Remaining Amt. (LCY)");
                    if TempCustLedgEntry."Remaining Amount" = 0 then
                      CurrReport.Skip;
                    if TempCustLedgEntry."Currency Code" <> '' then
                      TempCustLedgEntry."Remaining Amt. (LCY)" :=
                        ROUND(
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            PeriodEndingDate[1],
                            TempCustLedgEntry."Currency Code",
                            '',
                            TempCustLedgEntry."Remaining Amount"));
                    if PrintAmountsInLocal then begin
                      TempCustLedgEntry."Remaining Amount" :=
                        ROUND(
                          CurrExchRate.ExchangeAmtFCYToFCY(
                            PeriodEndingDate[1],
                            TempCustLedgEntry."Currency Code",
                            Customer."Currency Code",
                            TempCustLedgEntry."Remaining Amount"),
                          Currency."Amount Rounding Precision");
                      AmountDueToPrint := TempCustLedgEntry."Remaining Amount";
                    end else
                      AmountDueToPrint := TempCustLedgEntry."Remaining Amt. (LCY)";

                    case AgingMethod of
                      Agingmethod::"Due Date":
                        AgingDate := TempCustLedgEntry."Due Date";
                      Agingmethod::"Trans Date":
                        AgingDate := TempCustLedgEntry."Posting Date";
                      Agingmethod::"Document Date":
                        AgingDate := TempCustLedgEntry."Document Date";
                    end;
                    j := 0;
                    while AgingDate < PeriodEndingDate[j + 1] do
                      j := j + 1;
                    if j = 0 then
                      j := 1;

                    AmountDue[j] := AmountDueToPrint;
                    "BalanceDue$"[j] := "BalanceDue$"[j] + TempCustLedgEntry."Remaining Amt. (LCY)";

                    CustTotAmountDue[j] := CustTotAmountDue[j] + AmountDueToPrint;
                    CustTotAmountDueToPrint := CustTotAmountDueToPrint + AmountDueToPrint;

                    "TotalBalanceDue$" := 0;
                    for j := 1 to 4 do
                      "TotalBalanceDue$" := "TotalBalanceDue$" + "BalanceDue$"[j];
                    CalcPercents("TotalBalanceDue$","BalanceDue$");

                    "Cust. Ledger Entry" := TempCustLedgEntry;

                    // Do NOT use the following fields in the sections:
                    // "Applied-To Doc. Type"
                    // "Applied-To Doc. No."
                    // Open
                    // "Paym. Disc. Taken"
                    // "Closed by Entry No."
                    // "Closed at Date"
                    // "Closed by Amount"

                    TotalNumberOfEntries -= 1;
                    if TotalNumberOfEntries = 0 then begin
                      for j := 1 to 4 do
                        GrandBalanceDue[j] += "BalanceDue$"[j];
                      GrandTotalBalanceDue += "TotalBalanceDue$";
                    end;

                    if PrintDetail and PrintToExcel then
                      MakeExcelDataBody;
                end;

                trigger OnPostDataItem()
                begin
                    if TempCustLedgEntry.Count > 0 then begin
                      for j := 1 to 4 do
                        AmountDue[j] := CustTotAmountDue[j];
                      AmountDueToPrint := CustTotAmountDueToPrint;
                      if not PrintDetail and PrintToExcel then
                        MakeExcelDataBody;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals(AmountDueToPrint,AmountDue);
                    SetRange(Number,1,TempCustLedgEntry.Count);
                    TempCustLedgEntry.SetCurrentkey("Customer No.","Posting Date");
                    Clear(CustTotAmountDue);
                    CustTotAmountDueToPrint := 0;
                    TotalNumberOfEntries := TempCustLedgEntry.Count;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
            begin
                Clear("BalanceDue$");
                if PrintAmountsInLocal then begin
                  GetCurrencyRecord(Currency,"Currency Code");
                  CurrencyFactor := CurrExchRate.ExchangeRate(PeriodEndingDate[1],"Currency Code");
                end;

                if Blocked <> Blocked::" " then
                  BlockedDescription := StrSubstNo(Text002,Blocked)
                else
                  BlockedDescription := '';

                if "Credit Limit (LCY)" = 0 then begin
                  //CS 9-14-17: Per Linda, wanted $0 limit customers to show as $0, and not "No Limit"
                  //CreditLimitToPrint := Text003;
                  CreditLimitToPrint := '0';
                  OverLimitDescription := '';
                end else begin
                  SetRange("Date Filter",0D,PeriodEndingDate[1]);
                  CalcFields("Net Change (LCY)");
                  if "Net Change (LCY)" > "Credit Limit (LCY)" then
                    OverLimitDescription := Text004
                  else
                    OverLimitDescription := '';
                  if PrintAmountsInLocal and ("Currency Code" <> '') then
                    "Credit Limit (LCY)" :=
                      CurrExchRate.ExchangeAmtLCYToFCY(PeriodEndingDate[1],"Currency Code","Credit Limit (LCY)",CurrencyFactor);
                  CreditLimitToPrint := Format(ROUND("Credit Limit (LCY)",1));
                end;

                TempCustLedgEntry.DeleteAll;

                if Format(ShowOnlyOverDueBy) <> '' then
                  CalculatedDate := CalcDate(ShowOnlyOverDueBy,PeriodEndingDate[1]);

                if ShowAllForOverdue and (Format(ShowOnlyOverDueBy) <> '') then begin
                  CustLedgEntry.SetRange("Customer No.","No.");
                  CustLedgEntry.SetRange(Open,true);
                  CustLedgEntry.SetRange("Due Date",0D,CalculatedDate);
                  if not CustLedgEntry.FindFirst then
                    CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Clear("BalanceDue$");

                if PrintDetail then
                  SubTitle := Text006
                else
                  SubTitle := Text007;

                SubTitle := SubTitle + Text008 + ' ' + Format(PeriodEndingDate[1],0,4) + ')';

                case AgingMethod of
                  Agingmethod::"Due Date":
                    begin
                      DateTitle := Text009;
                      ShortDateTitle := Text010;
                      ColumnHead[2] := Text011 + ' '
                        + Format(PeriodEndingDate[1] - PeriodEndingDate[3])
                        + Text012;
                      ColumnHeadHead := Text013 + ' ';
                    end;
                  Agingmethod::"Trans Date":
                    begin
                      DateTitle := Text014;
                      ShortDateTitle := Text015;
                      ColumnHead[2] := Format(PeriodEndingDate[1] - PeriodEndingDate[2] + 1)
                        + ' - '
                        + Format(PeriodEndingDate[1] - PeriodEndingDate[3])
                        + Text012;
                      ColumnHeadHead := Text016 + ' ';
                    end;
                  Agingmethod::"Document Date":
                    begin
                      DateTitle := Text017;
                      ShortDateTitle := Text018;
                      ColumnHead[2] := Format(PeriodEndingDate[1] - PeriodEndingDate[2] + 1)
                        + ' - '
                        + Format(PeriodEndingDate[1] - PeriodEndingDate[3])
                        + Text012;
                      ColumnHeadHead := Text016 + ' ';
                    end;
                end;

                ColumnHead[1] := Text019;
                ColumnHead[3] := Format(PeriodEndingDate[1] - PeriodEndingDate[3] + 1)
                  + ' - '
                  + Format(PeriodEndingDate[1] - PeriodEndingDate[4])
                  + Text012;
                ColumnHead[4] := Text020 + ' '
                  + Format(PeriodEndingDate[1] - PeriodEndingDate[4])
                  + Text012;

                if PrintToExcel then
                  MakeExcelInfo;
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
                    field(AgedAsOf;PeriodEndingDate[1])
                    {
                        ApplicationArea = Basic;
                        Caption = 'Aged as of';

                        trigger OnValidate()
                        begin
                            if PeriodEndingDate[1] = 0D then
                              PeriodEndingDate[1] := WorkDate;
                        end;
                    }
                    field(AgedBy;AgingMethod)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Aged by';
                        OptionCaption = 'Trans Date,Due Date,Document Date';

                        trigger OnValidate()
                        begin
                            if AgingMethod in [Agingmethod::"Document Date",Agingmethod::"Trans Date"] then begin
                              Evaluate(ShowOnlyOverDueBy,'');
                              ShowAllForOverdue := false;
                            end;
                        end;
                    }
                    field(LengthOfAgingPeriods;PeriodCalculation)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Length of Aging Periods';
                        DateFormula = true;

                        trigger OnValidate()
                        begin
                            if Format(PeriodCalculation) = '' then
                              Error(Text121);
                        end;
                    }
                    field(ShowOnlyOverDueBy;ShowOnlyOverDueBy)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show If Overdue By';
                        DateFormula = true;

                        trigger OnValidate()
                        begin
                            if AgingMethod <> Agingmethod::"Due Date" then
                              Error(Text120);
                            if Format(ShowOnlyOverDueBy) = '' then
                              ShowAllForOverdue := false;
                        end;
                    }
                    field(ShowAllForOverdue;ShowAllForOverdue)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show All for Overdue Customer';

                        trigger OnValidate()
                        begin
                            if AgingMethod <> Agingmethod::"Due Date" then
                              Error(Text120);
                            if ShowAllForOverdue and (Format(ShowOnlyOverDueBy) = '') then
                              Error(Text119);
                        end;
                    }
                    field(PrintAmountsInVendorsCurrency;PrintAmountsInLocal)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Amounts in Customer''s Currency';
                        MultiLine = true;
                    }
                    field(PrintDetail;PrintDetail)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Detail';
                    }
                    field(PrintToExcel;PrintToExcel)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print to Excel';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if PeriodEndingDate[1] = 0D then begin
              PeriodEndingDate[1] := WorkDate;
              Evaluate(PeriodCalculation,'<30D>');
            end;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        if PrintToExcel then
          CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        if Format(PeriodCalculation) <> '' then
          Evaluate(PeriodCalculation,'-' + Format(PeriodCalculation));
        if Format(ShowOnlyOverDueBy) <> '' then
          Evaluate(ShowOnlyOverDueBy,'-' + Format(ShowOnlyOverDueBy));
        if AgingMethod = Agingmethod::"Due Date" then begin
          PeriodEndingDate[2] := PeriodEndingDate[1];
          for j := 3 to 4 do
            PeriodEndingDate[j] := CalcDate(PeriodCalculation,PeriodEndingDate[j - 1]);
        end else
          for j := 2 to 4 do
            PeriodEndingDate[j] := CalcDate(PeriodCalculation,PeriodEndingDate[j - 1]);

        PeriodEndingDate[5] := 0D;
        CompanyInformation.Get;
        GLSetup.Get;
        FilterString := Customer.GetFilters;
    end;

    var
        CompanyInformation: Record "Company Information";
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        ExcelBuf: Record "Excel Buffer" temporary;
        PeriodCalculation: DateFormula;
        ShowOnlyOverDueBy: DateFormula;
        AgingMethod: Option "Trans Date","Due Date","Document Date";
        PrintAmountsInLocal: Boolean;
        PrintDetail: Boolean;
        PrintToExcel: Boolean;
        AmountDue: array [4] of Decimal;
        "BalanceDue$": array [4] of Decimal;
        ColumnHead: array [4] of Text[20];
        ColumnHeadHead: Text[59];
        PercentString: array [4] of Text[10];
        Percent: Decimal;
        "TotalBalanceDue$": Decimal;
        AmountDueToPrint: Decimal;
        CreditLimitToPrint: Text[25];
        BlockedDescription: Text[60];
        OverLimitDescription: Text[25];
        j: Integer;
        CurrencyFactor: Decimal;
        FilterString: Text;
        SubTitle: Text[88];
        DateTitle: Text[20];
        ShortDateTitle: Text[20];
        PeriodEndingDate: array [5] of Date;
        AgingDate: Date;
        Text001: label 'Amounts are in %1';
        Text002: label '*** This customer is blocked  for %1 processing ***  ';
        Text003: label 'No Limit';
        Text004: label '*** Over Limit ***';
        Text006: label '(Detail';
        Text007: label '(Summary';
        Text008: label ', aged as of';
        Text009: label 'due date.';
        Text010: label 'Due Date';
        Text011: label 'Up To';
        Text012: label ' Days';
        Text013: label ' Aged Overdue Amounts';
        Text014: label 'transaction date.';
        Text015: label 'Trx Date';
        Text016: label ' Aged Customer Balances';
        Text017: label 'document date.';
        Text018: label 'Doc Date';
        Text019: label 'Current';
        Text020: label 'Over';
        Text021: label 'Amounts are in the customer''s local currency (report totals are in %1).';
        Text022: label 'Report Total Amount Due (%1)';
        Text101: label 'Data';
        Text102: label 'Aged Accounts Receivable';
        Text103: label 'Company Name';
        Text104: label 'Report No.';
        Text105: label 'Report Name';
        Text106: label 'User ID';
        Text107: label 'Date / Time';
        Text108: label 'Customer Filters';
        Text109: label 'Aged by';
        Text110: label 'Amounts are';
        Text111: label 'In our Functional Currency';
        Text112: label 'As indicated in Data';
        Text113: label 'Aged as of';
        Text114: label 'Aging Date (%1)';
        Text115: label 'Balance Due';
        Text116: label 'Document Currency';
        Text117: label 'Customer Currency';
        Text118: label 'Credit Limit';
        Text119: label 'Show Only Overdue By Needs a Valid Date Formula';
        ShowAllForOverdue: Boolean;
        CalculatedDate: Date;
        Text120: label 'This option is only allowed for method Due Date';
        CustTotAmountDue: array [4] of Decimal;
        CustTotAmountDueToPrint: Decimal;
        Text121: label 'You must enter a period calculation in the Length of Aging Periods field.';
        Aged_Accounts_ReceivableCaptionLbl: label 'Aged Accounts Receivable';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Aged_byCaptionLbl: label 'Aged by';
        AmountDueToPrint_Control74CaptionLbl: label 'Balance Due';
        Credit_LimitCaptionLbl: label 'Credit Limit';
        NameCaptionLbl: label 'Name';
        Cust__Ledger_Entry___Document_No__CaptionLbl: label 'Number';
        Cust__Ledger_Entry__DescriptionCaptionLbl: label 'Description';
        Cust__Ledger_Entry___Document_Type_CaptionLbl: label 'Type';
        AmountDueToPrint_Control63CaptionLbl: label 'Balance Due';
        Cust__Ledger_Entry___Currency_Code_CaptionLbl: label 'Doc. Curr.';
        DocumentCaptionLbl: label 'Document';
        Balance_ForwardCaptionLbl: label 'Balance Forward';
        Balance_to_Carry_ForwardCaptionLbl: label 'Balance to Carry Forward';
        Total_Amount_DueCaptionLbl: label 'Total Amount Due';
        Total_Amount_DueCaption_Control86Lbl: label 'Total Amount Due';
        Credit_Limit_CaptionLbl: label 'Credit Limit:';
        TotalNumberOfEntries: Integer;
        GrandTotalBalanceDue: Decimal;
        GrandBalanceDue: array [4] of Decimal;

    local procedure InsertTemp(var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
        with TempCustLedgEntry do begin
          if Get(CustLedgEntry."Entry No.") then
            exit;
          TempCustLedgEntry := CustLedgEntry;
          case AgingMethod of
            Agingmethod::"Due Date":
              "Posting Date" := "Due Date";
            Agingmethod::"Document Date":
              "Posting Date" := "Document Date";
          end;
          Insert;
        end;
    end;


    procedure CalcPercents(Total: Decimal;Amounts: array [4] of Decimal)
    var
        i: Integer;
        j: Integer;
    begin
        Clear(PercentString);
        if Total <> 0 then
          for i := 1 to 4 do begin
            Percent := Amounts[i] / Total * 100.0;
            if StrLen(Format(ROUND(Percent))) + 4 > MaxStrLen(PercentString[1]) then
              PercentString[i] := PadStr(PercentString[i],MaxStrLen(PercentString[i]),'*')
            else begin
              PercentString[i] := Format(ROUND(Percent));
              j := StrPos(PercentString[i],'.');
              if j = 0 then
                PercentString[i] := PercentString[i] + '.00'
              else
                if j = StrLen(PercentString[i]) - 1 then
                  PercentString[i] := PercentString[i] + '0';
              PercentString[i] := PercentString[i] + '%';
            end;
          end;
    end;

    local procedure GetCurrencyRecord(var Currency: Record Currency;CurrencyCode: Code[10])
    begin
        if CurrencyCode = '' then begin
          Clear(Currency);
          Currency.Description := GLSetup."LCY Code";
          Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
        end else
          if Currency.Code <> CurrencyCode then
            Currency.Get(CurrencyCode);
    end;

    local procedure GetCurrencyCaptionCode(CurrencyCode: Code[10]): Text[80]
    begin
        if PrintAmountsInLocal then begin
          if CurrencyCode = '' then
            exit('101,1,' + Text001);

          GetCurrencyRecord(Currency,CurrencyCode);
          exit('101,4,' + StrSubstNo(Text001,Currency.Description));
        end;
        exit('');
    end;

    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(Format(Text103),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text105),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Format(Text102),false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text104),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Report::"Aged Accounts Receivable",false,'',false,false,false,'',ExcelBuf."cell type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text106),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(UserId,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text107),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Today,false,'',false,false,false,'',ExcelBuf."cell type"::Date);
        ExcelBuf.AddInfoColumn(Time,false,'',false,false,false,'',ExcelBuf."cell type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text108),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(FilterString,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text109),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(DateTitle,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text113),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(PeriodEndingDate[1],false,'',false,false,false,'',ExcelBuf."cell type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text110),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        if PrintAmountsInLocal then
          ExcelBuf.AddInfoColumn(Format(Text112),false,'',false,false,false,'',ExcelBuf."cell type"::Text)
        else
          ExcelBuf.AddInfoColumn(Format(Text111),false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Cust. Ledger Entry".FieldCaption("Customer No."),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption(Name),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        if PrintDetail then begin
          ExcelBuf.AddColumn(StrSubstNo(Text114,ShortDateTitle),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
          ExcelBuf.AddColumn("Cust. Ledger Entry".FieldCaption(Description),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
          ExcelBuf.AddColumn("Cust. Ledger Entry".FieldCaption("Document Type"),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
          ExcelBuf.AddColumn("Cust. Ledger Entry".FieldCaption("Document No."),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        end else
          ExcelBuf.AddColumn(Format(Text118),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Format(Text115),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(ColumnHead[1],false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(ColumnHead[2],false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(ColumnHead[3],false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(ColumnHead[4],false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        if PrintAmountsInLocal then begin
          if PrintDetail then
            ExcelBuf.AddColumn(Format(Text116),false,'',true,false,true,'',ExcelBuf."cell type"::Text)
          else
            ExcelBuf.AddColumn(Format(Text117),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        end;
    end;

    local procedure MakeExcelDataBody()
    var
        CurrencyCodeToPrint: Code[20];
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.",false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Customer.Name,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        if PrintDetail then begin
          ExcelBuf.AddColumn(AgingDate,false,'',false,false,false,'',ExcelBuf."cell type"::Date);
          ExcelBuf.AddColumn("Cust. Ledger Entry".Description,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
          ExcelBuf.AddColumn(Format("Cust. Ledger Entry"."Document Type"),false,'',false,false,false,'',ExcelBuf."cell type"::Text);
          ExcelBuf.AddColumn("Cust. Ledger Entry"."Document No.",false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        end else
          if OverLimitDescription = '' then
            ExcelBuf.AddColumn(CreditLimitToPrint,false,'',false,false,false,'#,##0',ExcelBuf."cell type"::Number)
          else
            ExcelBuf.AddColumn(CreditLimitToPrint,false,OverLimitDescription,true,false,false,'#,##0',ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(AmountDueToPrint,false,'',false,false,false,'#,##0.00',ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(AmountDue[1],false,'',false,false,false,'#,##0.00',ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(AmountDue[2],false,'',false,false,false,'#,##0.00',ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(AmountDue[3],false,'',false,false,false,'#,##0.00',ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(AmountDue[4],false,'',false,false,false,'#,##0.00',ExcelBuf."cell type"::Number);
        if PrintAmountsInLocal then begin
          if PrintDetail then
            CurrencyCodeToPrint := "Cust. Ledger Entry"."Currency Code"
          else
            CurrencyCodeToPrint := Customer."Currency Code";
          if CurrencyCodeToPrint = '' then
            CurrencyCodeToPrint := GLSetup."LCY Code";
          ExcelBuf.AddColumn(CurrencyCodeToPrint,false,'',false,false,false,'',ExcelBuf."cell type"::Text)
        end;
    end;

    local procedure CreateExcelbook()
    begin
        ExcelBuf.CreateBookAndOpenExcel(Text101,Text102,COMPANYNAME,UserId);
    end;
}

