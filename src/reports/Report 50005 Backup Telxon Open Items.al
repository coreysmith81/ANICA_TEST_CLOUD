Report 50005 "Backup Telxon Open Items"
{
    // This routine backups the unprocessed items in the Telxon Input file after the morning import in case the
    // table items are accidentally delted.

    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Telxon Input File";"Telxon Input File")
        {
            DataItemTableView = sorting(Processed,"Batch Name",Sequence) order(ascending) where(Processed=const(false));
            column(ReportForNavId_9733; 9733)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //The table filter limits the records to those that have not been processsed
                BackupTelxonInputFile.Init;
                BackupTelxonInputFile.Sequence := "Telxon Input File".Sequence;
                BackupTelxonInputFile.Insert;
                BackupTelxonInputFile.TransferFields("Telxon Input File");
                BackupTelxonInputFile.Modify(true);
            end;

            trigger OnPreDataItem()
            begin
                DeleteExistingRecords;
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
        BackupTelxonInputFile: Record "Backup Telxon Input File";


    procedure DeleteExistingRecords()
    begin
        //Delete the last backup before backing up the current file
        BackupTelxonInputFile.DeleteAll;
    end;
}

