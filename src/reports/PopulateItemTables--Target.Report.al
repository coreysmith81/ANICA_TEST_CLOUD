Report 50160 "Populate Item Tables -- Target"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Populate Item Tables -- Target.rdlc';

    dataset
    {
        dataitem("Nonstock Item";"Nonstock Item")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Check if Inactive
                if "ANICA Inactive" then
                    CurrReport.Skip;

                //Get Entry No.
                VEntryNo := "Entry No.";

                //Lookup Entry No. in Nonstock UPC Table
                NonstockUPC.SetCurrentkey("Nonstock Entry No.",UPC);
                NonstockUPC.SetRange("Nonstock Entry No.",VEntryNo);

                //If Entry No. is found, then get the Zone Retails, Date Created, Last Modified, and User
                if NonstockUPC.Find('-') then repeat
                    begin
                        VUPC := NonstockUPC.UPC;
                        VZone1Retail := NonstockUPC."Zone 1 Retail";
                        VZone3Retail := NonstockUPC."Zone 3 Retail";
                        VZoneNRetail := NonstockUPC."Zone N Retail";
                        VDateCreated := NonstockUPC."Date Created";
                        VLastModified := NonstockUPC."Last Date Updated";
                        VLastUser := NonstockUPC."Last User";

                        //Create an Nonstock Target Retail Record for each of the Retails.
                        //If Zone 1 Retail is not 0, create Nonstock Target Record
                        if VZone1Retail <> 0 then
                            begin
                                NonstockTarget.SetCurrentkey("Entry No.",UPC,Target);
                                NonstockTarget.SetRange("Entry No.",VEntryNo);
                                NonstockTarget.SetRange(UPC,VUPC);
                                NonstockTarget.SetRange(Target,'Z01');

                                if not NonstockTarget.Find('-') then
                                    begin
                                        NonstockTarget.Init;
                                        NonstockTarget."Entry No." := VEntryNo;
                                        NonstockTarget.UPC := VUPC;
                                        NonstockTarget.Target := 'Z01';
                                        NonstockTarget.Retail := VZone1Retail;
                                        NonstockTarget."Date Created" := VDateCreated;
                                        NonstockTarget."Last Modified" := VLastModified;
                                        NonstockTarget."Last User" := VLastUser;
                                        NonstockTarget.Insert;
                                    end;
                            end;

                        //If Zone 3 Retail is not 0, create Nonstock Target Record
                        if VZone3Retail <> 0 then
                            begin
                                NonstockTarget.SetCurrentkey("Entry No.",UPC,Target);
                                NonstockTarget.SetRange("Entry No.",VEntryNo);
                                NonstockTarget.SetRange(UPC,VUPC);
                                NonstockTarget.SetRange(Target,'Z03');

                                if not NonstockTarget.Find('-') then
                                    begin
                                        NonstockTarget.Init;
                                        NonstockTarget."Entry No." := VEntryNo;
                                        NonstockTarget.UPC := VUPC;
                                        NonstockTarget.Target := 'Z03';
                                        NonstockTarget.Retail := VZone3Retail;
                                        NonstockTarget."Date Created" := VDateCreated;
                                        NonstockTarget."Last Modified" := VLastModified;
                                        NonstockTarget."Last User" := VLastUser;
                                        NonstockTarget.Insert;
                                    end;
                            end;

                        //If Zone N Retail is not 0, create Nonstock Target Record
                        if VZoneNRetail <> 0 then
                            begin
                                NonstockTarget.SetCurrentkey("Entry No.",UPC,Target);
                                NonstockTarget.SetRange("Entry No.",VEntryNo);
                                NonstockTarget.SetRange(UPC,VUPC);
                                NonstockTarget.SetRange(Target,'Z0N');

                                if not NonstockTarget.Find('-') then
                                    begin
                                        NonstockTarget.Init;
                                        NonstockTarget."Entry No." := VEntryNo;
                                        NonstockTarget.UPC := VUPC;
                                        NonstockTarget.Target := 'Z0N';
                                        NonstockTarget.Retail := VZoneNRetail;
                                        NonstockTarget."Date Created" := VDateCreated;
                                        NonstockTarget."Last Modified" := VLastModified;
                                        NonstockTarget."Last User" := VLastUser;
                                        NonstockTarget.Insert;
                                    end;
                            end;

                        //Use Zone N of the 031 Target for now
                        if VZoneNRetail <> 0 then
                            begin
                                NonstockTarget.SetCurrentkey("Entry No.",UPC,Target);
                                NonstockTarget.SetRange("Entry No.",VEntryNo);
                                NonstockTarget.SetRange(UPC,VUPC);
                                NonstockTarget.SetRange(Target,'031');

                                if not NonstockTarget.Find('-') then
                                    begin
                                        NonstockTarget.Init;
                                        NonstockTarget."Entry No." := VEntryNo;
                                        NonstockTarget.UPC := VUPC;
                                        NonstockTarget.Target := '031';
                                        NonstockTarget.Retail := VZoneNRetail;
                                        NonstockTarget."Date Created" := VDateCreated;
                                        NonstockTarget."Last Modified" := VLastModified;
                                        NonstockTarget."Last User" := VLastUser;
                                        NonstockTarget.Insert;
                                    end;
                            end;
                    end;
                until NonstockUPC.Next = 0;
            end;
        }
        dataitem(Item;Item)
        {
            column(ReportForNavId_1000000001; 1000000001)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Check if Inactive
                if "ANICA Inactive" then
                    CurrReport.Skip;

                //Get Entry No. & UPC
                VItemNo := "No.";

                //Lookup Entry No. in Item UPC Table
                ItemUPC.SetCurrentkey("Item No.",UPC);
                ItemUPC.SetRange("Item No.",VItemNo);

                //If Entry No. is found, then get the UPC, Zone Retails, Date Created, Last Modified, and User
                if ItemUPC.Find('-') then
                    repeat
                        begin
                            VUPC := ItemUPC.UPC;
                            VZone1Retail := ItemUPC."Zone 1 Retail";
                            VZone3Retail := ItemUPC."Zone 3 Retail";
                            VZoneNRetail := ItemUPC."Zone N Retail";
                            VDateCreated := ItemUPC."Date Created";
                            VLastModified := ItemUPC."Last Date Updated";
                            VLastUser := ItemUPC."Last User";

                            //Create an Item Target Retail Record for each of the Retails.
                            //If Zone 1 Retail is not 0, create Item Target Record
                            if VZone1Retail <> 0 then
                                begin
                                    ItemTarget.SetCurrentkey("Item No.",UPC,Target);
                                    ItemTarget.SetRange("Item No.",VItemNo);
                                    ItemTarget.SetRange(UPC,VUPC);
                                    ItemTarget.SetRange(Target,'Z01');

                                    if not ItemTarget.Find('-') then
                                        begin
                                            ItemTarget.Init;
                                            ItemTarget."Item No." := VItemNo;
                                            ItemTarget.UPC := VUPC;
                                            ItemTarget.Target := 'Z01';
                                            ItemTarget.Retail := VZone1Retail;
                                            ItemTarget."Date Created" := VDateCreated;
                                            ItemTarget."Last Modified" := VLastModified;
                                            ItemTarget."Last User" := VLastUser;
                                            ItemTarget.Insert;
                                        end;
                                end;

                            //If Zone 3 Retail is not 0, create Item Target Record
                            if VZone3Retail <> 0 then
                                begin
                                    ItemTarget.SetCurrentkey("Item No.",UPC,Target);
                                    ItemTarget.SetRange("Item No.",VItemNo);
                                    ItemTarget.SetRange(UPC,VUPC);
                                    ItemTarget.SetRange(Target,'Z03');

                                    if not ItemTarget.Find('-') then
                                        begin
                                            ItemTarget.Init;
                                            ItemTarget."Item No." := VItemNo;
                                            ItemTarget.UPC := VUPC;
                                            ItemTarget.Target := 'Z03';
                                            ItemTarget.Retail := VZone3Retail;
                                            ItemTarget."Date Created" := VDateCreated;
                                            ItemTarget."Last Modified" := VLastModified;
                                            ItemTarget."Last User" := VLastUser;
                                            ItemTarget.Insert;
                                        end;
                                end;

                            //If Zone N Retail is not 0, create Item Target Record
                            if VZoneNRetail <> 0 then
                                begin
                                    ItemTarget.SetCurrentkey("Item No.",UPC,Target);
                                    ItemTarget.SetRange("Item No.",VItemNo);
                                    ItemTarget.SetRange(UPC,VUPC);
                                    ItemTarget.SetRange(Target,'Z0N');

                                    if not ItemTarget.Find('-') then
                                        begin
                                            ItemTarget.Init;
                                            ItemTarget."Item No." := VItemNo;
                                            ItemTarget.UPC := VUPC;
                                            ItemTarget.Target := 'Z0N';
                                            ItemTarget.Retail := VZoneNRetail;
                                            ItemTarget."Date Created" := VDateCreated;
                                            ItemTarget."Last Modified" := VLastModified;
                                            ItemTarget."Last User" := VLastUser;
                                            ItemTarget.Insert;
                                        end;
                                end;

                            //Use Zone N of the 031 Target for now
                            if VZoneNRetail <> 0 then
                                begin
                                    ItemTarget.SetCurrentkey("Item No.",UPC,Target);
                                    ItemTarget.SetRange("Item No.",VItemNo);
                                    ItemTarget.SetRange(UPC,VUPC);
                                    ItemTarget.SetRange(Target,'031');

                                    if not ItemTarget.Find('-') then
                                        begin
                                            ItemTarget.Init;
                                            ItemTarget."Item No." := VItemNo;
                                            ItemTarget.UPC := VUPC;
                                            ItemTarget.Target := '031';
                                            ItemTarget.Retail := VZoneNRetail;
                                            ItemTarget."Date Created" := VDateCreated;
                                            ItemTarget."Last Modified" := VLastModified;
                                            ItemTarget."Last User" := VLastUser;
                                            ItemTarget.Insert;
                                        end;
                                end;
                        end;
                    until ItemUPC.Next = 0;
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
        NonstockUPC: Record "Nonstock UPC Table";
        ItemUPC: Record "Item UPC Table";
        NonstockTarget: Record "Nonstock Target Retail";
        ItemTarget: Record "Item Target Retail";
        VEntryNo: Code[10];
        VItemNo: Code[20];
        VUPC: Code[20];
        VZone1Retail: Decimal;
        VZone3Retail: Decimal;
        VZoneNRetail: Decimal;
        VDateCreated: Date;
        VLastModified: Date;
        VLastUser: Code[20];
}

