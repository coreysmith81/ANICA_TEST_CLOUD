Report 50002 "ANICA Item Sales by Customer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ANICA Item Sales by Customer.rdlc';
    Caption = 'Item Sales by Customer';

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.","Date Filter","Vendor No.";
            column(ReportForNavId_8129; 8129)
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
            column(ItemFilter;ItemFilter)
            {
            }
            column(ItemLedgEntryFilter;ItemLedgEntryFilter)
            {
            }
            column(IncludeReturns;IncludeReturns)
            {
            }
            column(Item_TABLECAPTION__________ItemFilter;Item.TableCaption + ': ' + ItemFilter)
            {
            }
            column(Item_Ledger_Entry__TABLECAPTION__________ItemLedgEntryFilter;"Item Ledger Entry".TableCaption + ': ' + ItemLedgEntryFilter)
            {
            }
            column(SalesText;SalesText)
            {
            }
            column(QtyText;QtyText)
            {
            }
            column(Item__No__;"No.")
            {
            }
            column(Item_Description;Description)
            {
            }
            column(FIELDCAPTION__Base_Unit_of_Measure_____________Base_Unit_of_Measure_;FieldCaption("Base Unit of Measure") + ': ' + "Base Unit of Measure")
            {
            }
            column(ValueEntry__Sales_Amount__Actual__;ValueEntry."Sales Amount (Actual)")
            {
            }
            column(ValueEntry__Discount_Amount_;ValueEntry."Discount Amount")
            {
            }
            column(Profit;Profit)
            {
            }
            column(ProfitPct;ProfitPct)
            {
                DecimalPlaces = 1:1;
            }
            column(Item_Date_Filter;"Date Filter")
            {
            }
            column(Item_Location_Filter;"Location Filter")
            {
            }
            column(Item_Variant_Filter;"Variant Filter")
            {
            }
            column(Item_Global_Dimension_1_Filter;"Global Dimension 1 Filter")
            {
            }
            column(Item_Global_Dimension_2_Filter;"Global Dimension 2 Filter")
            {
            }
            column(Item_Sales_by_CustomerCaption;Item_Sales_by_CustomerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Returns_are_included_in_Sales_Quantities_Caption;Returns_are_included_in_Sales_Quantities_CaptionLbl)
            {
            }
            column(Returns_are_not_included_in_Sales_Quantities_Caption;Returns_are_not_included_in_Sales_Quantities_CaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Source_No__Caption;Item_Ledger_Entry__Source_No__CaptionLbl)
            {
            }
            column(Cust_NameCaption;Cust_NameCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Invoiced_Quantity_Caption;"Item Ledger Entry".FieldCaption("Invoiced Quantity"))
            {
            }
            column(ValueEntry__Sales_Amount__Actual___Control29Caption;ValueEntry__Sales_Amount__Actual___Control29CaptionLbl)
            {
            }
            column(ValueEntry__Discount_Amount__Control30Caption;ValueEntry__Discount_Amount__Control30CaptionLbl)
            {
            }
            column(Profit_Control31Caption;Profit_Control31CaptionLbl)
            {
            }
            column(ProfitPct_Control32Caption;ProfitPct_Control32CaptionLbl)
            {
            }
            column(Report_TotalCaption;Report_TotalCaptionLbl)
            {
            }
            dataitem("Item Ledger Entry";"Item Ledger Entry")
            {
                DataItemLink = "Item No."=field("No."),"Posting Date"=field("Date Filter"),"Location Code"=field("Location Filter"),"Variant Code"=field("Variant Filter"),"Global Dimension 1 Code"=field("Global Dimension 1 Filter"),"Global Dimension 2 Code"=field("Global Dimension 2 Filter");
                DataItemTableView = sorting("Entry Type","Item No.","Variant Code","Source Type","Source No.","Posting Date") where("Entry Type"=const(Sale),"Source Type"=const(Customer));
                RequestFilterFields = "Source No.";
                column(ReportForNavId_7209; 7209)
                {
                }
                column(FIELDCAPTION__Variant_Code_____________Variant_Code_;FieldCaption("Variant Code") + ': ' + "Variant Code")
                {
                }
                column(Item_Ledger_Entry__Source_No__;"Source No.")
                {
                }
                column(Cust_Name;Cust.Name)
                {
                }
                column(Item_Ledger_Entry__Invoiced_Quantity_;"Invoiced Quantity")
                {
                    DecimalPlaces = 2:5;
                }
                column(ValueEntry__Sales_Amount__Actual___Control29;ValueEntry."Sales Amount (Actual)")
                {
                }
                column(ValueEntry__Discount_Amount__Control30;ValueEntry."Discount Amount")
                {
                }
                column(Profit_Control31;Profit)
                {
                }
                column(ProfitPct_Control32;ProfitPct)
                {
                    DecimalPlaces = 1:1;
                }
                column(ProfitPct_Control7;ProfitPct)
                {
                    DecimalPlaces = 1:1;
                }
                column(Profit_Control8;Profit)
                {
                }
                column(ValueEntry__Discount_Amount__Control9;ValueEntry."Discount Amount")
                {
                }
                column(ValueEntry__Sales_Amount__Actual___Control19;ValueEntry."Sales Amount (Actual)")
                {
                }
                column(Item_Ledger_Entry__Invoiced_Quantity__Control39;"Invoiced Quantity")
                {
                    DecimalPlaces = 2:5;
                }
                column(Text008_________FIELDCAPTION__Variant_Code_____________Variant_Code_;Text008 + ' ' + FieldCaption("Variant Code") + ': ' + "Variant Code")
                {
                }
                column(Text008_________FIELDCAPTION__Item_No______________Item_No__;Text008 + ' ' + FieldCaption("Item No.") + ': ' + "Item No.")
                {
                }
                column(Item_Ledger_Entry__Invoiced_Quantity__Control34;"Invoiced Quantity")
                {
                    DecimalPlaces = 2:5;
                }
                column(ValueEntry__Sales_Amount__Actual___Control35;ValueEntry."Sales Amount (Actual)")
                {
                }
                column(ValueEntry__Discount_Amount__Control36;ValueEntry."Discount Amount")
                {
                }
                column(Profit_Control37;Profit)
                {
                }
                column(ProfitPct_Control38;ProfitPct)
                {
                    DecimalPlaces = 1:1;
                }
                column(Item_Ledger_Entry_Entry_No_;"Entry No.")
                {
                }
                column(Item_Ledger_Entry_Variant_Code;"Variant Code")
                {
                }
                column(Item_Ledger_Entry_Item_No_;"Item No.")
                {
                }
                column(Item_Ledger_Entry_Posting_Date;"Posting Date")
                {
                }
                column(Item_Ledger_Entry_Location_Code;"Location Code")
                {
                }
                column(Item_Ledger_Entry_Global_Dimension_1_Code;"Global Dimension 1 Code")
                {
                }
                column(Item_Ledger_Entry_Global_Dimension_2_Code;"Global Dimension 2 Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if ("Source No." <> PrevSourceNo) or ("Variant Code" <> PrevVariantCode) then begin
                      if PrintToExcel then begin
                        CalcProfitPct;
                        if (TotalSalesAmtForSource <> 0) or (TotalInvQtyForSource <> 0) or
                           (TotalDiscAmtForSource <> 0) or (TotalProfitForSource <> 0)
                        then
                          MakeExcelDataBody;
                      end;
                      TotalInvQtyForSource := 0;
                      TotalSalesAmtForSource := 0;
                      TotalDiscAmtForSource := 0;
                      TotalProfitForSource := 0;
                      PrevSourceNo := "Source No.";
                      PrevVariantCode := "Variant Code";
                    end;
                    CalcFields("Cost Amount (Actual)");
                    "Invoiced Quantity" := -"Invoiced Quantity";
                    with ValueEntry do begin
                      SetRange("Item Ledger Entry No.","Item Ledger Entry"."Entry No.");
                      CalcSums("Sales Amount (Actual)","Discount Amount");
                      "Discount Amount" := -"Discount Amount";
                      Profit := "Sales Amount (Actual)" + "Item Ledger Entry"."Cost Amount (Actual)";
                    end;
                    if "Source No." <> '' then
                      Cust.Get("Source No.")
                    else
                      Clear(Cust);
                    TotalInvQtyForSource += "Invoiced Quantity";
                    TotalSalesAmtForSource += ValueEntry."Sales Amount (Actual)";
                    TotalDiscAmtForSource += ValueEntry."Discount Amount";
                    TotalProfitForSource += Profit;
                end;

                trigger OnPostDataItem()
                begin
                    if PrintToExcel then begin
                      CalcProfitPct;
                      if (TotalSalesAmtForSource <> 0) or (TotalInvQtyForSource <> 0) or
                         (TotalDiscAmtForSource <> 0) or (TotalProfitForSource <> 0)
                      then
                        MakeExcelDataBody;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals("Invoiced Quantity",ValueEntry."Sales Amount (Actual)",ValueEntry."Discount Amount",Profit);
                    if IncludeReturns then
                      SetFilter("Invoiced Quantity",'<>0')
                    else
                      SetFilter("Invoiced Quantity",'<0');

                    with ValueEntry do begin
                      Reset;
                      SetCurrentkey("Item Ledger Entry No.","Entry Type");
                    end;

                    TotalInvQtyForSource := 0;
                    TotalSalesAmtForSource := 0;
                    TotalDiscAmtForSource := 0;
                    TotalProfitForSource := 0;
                    PrevSourceNo := '';
                    PrevVariantCode := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Sales (Qty.)","Sales (LCY)");
                if MinSales <> 0 then
                  if "Sales (LCY)" <= MinSales then
                    CurrReport.Skip;
                if MaxSales <> 0 then
                  if "Sales (LCY)" >= MaxSales then
                    CurrReport.Skip;
                if MinQty <> 0 then
                  if "Sales (Qty.)" <= MinQty then
                    CurrReport.Skip;
                if MaxQty <> 0 then
                  if "Sales (Qty.)" >= MaxQty then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals(ValueEntry."Sales Amount (Actual)",ValueEntry."Discount Amount",Profit);
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
                    field(IncludeReturns;IncludeReturns)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Returns';
                    }
                    group("Items with Net Sales ($)")
                    {
                        Caption = 'Items with Net Sales ($)';
                        field(MinSales;MinSales)
                        {
                            ApplicationArea = Basic;
                            BlankZero = true;
                            Caption = 'Greater than';
                        }
                        field(MaxSales;MaxSales)
                        {
                            ApplicationArea = Basic;
                            BlankZero = true;
                            Caption = 'Less than';
                        }
                    }
                    group("Items with Net Sales (Qty)")
                    {
                        Caption = 'Items with Net Sales (Qty)';
                        field(MinQty;MinQty)
                        {
                            ApplicationArea = Basic;
                            BlankZero = true;
                            Caption = 'Greater than';
                        }
                        field(MaxQty;MaxQty)
                        {
                            ApplicationArea = Basic;
                            BlankZero = true;
                            Caption = 'Less than';
                        }
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
        CompanyInformation.Get;
        PeriodText := Item.GetFilter("Date Filter");
        Item.SetRange("Date Filter");
        ItemFilter := Item.GetFilters;
        ItemLedgEntryFilter := "Item Ledger Entry".GetFilters;
        if PeriodText = '' then
          SubTitle := Text000
        else
          SubTitle := Text001 + ' ' + PeriodText;
        if MinSales = 0 then
          SalesText := ''
        else
          SalesText := StrSubstNo(Text002,MinSales);
        if MaxSales <> 0 then begin
          if SalesText = '' then
            SalesText := StrSubstNo(Text003,MaxSales)
          else
            SalesText := SalesText + StrSubstNo(Text004,MaxSales);
        end;
        if MinQty = 0 then
          QtyText := ''
        else
          QtyText := StrSubstNo(Text005,MinQty);
        if MaxQty <> 0 then begin
          if QtyText = '' then
            QtyText := StrSubstNo(Text006,MaxQty)
          else
            QtyText := QtyText + StrSubstNo(Text007,MaxQty);
        end;

        if PrintToExcel then
          MakeExcelInfo;
    end;

    var
        Cust: Record Customer;
        CompanyInformation: Record "Company Information";
        ValueEntry: Record "Value Entry";
        ExcelBuf: Record "Excel Buffer" temporary;
        IncludeReturns: Boolean;
        MinSales: Decimal;
        MaxSales: Decimal;
        MinQty: Decimal;
        MaxQty: Decimal;
        SubTitle: Text;
        SalesText: Text[150];
        QtyText: Text[150];
        Profit: Decimal;
        ProfitPct: Decimal;
        PeriodText: Text;
        ItemFilter: Text;
        ItemLedgEntryFilter: Text;
        Text000: label 'All Sales to Date';
        Text001: label 'Sales during the Period';
        Text002: label 'Items with Net Sales of more than $%1';
        Text003: label 'Items with Net Sales of less than $%1';
        Text004: label ' and less than $%1';
        Text005: label 'Items with Net Sales Quantity more than %1';
        Text006: label 'Items with Net Sales Quantity less than %1';
        Text007: label ' and less than %1';
        Text008: label 'Total for';
        Text009: label 'Returns are included in Sales Quantities.';
        Text010: label 'Returns are not included in Sales Quantities.';
        Text101: label 'Data';
        Text102: label 'Item Sales by Customer';
        Text103: label 'Company Name';
        Text104: label 'Report No.';
        Text105: label 'Report Name';
        Text106: label 'User ID';
        Text107: label 'Date / Time';
        Text108: label 'Item Filters';
        Text109: label 'Item Ledger Entry Filters';
        Text110: label 'Profit';
        Text111: label 'Profit Percent';
        PrintToExcel: Boolean;
        Text112: label 'Sales Option';
        Text113: label 'Quantity Option';
        Text114: label 'Returns Option';
        TotalInvQtyForSource: Decimal;
        TotalSalesAmtForSource: Decimal;
        TotalDiscAmtForSource: Decimal;
        TotalProfitForSource: Decimal;
        PrevSourceNo: Code[20];
        PrevVariantCode: Code[20];
        Item_Sales_by_CustomerCaptionLbl: label 'Item Sales by Customer';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Returns_are_included_in_Sales_Quantities_CaptionLbl: label 'Returns are included in Sales Quantities.';
        Returns_are_not_included_in_Sales_Quantities_CaptionLbl: label 'Returns are not included in Sales Quantities.';
        Item_Ledger_Entry__Source_No__CaptionLbl: label 'Customer No.';
        Cust_NameCaptionLbl: label 'Name';
        ValueEntry__Sales_Amount__Actual___Control29CaptionLbl: label 'Amount';
        ValueEntry__Discount_Amount__Control30CaptionLbl: label 'Discount Amount';
        Profit_Control31CaptionLbl: label 'Profit';
        ProfitPct_Control32CaptionLbl: label 'Profit %';
        Report_TotalCaptionLbl: label 'Report Total';


    procedure CalcProfitPct()
    begin
        if PrintToExcel then begin
          if TotalSalesAmtForSource <> 0 then
            ProfitPct := ROUND(TotalProfitForSource / TotalSalesAmtForSource * 100,0.1)
          else
            ProfitPct := 0;
        end else
          with ValueEntry do begin
            if "Sales Amount (Actual)" <> 0 then
              ProfitPct := ROUND(Profit / "Sales Amount (Actual)" * 100,0.1)
            else
              ProfitPct := 0;
          end;
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
        ExcelBuf.AddInfoColumn(Report::"Item Sales by Customer",false,'',false,false,false,'',ExcelBuf."cell type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text106),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(UserId,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text107),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Today,false,'',false,false,false,'',ExcelBuf."cell type"::Date);
        ExcelBuf.AddInfoColumn(Time,false,'',false,false,false,'',ExcelBuf."cell type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text112),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(SalesText,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text113),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(QtyText,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text114),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        if IncludeReturns then
          ExcelBuf.AddInfoColumn(Format(Text009),false,'',false,false,false,'',ExcelBuf."cell type"::Text)
        else
          ExcelBuf.AddInfoColumn(Format(Text010),false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text108),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(ItemFilter,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text109),false,'',true,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(ItemLedgEntryFilter,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item.FieldCaption("No."),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Item.FieldCaption(Description),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Item.FieldCaption("Base Unit of Measure"),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry".FieldCaption("Variant Code"),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Cust.TableCaption + ' ' + Cust.FieldCaption("No."),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Cust.TableCaption + ' ' + Cust.FieldCaption(Name),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry".FieldCaption("Invoiced Quantity"),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(ValueEntry.FieldCaption("Sales Amount (Actual)"),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Format(Text110),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Format(Text111),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(ValueEntry.FieldCaption("Discount Amount"),false,'',true,false,true,'',ExcelBuf."cell type"::Text);
    end;

    local procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item."No.",false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Item.Description,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Item."Base Unit of Measure",false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(PrevVariantCode,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Cust."No.",false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Cust.Name,false,'',false,false,false,'',ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(TotalInvQtyForSource,false,'',false,false,false,'',ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(TotalSalesAmtForSource,false,'',false,false,false,'#,##0.00',ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(TotalProfitForSource,false,'',false,false,false,'#,##0.00',ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(ProfitPct / 100,false,'',false,false,false,'0.0%',ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(TotalDiscAmtForSource,false,'',false,false,false,'#,##0.00',ExcelBuf."cell type"::Number);
    end;

    local procedure CreateExcelbook()
    begin
        ExcelBuf.CreateBookAndOpenExcel(Text101,Text102,COMPANYNAME,UserId);
        Error('');
    end;
}

