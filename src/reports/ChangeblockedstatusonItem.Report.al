Report 50170 "Change blocked status on Item"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_8129; 8129)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Determne if we are moving the blocked field to order block or restoring it
                //Run type 0 is remove the blocks, 1 is restore the blocks

                if RunType = 0 then
                begin
                   if Item.Blocked = true then
                   begin
                   //remove the block, but check the order block field so we know which ones were blocked
                   Item."Order Block" := true;
                   Item.Blocked := false;
                   Item."Blocked Date" := Item."Last Date Modified";
                   Item.Modify(true);
                   end;
                end
                else
                begin
                   if Item."Order Block" = true then
                   begin
                   //change the codes back
                   Item."Order Block" := false;
                   Item.Blocked := true;
                   Item.Modify(true);
                   end;
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

        Window.Open('Processing Record #1##########');
        repeat
        Window.Update(1,Item."No.");
        until Item.Next = 0;
    end;

    var
        RunType: Option;
        Window: Dialog;
}

