Report 50096 "ANICA Availability Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ANICA Availability Status.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Search Description", "Assembly BOM", "Inventory Posting Group", "Vendor No.", "Location Filter", "Created From Nonstock Item", "Drop Ship Item", "ANICA Inactive";
            column(ReportForNavId_8129; 8129)
            {
            }
            column(Availability_Status_; 'Availability Status')
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Time; Time)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Item_TABLENAME__________ItemFilter; Item.TableName + ': ' + ItemFilter)
            {
            }
            column(Item__Inventory_Posting_Group_; "Inventory Posting Group")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; FieldCaption("Base Unit of Measure"))
            {
            }
            column(Item_InventoryCaption; FieldCaption(Inventory))
            {
            }
            column(Item__Qty__on_Sales_Order_Caption; FieldCaption("Qty. on Sales Order"))
            {
            }
            column(BackOrderQuantityCaption; BackOrderQuantityCaptionLbl)
            {
            }
            column(Item__Qty__on_Purch__Order_Caption; FieldCaption("Qty. on Purch. Order"))
            {
            }
            column(QtyAvailableCaption; QtyAvailableCaptionLbl)
            {
            }
            column(Item__Reorder_Point_Caption; FieldCaption("Reorder Point"))
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(Item_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Item__Bill_of_Materials_Caption; FieldCaption("Assembly BOM"))
            {
            }
            column(Item__Reorder_Quantity_Caption; FieldCaption("Reorder Quantity"))
            {
            }
            column(Item__Inventory_Posting_Group_Caption; FieldCaption("Inventory Posting Group"))
            {
            }
            column(Item_No_; "No.")
            {
            }
            dataitem("BOM Component"; "BOM Component")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Parent Item No.", "Line No.");
                column(ReportForNavId_8421; 8421)
                {
                }
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
                {
                }
                column(Item__No__; Item."No.")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }
                column(Item__Bill_of_Materials_; Item."Assembly BOM")
                {
                }
                column(Item_Inventory; Item.Inventory)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Item__Qty__on_Sales_Order_; Item."Qty. on Sales Order")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(BackOrderQuantity; -BackOrderQuantity)
                {
                }
                column(Item__Qty__on_Purch__Order_; Item."Qty. on Purch. Order")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(QtyAvailable; QtyAvailable)
                {
                }
                column(Item__Reorder_Point_; Item."Reorder Point")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Item__Reorder_Quantity_; Item."Reorder Quantity")
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    QuantityOnBOM := BOMIncrease - BOMDecrease;
                    QtyAvailable := Item.Inventory - Item."Qty. on Sales Order";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                BOMIncrease := 0;
                BOMDecrease := 0;
                //LCC removed BOM 5-14-15
                //CALCFIELDS(Inventory,"Qty. on Sales Order","Qty. on Purch. Order","Bill of Materials");
                CalcFields(Inventory, "Qty. on Sales Order", "Qty. on Purch. Order");
                BackOrderQuantity := Inventory - "Qty. on Sales Order";
                if BackOrderQuantity >= 0 then
                    Clear(BackOrderQuantity);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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
        ItemFilter := Item.GetFilters;
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
        ItemFilter: Text[250];
        BOMIncrease: Decimal;
        BOMDecrease: Decimal;
        QuantityOnBOM: Decimal;
        BackOrderQuantity: Decimal;
        QtyAvailable: Decimal;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        BackOrderQuantityCaptionLbl: label 'Back Orders';
        QtyAvailableCaptionLbl: label 'Quantity Available';
}

