Report 50136 "PDA Item File Creator (SKU)"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("PDA Export Table (SKU)";"PDA Export Table (SKU)")
        {
            column(ReportForNavId_7399; 7399)
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


                //Make a text version of the price
                VPrice := ROUND(Price,0.01);
                VTextPrice := Format(VPrice,6,'<Integer><Decimal,3>');
                VTextPrice := PadStr(VTextPrice,6,' ');

                //Make Text version of pack
                VPack := ROUND(Pack,0.0001);
                VTextPack := Format(VPack,15,'<Integer><Decimal,5>');
                VTextPack := PadStr(VTextPack,15,' ');

                //create output lines for SKU export file.
                VLineOutput := PadStr(SKU,13,' ') + PadStr("Item Number",20,' ') + PadStr(Description,60,' ') + PadStr(Vendor,10,' ') +
                    PadStr(Type ,15,' ') + PadStr(VTextPrice,6,' ') + PadStr(UOM,4,' ') + PadStr(VTextPack,15,' ') + ' ' +
                    PadStr("Pack Description",10,' ');

                VFileOutput.Write(VLineOutput);
            end;

            trigger OnPostDataItem()
            begin
                //for progress bar
                Window.Close;
                Clear(Window);

                PDAiExport.GetZone(VZone);
                PDAiExport.RunModal;
            end;

            trigger OnPreDataItem()
            begin
                //For progress bar
                begin
                    Clear(Window);
                    Window.Open('Processing Export File (SKU) @1@@@@@@@@');
                    TotalRec := COUNTAPPROX;
                    CurRec := 0;
                end;

                SetCurrentkey(SKU);
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

    trigger OnPostReport()
    begin
        Message('Your output files are at %1','\\EDISVR\MCL3\DATA\Price Files');
    end;

    trigger OnPreReport()
    begin
        PDAExport.RunModal;
        VZone := PDAExport.GetZone();

        VFileName := '\\EDISVR\MCL3\DATA\Price Files\am' + VZone + '.dat';
        VFileOutput.Create(VFileName);
        VFileOutput.TextMode(true);
    end;

    var
        ItemUOM: Record "Item Unit of Measure";
        PDA: Record "PDA Export Table (SKU)";
        PDAExport: Report "Table Creator For PDA files";
        PDAiExport: Report "PDA Export File Creator (Item)";
        VItemNo: Text[20];
        VDesc: Text[30];
        VDesc2: Text[30];
        VTelxVD: Text[10];
        VComCde: Text[10];
        VPrice: Decimal;
        VUOM: Text[10];
        VUPC: Code[20];
        VLineOutput: Text[200];
        VLineOutputItem: Text[200];
        VFileOutput: File;
        VFileName: Text[60];
        VFileNameItem: Text[60];
        VFileOutputItem: File;
        VTextPrice: Text[16];
        VZero: Text[1];
        VSpace: Text[1];
        VTExtUPC: Text[20];
        VZone: Code[10];
        VZoneSelect: Option;
        VZoneSelection: Text[30];
        VLength: Integer;
        VUPCCode: Code[20];
        VPack: Decimal;
        VPackDescription: Text[30];
        VTextPack: Text[20];
        Window: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
}

