Report 50023 "Archive Telxon Input File"
{
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Telxon Input File";"Telxon Input File")
        {
            DataItemTableView = sorting(Sequence) order(ascending) where(Processed=const(true));
            column(ReportForNavId_9733; 9733)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if FromDate = 0D then
                  begin
                      Message('No Archive Date Entered');
                      CurrReport.Quit;
                  end;

                if "Telxon Input File"."Processed Date" <= FromDate then
                    begin
                        GetArchiveNumber;
                        TelxonArchiveFile.Init;
                        TelxonArchiveFile."Archive Sequence" := TSequence;
                        TelxonArchiveFile.Insert(true);
                        TelxonArchiveFile.TransferFields("Telxon Input File");
                        TelxonArchiveFile.Modify(true);
                        //Delete Input Record after Archive
                        "Telxon Input File".Delete(true);
                    end
                else
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(FromDate;FromDate)
                    {
                        ApplicationArea = Basic;
                    }
                    label(Control2)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Text19036225;
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

    trigger OnPreReport()
    begin
        window.Open('Processing Record #1##########');
        repeat
        window.Update(1,"Telxon Input File".Sequence);
        until "Telxon Input File".Next = 0;
    end;

    var
        FromDate: Date;
        TelxonArchiveFile: Record "Archive Telxon Input File";
        TSequence: Integer;
        window: Dialog;
        Text19036225: label 'Archive Records Processed On or Before';


    procedure GetArchiveNumber()
    begin
        TelxonArchiveFile.LockTable;
        TelxonArchiveFile.SetCurrentkey("Archive Sequence");

        if TelxonArchiveFile.Find('+') then
            TSequence := TelxonArchiveFile."Archive Sequence" + 1
        else
            TSequence := 1;
    end;
}

