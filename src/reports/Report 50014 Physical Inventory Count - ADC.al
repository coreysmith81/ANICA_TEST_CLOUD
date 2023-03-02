Report 50014 "Physical Inventory Count - ADC"
{
    // ANICA 9-22-05 Added ANICA Fields from UOM table on after get item journal line
    //               Also added ANICA fields and desc2 to report sections
    // 
    // ANICA 9-22-05 Changed table view to Shelf/Bin and Item No for report sorting
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Physical Inventory Count - ADC.rdlc';

    Caption = 'Physical Inventory Count';

    dataset
    {
        dataitem("Item Journal Template"; "Item Journal Template")
        {
            DataItemTableView = sorting(Name);
            column(ReportForNavId_9552; 9552)
            {
            }
            column(Item_Journal_Template_Name; Name)
            {
            }
            dataitem("Item Journal Batch"; "Item Journal Batch")
            {
                DataItemTableView = sorting("Journal Template Name", Name);
                PrintOnlyIfDetail = true;
                column(ReportForNavId_8780; 8780)
                {
                }
                column(CompanyInformation_Name; CompanyInformation.Name)
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
                column(Item_Journal_Templ ate__TABLECAPTION__________ItemJnlTemplateFilter;"Item Journal Template".TableCaption + ': ' + ItemJnlTemplateFilter)
                {
                }
                column(Item_Journal_Batch__TABLECAPTION__________ItemJnlBatchFilter;"Item  Journal Batch".TableCaption + ': ' + ItemJnlBatchFilter)
                {
                }
                column(ItemJnlBatchFilterPrint;ItemJnlBatchFilterPrint) 
                {
                }
                column(Item_Journal_Line__TABLE CAPTION__________ItemJnlLineFilter;"Item Journal Line".TableCaption + ': ' + ItemJnlLineFilter)
                {
                }
                column(ItemJnlLineFilter;ItemJnlLineFilter) 
                {
                }
                column(Physical_Inventory _Count_SheetCaption;Physical_Inventory_Count_SheetCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption;CurrReport_PA GENOCaptionLbl)
                {
                }
                column(Shelf_Bin_No_Caption;Shel f_Bin_No_CaptionLbl)
                {
                }
                column(Item_Journal_Line__It em_No__Caption;"Item Journal Line".FieldCaption("Item No."))
                {
                }
                column(Item_Journal_Line_DescriptionCaption ;"Item Journal Line".FieldCaption(Description))
                {
                }
                column(Unit_of_MeasureCaption;Unit_of_Measur eCaptionLbl)
                {
                }
                column(Item_Journal_Batch_Jour nal_Template_Name;"Journal Template Name")
                {
                }
                column(Item_Journal_Batch_Name;Name) 
                {
                }
                dataitem("Item Journal Line";"I tem Journal Line")
                {
                    DataItemLink = "Journal Template Name"=field("Journal Template Name"),"Journal Batch Name"=field(Name);
                    DataItemTableView = sorti "Item Journal Line")
                {
                    DataItemLink = "Journal Template Name" = field("Journal Template Name"), "Journal Batch Name" = field(Name);
                    DataItemTableView = sorting("Shelf/Bin No.", "Vendor No.", "Inventory Count Order") order(ascending);
                    RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Item No.", 
                    column(Item__Base_Unit_of_Measure_;Item."Base Unit of Measure")
                    {
                    }
                    column(Item_Journal_Line_Descriptio n;Description)
                    {
                    }
                    column(Item_Journal_Line__Item_No__;" Item No.")
                    {
                    }
                    column(Item__Shelf_No__;Item."Shelf  No.")
                    {
                    }
                    column(VDesc2;VDesc2) 
                    {
                    }
                    column(PrtPack ;PrtPack)
                    {
                    }
                    column(PSize;PS ize)
                    {
                    }
                    column(Item__ Vendor_Item_No__;Item."Vendor Item No.")
                    {
                    }
                    column(Item__Vendor_No__;Item. "Vendor No.")
                    {
                    }
                    column(Item_Journal_Line_ Journal_Template_Name;"Journal Template Name")
                    {
                    }
                    column(Item_Journal_Line_Journal_Batch_Name;"Jo urnal Batch Name")
                    {
                    }
                    column(Item_Journal_Line_Line_No_;"Line No." )
                    {
                    }
 
                    trigger OnAfterGetRecord()
                    begin
                        if "Item No." <>'' then
                          Item.Get("Item No.")
                        else
                          Clear(Item); '' then
  
                        //>>ANICA 9-22-05 Add ANICA UOM Fields
                        It  emUOM.SetCurrentkey(ItemUOM."Item No.");
                        ItemUOM.SetRange(ItemUOM."Item No.",Item."No.");
                        if ItemUOM.Find('-') then
                        begin
                        PPack := ItemUOM.Pack; 
                        PSize := ItemUOM."Pack De begin
                            VDesc2 := Item."Description 2";
                            end;
                            //<<ANICA 6,  PSize;
                        end;
                }

                trigger OnAfterGetRecord()
                begin
                    //>>ANICA Add Batch Name to the report
                    ItemJnlBatchFilterPrint := 'Item Journal Batch ' + "Item Journal Batch".Name;
                    //<<ANICA
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Journal Template Name","Item Journal Template".Name);
                    if ItemJnlLineBatchFilter <> '' then
                      SetFilter(Name,ItemJnlLineBatchFilter);
                end; 
            }
   
            trigger OnPreDataItem()
            begin
                if ItemJnlLineTemplateFilter <> '' then begin
                  SetFilter(Name,ItemJnlLineTemplateFilter);
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;

        ItemJnlLineTemplateFilter := "Item Journal Line".GetFilter("Journal Template Name");
        ItemJnlLineBatchFilter := "Item Journal Line".GetFilter("Journal Batch Name");
        if ItemJnlLineTemplateFilter <> '' then begin
          "Item Journal Line".SetRange("Journal Template Name");
          "Item Journal Template".SetFilter(Name,ItemJnlLineTemplateFilter);
        end;
        if   ItemJnlLineBatchFilter <> '' then begin
            "Item Journal Line".SetRange("Journal B atch Name");
          "Item Journal Batch".SetFilter(Name,ItemJnlLineBatchFilter);
        end;
  
   
        ItemJnlLineFilter := "Item Journal Line".GetFilters;
        ItemJnlBatchFilter := "Item Journal Batch".GetFilters;
        ItemJnlTemplateFilter := "Item Journal Template".GetFilter(Name);
    end;

    var
        CompanyInformation: Record "Company Information";
        Item: Record Item;
        ItemJnlLineTemplateFilter: Text[250];
        ItemJnlLineBatchFilter: Text[250];
        ItemJnlLineFilter: Text[250];
        ItemJnlBatchFilter: Text[250];
        ItemJnlTemplateFilter: Text[250];
        ItemUOM: Record "Item Unit of Measure";
        PSize: Text[20];
        PPack: Decimal;
        PrtPack: Text[20];
        VDesc2: Text[40];
        Physical_Inventory_Count_SheetCaptionLbl: label 'Physical Inventory Count Sheet';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Shelf_Bin_No_CaptionLbl: label 'Shelf/Bin No.';
        Unit_of_MeasureCaptionLbl: label 'Unit of Measure';
        EmptyStringCaptionLbl: label 'Physical Count';
        Pack_SizeCaptionLbl: label 'Pack/Size';
        Vendor_Item_No_CaptionLbl: label 'Vendor Item No.';
        Vendor_No_CaptionLbl: label 'Vendor No.';
        ItemJnlBatchFilterPrint: Text[250];
}

