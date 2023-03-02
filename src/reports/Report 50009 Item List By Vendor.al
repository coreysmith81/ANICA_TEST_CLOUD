Report 50009 "Item List By Vendor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Item List By Vendor.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.") order(ascending);
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Vendor No.";
            column(ReportForNavId_8129; 8129)
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
            column(Item__Vendor_No__; "Vendor No.")
            {
            }
            column(PVendName; PVendName)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(PUOM; PUOM)
            {
            }
            column(Item__Unit_Price_; "Unit Price")
            {
            }
            column(VendorFile__No__; VendorFile."No.")
            {
            }
            column(PackPrint; PackPrint)
            {
            }
            column(Item__Gross_Weight_; "Gross Weight")
            {
            }
            column(Item__Vendor_Item_No__; "Vendor Item No.")
            {
            }
            column(Item__Description_2_; "Description 2")
            {
            }
            column(PFrtCde; PFrtCde)
            {
            }
            column(PFOB; PFOB)
            {
            }
            column(PManuCde; PManuCde)
            {
            }
            column(PGroupCode; PGroupCode)
            {
            }
            column(PCommodityCode; PCommodityCode)
            {
            }
            column(PRetunit; PRetunit)
            {
            }
            column(PLanded; PLanded)
            {
            }
            column(PRetail; PRetail)
            {
            }
            column(Item__Last_Date_Modified_; "Last Date Modified")
            {
            }
            column(PHaz; PHaz)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ANICA_1000_CATALOG_LISTINGCaption; ANICA_1000_CATALOG_LISTINGCaptionLbl)
            {
            }
            column(ORDER_NO_Caption; ORDER_NO_CaptionLbl)
            {
            }
            column(VENDOR_ITEM_NO_Caption; VENDOR_ITEM_NO_CaptionLbl)
            {
            }
            column(DESCRIPTIONCaption; DESCRIPTIONCaptionLbl)
            {
            }
            column(VENDOR_NO_Caption; VENDOR_NO_CaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(PACK_SIZECaption; PACK_SIZECaptionLbl)
            {
            }
            column(FRT_CDECaption; FRT_CDECaptionLbl)
            {
            }
            column(WEIGHTCaption; WEIGHTCaptionLbl)
            {
            }
            column(UNIT_PRICECaption; UNIT_PRICECaptionLbl)
            {
            }
            column(FOB_CDECaption; FOB_CDECaptionLbl)
            {
            }
            column(MFR__CODECaption; MFR__CODECaptionLbl)
            {
            }
            column(GROUP_CODECaption; GROUP_CODECaptionLbl)
            {
            }
            column(COM_CDECaption; COM_CDECaptionLbl)
            {
            }
            column(RET__UNITCaption; RET__UNITCaptionLbl)
            {
            }
            column(LANDEDCaption; LANDEDCaptionLbl)
            {
            }
            column(RETAILCaption; RETAILCaptionLbl)
            {
            }
            column(LAST_DATECaption; LAST_DATECaptionLbl)
            {
            }
            column(HAZCaption; HAZCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PVendName := '';

                VendorFile.SetCurrentkey(VendorFile."No.");
                VendorFile.SetRange(VendorFile."No.", Item."Vendor No.");

                if VendorFile.Find('-') then
                    PVendName := VendorFile.Name;

                PGroupCode := Item."Catalog Group Code";
                PCommodityCode := Item."Commodity Code";
                PRetunit := Item."Catalog UOM";

                if Item."Std Fixed Retail" <> 0 then
                    PRetail := Item."Std Fixed Retail";

                //>>CS 12-14-16: Changed section below from looking up Zone retail, to looking up Target Retail.
                if PRetail = 0 then begin
                    TargetRetail.SetCurrentkey("Item No.", UPC, Target);
                    TargetRetail.SetRange("Item No.", Item."No.");
                    TargetRetail.SetRange(UPC, Item."UPC for SMS");
                    TargetRetail.SetRange(Target, 'Z01'); //CS 12-14-16: Originally used the value from Zone 1/2 field.

                    if TargetRetail.Find('-') then
                        PRetail := TargetRetail.Retail
                    else
                        PRetail := 0;
                end;
                //<<
                if PRetail = 0 then
                    PRetail := Item."Std Floating Retail";

                PRetail := ROUND(PRetail, 0.01);
                PFOB := Item."FOB Code";
                PFrtCde := Item."Freight Code";
                PManuCde := Item."ANICA Manu Code";
                PHaz := Item."Hazardous Code";
                PLanded := Item."Store Landed Cost";
                PLanded := ROUND(PLanded, 0.01);

                UnitMeasure.SetCurrentkey(UnitMeasure."Item No.");
                UnitMeasure.SetRange(UnitMeasure."Item No.", Item."No.");

                if UnitMeasure.Find('-') then begin
                    PPack := UnitMeasure.Pack;
                    PSize := UnitMeasure."Pack Description";
                    PUOM := UnitMeasure.Code;
                    PackText := Format(PPack, 8);
                    PackPrint := PackText + '/' + PSize;
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
        ItemFilter := Item.GetFilters;
    end;

    var
        PackPrint: Text[30];
        CompanyInformation: Record "Company Information";
        ItemFilter: Text[250];
        VendorFile: Record Vendor;
        PVendName: Text[30];
        PGroupCode: Code[10];
        PCommodityCode: Code[10];
        PPack: Decimal;
        PSize: Text[10];
        PRetunit: Text[10];
        PRetail: Decimal;
        PFOB: Code[10];
        PFrtCde: Code[10];
        PUOM: Code[10];
        UnitMeasure: Record "Item Unit of Measure";
        PManuCde: Text[15];
        PLanded: Decimal;
        PackText: Text[10];
        PHaz: Boolean;
        TargetRetail: Record "Item Target Retail";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        ANICA_1000_CATALOG_LISTINGCaptionLbl: label 'ANICA 1000 CATALOG LISTING';
        ORDER_NO_CaptionLbl: label 'ORDER NO.';
        VENDOR_ITEM_NO_CaptionLbl: label 'VENDOR ITEM NO.';
        DESCRIPTIONCaptionLbl: label 'DESCRIPTION';
        VENDOR_NO_CaptionLbl: label 'VENDOR NO.';
        UOMCaptionLbl: label 'UOM';
        PACK_SIZECaptionLbl: label 'PACK/SIZE';
        FRT_CDECaptionLbl: label 'FRT CDE';
        WEIGHTCaptionLbl: label 'WEIGHT';
        UNIT_PRICECaptionLbl: label 'UNIT PRICE';
        FOB_CDECaptionLbl: label 'FOB CDE';
        MFR__CODECaptionLbl: label 'MFR. CODE';
        GROUP_CODECaptionLbl: label 'GROUP CODE';
        COM_CDECaptionLbl: label 'COM CDE';
        RET__UNITCaptionLbl: label 'RET. UNIT';
        LANDEDCaptionLbl: label 'LANDED';
        RETAILCaptionLbl: label 'RETAIL';
        LAST_DATECaptionLbl: label 'LAST DATE';
        HAZCaptionLbl: label 'HAZ';
}

