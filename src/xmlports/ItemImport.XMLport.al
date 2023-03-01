XmlPort 50091 "Item Import"
{
    Caption = 'Item Import';
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Item;Item)
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'Item';
                fieldelement(ItemNo;Item."No.")
                {
                }
                fieldelement(Description;Item.Description)
                {
                }
                fieldelement(Description2;Item."Description 2")
                {
                }
                textelement(VVendorNo)
                {
                }
                textelement(VVendorItemNo)
                {
                }
                textelement(VUPCsms)
                {
                }
                textelement(TxtUnitCost)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VUnitCost,TxtUnitCost) = false then Message('Invalid Amount');
                    end;
                }
                textelement(TxtUnitPrice)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VUnitPrice,TxtUnitCost) = false then Message('Invalid Amount');
                    end;
                }
                textelement(VTelxonVendor)
                {
                }
                textelement(VProdPosting)
                {
                }
                textelement(VInvPosting)
                {
                }
                textelement(VCategoryCode)
                {
                }
                textelement(VCommodityCode)
                {
                }
                textelement(VFreightCode)
                {
                }
                textelement(VCatGroupCode)
                {
                }
                textelement(VBaseUOM)
                {
                }
                textelement(TxtQtyUOM)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VQtyUOM,TxtQtyUOM) = false then Message('Invalid Amount');
                    end;
                }
                textelement(TxtUPCPackDivider)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VUPCPackDivider,TxtUPCPackDivider) = false then Message('Invalid Amount');
                        VUOMPack := VUPCPackDivider;//Use the UPC Pack Divider for the Base UOM update
                    end;
                }
                textelement(VUOMPackDesc)
                {
                }
                textelement(VSalesUOM)
                {
                }
                textelement(VPurchUOM)
                {
                }
                textelement(TxtZRZone1)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VZRZone1,TxtZRZone1) = false then Message('Invalid Amount');
                    end;
                }
                textelement(TxtZRZone3)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VZRZone3,TxtZRZone3) = false then Message('Invalid Amount');
                    end;
                }
                textelement(TxtZRZoneN)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VZRZoneN,TxtZRZoneN) = false then Message('Invalid Amount');
                    end;
                }
                textelement(TxtGrossWt)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VGrossWt,TxtGrossWt) = false then Message('Invalid Amount');
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    with Item do
                        begin
                            "Drop Ship Item" := true; //all yes
                            "Vendor No." := VVendorNo;
                            "Vendor Item No." := VVendorItemNo;
                            "UPC for SMS" := VUPCsms;
                            "Unit Cost" := VUnitCost;
                            "Unit Price" := VUnitPrice;
                            "Telxon Vendor Code" := VTelxonVendor;
                            "Gen. Prod. Posting Group" :=  VProdPosting;
                            "Inventory Posting Group" := VInvPosting;
                            "Item Category Code" := VCategoryCode;
                            "Commodity Code" := VCommodityCode;
                            "Freight Code" := VFreightCode;
                            "Catalog Group Code" := VCatGroupCode;
                            "Sales Unit of Measure" := VSalesUOM;
                            "Purch. Unit of Measure" := VPurchUOM;
                            "Gross Weight" := VGrossWt;
                            "Costing Method" := 3;//Average for all items
                            "FOB Code" := 'ANC';//All Items
                            //"Pick Type" := 9; //all snacks
                        end;

                    VItemNo := Item."No.";

                    ItemUOMUpdate;
                    Item."Base Unit of Measure" := VBaseUOM;

                    UPCUpdate;

                    ZoneRetailUpdate;


                    //SMSSubDeptUpdate;
                    //Item."SMS Subdepartment" := VSMSSubDepartment;
                    //CS 2/22/17: Making this particular import all SMS Subdepartment 27
                    Item."SMS Subdepartment" := 27;
                end;
            }
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

    trigger OnPostXmlPort()
    begin
        //For Status Box
        Window.Close;
        Clear(Window);
        Message('Import is Done');
    end;

    trigger OnPreXmlPort()
    begin
        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
        end;
    end;

    var
        ItemUOM: Record "Item Unit of Measure";
        UPC: Record "Item UPC Table";
        ZoneRetail: Record "Margin Category";
        CommCodeTable: Record "Commodity Code";
        VItemNo: Text;
        VIsDropShip: Boolean;
        VUnitCost: Decimal;
        VANICALandedCost: Decimal;
        VUnitPrice: Decimal;
        VGrossWt: Decimal;
        VPickType: Option;
        VQtyUOM: Integer;
        VUOMPack: Integer;
        VUPCPackDivider: Integer;
        VZRZone1: Decimal;
        VZRZone3: Decimal;
        VZRZoneN: Decimal;
        Window: Dialog;
        VSMSSubDepartment: Integer;

    local procedure ItemUOMUpdate()
    begin
        ItemUOM.SetCurrentkey("Item No.",Code);

        ItemUOM.Init;
        ItemUOM."Item No." := VItemNo;
        ItemUOM.Code := VBaseUOM;
        ItemUOM.Insert;

        ItemUOM."Qty. per Unit of Measure" := VQtyUOM;
        ItemUOM."Pack Description" := VUOMPackDesc;
        ItemUOM.Pack := VUOMPack;
        ItemUOM.Modify(true);

        Clear(ItemUOM);
    end;

    local procedure UPCUpdate()
    begin
        UPC.SetCurrentkey("Item No.", UPC);

        UPC.Init;
        UPC."Item No." := VItemNo;
        UPC.UPC := VUPCsms;
        UPC.Insert;

        UPC."Pack Descrip" := VUOMPackDesc;
        UPC."Pack Divider" := VUPCPackDivider;
        UPC."Zone 1 Retail" := VZRZone1;
        UPC."Zone 3 Retail" := VZRZone3;
        UPC."Zone N Retail" := VZRZoneN;
        UPC.Modify(true);

        Clear(UPC);
    end;

    local procedure ZoneRetailUpdate()
    begin
        ZoneRetail.SetCurrentkey("Margin Category",Margin);

        ZoneRetail.Init;
        ZoneRetail."Margin Category" := VItemNo;
        ZoneRetail.Margin := '912';
        ZoneRetail.Insert;

        ZoneRetail."Fixed Retail Zone 1/2" := VZRZone1;
        ZoneRetail."Fixed Retail Zone 3" := VZRZone3;
        ZoneRetail."Fixed Retail Zone N" := VZRZoneN;
        ZoneRetail.Modify(true);

        Clear(ZoneRetail);
    end;

    local procedure SMSSubDeptUpdate()
    begin
        CommCodeTable.SetCurrentkey("Commodity Code");
        CommCodeTable.SetRange("Commodity Code",VCommodityCode);
        if CommCodeTable.Find('-') then VSMSSubDepartment := CommCodeTable."SMS Sub Department";
    end;
}

