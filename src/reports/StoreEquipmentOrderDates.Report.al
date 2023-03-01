Report 50060 "Store Equipment Order Dates"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Store Equipment Order Dates.rdlc';

    dataset
    {
        dataitem(SalesInvoiceLine;"Sales Invoice Line")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(ItemNo;SalesInvoiceLine."No.")
            {
            }
            column(Description;SalesInvoiceLine.Description)
            {
            }
            column(Description2;SalesInvoiceLine."Description 2")
            {
            }
            column(ShipmentDate;SalesInvoiceLine."Shipment Date")
            {
            }
            column(OrderNumber;SalesInvoiceLine."Document No.")
            {
            }
            column(Quantity;SalesInvoiceLine.Quantity)
            {
            }
            column(VStore;VStore)
            {
            }
            column(VStartDate;VStartDate)
            {
            }
            column(VEndDate;VEndDate)
            {
            }

            trigger OnPreDataItem()
            begin
                SetRange(SalesInvoiceLine."Sell-to Customer No.",VStore);

                if (VStartDate > 0D) and (VEndDate > 0D) then
                    SetRange("Shipment Date",VStartDate,VEndDate)
                else if (VStartDate > 0D) and (VEndDate = 0D) then
                    SetFilter("Shipment Date",'VStartDate..')
                else if (VStartDate = 0D) and (VEndDate > 0D) then
                    SetFilter("Shipment Date",'..VEndDate');



                SetFilter("No.",'0025-0023|0025-9089|0025-9091|0025-9088|0025-9086|0025-9094|0025-9095|0025-9084'+
                    '|0025-9078|0025-9055|0025-9038|0025-9032|0025-9016|0025-9042|0025-9045|ONP-7197-2015-9001|ONP-7402-1024-8801|ONP-7892-1292-0000');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(VStore;VStore)
                {
                    ApplicationArea = Basic;
                    Caption = 'Store (ie. ANIC001)';
                }
                field(VStartDate;VStartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting Date';
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field(VEndDate;VEndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending Date';
                    NotBlank = true;
                    ShowMandatory = true;
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
        VStore: Code[10];
        VStartDate: Date;
        VEndDate: Date;
}

