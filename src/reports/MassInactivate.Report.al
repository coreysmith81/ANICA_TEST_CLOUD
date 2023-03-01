Report 50173 "Mass Inactivate"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = sorting("Vendor No.");
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //IF "Vendor No." = 'SUPE004' THEN
                   // BEGIN
                        "ANICA Inactive" := true;
                   // END;

                Modify(true);
            end;

            trigger OnPreDataItem()
            begin
                SetCurrentkey("Vendor No.");
                SetRange("Vendor No.",VVendor);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(options)
                {
                    Caption = 'options';
                    field(VVendor;VVendor)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Vendor';
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
        VVendor: Code[50];
}

