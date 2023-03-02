Report 50138 "PDA Export File Creator (Item)"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("PDA Export Table (Item No.)";"PDA Export Table (Item No.)")
        {
            DataItemTableView = sorting("Item Number") order(ascending);
            column(ReportForNavId_1527; 1527)
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

                VCheckFirst := CopyStr("Item Number",1,1);
                VLetterCheck := StrPos("Item Number",'A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z');
                VDashCheck := StrPos("Item Number",'-');
                VLength := StrLen("Item Number");

                if (VLength = 6) and (VLetterCheck = 0) and (VDashCheck = 0) then
                    begin
                        //Make a JBG version of the price
                        VPrice := ROUND(Price,0.01);
                        VTextPrice := Format(VPrice,6,'<Integer><Decimal,3>');
                        VTextPrice := PadStr(VTextPrice,6,' ');

                        //Make Text version of pack
                        VPack := ROUND(Pack,0.0001);
                        VTextPack := Format(VPack,15,'<Integer><Decimal,5>');
                        VTextPack := PadStr(VTextPack,15,' ');

                        //create output lines for Item export file.
                        VLineOutput_JBG := PadStr("Item Number",20,' ') + PadStr(SKU,13,' ') + PadStr(Description,60,' ') + PadStr(Vendor,10,' ')
                +
                            PadStr(Type ,15,' ') + PadStr(VTextPrice,6,' ') + PadStr(UOM,4,' ') + PadStr(VTextPack,15,' ') + ' ' +
                            PadStr("Pack Description",10,' ');

                        VFileOutputItem_JBG.Write(VLineOutput_JBG);
                    end

                else if (VLetterCheck = 0) and (VLength = 9) and (VDashCheck = 5) then
                    begin
                        //Make a ANICA version of the price
                        VPrice := ROUND(Price,0.01);
                        VTextPrice := Format(VPrice,6,'<Integer><Decimal,3>');
                        VTextPrice := PadStr(VTextPrice,6,' ');

                        //Make Text version of pack
                        VPack := ROUND(Pack,0.0001);
                        VTextPack := Format(VPack,15,'<Integer><Decimal,5>');
                        VTextPack := PadStr(VTextPack,15,' ');

                        //create output lines for Item export file.
                        VLineOutput_ANICA := PadStr("Item Number",20,' ') + PadStr(SKU,13,' ') + PadStr(Description,60,' ') +
                            PadStr(Vendor,10,' ') + PadStr(Type ,15,' ') + PadStr(VTextPrice,6,' ') + PadStr(UOM,4,' ') + PadStr(VTextPack,15,' ')
                            + ' ' + PadStr("Pack Description",10,' ');

                        VFileOutputItem_ANICA.Write(VLineOutput_ANICA);
                    end

                else
                    begin
                        //Make a OTHER version of the price
                        VPrice := ROUND(Price,0.01);
                        VTextPrice := Format(VPrice,6,'<Integer><Decimal,3>');
                        VTextPrice := PadStr(VTextPrice,6,' ');

                        //Make Text version of pack
                        VPack := ROUND(Pack,0.0001);
                        VTextPack := Format(VPack,15,'<Integer><Decimal,5>');
                        VTextPack := PadStr(VTextPack,15,' ');

                        //create output lines for Item export file.
                        VLineOutput_OTHER := PadStr("Item Number",20,' ') + PadStr(SKU,13,' ') + PadStr(Description,60,' ') +
                            PadStr(Vendor,10,' ') + PadStr(Type ,15,' ') + PadStr(VTextPrice,6,' ') + PadStr(UOM,4,' ') + PadStr(VTextPack,15,' ')
                            + ' ' + PadStr("Pack Description",10,' ');

                        VFileOutputItem_OTHER.Write(VLineOutput_OTHER);
                    end;
            end;

            trigger OnPostDataItem()
            begin
                //for progress bar
                Window.Close;
                Clear(Window);
            end;

            trigger OnPreDataItem()
            begin
                //For progress bar
                begin
                    Clear(Window);
                    Window.Open('Processing Export File (Item) @1@@@@@@@@');
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

    trigger OnPreReport()
    begin
        VFileNameItem_JBG := '\\EDISVR\MCL3\DATA\Price Files\aq' + VZone + '.dat';
        VFileOutputItem_JBG.Create(VFileNameItem_JBG);
        VFileOutputItem_JBG.TextMode(true);
        
        VFileNameItem_ANICA := '\\EDISVR\MCL3\DATA\Price Files\al' + VZone + '.dat';
        VFileOutputItem_ANICA.Create(VFileNameItem_ANICA);
        VFileOutputItem_ANICA.TextMode(true);
        
        VFileNameItem_OTHER := '\\EDISVR\MCL3\DATA\Price Files\ar' + VZone + '.dat';
        VFileOutputItem_OTHER.Create(VFileNameItem_OTHER);
        VFileOutputItem_OTHER.TextMode(true);
        
        
        //CS: using this to test whether file will write fine to a local folder
        /*
        VFileNameItem_JBG := 'C:\MCL3\DATA\Price Files\aq' + VZone + '.dat';
        VFileOutputItem_JBG.CREATE(VFileNameItem_JBG);
        VFileOutputItem_JBG.TEXTMODE(TRUE);
        
        VFileNameItem_ANICA := 'C:\MCL3\DATA\Price Files\al' + VZone + '.dat';
        VFileOutputItem_ANICA.CREATE(VFileNameItem_ANICA);
        VFileOutputItem_ANICA.TEXTMODE(TRUE);
        
        VFileNameItem_OTHER := 'C:\MCL3\DATA\Price Files\ar' + VZone + '.dat';
        VFileOutputItem_OTHER.CREATE(VFileNameItem_OTHER);
        VFileOutputItem_OTHER.TEXTMODE(TRUE);
        */

    end;

    var
        ItemUOM: Record "Item Unit of Measure";
        PDA: Record "PDA Export Table (SKU)";
        PDAExport: Report "Table Creator For PDA files";
        VItemNo: Text[20];
        VDesc: Text[30];
        VDesc2: Text[30];
        VTelxVD: Text[10];
        VComCde: Text[10];
        VPrice: Decimal;
        VUOM: Text[10];
        VUPC: Code[20];
        VLineOutput_JBG: Text[200];
        VLineOutputItem_JBG: Text[200];
        VFileOutput_JBG: File;
        VFileName_JBG: Text[60];
        VFileNameItem_JBG: Text[60];
        VFileOutputItem_JBG: File;
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
        VLineOutput_OTHER: Text[200];
        VLineOutputItem_OTHER: Text[200];
        VFileOutput_OTHER: File;
        VFileName_OTHER: Text[60];
        VFileNameItem_OTHER: Text[60];
        VFileOutputItem_OTHER: File;
        VCheckFirst: Text[5];
        VDashCheck: Integer;
        VLetterCheck: Integer;
        VLineOutput_ANICA: Text[200];
        VLineOutputItem_ANICA: Text[200];
        VFileOutput_ANICA: File;
        VFileName_ANICA: Text[60];
        VFileNameItem_ANICA: Text[60];
        VFileOutputItem_ANICA: File;


    procedure GetZone(VGetZone: Code[10])
    begin
        VZone := VGetZone;
    end;
}

