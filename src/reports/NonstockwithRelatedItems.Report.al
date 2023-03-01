Report 50100 "Nonstock with Related Items"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Nonstock with Related Items.rdlc';

    dataset
    {
        dataitem("Nonstock Item";"Nonstock Item")
        {
            DataItemTableView = sorting("Vendor No.","Vendor Item No.") order(ascending) where("Vendor No."=const('JBGO001'));
            RequestFilterFields = "Vendor Item No.";
            column(ReportForNavId_7742; 7742)
            {
            }
            column(Today;Today)
            {
            }
            column(Time;Time)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(NonStock_ItemCaption;NonStock_ItemCaptionLbl)
            {
            }
            column(JBG_NONSTOCK_ITEMS_WITH_RELATED_ITEMSCaption;JBG_NONSTOCK_ITEMS_WITH_RELATED_ITEMSCaptionLbl)
            {
            }
            column(NonStock_UPCCaption;NonStock_UPCCaptionLbl)
            {
            }
            column(Item_UPCCaption;Item_UPCCaptionLbl)
            {
            }
            column(PAGECaption;PAGECaptionLbl)
            {
            }
            column(Item_No_Caption;Item_No_CaptionLbl)
            {
            }
            column(Nonstock_PackCaption;Nonstock_PackCaptionLbl)
            {
            }
            column(NonStock_DescriptionCaption;NonStock_DescriptionCaptionLbl)
            {
            }
            column(Item_DescriptionCaption;Item_DescriptionCaptionLbl)
            {
            }
            column(Inactive__BlockedCaption;Inactive__BlockedCaptionLbl)
            {
            }
            column(Item_PackCaption;Item_PackCaptionLbl)
            {
            }
            column(Nonstock_Item_Entry_No_;"Entry No.")
            {
            }
            column(Nonstock_Item_Item_No_;"Item No.")
            {
            }
            dataitem(Item;Item)
            {
                DataItemLink = "No."=field("Item No.");
                DataItemTableView = sorting("No.");
                column(ReportForNavId_8129; 8129)
                {
                }
                column(Item__No__;"No.")
                {
                }
                column(Item_Description;Description)
                {
                }
                column(Item__UPC_for_SMS_;"UPC for SMS")
                {
                }
                column(Nonstock_Item___Vendor_Item_No__;"Nonstock Item"."Vendor Item No.")
                {
                }
                column(Nonstock_Item__Description;"Nonstock Item".Description)
                {
                }
                column(Nonstock_Item___UPC_Code_for_SMS_;"Nonstock Item"."UPC Code for SMS")
                {
                }
                column(Item__ANICA_Inactive_;"ANICA Inactive")
                {
                }
                column(Nonstock_Item__Pack;"Nonstock Item".Pack)
                {
                }
                column(Nonstock_Item___Pack_Description_;"Nonstock Item"."Pack Description")
                {
                }
                column(Vpack;Vpack)
                {
                }
                column(VPackDescription;VPackDescription)
                {
                }
                column(Item_Blocked;Blocked)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Run per variables in request form
                    if VInactiveOnly = true then
                        if Item."ANICA Inactive" = false then CurrReport.Skip;
                    if VUnMatchedUPC = true then
                        if Item."UPC for SMS" = "Nonstock Item"."UPC Code for SMS" then CurrReport.Skip;

                    // Update the pack on the item unit of measure table
                      Vpack := 0;
                      VPackDescription := '';
                      ItemUOM.SetCurrentkey(ItemUOM."Item No.");
                      ItemUOM.SetRange(ItemUOM."Item No.",Item."No.");
                        if ItemUOM.Find('-') then
                        begin
                        Vpack := ItemUOM.Pack;
                        VPackDescription := ItemUOM."Pack Description";
                        end;
                      ItemUOM.SetRange(ItemUOM."Item No.");//clear filter
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Nonstock Item"."Manufacturer Code" <> 'G' then CurrReport.Skip;
                if "Nonstock Item"."ANICA Inactive" = true then CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(VUnMatchedUPC;VUnMatchedUPC)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Report Only Unmatched UPC''s';
                    }
                    field(VInactiveOnly;VInactiveOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Report Only Inactive - Nonstock is Active';
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

    var
        ItemUOM: Record "Item Unit of Measure";
        Vpack: Decimal;
        VPackDescription: Text[20];
        VUnMatchedUPC: Boolean;
        VInactiveOnly: Boolean;
        Text19070446: label 'Report Only Unmatched UPC''s';
        Text19037253: label 'Report Only Inactive Items - Nonstock is Active';
        NonStock_ItemCaptionLbl: label 'NonStock Item';
        JBG_NONSTOCK_ITEMS_WITH_RELATED_ITEMSCaptionLbl: label 'JBG NONSTOCK ITEMS WITH RELATED ITEMS';
        NonStock_UPCCaptionLbl: label 'NonStock UPC';
        Item_UPCCaptionLbl: label 'Item UPC';
        PAGECaptionLbl: label 'PAGE';
        Item_No_CaptionLbl: label 'Item No.';
        Nonstock_PackCaptionLbl: label 'Nonstock Pack';
        NonStock_DescriptionCaptionLbl: label 'NonStock Description';
        Item_DescriptionCaptionLbl: label 'Item Description';
        Inactive__BlockedCaptionLbl: label 'Inactive  Blocked';
        Item_PackCaptionLbl: label 'Item Pack';
}

