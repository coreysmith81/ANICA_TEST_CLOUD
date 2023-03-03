Report 50091 "ANICA Reorder Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ANICA Reorder Report.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = "Qty. on Purch. Order";
            DataItemTableView = sorting("Vendor No.");
            RequestFilterFields = Blocked, "Created From Nonstock Item", "Drop Ship Item", "ANICA Inactive", "Inventory Posting Group", "Location Filter", "Vendor No.", "No.", "Search Description", "Assembly BOM", "Shelf No.", "Drop Shipment Filter";
            column(ReportForNavId_8129; 8129)
            {
            }
            column(Inventory___Reorders_; 'Inventory - Reorders')
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
            column(Item_Item__Vendor_No__; Item."Vendor No.")
            {
            }
            column(Vend_Name; Vend.Name)
            {
            }
            column(Vend__Phone_No__; Vend."Phone No.")
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__Base_Unit_of_Measure_; "Base Unit of Measure")
            {
            }
            column(Item__Vendor_Item_No__; "Vendor Item No.")
            {
            }
            column(Item__Lead_Time_Calculation_; "Lead Time Calculation")
            {
            }
            column(Item__Qty__on_Purch__Order_; "Qty. on Purch. Order")
            {
            }
            column(QtyAvailable; QtyAvailable)
            {
                DecimalPlaces = 0 : 5;
            }
            column(Item__Reorder_Quantity_; "Reorder Quantity")
            {
            }
            column(Item__Reorder_Point_; "Reorder Point")
            {
                DecimalPlaces = 0 : 5;
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(Item_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; FieldCaption("Base Unit of Measure"))
            {
            }
            column(Item__Vendor_Item_No__Caption; FieldCaption("Vendor Item No."))
            {
            }
            column(Item__Lead_Time_Calculation_Caption; FieldCaption("Lead Time Calculation"))
            {
            }
            column(Item__Qty__on_Purch__Order_Caption; FieldCaption("Qty. on Purch. Order"))
            {
            }
            column(QtyAvailableCaption; QtyAvailableCaptionLbl)
            {
            }
            column(Item__Reorder_Quantity_Caption; FieldCaption("Reorder Quantity"))
            {
            }
            column(Reorder_PointCaption; Reorder_PointCaptionLbl)
            {
            }
            column(Vend__Phone_No__Caption; Vend__Phone_No__CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if not Vend.Get(Item."Vendor No.") then
                    Vend.Init;

                CalcFields(Inventory, "Qty. on Purch. Order", "Qty. on Sales Order", "Scheduled Receipt (Qty.)", "Scheduled Need (Qty.)");
                //QtyAvailable :=
                //  "Quantity on Hand" + "Qty. on Purch. Order" - "Qty. on Sales Order" + "Scheduled Receipt (Qty.)" - "Scheduled Need (Qty.)";
                //QtyAvailable :=  Inventory;
                QtyAvailable := Inventory - "Qty. on Sales Order";
                //  Inventory - "Qty. on Sales Order" + "Scheduled Receipt (Qty.)" - "Scheduled Need (Qty.)";

                if QtyAvailable >= "Reorder Point" then
                    CurrReport.Skip;

                ReorderQty :=
                  AvailableMgt.GetItemReorderQty(Item, QtyAvailable);
                //  Changed line above from line below to remove req code ANICA 8-3-04
                //  AvailableMgt.GetItemReorderQty(Item,Item."Requisition Method Code",QtyAvailable);
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
        ItemFilter := Item.GetFilters;
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
        Vend: Record Vendor;
        AvailableMgt: Codeunit "Available Management";
        ItemFilter: Text[250];
        QtyAvailable: Decimal;
        ReorderQty: Decimal;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        QtyAvailableCaptionLbl: label 'Available Inventory';
        Reorder_PointCaptionLbl: label 'Reorder Point';
        Vend__Phone_No__CaptionLbl: label 'Phone No.';
}

