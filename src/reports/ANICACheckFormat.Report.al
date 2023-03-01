Report 50013 "ANICA Check Format"
{
    // 7-20-15 LCC Create a variable to for the check date, VCheckDate.
    // 
    // 7-21-15 LCC Remove to trailing pad charachters from the check amount print field.  These were add zeros and decimals
    //      beyond two decimal places.
    // 
    // 10-6-15 LCC Force department code to be ANICA for checks
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ANICA Check Format.rdlc';

    Caption = 'Check (Stub/Check/Stub)';
    Permissions = TableData "Bank Account"=m;

    dataset
    {
        dataitem(VoidGenJnlLine;"Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
            RequestFilterFields = "Journal Template Name","Journal Batch Name","Posting Date";
            column(ReportForNavId_9788; 9788)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CheckManagement.VoidCheck(VoidGenJnlLine);
            end;

            trigger OnPreDataItem()
            begin
                if CurrReport.Preview then
                  Error(Text000);

                if UseCheckNo = '' then
                  Error(Text001);

                if IncStr(UseCheckNo) = '' then
                  Error(USText004);

                if TestPrint then
                  CurrReport.Break;

                if not ReprintChecks then
                  CurrReport.Break;

                if (GetFilter("Line No.") <> '') or (GetFilter("Document No.") <> '') then
                  Error(
                    Text002,FieldCaption("Line No."),FieldCaption("Document No."));
                SetRange("Bank Payment Type","bank payment type"::"Computer Check");
                SetRange("Check Printed",true);
            end;
        }
        dataitem(TestGenJnlLine;"Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name","Journal Batch Name","Line No.");
            column(ReportForNavId_7546; 7546)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Amount = 0 then
                  CurrReport.Skip;

                TestField("Bal. Account Type","bal. account type"::"Bank Account");
                if "Bal. Account No." <> BankAcc2."No." then
                  CurrReport.Skip;
                case "Account Type" of
                  "account type"::"G/L Account":
                    begin
                      if BankAcc2."Check Date Format" = BankAcc2."check date format"::" " then
                        Error(USText006,BankAcc2.FieldCaption("Check Date Format"),BankAcc2.TableCaption,BankAcc2."No.");
                      if BankAcc2."Bank Communication" = BankAcc2."bank communication"::"S Spanish" then
                        Error(USText007,BankAcc2.FieldCaption("Bank Communication"),BankAcc2.TableCaption,BankAcc2."No.");
                    end;
                  "account type"::Customer:
                    begin
                      Cust.Get("Account No.");
                      if Cust."Check Date Format" = Cust."check date format"::" " then
                        Error(USText006,Cust.FieldCaption("Check Date Format"),Cust.TableCaption,"Account No.");
                      if Cust."Bank Communication" = Cust."bank communication"::"S Spanish" then
                        Error(USText007,Cust.FieldCaption("Bank Communication"),Cust.TableCaption,"Account No.");
                    end;
                  "account type"::Vendor:
                    begin
                      Vend.Get("Account No.");
                      if Vend."Check Date Format" = Vend."check date format"::" " then
                        Error(USText006,Vend.FieldCaption("Check Date Format"),Vend.TableCaption,"Account No.");
                      if Vend."Bank Communication" = Vend."bank communication"::"S Spanish" then
                        Error(USText007,Vend.FieldCaption("Bank Communication"),Vend.TableCaption,"Account No.");
                    end;
                  "account type"::"Bank Account":
                    begin
                      BankAcc.Get("Account No.");
                      if BankAcc."Check Date Format" = BankAcc."check date format"::" " then
                        Error(USText006,BankAcc.FieldCaption("Check Date Format"),BankAcc.TableCaption,"Account No.");
                      if BankAcc."Bank Communication" = BankAcc."bank communication"::"S Spanish" then
                        Error(USText007,BankAcc.FieldCaption("Bank Communication"),BankAcc.TableCaption,"Account No.");
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if TestPrint then begin
                  CompanyInfo.Get;
                  BankAcc2.Get(BankAcc2."No.");
                  BankCurrencyCode := BankAcc2."Currency Code";
                end;

                if TestPrint then
                  CurrReport.Break;
                CompanyInfo.Get;
                BankAcc2.Get(BankAcc2."No.");
                BankCurrencyCode := BankAcc2."Currency Code";

                if BankAcc2."Country/Region Code" <> CompanyInfo."Canada Country/Region Code" then
                  CurrReport.Break;
                BankAcc2.TestField(Blocked,false);
                Copy(VoidGenJnlLine);
                BankAcc2.Get(BankAcc2."No.");
                BankAcc2.TestField(Blocked,false);
                SetRange("Bank Payment Type","bank payment type"::"Computer Check");
                SetRange("Check Printed",false);
            end;
        }
        dataitem(GenJnlLine;"Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
            column(ReportForNavId_3808; 3808)
            {
            }
            column(GenJnlLine_Journal_Template_Name;"Journal Template Name")
            {
            }
            column(GenJnlLine_Journal_Batch_Name;"Journal Batch Name")
            {
            }
            column(GenJnlLine_Line_No_;"Line No.")
            {
            }
            dataitem(CheckPages;"Integer")
            {
                DataItemTableView = sorting(Number);
                column(ReportForNavId_1159; 1159)
                {
                }
                column(CheckToAddr_1_;CheckToAddr[1])
                {
                }
                column(CheckDateText;CheckDateText)
                {
                }
                column(CheckNoText;CheckNoText)
                {
                }
                column(PageNo;PageNo)
                {
                }
                column(CheckPages_Number;Number)
                {
                }
                column(CheckNoTextCaption;CheckNoTextCaptionLbl)
                {
                }
                column(VCheckDateNo;VCheckDate)
                {
                }
                dataitem(PrintSettledLoop;"Integer")
                {
                    DataItemTableView = sorting(Number);
                    MaxIteration = 10;
                    column(ReportForNavId_4098; 4098)
                    {
                    }
                    column(PreprintedStub;PreprintedStub)
                    {
                    }
                    column(LineAmount;LineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineDiscount;LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount___LineDiscount;LineAmount + LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(DocNo;DocNo)
                    {
                    }
                    column(DocDate;DocDate)
                    {
                    }
                    column(PostingDesc;PostingDesc)
                    {
                    }
                    column(PrintSettledLoop_Number;Number)
                    {
                    }
                    column(LineAmountCaption;LineAmountCaptionLbl)
                    {
                    }
                    column(LineDiscountCaption;LineDiscountCaptionLbl)
                    {
                    }
                    column(DocNoCaption;DocNoCaptionLbl)
                    {
                    }
                    column(DocDateCaption;DocDateCaptionLbl)
                    {
                    }
                    column(Posting_DescriptionCaption;Posting_DescriptionCaptionLbl)
                    {
                    }
                    column(AmountCaption;AmountCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if not TestPrint then begin
                          if FoundLast then begin
                            if RemainingAmount <> 0 then begin
                              DocNo := '';
                              ExtDocNo := '';
                              LineAmount := RemainingAmount;
                              LineAmount2 := RemainingAmount;
                              CurrentLineAmount := LineAmount2;
                              LineDiscount := 0;
                              RemainingAmount := 0;

                              PostingDesc := CheckToAddr[1];
                            end else
                              CurrReport.Break;
                          end else
                            case ApplyMethod of
                              Applymethod::OneLineOneEntry:
                                begin
                                  case BalancingType of
                                    Balancingtype::Customer:
                                      begin
                                        CustLedgEntry.Reset;
                                        CustLedgEntry.SetCurrentkey("Document No.");
                                        CustLedgEntry.SetRange("Document Type",GenJnlLine."Applies-to Doc. Type");
                                        CustLedgEntry.SetRange("Document No.",GenJnlLine."Applies-to Doc. No.");
                                        CustLedgEntry.SetRange("Customer No.",BalancingNo);
                                        CustLedgEntry.Find('-');
                                        CustUpdateAmounts(CustLedgEntry,RemainingAmount);
                                      end;
                                    Balancingtype::Vendor:
                                      begin
                                        VendLedgEntry.Reset;
                                        VendLedgEntry.SetCurrentkey("Document No.");
                                        VendLedgEntry.SetRange("Document Type",GenJnlLine."Applies-to Doc. Type");
                                        VendLedgEntry.SetRange("Document No.",GenJnlLine."Applies-to Doc. No.");
                                        VendLedgEntry.SetRange("Vendor No.",BalancingNo);
                                        VendLedgEntry.Find('-');
                                        VendUpdateAmounts(VendLedgEntry,RemainingAmount);
                                      end;
                                  end;
                                  RemainingAmount := RemainingAmount - LineAmount2;
                                  CurrentLineAmount := LineAmount2;
                                  FoundLast := true;
                                end;
                              Applymethod::OneLineID:
                                begin
                                  case BalancingType of
                                    Balancingtype::Customer:
                                      begin
                                        CustUpdateAmounts(CustLedgEntry,RemainingAmount);
                                        FoundLast := (CustLedgEntry.Next = 0) or (RemainingAmount <= 0);
                                        if FoundLast and not FoundNegative then begin
                                          CustLedgEntry.SetRange(Positive,false);
                                          FoundLast := not CustLedgEntry.Find('-');
                                          FoundNegative := true;
                                        end;
                                      end;
                                    Balancingtype::Vendor:
                                      begin
                                        VendUpdateAmounts(VendLedgEntry,RemainingAmount);
                                        FoundLast := (VendLedgEntry.Next = 0) or (RemainingAmount <= 0);
                                        if FoundLast and not FoundNegative then begin
                                          VendLedgEntry.SetRange(Positive,false);
                                          FoundLast := not VendLedgEntry.Find('-');
                                          FoundNegative := true;
                                        end;
                                      end;
                                  end;
                                  RemainingAmount := RemainingAmount - LineAmount2;
                                  CurrentLineAmount := LineAmount2
                                end;
                              Applymethod::MoreLinesOneEntry:
                                begin
                                  CurrentLineAmount := GenJnlLine2.Amount;
                                  LineAmount2 := CurrentLineAmount;
                                  if GenJnlLine2."Applies-to ID" <> '' then
                                    Error(
                                      Text016 +
                                      Text017);
                                  GenJnlLine2.TestField("Check Printed",false);
                                  GenJnlLine2.TestField("Bank Payment Type",GenJnlLine2."bank payment type"::"Computer Check");

                                  if GenJnlLine2."Applies-to Doc. No." = '' then begin
                                    DocNo := '';
                                    ExtDocNo := '';
                                    LineAmount := CurrentLineAmount;
                                    LineDiscount := 0;
                                    PostingDesc := GenJnlLine2.Description;
                                  end else
                                    case BalancingType of
                                      Balancingtype::"G/L Account":
                                        begin
                                          DocNo := GenJnlLine2."Document No.";
                                          ExtDocNo := GenJnlLine2."External Document No.";
                                          LineAmount := CurrentLineAmount;
                                          LineDiscount := 0;
                                          PostingDesc := GenJnlLine2.Description;
                                        end;
                                      Balancingtype::Customer:
                                        begin
                                          CustLedgEntry.Reset;
                                          CustLedgEntry.SetCurrentkey("Document No.");
                                          CustLedgEntry.SetRange("Document Type",GenJnlLine2."Applies-to Doc. Type");
                                          CustLedgEntry.SetRange("Document No.",GenJnlLine2."Applies-to Doc. No.");
                                          CustLedgEntry.SetRange("Customer No.",BalancingNo);
                                          CustLedgEntry.Find('-');
                                          CustUpdateAmounts(CustLedgEntry,CurrentLineAmount);
                                          LineAmount := CurrentLineAmount;
                                        end;
                                      Balancingtype::Vendor:
                                        begin
                                          VendLedgEntry.Reset;
                                          VendLedgEntry.SetCurrentkey("Document No.");
                                          VendLedgEntry.SetRange("Document Type",GenJnlLine2."Applies-to Doc. Type");
                                          VendLedgEntry.SetRange("Document No.",GenJnlLine2."Applies-to Doc. No.");
                                          VendLedgEntry.SetRange("Vendor No.",BalancingNo);
                                          VendLedgEntry.Find('-');
                                          VendUpdateAmounts(VendLedgEntry,CurrentLineAmount);
                                          LineAmount := CurrentLineAmount;
                                        end;
                                      Balancingtype::"Bank Account":
                                        begin
                                          DocNo := GenJnlLine2."Document No.";
                                          ExtDocNo := GenJnlLine2."External Document No.";
                                          LineAmount := CurrentLineAmount;
                                          LineDiscount := 0;
                                          PostingDesc := GenJnlLine2.Description;
                                        end;
                                    end;

                                  FoundLast := GenJnlLine2.Next = 0;
                                end;
                            end;

                          TotalLineAmount := TotalLineAmount + CurrentLineAmount;
                          TotalLineDiscount := TotalLineDiscount + LineDiscount;
                        end else begin
                          if FoundLast then
                            CurrReport.Break;
                          FoundLast := true;
                          DocNo := Text010;
                          ExtDocNo := Text010;
                          LineAmount := 0;
                          LineDiscount := 0;
                          PostingDesc := '';
                        end;

                        if DocNo = '' then
                          CurrencyCode2 := GenJnlLine."Currency Code";

                        Stub2LineNo := Stub2LineNo + 1;
                        //CS 04/08/21: Gen. Jnl Line table is allowing 50, but Stub2LineNo is at 30. Doing this as a temp fix.
                        Stub2DocNo[Stub2LineNo] := CopyStr(DocNo,1,30);
                        Stub2DocDate[Stub2LineNo] := DocDate;
                        Stub2LineAmount[Stub2LineNo] := LineAmount;
                        Stub2LineDiscount[Stub2LineNo] := LineDiscount;
                        Stub2PostingDesc[Stub2LineNo] := PostingDesc;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if not TestPrint then
                          if FirstPage then begin
                            FoundLast := true;
                            case ApplyMethod of
                              Applymethod::OneLineOneEntry:
                                FoundLast := false;
                              Applymethod::OneLineID:
                                case BalancingType of
                                  Balancingtype::Customer:
                                    begin
                                      CustLedgEntry.Reset;
                                      CustLedgEntry.SetCurrentkey("Customer No.",Open,Positive);
                                      CustLedgEntry.SetRange("Customer No.",BalancingNo);
                                      CustLedgEntry.SetRange(Open,true);
                                      CustLedgEntry.SetRange(Positive,true);
                                      CustLedgEntry.SetRange("Applies-to ID",GenJnlLine."Applies-to ID");
                                      FoundLast := not CustLedgEntry.Find('-');
                                      if FoundLast then begin
                                        CustLedgEntry.SetRange(Positive,false);
                                        FoundLast := not CustLedgEntry.Find('-');
                                        FoundNegative := true;
                                      end else
                                        FoundNegative := false;
                                    end;
                                  Balancingtype::Vendor:
                                    begin
                                      VendLedgEntry.Reset;
                                      VendLedgEntry.SetCurrentkey("Vendor No.",Open,Positive);
                                      VendLedgEntry.SetRange("Vendor No.",BalancingNo);
                                      VendLedgEntry.SetRange(Open,true);
                                      VendLedgEntry.SetRange(Positive,true);
                                      VendLedgEntry.SetRange("Applies-to ID",GenJnlLine."Applies-to ID");
                                      FoundLast := not VendLedgEntry.Find('-');
                                      if FoundLast then begin
                                        VendLedgEntry.SetRange(Positive,false);
                                        FoundLast := not VendLedgEntry.Find('-');
                                        FoundNegative := true;
                                      end else
                                        FoundNegative := false;
                                    end;
                                end;
                              Applymethod::MoreLinesOneEntry:
                                FoundLast := false;
                            end;
                          end else
                            FoundLast := false;

                        if PreprintedStub then begin
                          TotalText := '';
                        end else begin
                          TotalText := Text019;
                          Stub2DocNoHeader := USText011;
                          Stub2DocDateHeader := USText012;
                          Stub2AmountHeader := USText013;
                          Stub2DiscountHeader := USText014;
                          Stub2NetAmountHeader := USText015;
                          Stub2PostingDescHeader := USText017;
                        end;
                        GLSetup.Get;
                        PageNo := PageNo + 1;
                    end;
                }
                dataitem(PrintCheck;"Integer")
                {
                    DataItemTableView = sorting(Number);
                    MaxIteration = 1;
                    column(ReportForNavId_3931; 3931)
                    {
                    }
                    column(PrnChkCheckToAddr_CheckStyle__CA_5_;PrnChkCheckToAddr[Checkstyle::CA,5])
                    {
                    }
                    column(PrnChkCheckToAddr_CheckStyle__CA_4_;PrnChkCheckToAddr[Checkstyle::CA,4])
                    {
                    }
                    column(PrnChkCheckToAddr_CheckStyle__CA_3_;PrnChkCheckToAddr[Checkstyle::CA,3])
                    {
                    }
                    column(PrnChkCheckToAddr_CheckStyle__CA_2_;PrnChkCheckToAddr[Checkstyle::CA,2])
                    {
                    }
                    column(PrnChkCheckToAddr_CheckStyle__CA_1_;PrnChkCheckToAddr[Checkstyle::CA,1])
                    {
                    }
                    column(PrnChkCheckAmountText_CheckStyle__US_;PrnChkCheckAmountText[Checkstyle::US])
                    {
                    }
                    column(PrnChkCheckDateText_CheckStyle__US_;PrnChkCheckDateText[Checkstyle::US])
                    {
                    }
                    column(PrnChkDescriptionLine_CheckStyle__US_2_;PrnChkDescriptionLine[Checkstyle::US,2])
                    {
                    }
                    column(PrnChkDescriptionLine_CheckStyle__US_1_;PrnChkDescriptionLine[Checkstyle::US,1])
                    {
                    }
                    column(PrnChkCheckToAddr_CheckStyle__US_1_;PrnChkCheckToAddr[Checkstyle::US,1])
                    {
                    }
                    column(PrnChkCheckToAddr_CheckStyle__US_2_;PrnChkCheckToAddr[Checkstyle::US,2])
                    {
                    }
                    column(PrnChkCheckToAddr_CheckStyle__US_4_;PrnChkCheckToAddr[Checkstyle::US,4])
                    {
                    }
                    column(PrnChkCheckToAddr_CheckStyle__US_3_;PrnChkCheckToAddr[Checkstyle::US,3])
                    {
                    }
                    column(PrnChkCheckToAddr_CheckStyle__US_5_;PrnChkCheckToAddr[Checkstyle::US,5])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__US_4_;PrnChkCompanyAddr[Checkstyle::US,4])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__US_6_;PrnChkCompanyAddr[Checkstyle::US,6])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__US_5_;PrnChkCompanyAddr[Checkstyle::US,5])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__US_3_;PrnChkCompanyAddr[Checkstyle::US,3])
                    {
                    }
                    column(PrnChkCheckNoText_CheckStyle__US_;PrnChkCheckNoText[Checkstyle::US])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__US_2_;PrnChkCompanyAddr[Checkstyle::US,2])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__US_1_;PrnChkCompanyAddr[Checkstyle::US,1])
                    {
                    }
                    column(TotalLineAmount;TotalLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalText;TotalText)
                    {
                    }
                    column(PrnChkVoidText_CheckStyle__US_;PrnChkVoidText[Checkstyle::US])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__CA_1_;PrnChkCompanyAddr[Checkstyle::CA,1])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__CA_2_;PrnChkCompanyAddr[Checkstyle::CA,2])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__CA_3_;PrnChkCompanyAddr[Checkstyle::CA,3])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__CA_4_;PrnChkCompanyAddr[Checkstyle::CA,4])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__CA_5_;PrnChkCompanyAddr[Checkstyle::CA,5])
                    {
                    }
                    column(PrnChkCompanyAddr_CheckStyle__CA_6_;PrnChkCompanyAddr[Checkstyle::CA,6])
                    {
                    }
                    column(PrnChkDescriptionLine_CheckStyle__CA_1_;PrnChkDescriptionLine[Checkstyle::CA,1])
                    {
                    }
                    column(PrnChkDescriptionLine_CheckStyle__CA_2_;PrnChkDescriptionLine[Checkstyle::CA,2])
                    {
                    }
                    column(PrnChkCheckDateText_CheckStyle__CA_;PrnChkCheckDateText[Checkstyle::CA])
                    {
                    }
                    column(PrnChkDateIndicator_CheckStyle__CA_;PrnChkDateIndicator[Checkstyle::CA])
                    {
                    }
                    column(PrnChkCheckAmountText_CheckStyle__CA_;PrnChkCheckAmountText[Checkstyle::CA])
                    {
                    }
                    column(PrnChkVoidText_CheckStyle__CA_;PrnChkVoidText[Checkstyle::CA])
                    {
                    }
                    column(PrnChkCurrencyCode_CheckStyle__CA_;PrnChkCurrencyCode[Checkstyle::CA])
                    {
                    }
                    column(PrnChkCurrencyCode_CheckStyle__US_;PrnChkCurrencyCode[Checkstyle::US])
                    {
                    }
                    column(CheckNoText_Control1480000;CheckNoText)
                    {
                    }
                    column(CheckDateText_Control1480021;CheckDateText)
                    {
                    }
                    column(CheckToAddr_1__Control1480022;CheckToAddr[1])
                    {
                    }
                    column(Stub2DocNoHeader;Stub2DocNoHeader)
                    {
                    }
                    column(Stub2DocDateHeader;Stub2DocDateHeader)
                    {
                    }
                    column(Stub2AmountHeader;Stub2AmountHeader)
                    {
                    }
                    column(Stub2DiscountHeader;Stub2DiscountHeader)
                    {
                    }
                    column(Stub2NetAmountHeader;Stub2NetAmountHeader)
                    {
                    }
                    column(Stub2LineAmount_1_;Stub2LineAmount[1])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineDiscount_1_;Stub2LineDiscount[1])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineAmount_1____Stub2LineDiscount_1_;Stub2LineAmount[1] + Stub2LineDiscount[1])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2DocDate_1_;Stub2DocDate[1])
                    {
                    }
                    column(Stub2DocNo_1_;Stub2DocNo[1])
                    {
                    }
                    column(Stub2LineAmount_2_;Stub2LineAmount[2])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineDiscount_2_;Stub2LineDiscount[2])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineAmount_2____Stub2LineDiscount_2_;Stub2LineAmount[2] + Stub2LineDiscount[2])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2DocDate_2_;Stub2DocDate[2])
                    {
                    }
                    column(Stub2DocNo_2_;Stub2DocNo[2])
                    {
                    }
                    column(Stub2LineAmount_3_;Stub2LineAmount[3])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineDiscount_3_;Stub2LineDiscount[3])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineAmount_3____Stub2LineDiscount_3_;Stub2LineAmount[3] + Stub2LineDiscount[3])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2DocDate_3_;Stub2DocDate[3])
                    {
                    }
                    column(Stub2DocNo_3_;Stub2DocNo[3])
                    {
                    }
                    column(Stub2LineAmount_4_;Stub2LineAmount[4])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineDiscount_4_;Stub2LineDiscount[4])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineAmount_4____Stub2LineDiscount_4_;Stub2LineAmount[4] + Stub2LineDiscount[4])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2DocDate_4_;Stub2DocDate[4])
                    {
                    }
                    column(Stub2DocNo_4_;Stub2DocNo[4])
                    {
                    }
                    column(Stub2LineAmount_5_;Stub2LineAmount[5])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineDiscount_5_;Stub2LineDiscount[5])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineAmount_5____Stub2LineDiscount_5_;Stub2LineAmount[5] + Stub2LineDiscount[5])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2DocDate_5_;Stub2DocDate[5])
                    {
                    }
                    column(Stub2DocNo_5_;Stub2DocNo[5])
                    {
                    }
                    column(Stub2LineAmount_6_;Stub2LineAmount[6])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineDiscount_6_;Stub2LineDiscount[6])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineAmount_6____Stub2LineDiscount_6_;Stub2LineAmount[6] + Stub2LineDiscount[6])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2DocDate_6_;Stub2DocDate[6])
                    {
                    }
                    column(Stub2DocNo_6_;Stub2DocNo[6])
                    {
                    }
                    column(Stub2LineAmount_7_;Stub2LineAmount[7])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineDiscount_7_;Stub2LineDiscount[7])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineAmount_7____Stub2LineDiscount_7_;Stub2LineAmount[7] + Stub2LineDiscount[7])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2DocDate_7_;Stub2DocDate[7])
                    {
                    }
                    column(Stub2DocNo_7_;Stub2DocNo[7])
                    {
                    }
                    column(Stub2LineAmount_8_;Stub2LineAmount[8])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineDiscount_8_;Stub2LineDiscount[8])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineAmount_8____Stub2LineDiscount_8_;Stub2LineAmount[8] + Stub2LineDiscount[8])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2DocDate_8_;Stub2DocDate[8])
                    {
                    }
                    column(Stub2DocNo_8_;Stub2DocNo[8])
                    {
                    }
                    column(Stub2LineAmount_9_;Stub2LineAmount[9])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineDiscount_9_;Stub2LineDiscount[9])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineAmount_9____Stub2LineDiscount_9_;Stub2LineAmount[9] + Stub2LineDiscount[9])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2DocDate_9_;Stub2DocDate[9])
                    {
                    }
                    column(Stub2DocNo_9_;Stub2DocNo[9])
                    {
                    }
                    column(Stub2LineAmount_10_;Stub2LineAmount[10])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineDiscount_10_;Stub2LineDiscount[10])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2LineAmount_10____Stub2LineDiscount_10_;Stub2LineAmount[10] + Stub2LineDiscount[10])
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Stub2DocDate_10_;Stub2DocDate[10])
                    {
                    }
                    column(Stub2DocNo_10_;Stub2DocNo[10])
                    {
                    }
                    column(TotalLineAmount_Control1480082;TotalLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalText_Control1480083;TotalText)
                    {
                    }
                    column(Stub2PostingDescHeader;Stub2PostingDescHeader)
                    {
                    }
                    column(Stub2PostingDesc_1_;Stub2PostingDesc[1])
                    {
                    }
                    column(Stub2PostingDesc_2_;Stub2PostingDesc[2])
                    {
                    }
                    column(Stub2PostingDesc_4_;Stub2PostingDesc[4])
                    {
                    }
                    column(Stub2PostingDesc_3_;Stub2PostingDesc[3])
                    {
                    }
                    column(Stub2PostingDesc_8_;Stub2PostingDesc[8])
                    {
                    }
                    column(Stub2PostingDesc_7_;Stub2PostingDesc[7])
                    {
                    }
                    column(Stub2PostingDesc_6_;Stub2PostingDesc[6])
                    {
                    }
                    column(Stub2PostingDesc_5_;Stub2PostingDesc[5])
                    {
                    }
                    column(Stub2PostingDesc_10_;Stub2PostingDesc[10])
                    {
                    }
                    column(Stub2PostingDesc_9_;Stub2PostingDesc[9])
                    {
                    }
                    column(CheckToAddr_5_;CheckToAddr[5])
                    {
                    }
                    column(CheckToAddr_4_;CheckToAddr[4])
                    {
                    }
                    column(CheckToAddr_3_;CheckToAddr[3])
                    {
                    }
                    column(CheckToAddr_2_;CheckToAddr[2])
                    {
                    }
                    column(CheckToAddr_01_;CheckToAddr[1])
                    {
                    }
                    column(VoidText;VoidText)
                    {
                    }
                    column(BankCurrencyCode;BankCurrencyCode)
                    {
                    }
                    column(DollarSignBefore_CheckAmountText_DollarSignAfter;DollarSignBefore + CheckAmountText + DollarSignAfter)
                    {
                    }
                    column(DescriptionLine_1__;DescriptionLine[1])
                    {
                    }
                    column(DescriptionLine_2__;DescriptionLine[2])
                    {
                    }
                    column(DateIndicator;DateIndicator)
                    {
                    }
                    column(CheckDateText_Control1020013;CheckDateText)
                    {
                    }
                    column(CheckNoText_Control1020014;CheckNoText)
                    {
                    }
                    column(CompanyAddr_6_;CompanyAddr[6])
                    {
                    }
                    column(CompanyAddr_5_;CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_4_;CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_3_;CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_2_;CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_1_;CompanyAddr[1])
                    {
                    }
                    column(CheckStyleIndex;CheckStyleIndex)
                    {
                    }
                    column(CompanyAddr_7_;CompanyAddr[7])
                    {
                    }
                    column(PrintCheck_Number;Number)
                    {
                    }
                    column(CheckNoText_Control1480000Caption;CheckNoText_Control1480000CaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        Decimals: Decimal;
                    begin
                        if not TestPrint then
                          with GenJnlLine do begin
                            CheckLedgEntry.Init;
                            CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                            CheckLedgEntry."Posting Date" := "Posting Date";
                            CheckLedgEntry."Document Type" := "Document Type";
                            CheckLedgEntry."Document No." := UseCheckNo;
                            CheckLedgEntry.Description := CheckToAddr[1];
                            CheckLedgEntry."Bank Payment Type" := "Bank Payment Type";
                            CheckLedgEntry."Bal. Account Type" := BalancingType;
                            CheckLedgEntry."Bal. Account No." := BalancingNo;
                            if FoundLast then begin
                              if TotalLineAmount < 0 then
                                Error(
                                  Text020,
                                  UseCheckNo,TotalLineAmount);
                              CheckLedgEntry."Entry Status" := CheckLedgEntry."entry status"::Printed;
                              CheckLedgEntry.Amount := TotalLineAmount;
                            end else begin
                              CheckLedgEntry."Entry Status" := CheckLedgEntry."entry status"::Voided;
                              CheckLedgEntry.Amount := 0;
                            end;
                            CheckLedgEntry."Check Date" := "Posting Date";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry);

                            if FoundLast then begin
                              if BankAcc2."Currency Code" <> '' then
                                Currency.Get(BankAcc2."Currency Code")
                              else
                                Currency.InitRoundingPrecision;
                              Decimals := CheckLedgEntry.Amount - ROUND(CheckLedgEntry.Amount,1,'<');
                              if StrLen(Format(Decimals)) < StrLen(Format(Currency."Amount Rounding Precision")) then
                                if Decimals = 0 then
                                  begin
                                  //<ANICA 7-21-05 LCC Remove padding at end of string text
                                  //CheckAmountText := FORMAT(CheckLedgEntry.Amount,0,0) +
                                  //  COPYSTR(FORMAT(0.01),2,1) +
                                  //  PADSTR('',STRLEN(FORMAT(Currency."Amount Rounding Precision")) - 2,'0')
                                  //>ANICA
                                  CheckAmountText := Format(CheckLedgEntry.Amount,0,0);
                                  end
                                else
                                  begin
                                  //ANICA 7-21-05 LCC Remove padding at end of string text
                                  //CheckAmountText := FORMAT(CheckLedgEntry.Amount,0,0) +
                                  //  PADSTR('',STRLEN(FORMAT(Currency."Amount Rounding Precision")) - STRLEN(FORMAT(Decimals)),'0')
                                  //>ANICA
                                  CheckAmountText := Format(CheckLedgEntry.Amount,0,0);
                                  end
                              else
                                CheckAmountText := Format(CheckLedgEntry.Amount,0,0);
                              if CheckLanguage = 3084 then begin   // French
                                DollarSignBefore := '';
                                DollarSignAfter := Currency.Symbol;
                              end else begin
                                DollarSignBefore := Currency.Symbol;
                                DollarSignAfter := ' ';
                              end;
                              if not ChkTransMgt.FormatNoText(DescriptionLine,CheckLedgEntry.Amount,CheckLanguage,BankAcc2."Currency Code") then
                                Error(DescriptionLine[1]);
                              VoidText := '';
                            end else begin
                              Clear(CheckAmountText);
                              Clear(DescriptionLine);
                              DescriptionLine[1] := Text021;
                              DescriptionLine[2] := DescriptionLine[1];
                              VoidText := Text022;
                            end;
                          end
                        else
                          with GenJnlLine do begin
                            CheckLedgEntry.Init;
                            CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                            CheckLedgEntry."Posting Date" := "Posting Date";
                            CheckLedgEntry."Document No." := UseCheckNo;
                            CheckLedgEntry.Description := Text023;
                            CheckLedgEntry."Bank Payment Type" := "bank payment type"::"Computer Check";
                            CheckLedgEntry."Entry Status" := CheckLedgEntry."entry status"::"Test Print";
                            CheckLedgEntry."Check Date" := "Posting Date";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry);

                            CheckAmountText := Text024;
                            DescriptionLine[1] := Text025;
                            DescriptionLine[2] := DescriptionLine[1];
                            VoidText := Text022;
                          end;

                        ChecksPrinted := ChecksPrinted + 1;
                        FirstPage := false;

                        Clear(PrnChkCompanyAddr);
                        Clear(PrnChkCheckToAddr);
                        Clear(PrnChkCheckNoText);
                        Clear(PrnChkCheckDateText);
                        Clear(PrnChkDescriptionLine);
                        Clear(PrnChkVoidText);
                        Clear(PrnChkDateIndicator);
                        Clear(PrnChkCurrencyCode);
                        Clear(PrnChkCheckAmountText);
                        CopyArray(PrnChkCompanyAddr[CheckStyle],CompanyAddr,1);
                        CopyArray(PrnChkCheckToAddr[CheckStyle],CheckToAddr,1);
                        PrnChkCheckNoText[CheckStyle] := CheckNoText;
                        PrnChkCheckDateText[CheckStyle] := CheckDateText;
                        CopyArray(PrnChkDescriptionLine[CheckStyle],DescriptionLine,1);
                        PrnChkVoidText[CheckStyle] := VoidText;
                        PrnChkDateIndicator[CheckStyle] := DateIndicator;
                        PrnChkCurrencyCode[CheckStyle] := BankAcc2."Currency Code";
                        StartingLen := StrLen(CheckAmountText);
                        if CheckStyle = Checkstyle::US then
                          ControlLen := 27
                        else
                          ControlLen := 29;
                        CheckAmountText := CheckAmountText + DollarSignBefore + DollarSignAfter;
                        Index := 0;
                        if CheckAmountText = Text024 then begin
                          if StrLen(CheckAmountText) < (ControlLen - 12) then begin
                            repeat
                              Index := Index + 1;
                              CheckAmountText := InsStr(CheckAmountText,'*',StrLen(CheckAmountText) + 1);
                            until (Index = ControlLen) or (StrLen(CheckAmountText) >= (ControlLen - 12))
                          end;
                        end else
                          if StrLen(CheckAmountText) < (ControlLen - 11) then begin
                            repeat
                              Index := Index + 1;
                              CheckAmountText := InsStr(CheckAmountText,'*',StrLen(CheckAmountText) + 1);
                            until (Index = ControlLen) or (StrLen(CheckAmountText) >= (ControlLen - 11))
                          end;
                        CheckAmountText :=
                          DelStr(CheckAmountText,StartingLen + 1,StrLen(DollarSignBefore + DollarSignAfter));
                        NewLen := StrLen(CheckAmountText);
                        if NewLen <> StartingLen then
                          CheckAmountText :=
                            CopyStr(CheckAmountText,StartingLen + 1) +
                            CopyStr(CheckAmountText,1,StartingLen);
                        PrnChkCheckAmountText[CheckStyle] :=
                          DollarSignBefore + CheckAmountText + DollarSignAfter;


                        if CheckStyle = Checkstyle::CA then
                          CheckStyleIndex := 0
                        else
                          CheckStyleIndex := 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if FoundLast then
                      CurrReport.Break;

                    UseCheckNo := IncStr(UseCheckNo);
                    if not TestPrint then
                      CheckNoText := UseCheckNo
                    else
                      CheckNoText := Text011;

                    Stub2LineNo := 0;
                    Clear(Stub2DocNo);
                    Clear(Stub2DocDate);
                    Clear(Stub2LineAmount);
                    Clear(Stub2LineDiscount);
                    Clear(Stub2PostingDesc);
                    Stub2DocNoHeader := '';
                    Stub2DocDateHeader := '';
                    Stub2AmountHeader := '';
                    Stub2DiscountHeader := '';
                    Stub2NetAmountHeader := '';
                    Stub2PostingDescHeader := '';
                end;

                trigger OnPostDataItem()
                begin
                    if not TestPrint then begin
                      if UseCheckNo <> GenJnlLine."Document No." then begin
                        GenJnlLine3.Reset;
                        GenJnlLine3.SetCurrentkey("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
                        GenJnlLine3.SetRange("Journal Template Name",GenJnlLine."Journal Template Name");
                        GenJnlLine3.SetRange("Journal Batch Name",GenJnlLine."Journal Batch Name");
                        GenJnlLine3.SetRange("Posting Date",GenJnlLine."Posting Date");
                        GenJnlLine3.SetRange("Document No.",UseCheckNo);
                        if GenJnlLine3.Find('-') then
                          GenJnlLine3.FieldError("Document No.",StrSubstNo(Text013,UseCheckNo));
                      end;

                      if ApplyMethod <> Applymethod::MoreLinesOneEntry then begin
                        GenJnlLine3 := GenJnlLine;
                        GenJnlLine3.TestField("Posting No. Series",'');
                        GenJnlLine3."Document No." := UseCheckNo;
                        GenJnlLine3."Check Printed" := true;
                        GenJnlLine3.Modify;
                      end else begin
                        "TotalLineAmount$" := 0;
                        if GenJnlLine2.Find('-') then begin
                          HighestLineNo := GenJnlLine2."Line No.";
                          repeat
                            if BankAcc2."Currency Code" <> GenJnlLine2."Currency Code" then
                              Error(Text005);
                            if GenJnlLine2."Line No." > HighestLineNo then
                              HighestLineNo := GenJnlLine2."Line No.";
                            GenJnlLine3 := GenJnlLine2;
                            GenJnlLine3.TestField("Posting No. Series",'');
                            GenJnlLine3."Bal. Account No." := '';
                            GenJnlLine3."Bank Payment Type" := GenJnlLine3."bank payment type"::" ";
                            GenJnlLine3."Document No." := UseCheckNo;
                            GenJnlLine3."Check Printed" := true;
                            GenJnlLine3.Validate(Amount);
                            "TotalLineAmount$" := "TotalLineAmount$" + GenJnlLine3."Amount (LCY)";
                            GenJnlLine3.Modify;
                          until GenJnlLine2.Next = 0;
                        end;

                        GenJnlLine3.Reset;
                        GenJnlLine3 := GenJnlLine;
                        GenJnlLine3.SetRange("Journal Template Name",GenJnlLine."Journal Template Name");
                        GenJnlLine3.SetRange("Journal Batch Name",GenJnlLine."Journal Batch Name");
                        GenJnlLine3."Line No." := HighestLineNo;
                        if GenJnlLine3.Next = 0 then
                          GenJnlLine3."Line No." := HighestLineNo + 10000
                        else begin
                          while GenJnlLine3."Line No." = HighestLineNo + 1 do begin
                            HighestLineNo := GenJnlLine3."Line No.";
                            if GenJnlLine3.Next = 0 then
                              GenJnlLine3."Line No." := HighestLineNo + 20000;
                          end;
                          GenJnlLine3."Line No." := (GenJnlLine3."Line No." + HighestLineNo) DIV 2;
                        end;
                        GenJnlLine3.Init;
                        GenJnlLine3.Validate("Posting Date",GenJnlLine."Posting Date");
                        GenJnlLine3."Document Type" := GenJnlLine."Document Type";
                        GenJnlLine3."Document No." := UseCheckNo;
                        GenJnlLine3."Account Type" := GenJnlLine3."account type"::"Bank Account";
                        GenJnlLine3.Validate("Account No.",BankAcc2."No.");
                        if BalancingType <> Balancingtype::"G/L Account" then
                          GenJnlLine3.Description := StrSubstNo(Text014,SelectStr(BalancingType + 1,Text062),BalancingNo);
                        GenJnlLine3.Validate(Amount,-TotalLineAmount);
                        if TotalLineAmount <> "TotalLineAmount$" then
                          GenJnlLine3.Validate("Amount (LCY)",-"TotalLineAmount$");
                        GenJnlLine3."Bank Payment Type" := GenJnlLine3."bank payment type"::"Computer Check";
                        GenJnlLine3."Check Printed" := true;
                        GenJnlLine3."Source Code" := GenJnlLine."Source Code";
                        GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
                        GenJnlLine3."Allow Zero-Amount Posting" := true;
                        //<<ANICA 10-6-15 Set Department for Main Account to be ANICA
                        //GenJnlLine3."Shortcut Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
                        GenJnlLine3."Shortcut Dimension 1 Code" := 'ANICA';
                        //>>ANICA
                        GenJnlLine3."Shortcut Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
                        GenJnlLine3."Dimension Set ID" := GenJnlLine."Dimension Set ID";
                        GenJnlLine3.Insert;
                      end;
                    end;

                    BankAcc2."Last Check No." := UseCheckNo;
                    BankAcc2.Modify;
                    if CommitEachCheck then begin
                      Commit;
                      Clear(CheckManagement);
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    FirstPage := true;
                    FoundLast := false;
                    TotalLineAmount := 0;
                    TotalLineDiscount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if OneCheckPrVendor and ("Currency Code" <> '') and
                   ("Currency Code" <> Currency.Code)
                then begin
                  Currency.Get("Currency Code");
                  Currency.TestField("Conv. LCY Rndg. Debit Acc.");
                  Currency.TestField("Conv. LCY Rndg. Credit Acc.");
                end;

                if not TestPrint then begin
                  if Amount = 0 then
                    CurrReport.Skip;

                  TestField("Bal. Account Type","bal. account type"::"Bank Account");
                  if "Bal. Account No." <> BankAcc2."No." then
                    CurrReport.Skip;

                  if ("Account No." <> '') and ("Bal. Account No." <> '') then begin
                    BalancingType := "Account Type";
                    BalancingNo := "Account No.";
                    RemainingAmount := Amount;
                    if OneCheckPrVendor then begin
                      ApplyMethod := Applymethod::MoreLinesOneEntry;
                      GenJnlLine2.Reset;
                      GenJnlLine2.SetCurrentkey("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
                      GenJnlLine2.SetRange("Journal Template Name","Journal Template Name");
                      GenJnlLine2.SetRange("Journal Batch Name","Journal Batch Name");
                      GenJnlLine2.SetRange("Posting Date","Posting Date");
                      GenJnlLine2.SetRange("Document No.","Document No.");
                      GenJnlLine2.SetRange("Account Type","Account Type");
                      GenJnlLine2.SetRange("Account No.","Account No.");
                      GenJnlLine2.SetRange("Bal. Account Type","Bal. Account Type");
                      GenJnlLine2.SetRange("Bal. Account No.","Bal. Account No.");
                      GenJnlLine2.SetRange("Bank Payment Type","Bank Payment Type");
                      GenJnlLine2.Find('-');
                      RemainingAmount := 0;
                    end else
                      if "Applies-to Doc. No." <> '' then
                        ApplyMethod := Applymethod::OneLineOneEntry
                      else
                        if "Applies-to ID" <> '' then
                          ApplyMethod := Applymethod::OneLineID
                        else
                          ApplyMethod := Applymethod::Payment;
                  end else
                    if "Account No." = '' then
                      FieldError("Account No.",Text004)
                    else
                      FieldError("Bal. Account No.",Text004);

                  Clear(CheckToAddr);
                  Clear(SalesPurchPerson);
                  case BalancingType of
                    Balancingtype::"G/L Account":
                      begin
                        CheckToAddr[1] := Description;
                        SetCheckPrintParams(
                          BankAcc2."Check Date Format",
                          BankAcc2."Check Date Separator",
                          BankAcc2."Country/Region Code",
                          BankAcc2."Bank Communication");
                      end;
                    Balancingtype::Customer:
                      begin
                        Cust.Get(BalancingNo);
                        if Cust.Blocked = Cust.Blocked::All then
                          Error(Text064,Cust.FieldCaption(Blocked),Cust.Blocked,Cust.TableCaption,Cust."No.");
                        Cust.Contact := '';
                        FormatAddr.Customer(CheckToAddr,Cust);
                        if BankAcc2."Currency Code" <> "Currency Code" then
                          Error(Text005);
                        if Cust."Salesperson Code" <> '' then
                          SalesPurchPerson.Get(Cust."Salesperson Code");
                        SetCheckPrintParams(
                          Cust."Check Date Format",
                          Cust."Check Date Separator",
                          BankAcc2."Country/Region Code",
                          Cust."Bank Communication");
                      end;
                    Balancingtype::Vendor:
                      begin
                        Vend.Get(BalancingNo);
                        if Vend.Blocked in [Vend.Blocked::All,Vend.Blocked::Payment] then
                          Error(Text064,Vend.FieldCaption(Blocked),Vend.Blocked,Vend.TableCaption,Vend."No.");
                        Vend.Contact := '';
                        FormatAddr.Vendor(CheckToAddr,Vend);
                        if BankAcc2."Currency Code" <> "Currency Code" then
                          Error(Text005);
                        if Vend."Purchaser Code" <> '' then
                          SalesPurchPerson.Get(Vend."Purchaser Code");
                        SetCheckPrintParams(
                          Vend."Check Date Format",
                          Vend."Check Date Separator",
                          BankAcc2."Country/Region Code",
                          Vend."Bank Communication");
                      end;
                    Balancingtype::"Bank Account":
                      begin
                        BankAcc.Get(BalancingNo);
                        BankAcc.TestField(Blocked,false);
                        BankAcc.Contact := '';
                        FormatAddr.BankAcc(CheckToAddr,BankAcc);
                        if BankAcc2."Currency Code" <> BankAcc."Currency Code" then
                          Error(Text008);
                        if BankAcc."Our Contact Code" <> '' then
                          SalesPurchPerson.Get(BankAcc."Our Contact Code");
                        SetCheckPrintParams(
                          BankAcc."Check Date Format",
                          BankAcc."Check Date Separator",
                          BankAcc2."Country/Region Code",
                          BankAcc."Bank Communication");
                      end;
                  end;

                  CheckDateText :=
                    ChkTransMgt.FormatDate("Posting Date",CheckDateFormat,DateSeparator,CheckLanguage,DateIndicator);
                //ANICA LC 7-20-15
                //Get a variable that we can use for the check date
                VCheckDate := GenJnlLine2."Posting Date";
                //ANICA
                end else begin
                  if ChecksPrinted > 0 then
                    CurrReport.Break;
                  SetCheckPrintParams(
                    BankAcc2."Check Date Format",
                    BankAcc2."Check Date Separator",
                    BankAcc2."Country/Region Code",
                    BankAcc2."Bank Communication");
                  BalancingType := Balancingtype::Vendor;
                  BalancingNo := Text010;
                  Clear(CheckToAddr);
                  for i := 1 to 5 do
                    CheckToAddr[i] := Text003;
                  Clear(SalesPurchPerson);
                  CheckNoText := Text011;
                  if CheckStyle = Checkstyle::CA then
                    CheckDateText := DateIndicator
                  else
                    CheckDateText := Text010;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Copy(VoidGenJnlLine);
                CompanyInfo.Get;
                if not TestPrint then begin
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                  BankAcc2.Get(BankAcc2."No.");
                  BankAcc2.TestField(Blocked,false);
                  Copy(VoidGenJnlLine);
                  SetRange("Bank Payment Type","bank payment type"::"Computer Check");
                  SetRange("Check Printed",false);
                end else begin
                  Clear(CompanyAddr);
                  for i := 1 to 5 do
                    CompanyAddr[i] := Text003;
                end;
                ChecksPrinted := 0;

                SetRange("Account Type","account type"::"Fixed Asset");
                if Find('-') then
                  FieldError("Account Type");
                SetRange("Account Type");
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
                    field(BankAccount;BankAcc2."No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bank Account';
                        TableRelation = "Bank Account";

                        trigger OnValidate()
                        begin
                            if BankAcc2."No." <> '' then begin
                              BankAcc2.Get(BankAcc2."No.");
                              BankAcc2.TestField("Last Check No.");
                              UseCheckNo := BankAcc2."Last Check No.";
                            end;
                        end;
                    }
                    field(UseCheckNo;UseCheckNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Last Check No.';
                    }
                    field(OneCheckPerVendorPerDocumentNo;OneCheckPrVendor)
                    {
                        ApplicationArea = Basic;
                        Caption = 'One Check per Vendor per Document No.';
                        MultiLine = true;
                    }
                    field(ReprintChecks;ReprintChecks)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Reprint Checks';
                    }
                    field(TestPrint;TestPrint)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Test Print';
                    }
                    field(PreprintedStub;PreprintedStub)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Preprinted Stub';
                    }
                    field(CommitEachCheck;CommitEachCheck)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Commit Each Check';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if BankAcc2."No." <> '' then
              if BankAcc2.Get(BankAcc2."No.") then
                UseCheckNo := BankAcc2."Last Check No."
              else begin
                BankAcc2."No." := '';
                UseCheckNo := '';
              end;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GenJnlTemplate.Get(VoidGenJnlLine.GetFilter("Journal Template Name"));
        if not GenJnlTemplate."Force Doc. Balance" then
          if not Confirm(USText001,true) then
            Error(USText002);

        PageNo := 0;
    end;

    var
        Text000: label 'Preview is not allowed.';
        Text001: label 'Last Check No. must be filled in.';
        Text002: label 'Filters on %1 and %2 are not allowed.';
        Text003: label 'XXXXXXXXXXXXXXXX';
        Text004: label 'must be entered.';
        Text005: label 'The Bank Account and the General Journal Line must have the same currency.';
        Text008: label 'Both Bank Accounts must have the same currency.';
        Text010: label 'XXXXXXXXXX';
        Text011: label 'XXXX';
        Text013: label '%1 already exists.';
        Text014: label 'Check for %1 %2';
        Text016: label 'In the Check report, One Check per Vendor and Document No.\';
        Text017: label 'must not be activated when Applies-to ID is specified in the journal lines.';
        Text019: label 'Total';
        Text020: label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: label 'NON-NEGOTIABLE';
        Text023: label 'Test print';
        Text024: label 'XXXX.XX';
        Text025: label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text030: label ' is already applied to %1 %2 for customer %3.';
        Text031: label ' is already applied to %1 %2 for vendor %3.';
        CompanyInfo: Record "Company Information";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        Cust: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        CheckLedgEntry: Record "Check Ledger Entry";
        Currency: Record Currency;
        GenJnlTemplate: Record "Gen. Journal Template";
        WindowsLang: Record "Windows Language";
        FormatAddr: Codeunit "Format Address";
        CheckManagement: Codeunit CheckManagement;
        ChkTransMgt: Report "Check Translation Management";
        CompanyAddr: array [8] of Text[50];
        CheckToAddr: array [8] of Text[50];
        BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingNo: Code[20];
        CheckNoText: Text[30];
        CheckDateText: Text[30];
        CheckAmountText: Text[30];
        DescriptionLine: array [2] of Text[80];
        DocNo: Text[50];
        ExtDocNo: Text[50];
        VoidText: Text[50];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        "TotalLineAmount$": Decimal;
        TotalLineDiscount: Decimal;
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        UseCheckNo: Code[20];
        FoundLast: Boolean;
        ReprintChecks: Boolean;
        TestPrint: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        CommitEachCheck: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        PreprintedStub: Boolean;
        TotalText: Text[10];
        DocDate: Date;
        i: Integer;
        CurrencyCode2: Code[10];
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        LineAmount2: Decimal;
        GLSetup: Record "General Ledger Setup";
        Text064: label '%1 must not be %2 for %3 %4.';
        Text062: label 'G/L Account,Customer,Vendor,Bank Account';
        USText001: label 'Warning:  Checks cannot be financially voided when Force Doc. Balance is set to No in the Journal Template.  Do you want to continue anyway?';
        USText002: label 'Process canceled at user request.';
        USText004: label 'Last Check No. must include at least one digit, so that it can be incremented.';
        USText005: label '%1 language is not enabled. %2 is set up for checks in %1.';
        DateIndicator: Text[10];
        CheckDateFormat: Option " ","MM DD YYYY","DD MM YYYY","YYYY MM DD";
        CheckStyle: Option ,US,CA;
        CheckLanguage: Integer;
        DateSeparator: Option " ","-",".","/";
        DollarSignBefore: Code[5];
        DollarSignAfter: Code[5];
        PrnChkCompanyAddr: array [2,8] of Text[50];
        PrnChkCheckToAddr: array [2,8] of Text[50];
        PrnChkCheckNoText: array [2] of Text[30];
        PrnChkCheckDateText: array [2] of Text[30];
        PrnChkCheckAmountText: array [2] of Text[30];
        PrnChkDescriptionLine: array [2,2] of Text[80];
        PrnChkVoidText: array [2] of Text[30];
        PrnChkDateIndicator: array [2] of Text[10];
        PrnChkCurrencyCode: array [2] of Code[10];
        USText006: label 'You cannot use the <blank> %1 option with a Canadian style check. Please check %2 %3.';
        USText007: label 'You cannot use the Spanish %1 option with a Canadian style check. Please check %2 %3.';
        Stub2LineNo: Integer;
        Stub2DocNo: array [50] of Text[30];
        Stub2DocDate: array [50] of Date;
        Stub2LineAmount: array [50] of Decimal;
        Stub2LineDiscount: array [50] of Decimal;
        Stub2PostingDesc: array [50] of Text[50];
        Stub2DocNoHeader: Text[30];
        Stub2DocDateHeader: Text[30];
        Stub2AmountHeader: Text[30];
        Stub2DiscountHeader: Text[30];
        Stub2NetAmountHeader: Text[30];
        Stub2PostingDescHeader: Text[30];
        USText011: label 'Document No.';
        USText012: label 'Document Date';
        USText013: label 'Amount';
        USText014: label 'Discount';
        USText015: label 'Net Amount';
        PostingDesc: Text[50];
        USText017: label 'Posting Description';
        StartingLen: Integer;
        ControlLen: Integer;
        NewLen: Integer;
        CheckStyleIndex: Integer;
        Index: Integer;
        BankCurrencyCode: Text[30];
        PageNo: Integer;
        CheckNoTextCaptionLbl: label 'Check No.';
        LineAmountCaptionLbl: label 'Net Amount';
        LineDiscountCaptionLbl: label 'Discount';
        DocNoCaptionLbl: label 'Document No.';
        DocDateCaptionLbl: label 'Document Date';
        Posting_DescriptionCaptionLbl: label 'Posting Description';
        AmountCaptionLbl: label 'Amount';
        CheckNoText_Control1480000CaptionLbl: label 'Check No.';
        VCheckDate: Date;

    local procedure CustUpdateAmounts(var CustLedgEntry2: Record "Cust. Ledger Entry";RemainingAmount2: Decimal)
    begin
        if (ApplyMethod = Applymethod::OneLineOneEntry) or
           (ApplyMethod = Applymethod::MoreLinesOneEntry)
        then begin
          GenJnlLine3.Reset;
          GenJnlLine3.SetCurrentkey(
            "Account Type","Account No.","Applies-to Doc. Type","Applies-to Doc. No.");
          GenJnlLine3.SetRange("Account Type",GenJnlLine3."account type"::Customer);
          GenJnlLine3.SetRange("Account No.",CustLedgEntry2."Customer No.");
          GenJnlLine3.SetRange("Applies-to Doc. Type",CustLedgEntry2."Document Type");
          GenJnlLine3.SetRange("Applies-to Doc. No.",CustLedgEntry2."Document No.");
          if ApplyMethod = Applymethod::OneLineOneEntry then
            GenJnlLine3.SetFilter("Line No.",'<>%1',GenJnlLine."Line No.")
          else
            GenJnlLine3.SetFilter("Line No.",'<>%1',GenJnlLine2."Line No.");
          if CustLedgEntry2."Document Type" <> CustLedgEntry2."document type"::" " then
            if GenJnlLine3.Find('-') then
              GenJnlLine3.FieldError(
                "Applies-to Doc. No.",
                StrSubstNo(
                  Text030,
                  CustLedgEntry2."Document Type",CustLedgEntry2."Document No.",
                  CustLedgEntry2."Customer No."));
        end;

        DocNo := CustLedgEntry2."Document No.";
        ExtDocNo := CustLedgEntry2."External Document No.";
        DocDate := CustLedgEntry2."Document Date";
        PostingDesc := CustLedgEntry2.Description;

        CurrencyCode2 := CustLedgEntry2."Currency Code";
        CustLedgEntry2.CalcFields("Remaining Amount");

        LineAmount := -(CustLedgEntry2."Remaining Amount" - CustLedgEntry2."Remaining Pmt. Disc. Possible" -
                        CustLedgEntry2."Accepted Payment Tolerance");
        LineAmount2 :=
          ROUND(
            ExchangeAmt(CustLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,LineAmount),
            Currency."Amount Rounding Precision");
        if ((((CustLedgEntry2."Document Type" = CustLedgEntry2."document type"::Invoice) and
              (LineAmount2 >= RemainingAmount2)) or
             ((CustLedgEntry2."Document Type" = CustLedgEntry2."document type"::"Credit Memo") and
              (LineAmount2 <= RemainingAmount2))) and
            (GenJnlLine."Posting Date" <= CustLedgEntry2."Pmt. Discount Date")) or
           CustLedgEntry2."Accepted Pmt. Disc. Tolerance"
        then begin
          LineDiscount := -CustLedgEntry2."Remaining Pmt. Disc. Possible";
          if CustLedgEntry2."Accepted Payment Tolerance" <> 0 then
            LineDiscount := LineDiscount - CustLedgEntry2."Accepted Payment Tolerance";
        end else begin
          if RemainingAmount2 >=
             ROUND(
               -(ExchangeAmt(CustLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,
                   CustLedgEntry2."Remaining Amount")),Currency."Amount Rounding Precision")
          then
            LineAmount2 :=
              ROUND(
                -(ExchangeAmt(CustLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,
                    CustLedgEntry2."Remaining Amount")),Currency."Amount Rounding Precision")
          else begin
            LineAmount2 := RemainingAmount2;
            LineAmount :=
              ROUND(
                ExchangeAmt(CustLedgEntry2."Posting Date",CurrencyCode2,GenJnlLine."Currency Code",
                  LineAmount2),Currency."Amount Rounding Precision");
          end;
          LineDiscount := 0;
        end;
    end;

    local procedure VendUpdateAmounts(var VendLedgEntry2: Record "Vendor Ledger Entry";RemainingAmount2: Decimal)
    begin
        if (ApplyMethod = Applymethod::OneLineOneEntry) or
           (ApplyMethod = Applymethod::MoreLinesOneEntry)
        then begin
          GenJnlLine3.Reset;
          GenJnlLine3.SetCurrentkey(
            "Account Type","Account No.","Applies-to Doc. Type","Applies-to Doc. No.");
          GenJnlLine3.SetRange("Account Type",GenJnlLine3."account type"::Vendor);
          GenJnlLine3.SetRange("Account No.",VendLedgEntry2."Vendor No.");
          GenJnlLine3.SetRange("Applies-to Doc. Type",VendLedgEntry2."Document Type");
          GenJnlLine3.SetRange("Applies-to Doc. No.",VendLedgEntry2."Document No.");
          if ApplyMethod = Applymethod::OneLineOneEntry then
            GenJnlLine3.SetFilter("Line No.",'<>%1',GenJnlLine."Line No.")
          else
            GenJnlLine3.SetFilter("Line No.",'<>%1',GenJnlLine2."Line No.");
          if VendLedgEntry2."Document Type" <> VendLedgEntry2."document type"::" " then
            if GenJnlLine3.Find('-') then
              GenJnlLine3.FieldError(
                "Applies-to Doc. No.",
                StrSubstNo(
                  Text031,
                  VendLedgEntry2."Document Type",VendLedgEntry2."Document No.",
                  VendLedgEntry2."Vendor No."));
        end;

        DocNo := VendLedgEntry2."Document No.";
        ExtDocNo := VendLedgEntry2."External Document No.";
        DocNo := ExtDocNo;
        DocDate := VendLedgEntry2."Document Date";
        CurrencyCode2 := VendLedgEntry2."Currency Code";
        VendLedgEntry2.CalcFields("Remaining Amount");
        PostingDesc := VendLedgEntry2.Description;

        LineAmount := -(VendLedgEntry2."Remaining Amount" - VendLedgEntry2."Remaining Pmt. Disc. Possible" -
                        VendLedgEntry2."Accepted Payment Tolerance");

        LineAmount2 :=
          ROUND(
            ExchangeAmt(VendLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,LineAmount),
            Currency."Amount Rounding Precision");

        if ((((VendLedgEntry2."Document Type" = VendLedgEntry2."document type"::Invoice) and
              (LineAmount2 <= RemainingAmount2)) or
             ((VendLedgEntry2."Document Type" = VendLedgEntry2."document type"::"Credit Memo") and
              (LineAmount2 >= RemainingAmount2))) and
            (GenJnlLine."Posting Date" <= VendLedgEntry2."Pmt. Discount Date")) or
           VendLedgEntry2."Accepted Pmt. Disc. Tolerance"
        then begin
          LineDiscount := -VendLedgEntry2."Remaining Pmt. Disc. Possible";
          if VendLedgEntry2."Accepted Payment Tolerance" <> 0 then
            LineDiscount := LineDiscount - VendLedgEntry2."Accepted Payment Tolerance";
        end else begin
          if RemainingAmount2 >=
             ROUND(
               -(ExchangeAmt(VendLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,
                   VendLedgEntry2."Amount to Apply")),Currency."Amount Rounding Precision")
          then begin
            LineAmount2 :=
              ROUND(
                -(ExchangeAmt(VendLedgEntry2."Posting Date",GenJnlLine."Currency Code",CurrencyCode2,
                    VendLedgEntry2."Amount to Apply")),Currency."Amount Rounding Precision");
            LineAmount :=
              ROUND(
                ExchangeAmt(VendLedgEntry2."Posting Date",CurrencyCode2,GenJnlLine."Currency Code",
                  LineAmount2),Currency."Amount Rounding Precision");
          end else begin
            LineAmount2 := RemainingAmount2;
            LineAmount :=
              ROUND(
                ExchangeAmt(VendLedgEntry2."Posting Date",CurrencyCode2,GenJnlLine."Currency Code",
                  LineAmount2),Currency."Amount Rounding Precision");
          end;
          LineDiscount := 0;
        end;
    end;


    procedure InitializeRequest(BankAcc: Code[20];LastCheckNo: Code[20];NewOneCheckPrVend: Boolean;NewReprintChecks: Boolean;NewTestPrint: Boolean;NewPreprintedStub: Boolean)
    begin
        if BankAcc <> '' then
          if BankAcc2.Get(BankAcc) then begin
            UseCheckNo := LastCheckNo;
            OneCheckPrVendor := NewOneCheckPrVend;
            ReprintChecks := NewReprintChecks;
            TestPrint := NewTestPrint;
            PreprintedStub := NewPreprintedStub;
          end;
    end;


    procedure ExchangeAmt(PostingDate: Date;CurrencyCode: Code[10];CurrencyCode2: Code[10];Amount: Decimal) Amount2: Decimal
    begin
        if (CurrencyCode <> '') and (CurrencyCode2 = '') then
          Amount2 :=
            CurrencyExchangeRate.ExchangeAmtLCYToFCY(
              PostingDate,CurrencyCode,Amount,CurrencyExchangeRate.ExchangeRate(PostingDate,CurrencyCode))
        else
          if (CurrencyCode = '') and (CurrencyCode2 <> '') then
            Amount2 :=
              CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                PostingDate,CurrencyCode2,Amount,CurrencyExchangeRate.ExchangeRate(PostingDate,CurrencyCode2))
          else
            if (CurrencyCode <> '') and (CurrencyCode2 <> '') and (CurrencyCode <> CurrencyCode2) then
              Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(PostingDate,CurrencyCode2,CurrencyCode,Amount)
            else
              Amount2 := Amount;
    end;

    local procedure SetCheckPrintParams(NewDateFormat: Option " ","MM DD YYYY","DD MM YYYY","YYYY MM DD";NewDateSeparator: Option " ","-",".","/";NewCountryCode: Code[10];NewCheckLanguage: Option "E English","F French","S Spanish")
    begin
        CheckDateFormat := NewDateFormat;
        DateSeparator := NewDateSeparator;
        case NewCheckLanguage of
          Newchecklanguage::"E English":
            CheckLanguage := 4105;
          Newchecklanguage::"F French":
            CheckLanguage := 3084;
          Newchecklanguage::"S Spanish":
            CheckLanguage := 2058;
          else
            CheckLanguage := 1033;
        end;
        case NewCountryCode of
          CompanyInfo."US Country/Region Code":
            begin
              CheckStyle := Checkstyle::US;
              if CheckLanguage = 4105 then
                CheckLanguage := 1033;
            end;
          CompanyInfo."Canada Country/Region Code":
            begin
              CheckStyle := Checkstyle::CA;
              if CheckLanguage = 1033 then
                CheckLanguage := 4105;
            end;
          CompanyInfo."Mexico Country/Region Code":
            CheckStyle := Checkstyle::US;
          else
            CheckStyle := Checkstyle::US;
        end;
        if CheckLanguage <> WindowsLang."Language ID" then
          WindowsLang.Get(CheckLanguage);
        if not WindowsLang."Globally Enabled" then begin
          if CheckLanguage = 4105 then
            CheckLanguage := 1033
          else
            Error(USText005,WindowsLang.Name,CheckToAddr[1]);
        end;
    end;
}

