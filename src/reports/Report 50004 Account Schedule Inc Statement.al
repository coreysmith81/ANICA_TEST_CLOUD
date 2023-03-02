Report 50004 "Account Schedule Inc Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Account Schedule Inc Statement.rdlc';
    Caption = 'Account Schedule';

    dataset
    {
        dataitem(AccScheduleName;"Acc. Schedule Name")
        {
            DataItemTableView = sorting(Name);
            column(ReportForNavId_2151; 2151)
            {
            }
            column(AccScheduleName_Name;Name)
            {
            }
            dataitem(Heading;"Integer")
            {
                DataItemTableView = sorting(Number) where(Number=const(1));
                column(ReportForNavId_6714; 6714)
                {
                }
                column(ColumnLayoutName;ColumnLayoutName)
                {
                }
                column(FiscalStartDate;Format(FiscalStartDate))
                {
                }
                column(PeriodText;PeriodText)
                {
                }
                column(COMPANYNAME;COMPANYNAME)
                {
                }
                column(AccScheduleName_Description;AccScheduleName.Description)
                {
                }
                column(AnalysisView_Code;AnalysisView.Code)
                {
                }
                column(AnalysisView_Name;AnalysisView.Name)
                {
                }
                column(HeaderText;HeaderText)
                {
                }
                column(AccScheduleLineTABLECAPTION_AccSchedLineFilter;"Acc. Schedule Line".TableCaption + ': ' + AccSchedLineFilter)
                {
                }
                column(AccSchedLineFilter;AccSchedLineFilter)
                {
                }
                column(ShowAccSchedSetup;ShowAccSchedSetup)
                {
                }
                column(ColumnLayoutNameCaption;ColumnLayoutNameCaptionLbl)
                {
                }
                column(AccScheduleName_Name_Caption;AccScheduleName_Name_CaptionLbl)
                {
                }
                column(FiscalStartDateCaption;FiscalStartDateCaptionLbl)
                {
                }
                column(PeriodTextCaption;PeriodTextCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Account_ScheduleCaption;Account_ScheduleCaptionLbl)
                {
                }
                column(AnalysisView_CodeCaption;AnalysisView_CodeCaptionLbl)
                {
                }
                dataitem(AccSchedLineSpec;"Acc. Schedule Line")
                {
                    DataItemLink = "Schedule Name"=field(Name);
                    DataItemLinkReference = AccScheduleName;
                    DataItemTableView = sorting("Schedule Name","Line No.");
                    column(ReportForNavId_6684; 6684)
                    {
                    }
                    column(AccSchedLineSpec_Show;Show)
                    {
                    }
                    column(AccSchedLineSpec__Totaling_Type_;"Totaling Type")
                    {
                    }
                    column(AccSchedLineSpec_Totaling;Totaling)
                    {
                    }
                    column(AccSchedLineSpec_Description;Description)
                    {
                    }
                    column(AccSchedLineSpec__Row_Type_;"Row Type")
                    {
                    }
                    column(AccSchedLineSpec__Amount_Type_;"Amount Type")
                    {
                    }
                    column(Bold_format;Format(Bold))
                    {
                    }
                    column(Italic_format;Format(Italic))
                    {
                    }
                    column(Underline_format;Format(Underline))
                    {
                    }
                    column(DoubleUnderline_format;Format("Double Underline"))
                    {
                    }
                    column(ShowOppSign_format;Format("Show Opposite Sign"))
                    {
                    }
                    column(NewPage_format;Format("New Page"))
                    {
                    }
                    column(AnalysisView__Dimension_1_Code_;AnalysisView."Dimension 1 Code")
                    {
                    }
                    column(AccSchedLineSpec__Dimension_1_Totaling_;"Dimension 1 Totaling")
                    {
                    }
                    column(AnalysisView__Dimension_2_Code_;AnalysisView."Dimension 2 Code")
                    {
                    }
                    column(AccSchedLineSpec__Dimension_2_Totaling_;"Dimension 2 Totaling")
                    {
                    }
                    column(AnalysisView__Dimension_3_Code_;AnalysisView."Dimension 3 Code")
                    {
                    }
                    column(AccSchedLineSpec__Dimension_3_Totaling_;"Dimension 3 Totaling")
                    {
                    }
                    column(AnalysisView__Dimension_4_Code_;AnalysisView."Dimension 4 Code")
                    {
                    }
                    column(AccSchedLineSpec__Dimension_4_Totaling_;"Dimension 4 Totaling")
                    {
                    }
                    column(AccSchedLineSpec_Schedule_Name;"Schedule Name")
                    {
                    }
                    column(SetupLineShadowed;LineShadowed)
                    {
                    }
                    column(AccSchedLineSpec__Show_Opposite_Sign_Caption;AccSchedLineSpec__Show_Opposite_Sign_CaptionLbl)
                    {
                    }
                    column(AccSchedLineSpec_UnderlineCaption;AccSchedLineSpec_UnderlineCaptionLbl)
                    {
                    }
                    column(AccSchedLineSpec_DoubleUnderlineCaption;AccSchedLineSpec_DoubleUnderlineCaptionLbl)
                    {
                    }
                    column(AccSchedLineSpec_ItalicCaption;AccSchedLineSpec_ItalicCaptionLbl)
                    {
                    }
                    column(AccSchedLineSpec_BoldCaption;AccSchedLineSpec_BoldCaptionLbl)
                    {
                    }
                    column(AccSchedLineSpec_ShowCaption;AccSchedLineSpec_ShowCaptionLbl)
                    {
                    }
                    column(AccSchedLineSpec__New_Page_Caption;AccSchedLineSpec__New_Page_CaptionLbl)
                    {
                    }
                    column(AccSchedLineSpec__Totaling_Type_Caption;AccSchedLineSpec__Totaling_Type_CaptionLbl)
                    {
                    }
                    column(AccSchedLineSpec_TotalingCaption;AccSchedLineSpec_TotalingCaptionLbl)
                    {
                    }
                    column(AnalysisView__Dimension_1_Code_Caption;AnalysisView__Dimension_1_Code_CaptionLbl)
                    {
                    }
                    column(AccSchedLineSpec__Row_Type_Caption;AccSchedLineSpec__Row_Type_CaptionLbl)
                    {
                    }
                    column(AccSchedLineSpec__Amount_Type_Caption;AccSchedLineSpec__Amount_Type_CaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if "Row No." <> '' then
                          LineShadowed := not LineShadowed
                        else
                          LineShadowed := false;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if not ShowAccSchedSetup then
                          CurrReport.Break;

                        NextPageGroupNo += 1;
                    end;
                }
                dataitem(PageBreak;"Integer")
                {
                    DataItemTableView = sorting(Number) where(Number=const(1));
                    column(ReportForNavId_1856; 1856)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CurrReport.Newpage;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if not ShowAccSchedSetup then
                          CurrReport.Break;
                    end;
                }
                dataitem("Acc. Schedule Line";"Acc. Schedule Line")
                {
                    DataItemLink = "Schedule Name"=field(Name);
                    DataItemLinkReference = AccScheduleName;
                    DataItemTableView = sorting("Schedule Name","Line No.");
                    PrintOnlyIfDetail = true;
                    column(ReportForNavId_7769; 7769)
                    {
                    }
                    column(NextPageGroupNo;NextPageGroupNo)
                    {
                        OptionCaption = 'None,Division by Zero,Period Error,Both';
                    }
                    column(Acc__Schedule_Line_Description;Description)
                    {
                    }
                    column(Acc__Schedule_Line_Line_No;"Line No.")
                    {
                    }
                    column(Bold_control;Bold_control)
                    {
                    }
                    column(Italic_control;Italic_control)
                    {
                    }
                    column(Underline_control;Underline_control)
                    {
                    }
                    column(DoubleUnderline_control;DoubleUnderline_control)
                    {
                    }
                    column(LineShadowed;LineShadowed)
                    {
                    }
                    dataitem("Column Layout";"Column Layout")
                    {
                        column(ReportForNavId_5937; 5937)
                        {
                        }
                        column(ColumnNo;"Column No.")
                        {
                        }
                        column(Header;Header)
                        {
                        }
                        column(RoundingHeader;RoundingHeader)
                        {
                            AutoCalcField = false;
                        }
                        column(ColumnValuesAsText;ColumnValuesAsText)
                        {
                            AutoCalcField = false;
                        }
                        column(LineSkipped;LineSkipped)
                        {
                        }
                        column(LineNo_ColumnLayout;"Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Show = Show::Never then
                              CurrReport.Skip;

                            Header := "Column Header";
                            RoundingHeader := '';

                            if "Rounding Factor" in ["rounding factor"::"1000","rounding factor"::"1000000"] then
                              case "Rounding Factor" of
                                "rounding factor"::"1000":
                                  RoundingHeader := Text000;
                                "rounding factor"::"1000000":
                                  RoundingHeader := Text001;
                              end;

                            ColumnValuesAsText := '';

                            ColumnValuesDisplayed := AccSchedManagement.CalcCell("Acc. Schedule Line","Column Layout",UseAmtsInAddCurr);
                            if AccSchedManagement.GetDivisionError then begin
                              if ShowError in [Showerror::"Division by Zero",Showerror::Both] then
                                ColumnValuesAsText := Text002;
                            end else
                              if AccSchedManagement.GetPeriodError then begin
                                if ShowError in [Showerror::"Period Error",Showerror::Both] then
                                  ColumnValuesAsText := Text004;
                              end else begin
                                ColumnValuesAsText :=
                                  AccSchedManagement.FormatCellAsText("Column Layout",ColumnValuesDisplayed);

                                if "Acc. Schedule Line"."Totaling Type" = "Acc. Schedule Line"."totaling type"::Formula then
                                  case "Acc. Schedule Line".Show of
                                    "Acc. Schedule Line".Show::"When Positive Balance":
                                      if ColumnValuesDisplayed < 0 then
                                        ColumnValuesAsText := '';
                                    "Acc. Schedule Line".Show::"When Negative Balance":
                                      if ColumnValuesDisplayed > 0 then
                                        ColumnValuesAsText := '';
                                    "Acc. Schedule Line".Show::"If Any Column Not Zero":
                                      if ColumnValuesDisplayed = 0 then
                                        ColumnValuesAsText := '';
                                  end;
                              end;

                            if (ColumnValuesAsText <> '') or ("Acc. Schedule Line".Show = "Acc. Schedule Line".Show::Yes) then
                              LineSkipped := false;
                        end;

                        trigger OnPostDataItem()
                        begin
                            if LineSkipped then
                              LineShadowed := not LineShadowed;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange("Column Layout Name",ColumnLayoutName);
                            LineSkipped := true;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if (Show = Show::No) or not ShowLine(Bold,Italic) then
                          CurrReport.Skip;

                        Bold_control := Bold;
                        Italic_control := Italic;
                        Underline_control := Underline;
                        DoubleUnderline_control := "Double Underline";
                        PageGroupNo := NextPageGroupNo;
                        if "New Page" then
                          NextPageGroupNo := PageGroupNo + 1;

                        if "Row No." <> '' then
                          LineShadowed := not LineShadowed
                        else
                          LineShadowed := false;
                    end;

                    trigger OnPreDataItem()
                    begin
                        PageGroupNo := NextPageGroupNo;

                        SetFilter("Date Filter",DateFilter);
                        SetFilter("G/L Budget Filter",GLBudgetFilter);
                        SetFilter("Cost Budget Filter",CostBudgetFilter);
                        SetFilter("Business Unit Filter",BusinessUnitFilter);
                        SetFilter("Dimension 1 Filter",Dim1Filter);
                        SetFilter("Dimension 2 Filter",Dim2Filter);
                        SetFilter("Dimension 3 Filter",Dim3Filter);
                        SetFilter("Dimension 4 Filter",Dim4Filter);
                        SetFilter("Cost Center Filter",CostCenterFilter);
                        SetFilter("Cost Object Filter",CostObjectFilter);
                        SetFilter("Cash Flow Forecast Filter",CashFlowFilter);
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.PageNo := 1;
                GLSetup.Get;
                if "Analysis View Name" <> '' then begin
                  AnalysisView.Get("Analysis View Name");
                end else begin
                  AnalysisView.Init;
                  AnalysisView."Dimension 1 Code" := GLSetup."Global Dimension 1 Code";
                  AnalysisView."Dimension 2 Code" := GLSetup."Global Dimension 2 Code";
                end;

                if UseAmtsInAddCurr then
                  HeaderText := StrSubstNo(Text003,GLSetup."Additional Reporting Currency")
                else
                  if GLSetup."LCY Code" <> '' then
                    HeaderText := StrSubstNo(Text003,GLSetup."LCY Code")
                  else
                    HeaderText := '';
            end;

            trigger OnPreDataItem()
            begin
                SetRange(Name,AccSchedName);

                PageGroupNo := 1;
                NextPageGroupNo := 1;
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
                    group("Layout")
                    {
                        Caption = 'Layout';
                        field(AccSchedNam;AccSchedName)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Acc. Schedule Name';
                            Editable = HiddenFilterEditable;
                            Lookup = true;
                            TableRelation = "Acc. Schedule Name";

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                exit(AccSchedManagement.LookupName(AccSchedName,Text));
                            end;

                            trigger OnValidate()
                            begin
                                ValidateAccSchedName
                            end;
                        }
                        field(ColumnLayoutNames;ColumnLayoutName)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Column Layout Name';
                            Editable = HiddenFilterEditable;
                            Lookup = true;
                            TableRelation = "Column Layout Name".Name;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                exit(AccSchedManagement.LookupColumnName(ColumnLayoutName,Text));
                            end;

                            trigger OnValidate()
                            begin
                                if ColumnLayoutName = '' then
                                  Error(Text006);
                                AccSchedManagement.CheckColumnName(ColumnLayoutName);
                            end;
                        }
                    }
                    group(Filters)
                    {
                        Caption = 'Filters';
                        field(DateFilters;DateFilter)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Date Filter';
                            Editable = HiddenFilterEditable;

                            trigger OnValidate()
                            var
                                ApplicationManagement: Codeunit ApplicationManagement;
                            begin
                                if ApplicationManagement.MakeDateFilter(DateFilter) = 0 then;
                                "Acc. Schedule Line".SetFilter("Date Filter",DateFilter);
                                DateFilter := "Acc. Schedule Line".GetFilter("Date Filter");
                            end;
                        }
                        field(GLBudgetFilter;GLBudgetFilter)
                        {
                            ApplicationArea = Basic;
                            Caption = 'G/L Budget Filter';
                            Editable = HiddenFilterEditable;
                            TableRelation = "G/L Budget Name".Name;

                            trigger OnValidate()
                            begin
                                "Acc. Schedule Line".SetFilter("G/L Budget Filter",GLBudgetFilter);
                                GLBudgetFilter := "Acc. Schedule Line".GetFilter("G/L Budget Filter");
                            end;
                        }
                        field(CostBudgetFilter;CostBudgetFilter)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Cost Budget Filter';
                            Editable = HiddenFilterEditable;
                            TableRelation = "Cost Budget Name".Name;

                            trigger OnValidate()
                            begin
                                "Acc. Schedule Line".SetFilter("Cost Budget Filter",CostBudgetFilter);
                                CostBudgetFilter := "Acc. Schedule Line".GetFilter("Cost Budget Filter");
                            end;
                        }
                        field(BusinessUnitFilter;BusinessUnitFilter)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Business Unit Filter';
                            Editable = HiddenFilterEditable;
                            LookupPageID = "Business Unit List";
                            TableRelation = "Business Unit";

                            trigger OnValidate()
                            begin
                                "Acc. Schedule Line".SetFilter("Business Unit Filter",BusinessUnitFilter);
                                BusinessUnitFilter := "Acc. Schedule Line".GetFilter("Business Unit Filter");
                            end;
                        }
                    }
                    group("Dimension Filters")
                    {
                        Caption = 'Dimension Filters';
                        field(Dim1Filter;Dim1Filter)
                        {
                            ApplicationArea = Basic;
                            CaptionClass = FormGetCaptionClass(1);
                            Caption = 'Dimension 1 Filter';
                            Editable = HiddenFilterEditable;
                            Enabled = Dim1FilterEnable;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                exit(FormLookUpDimFilter(AnalysisView."Dimension 1 Code",Text));
                            end;
                        }
                        field(Dim2Filter;Dim2Filter)
                        {
                            ApplicationArea = Basic;
                            CaptionClass = FormGetCaptionClass(2);
                            Caption = 'Dimension 2 Filter';
                            Editable = HiddenFilterEditable;
                            Enabled = Dim2FilterEnable;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                exit(FormLookUpDimFilter(AnalysisView."Dimension 2 Code",Text));
                            end;
                        }
                        field(Dim3Filter;Dim3Filter)
                        {
                            ApplicationArea = Basic;
                            CaptionClass = FormGetCaptionClass(3);
                            Caption = 'Dimension 3 Filter';
                            Editable = HiddenFilterEditable;
                            Enabled = Dim3FilterEnable;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                exit(FormLookUpDimFilter(AnalysisView."Dimension 3 Code",Text));
                            end;
                        }
                        field(Dim4Filter;Dim4Filter)
                        {
                            ApplicationArea = Basic;
                            CaptionClass = FormGetCaptionClass(4);
                            Caption = 'Dimension 4 Filter';
                            Editable = HiddenFilterEditable;
                            Enabled = Dim4FilterEnable;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                exit(FormLookUpDimFilter(AnalysisView."Dimension 4 Code",Text));
                            end;
                        }
                        field(CostCenterFilter;CostCenterFilter)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Cost Center Filter';
                            Editable = HiddenFilterEditable;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                CostCenter: Record "Cost Center";
                            begin
                                exit(CostCenter.LookupCostCenterFilter(Text));
                            end;
                        }
                        field(CostObjectFilter;CostObjectFilter)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Cost Object Filter';
                            Editable = HiddenFilterEditable;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                CostObject: Record "Cost Object";
                            begin
                                exit(CostObject.LookupCostObjectFilter(Text));
                            end;
                        }
                        field(CashFlowFilter;CashFlowFilter)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Cash Flow Filter';
                            Editable = HiddenFilterEditable;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                CashFlowForecast: Record "Cash Flow Forecast";
                            begin
                                exit(CashFlowForecast.LookupCashFlowFilter(Text));
                            end;
                        }
                    }
                    group(Show)
                    {
                        Caption = 'Show';
                        field(ShowError;ShowError)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Show Error';
                            OptionCaption = 'None,Division by Zero,Period Error,Both';
                        }
                        field(UseAmtsInAddCurr;UseAmtsInAddCurr)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Show Amounts in Add. Reporting Currency';
                            MultiLine = true;
                        }
                        field(ShowAccSchedSetup;ShowAccSchedSetup)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Show Account Schedule Setup';
                            MultiLine = true;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            Dim4FilterEnable := true;
            Dim3FilterEnable := true;
            Dim2FilterEnable := true;
            Dim1FilterEnable := true;
        end;

        trigger OnOpenPage()
        begin
            GLSetup.Get;
            TransferValues;
            if AccSchedName <> '' then
              ValidateAccSchedName;
            if not UseHiddenFilters then
              HiddenFilterEditable := true;
        end;
    }

    labels
    {
        AccSchedLineSpec_DescriptionCaptionLbl = 'Description';
        AccSchedLineSpec__Row_No__CaptionLbl = 'Row No.';
    }

    trigger OnPreReport()
    begin
        TransferValues;
        UpdateFilters;
        InitAccSched;
    end;

    var
        Text000: label '(Thousands)';
        Text001: label '(Millions)';
        Text002: label '* ERROR *';
        Text003: label 'All amounts are in %1.';
        AnalysisView: Record "Analysis View";
        GLSetup: Record "General Ledger Setup";
        AccSchedManagement: Codeunit AccSchedManagement;
        AccSchedName: Code[10];
        AccSchedNameHidden: Code[10];
        ColumnLayoutName: Code[10];
        ColumnLayoutNameHidden: Code[10];
        EndDate: Date;
        ShowError: Option "None","Division by Zero","Period Error",Both;
        DateFilter: Text[30];
        UseHiddenFilters: Boolean;
        DateFilterHidden: Text[30];
        GLBudgetFilter: Text[30];
        GLBudgetFilterHidden: Text[30];
        CostBudgetFilter: Text[30];
        CostBudgetFilterHidden: Text[30];
        BusinessUnitFilter: Text[30];
        BusinessUnitFilterHidden: Text[30];
        Dim1Filter: Text[250];
        Dim1FilterHidden: Text[250];
        Dim2Filter: Text[250];
        Dim2FilterHidden: Text[250];
        Dim3Filter: Text[250];
        Dim3FilterHidden: Text[250];
        Dim4Filter: Text[250];
        Dim4FilterHidden: Text[250];
        CostCenterFilter: Text[250];
        CostObjectFilter: Text[250];
        CashFlowFilter: Text[250];
        FiscalStartDate: Date;
        ColumnValuesDisplayed: Decimal;
        ColumnValuesAsText: Text[30];
        PeriodText: Text[40];
        AccSchedLineFilter: Text;
        Header: Text[30];
        RoundingHeader: Text[30];
        UseAmtsInAddCurr: Boolean;
        ShowAccSchedSetup: Boolean;
        HeaderText: Text[100];
        Text004: label 'Not Available';
        Text005: label '1,6,,Dimension %1 Filter';
        Bold_control: Boolean;
        Italic_control: Boolean;
        Underline_control: Boolean;
        DoubleUnderline_control: Boolean;
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        Text006: label 'Enter the Column Layout Name.';
        [InDataSet]
        Dim1FilterEnable: Boolean;
        [InDataSet]
        Dim2FilterEnable: Boolean;
        [InDataSet]
        Dim3FilterEnable: Boolean;
        [InDataSet]
        Dim4FilterEnable: Boolean;
        [InDataSet]
        HiddenFilterEditable: Boolean;
        LineShadowed: Boolean;
        LineSkipped: Boolean;
        ColumnLayoutNameCaptionLbl: label 'Column Layout';
        AccScheduleName_Name_CaptionLbl: label 'Account Schedule';
        FiscalStartDateCaptionLbl: label 'Fiscal Start Date';
        PeriodTextCaptionLbl: label 'Period';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Account_ScheduleCaptionLbl: label 'Account Schedule';
        AnalysisView_CodeCaptionLbl: label 'Analysis View';
        AccSchedLineSpec__Show_Opposite_Sign_CaptionLbl: label 'Show Opposite Sign';
        AccSchedLineSpec_UnderlineCaptionLbl: label 'Underline';
        AccSchedLineSpec_ItalicCaptionLbl: label 'Italic';
        AccSchedLineSpec_BoldCaptionLbl: label 'Bold';
        AccSchedLineSpec_ShowCaptionLbl: label 'Show';
        AccSchedLineSpec__New_Page_CaptionLbl: label 'New Page';
        AccSchedLineSpec__Totaling_Type_CaptionLbl: label 'Totaling Type';
        AccSchedLineSpec_TotalingCaptionLbl: label 'Totaling';
        AnalysisView__Dimension_1_Code_CaptionLbl: label 'Dimension Code';
        AccSchedLineSpec__Row_Type_CaptionLbl: label 'Row Type';
        AccSchedLineSpec__Amount_Type_CaptionLbl: label 'Amount Type';
        AccSchedLineSpec_DoubleUnderlineCaptionLbl: label 'Double Underline';


    procedure InitAccSched()
    begin
        AccScheduleName.SetRange(Name,AccSchedName);
        "Acc. Schedule Line".SetFilter("Date Filter",DateFilter);
        "Acc. Schedule Line".SetFilter("G/L Budget Filter",GLBudgetFilter);
        "Acc. Schedule Line".SetFilter("Cost Budget Filter",CostBudgetFilter);
        "Acc. Schedule Line".SetFilter("Business Unit Filter",BusinessUnitFilter);
        "Acc. Schedule Line".SetFilter("Dimension 1 Filter",Dim1Filter);
        "Acc. Schedule Line".SetFilter("Dimension 2 Filter",Dim2Filter);
        "Acc. Schedule Line".SetFilter("Dimension 3 Filter",Dim3Filter);
        "Acc. Schedule Line".SetFilter("Dimension 4 Filter",Dim4Filter);
        "Acc. Schedule Line".SetFilter("Cost Center Filter",CostCenterFilter);
        "Acc. Schedule Line".SetFilter("Cost Object Filter",CostObjectFilter);
        "Acc. Schedule Line".SetFilter("Cash Flow Forecast Filter",CashFlowFilter);

        EndDate := "Acc. Schedule Line".GetRangemax("Date Filter");
        FiscalStartDate := AccSchedManagement.FindFiscalYear(EndDate);

        AccSchedLineFilter := "Acc. Schedule Line".GetFilters;

        //>>ANICA change printed date
        PeriodText := 'For the Period Ended ' + Format(EndDate,0,4);
        //original code below
        //PeriodText := "Acc. Schedule Line".GETFILTER("Date Filter");
    end;


    procedure SetAccSchedName(NewAccSchedName: Code[10])
    begin
        AccSchedNameHidden := NewAccSchedName;
    end;


    procedure SetColumnLayoutName(ColLayoutName: Code[10])
    begin
        ColumnLayoutNameHidden := ColLayoutName;
    end;


    procedure SetFilters(NewDateFilter: Text[30];NewBudgetFilter: Text[30];NewCostBudgetFilter: Text[30];NewBusUnitFilter: Text[30];NewDim1Filter: Text[250];NewDim2Filter: Text[250];NewDim3Filter: Text[250];NewDim4Filter: Text[250])
    begin
        DateFilterHidden := NewDateFilter;
        GLBudgetFilterHidden := NewBudgetFilter;
        CostBudgetFilterHidden := NewCostBudgetFilter;
        BusinessUnitFilterHidden := NewBusUnitFilter;
        Dim1FilterHidden := NewDim1Filter;
        Dim2FilterHidden := NewDim2Filter;
        Dim3FilterHidden := NewDim3Filter;
        Dim4FilterHidden := NewDim4Filter;
        UseHiddenFilters := true;
    end;


    procedure ShowLine(Bold: Boolean;Italic: Boolean): Boolean
    begin
        if "Acc. Schedule Line"."Totaling Type" = "Acc. Schedule Line"."totaling type"::"Set Base For Percent" then
          exit(false);
        if "Acc. Schedule Line".Show = "Acc. Schedule Line".Show::No then
          exit(false);
        if "Acc. Schedule Line".Bold <> Bold then
          exit(false);
        if "Acc. Schedule Line".Italic <> Italic then
          exit(false);

        exit(true);
    end;

    local procedure FormLookUpDimFilter(Dim: Code[20];var Text: Text[1024]): Boolean
    var
        DimVal: Record "Dimension Value";
        DimValList: Page "Dimension Value List";
    begin
        if Dim = '' then
          exit(false);
        DimValList.LookupMode(true);
        DimVal.SetRange("Dimension Code",Dim);
        DimValList.SetTableview(DimVal);
        if DimValList.RunModal = Action::LookupOK then begin
          DimValList.GetRecord(DimVal);
          Text := DimValList.GetSelectionFilter;
          exit(true);
        end;
        exit(false)
    end;

    local procedure FormGetCaptionClass(DimNo: Integer): Text[250]
    begin
        case DimNo of
          1:
            begin
              if AnalysisView."Dimension 1 Code" <> '' then
                exit('1,6,' + AnalysisView."Dimension 1 Code");
              exit(StrSubstNo(Text005,DimNo));
            end;
          2:
            begin
              if AnalysisView."Dimension 2 Code" <> '' then
                exit('1,6,' + AnalysisView."Dimension 2 Code");
              exit(StrSubstNo(Text005,DimNo));
            end;
          3:
            begin
              if AnalysisView."Dimension 3 Code" <> '' then
                exit('1,6,' + AnalysisView."Dimension 3 Code");
              exit(StrSubstNo(Text005,DimNo));
            end;
          4:
            begin
              if AnalysisView."Dimension 4 Code" <> '' then
                exit('1,6,' + AnalysisView."Dimension 4 Code");
              exit(StrSubstNo(Text005,DimNo));
            end;
        end;
    end;

    local procedure TransferValues()
    var
        ColumnLayoutName2: Record "Column Layout Name";
    begin
        GLSetup.Get;
        if AccSchedNameHidden <> '' then
          AccSchedName := AccSchedNameHidden;
        if ColumnLayoutNameHidden <> '' then
          ColumnLayoutName := ColumnLayoutNameHidden;
        if DateFilterHidden <> '' then
          DateFilter := DateFilterHidden;
        if GLBudgetFilterHidden <> '' then
          GLBudgetFilter := GLBudgetFilterHidden;
        if CostBudgetFilterHidden <> '' then
          CostBudgetFilter := CostBudgetFilterHidden;
        if BusinessUnitFilterHidden <> '' then
          BusinessUnitFilter := BusinessUnitFilterHidden;
        if Dim1FilterHidden <> '' then
          Dim1Filter := Dim1FilterHidden;
        if Dim2FilterHidden <> '' then
          Dim2Filter := Dim2FilterHidden;
        if Dim3FilterHidden <> '' then
          Dim3Filter := Dim3FilterHidden;
        if Dim4FilterHidden <> '' then
          Dim4Filter := Dim4FilterHidden;

        if AccSchedName <> '' then
          if not AccScheduleName.Get(AccSchedName) then
            AccSchedName := '';
        if AccSchedName = '' then
          if AccScheduleName.FindFirst then
            AccSchedName := AccScheduleName.Name;

        if ColumnLayoutName <> '' then
          if not ColumnLayoutName2.Get(ColumnLayoutName) then
            ColumnLayoutName := AccScheduleName."Default Column Layout";

        if AccScheduleName."Analysis View Name" <> '' then
          AnalysisView.Get(AccScheduleName."Analysis View Name")
        else begin
          AnalysisView."Dimension 1 Code" := GLSetup."Global Dimension 1 Code";
          AnalysisView."Dimension 2 Code" := GLSetup."Global Dimension 2 Code";
        end;
    end;

    local procedure UpdateFilters()
    begin
        if UseHiddenFilters then begin
          DateFilter := DateFilterHidden;
          GLBudgetFilter := GLBudgetFilterHidden;
          CostBudgetFilter := CostBudgetFilterHidden;
          BusinessUnitFilter := BusinessUnitFilterHidden;
          Dim1Filter := Dim1FilterHidden;
          Dim2Filter := Dim2FilterHidden;
          Dim3Filter := Dim3FilterHidden;
          Dim4Filter := Dim4FilterHidden;
        end;

        if ColumnLayoutName = '' then
          if AccScheduleName.FindFirst then
            ColumnLayoutName := AccScheduleName."Default Column Layout";
    end;


    procedure ValidateAccSchedName()
    begin
        AccSchedManagement.CheckName(AccSchedName);
        AccScheduleName.Get(AccSchedName);
        if AccScheduleName."Default Column Layout" <> '' then
          ColumnLayoutName := AccScheduleName."Default Column Layout";
        if AccScheduleName."Analysis View Name" <> '' then
          AnalysisView.Get(AccScheduleName."Analysis View Name")
        else begin
          Clear(AnalysisView);
          AnalysisView."Dimension 1 Code" := GLSetup."Global Dimension 1 Code";
          AnalysisView."Dimension 2 Code" := GLSetup."Global Dimension 2 Code";
        end;
        Dim1FilterEnable := AnalysisView."Dimension 1 Code" <> '';
        Dim2FilterEnable := AnalysisView."Dimension 2 Code" <> '';
        Dim3FilterEnable := AnalysisView."Dimension 3 Code" <> '';
        Dim4FilterEnable := AnalysisView."Dimension 4 Code" <> '';
    end;
}

