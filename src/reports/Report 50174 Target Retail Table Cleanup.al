Report 50174 "Target Retail Table Cleanup"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Target Retail";"Item Target Retail")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VItemNo := "Item No.";
                VUPC := UPC;

                LookupUPC;
            end;
        }
        dataitem("Nonstock Target Retail";"Nonstock Target Retail")
        {
            column(ReportForNavId_1000000001; 1000000001)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VNSEntryNo := "Entry No.";
                VUPC := UPC;

                LookupNSUPC;
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

    var
        ItemUPC: Record "Item UPC Table";
        NSItemUPC: Record "Nonstock UPC Table";
        VItemNo: Code[30];
        VUPC: Code[30];
        VNSEntryNo: Code[20];


    procedure LookupUPC()
    begin
        ItemUPC.SetCurrentkey("Item No.",UPC);
        ItemUPC.SetRange("Item No.",VItemNo);
        ItemUPC.SetRange(UPC,VUPC);

        if ItemUPC.Find('-') then
            CurrReport.Skip
        else
            "Item Target Retail".Delete;
    end;


    procedure LookupNSUPC()
    begin
        NSItemUPC.SetCurrentkey("Nonstock Entry No.",UPC);
        NSItemUPC.SetRange("Nonstock Entry No.",VNSEntryNo);
        NSItemUPC.SetRange(UPC,VUPC);

        if NSItemUPC.Find('-') then
            CurrReport.Skip
        else
            "Nonstock Target Retail".Delete;
    end;
}

