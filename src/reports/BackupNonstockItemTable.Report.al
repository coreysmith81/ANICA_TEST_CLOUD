Report 50106 "Backup Nonstock Item Table"
{
    // This routine backups the Nonstock Item Table.

    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Nonstock Item";"Nonstock Item")
        {
            column(ReportForNavId_7742; 7742)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For Progress Bar
                begin
                    CurRec := CurRec + 1;
                    if (TotalRec <> 0) then
                        Window.Update(1,ROUND(CurRec * 10000 / TotalRec,1));
                end;


                //The table filter limits the records to those that have not been processsed
                BackupNonstockItemFile.Init;
                BackupNonstockItemFile."Entry No." := "Nonstock Item"."Entry No.";
                BackupNonstockItemFile.Insert;
                BackupNonstockItemFile.TransferFields("Nonstock Item");
                BackupNonstockItemFile.Modify(true);
            end;

            trigger OnPostDataItem()
            begin
                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                DeleteExistingRecords;

                //For progress bar
                begin
                    Clear(Window);
                    Window.Open('Processing @1@@@@@@@@');
                    TotalRec := COUNTAPPROX;
                    CurRec := 0;
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

    var
        BackupNonstockItemFile: Record "Backup Nonstock Item";
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;


    procedure DeleteExistingRecords()
    begin
        //Delete the last backup before backing up the current file
        BackupNonstockItemFile.DeleteAll;
    end;
}

