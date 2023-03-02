Report 50195 "SMS Price Update"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
        dataitem("Nonstock Item";"Nonstock Item")
        {
            DataItemTableView = sorting("Item No.") order(ascending);
            RequestFilterFields = "Entry No.";
            column(ReportForNavId_7742; 7742)
            {
            }
            dataitem("Nonstock UPC Table";"Nonstock UPC Table")
            {
                DataItemLink = "Nonstock Entry No."=field("Entry No.");
                column(ReportForNavId_8733; 8733)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //If shelf labels have been requested, skip any items without the shelf label print flag set
                    if VPrintShelfLabels then
                        if "Nonstock UPC Table"."Print Shelf Tag" = false then
                            CurrReport.Skip;

                    //Do not import items with a 'do not update sms retail' checked
                    if "Nonstock UPC Table"."Do Not Update SMS Retail" = true then
                        CurrReport.Skip;

                    //Only Nonstock Item's with a UPC Code are considered
                    if "Nonstock Item"."UPC Code for SMS" = '' then
                        CurrReport.Skip;

                    if "Nonstock Item"."UPC Code for SMS" = '000000000000' then
                        CurrReport.Skip;

                    if "Nonstock Item"."UPC Code for SMS" = '999999999999' then
                        CurrReport.Skip;

                    if "Nonstock Item"."UPC Code for SMS" = '0' then
                        CurrReport.Skip;

                    VUPCCode := "Nonstock UPC Table".UPC;
                    //Get length of UPC Code
                    VLength := StrLen(VUPCCode);
                    case VLength of
                    4:VUPCCode := '000000000' + VUPCCode;
                    5:VUPCCode := '00000000' + VUPCCode;
                    //6:VUPCCode := '       ' + VUPCCode;
                    //7:VUPCCode := '      ' + VUPCCode;
                    //8:VUPCCode := '00000' + VUPCCode;
                    9:VUPCCode := '0000' + VUPCCode;
                    10:VUPCCode := '000' + VUPCCode;
                    11:VUPCCode := '00' + VUPCCode;
                    12:VUPCCode := '0' + VUPCCode;
                    end;

                    //Get the Nonstock Item retail, Item's are not exported if they do not have a retail
                    GetNonStockRetail;
                    if VRetail = 0 then
                        CurrReport.Skip;

                    //Get pack information
                    VSize := "Nonstock UPC Table"."Pack Desc";
                    VPack := Format(ROUND("Nonstock UPC Table"."Pack Divider",0.01),10,'<Integer><Decimals,3>');

                    //Output a record for SMS
                    WriteSMSRecord;

                    //Indicate that an SMS export record has been created
                    if VPriceFileCreated = true then
                        "Nonstock Item"."Price Files Created" := true;

                    "Nonstock Item".Modify(true);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Temporarily exlude all but cigs
                //IF "Nonstock Item"."SMS Subdepartment" <> 22 THEN CurrReport.SKIP;

                //Only Nonstock Item's with a UPC Code are considered
                if "Nonstock Item"."UPC Code for SMS" = '' then
                    CurrReport.Skip;

                //If an item number does not exist, it has not been sold by ANICA and is skipped
                if "Nonstock Item"."Item No." = '' then
                    CurrReport.Skip;

                //If the item is marked as discontiued by Gottstein, do not update it
                if "Nonstock Item"."Change Indicator" = 'D' then
                    CurrReport.Skip;

                //CS 10-26-16: If not a JBG item, and Price File has been created already, then skip.
                if "Nonstock Item"."Manufacturer Code" <> 'G' then
                    begin
                        if "Nonstock Item"."Price Files Created" = true then
                            CurrReport.Skip;
                    end;

                //Get other item data
                VLookupItemNo := "Nonstock Item"."Item No.";
                VLookupUOM := "Nonstock Item"."Unit of Measure";
                //LookupUOM;
                VSize := "Nonstock Item"."Pack Description";
                VPack := Format(ROUND("Nonstock Item".Pack,0.01),10,'<Integer><Decimals,3>');
                VLookupCommCode := "Nonstock Item"."Commodity Code";

                if "Nonstock Item"."SMS Subdepartment" = 0 then
                    begin
                        LookupSubDept;
                    end
                else
                    begin
                        VSubDept := "Nonstock Item"."SMS Subdepartment";

                        SMSSubDept.SetCurrentkey("Sub Department");
                        SMSSubDept.SetRange("Sub Department",VSubDept);

                        if SMSSubDept.Find('-') then
                            VDept := SMSSubDept."SMS Department";

                        VDeptText := Format(VDept,3,'<Integer>');
                        VSubDeptText := Format(VSubDept,3,'<Integer>');
                    end;

                //LookupSubDept;
                VDesc := "Nonstock Item".Description;
                VItemNo := "Nonstock Item"."Vendor Item No.";
                VSequenceNo := "Nonstock Item"."Entry No."; //CS 6-1-16, to add KIKI prices from Zone Retail Tables
                VUnitPrice := Format(ROUND("Nonstock Item"."Unit Price"),12,'<Integer><Decimals,3>');
                VTelxonVendor := "Nonstock Item"."Telxon Catalog Code";

                if VTelxonVendor = '' then
                    VTelxonVendor := '9999';
                VWIC := Format("Nonstock Item"."WIC Flag",3,'<Text>');

                if "Nonstock Item"."WIC Flag" = true then
                    begin
                        VFoodStamp := 'YES';
                        VFollowSubDept := 'NO ';
                        VTax := 'YES';
                    end
                else
                    begin
                        VFoodStamp := 'NO ';
                        VFollowSubDept := 'YES';
                        VTax := 'NO ';
                    end;
            end;

            trigger OnPreDataItem()
            begin
                "Nonstock Item".LockTable
            end;
        }
        dataitem(Item;Item)
        {
            column(ReportForNavId_8129; 8129)
            {
            }
            dataitem("Item UPC Table";"Item UPC Table")
            {
                DataItemLink = "Item No."=field("No.");
                DataItemLinkReference = Item;
                column(ReportForNavId_7617; 7617)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //If shelf labels have been requested, skip any items without the shelf label print flag set
                    if VPrintShelfLabels then if "Item UPC Table"."Print Shelf Tag" = false then
                        CurrReport.Skip;

                    //Do not export items marked 'do not update sms retail'
                    if "Item UPC Table"."Do Not Update SMS Retail" = true then
                        CurrReport.Skip;

                    //Only valid UPC Codes are considered
                    if "Item UPC Table".UPC = '' then CurrReport.Skip;
                    if "Item UPC Table".UPC = '000000000000' then CurrReport.Skip;
                    if "Item UPC Table".UPC = '999999999999' then CurrReport.Skip;
                    if "Item UPC Table".UPC = '0' then CurrReport.Skip;

                    //Get the Item retail, Items are not exported if they do not have a retail
                    GetItemRetail;
                    if VRetail = 0 then
                        CurrReport.Skip;

                    VUPCCode := "Item UPC Table".UPC;
                    //Get length of UPC Code
                    VLength := StrLen(VUPCCode);
                    case VLength of
                    4:VUPCCode := '000000000' + VUPCCode;
                    5:VUPCCode := '00000000' + VUPCCode;
                    //6:VUPCCode := '       ' + VUPCCode;
                    //7:VUPCCode := '      ' + VUPCCode;
                    //8:VUPCCode := '00000' + VUPCCode;
                    9:VUPCCode := '0000' + VUPCCode;
                    10:VUPCCode := '000' + VUPCCode;
                    11:VUPCCode := '00' + VUPCCode;
                    12:VUPCCode := '0' + VUPCCode;
                    end;

                    //Get pack information
                    VSize := "Item UPC Table"."Pack Descrip";
                    VPack := Format(ROUND("Item UPC Table"."Pack Divider",0.01),10,'<Integer><Decimals,3>');

                    //Output a record for SMS
                    WriteSMSRecord;

                    "Item UPC Table".LockTable(true);

                    //Indicate that an SMS export record has been created
                    //CS 10-26-16: Modified to have just the one checkbox marked.
                    if VPriceFileCreated = true then
                        Item."Price Files Created" := true;

                    Item.Modify(true);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Temp skip all but cigs
                //IF Item."SMS Subdepartment" <> 22 THEN CurrReport.SKIP;

                //Do not import items created from non-stock, these have already been imported
                if Item."Created From Nonstock Item" = true then
                    CurrReport.Skip;

                //Do not import blocked items
                if Item.Blocked = true then
                    CurrReport.Skip;

                //Only Item's with a UPC Code are considered
                if Item."UPC for SMS" = '' then
                    CurrReport.Skip;

                //TEMP CS 06-13-2019
                if Item."ANICA Inactive" = true then
                    CurrReport.Skip;

                //Check price file created flag to see if this has already gone to SMS
                //CS 10-26-16: Modified it to just mark the one checkbox there is now.
                if Item."Price Files Created" = true then
                    CurrReport.Skip;


                //Get other item data
                VLookupItemNo := Item."No.";
                VLookupCommCode := Item."Commodity Code";

                if Item."SMS Subdepartment" = 0 then
                    begin
                        LookupSubDept;
                    end
                else
                    begin
                        VSubDept := Item."SMS Subdepartment";

                        SMSSubDept.SetCurrentkey("Sub Department");
                        SMSSubDept.SetRange("Sub Department",VSubDept);

                        if SMSSubDept.Find('-') then
                            VDept := SMSSubDept."SMS Department";

                        VDeptText := Format(VDept,3,'<Integer>');
                        VSubDeptText := Format(VSubDept,3,'<Integer>');
                    end;

                VDesc := Item.Description + ' ' + Item."Description 2";
                VItemNo := Item."No.";
                VUnitPrice := Format(ROUND(Item."Unit Price"),12,'<Integer><Decimals,3>');
                VTelxonVendor := Item."Telxon Vendor Code";
                if VTelxonVendor = '' then VTelxonVendor := '9999';
                VWIC := Format(Item."WIC Item",3,'<Text>');

                if Item."WIC Item" = true then
                    begin
                        VFoodStamp := 'YES';
                        VFollowSubDept := 'NO ';
                        VTax := 'YES';
                    end
                else
                    begin
                        VFoodStamp := 'NO ';
                        VFollowSubDept := 'YES';
                        VTax := 'NO ';
                    end;
            end;

            trigger OnPreDataItem()
            begin
                Item.LockTable;
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
                    field(VTarget;VTarget)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Select Target';
                        TableRelation = Target;
                    }
                    field(VPriceFileCreated;VPriceFileCreated)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Mark "Price File Created"';
                    }
                    field(VPrintShelfLabels;VPrintShelfLabels)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Export Print Shelf Label Items Only';
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

    trigger OnPostReport()
    begin
        VLineOutputFile.Close;
    end;

    trigger OnPreReport()
    begin
        VStartDate := Format(Today,8,'<Month,2><Day,2><Year4>');

        //Get zone from request form selection
        //CASE VSelectZone OF
        //0:VTarget := 'Z01';
        //1:VTarget := 'Z03';
        //2:VTarget := 'Z0N';
        //3:VTarget := '031';
        //END;

        //Filename section
        VFileName := 'SMS-' + VTarget + VStartDate + '.txt'; //Enter a fixed filename for now

        //Put the output file in the ANICA folder for import
        VFullFileName := '\\filestore\EDI\SMS\Price Update\' + VFileName;
        VLineOutputFile.Create(VFullFileName);
        VLineOutputFile.TextMode(true);
        Window.Open('Processing Record #1##########');
        repeat
        Window.Update(1,"Nonstock Item"."Item No.");
        until "Nonstock Item".Next = 0;
    end;

    var
        VItemNo: Code[20];
        VLookupItemNo: Code[20];
        VLookupUOM: Code[10];
        VLookupCommCode: Code[10];
        VSize: Text[30];
        VSelectZone: Option;
        VTarget: Code[10];
        VRetail: Decimal;
        VDept: Integer;
        VDesc: Text[80];
        VDeptText: Code[10];
        VReptCode: Code[10];
        VSubDept: Integer;
        VSubDeptText: Code[10];
        CommCode: Record "Commodity Code";
        SMSSubDept: Record "SMS Subdepartments";
        ItemUOM: Record "Item Unit of Measure";
        Target: Record Target;
        TargetRetail: Record "Item Target Retail";
        NonstockTargetRetail: Record "Nonstock Target Retail";
        VPack: Text[30];
        VStoreNo: Code[10];
        Customer: Record Customer;
        TTarget: Code[10];
        VCapCode: Code[10];
        VUnitPrice: Text[15];
        VRetail2: Text[12];
        Window: Dialog;
        VLineOutputFile: File;
        VOutputFileLine: Text[180];
        VFileName: Text[25];
        VFullFileName: Text[60];
        VTelxonVendor: Code[10];
        VPrintShelfLabels: Boolean;
        VUPCCode: Code[20];
        VLength: Integer;
        VRetail3: Text[20];
        VWIC: Text[3];
        VFoodStamp: Text[3];
        VFollowSubDept: Text[3];
        VTax: Text[3];
        VDate: Date;
        VStartDate: Text[10];
        VApostrophe: Text[30];
        VSequenceNo: Code[10];
        VPriceFileCreated: Boolean;


    procedure GetNonStockRetail()
    begin
        //For now, price level 1 is fixed in the SMS import
        //First look for standard fixed retail
        VRetail := "Nonstock Item"."Standard Fixed Retail";
        //If none, lookup retails per the UPC table
        if VRetail = 0 then
            begin
                //CS 11-01-16: Replacing UPC table lookup with Target Retail Table lookup.
                NonstockTargetRetail.SetCurrentkey("Entry No.",UPC,Target);
                NonstockTargetRetail.SetRange("Entry No.","Nonstock Item"."Entry No.");
                NonstockTargetRetail.SetRange(UPC,"Nonstock UPC Table".UPC);
                NonstockTargetRetail.SetRange(Target,VTarget);

                if NonstockTargetRetail.Find('-') then
                    VRetail := NonstockTargetRetail.Retail
                else
                    VRetail := 0;
            end;

        //CS 06-15-17: Per Gina, SMS would never need to use Floating Retail. So removing this block of code for the time being.
        //Lastly, if no zone retails, get floating retail
        //IF VRetail = 0 THEN
        //    VRetail := "Nonstock Item"."Floating Retail";

        VRetail2 := Format(ROUND(VRetail,0.01),10,'<Integer><Decimal,3>');
    end;


    procedure GetItemRetail()
    begin
        //For now, price level 1 is fixed in the SMS import
        //First look for standard fixed retail
        VRetail := Item."Std Fixed Retail";
        //If none, take the retail per the UPC table
        if VRetail = 0 then
            begin
                //CS 11-1-16: Replacing lookup in teh UPC table, for lookup in the Target Retails table.
                TargetRetail.SetCurrentkey("Item No.",UPC,Target);
                TargetRetail.SetRange("Item No.",Item."No.");
                TargetRetail.SetRange(UPC,"Item UPC Table".UPC);//CS 06-13-19: changed from Item."UPC for SMS"
                TargetRetail.SetRange(Target,VTarget);

                if TargetRetail.Find('-') then
                    VRetail := TargetRetail.Retail
                else
                    VRetail := 0;
            end;

        //CS 06-15-17: Per Gina, SMS would never need to use Floating Retail. So removing this block of code for the time being.
        //Lastly, if no zone retails, get floating retail
        //We may need validate the commodity code to create a floating retail if it is zero on the card
        // IF Item."Std Floating Retail" = 0 THEN
        //    BEGIN
        //        Item.VALIDATE("Commodity Code");
        //        Item.MODIFY(TRUE);
        //    END;
        //
        //CS 06-12-17: Modified so that it will not grab Std Floating Retail for ZALL target.
        //IF (VRetail = 0) AND (VTarget <> 'ZALL') THEN
        //    VRetail := Item."Std Floating Retail";

        VRetail2 := Format(ROUND(VRetail,0.01),10,'<Integer><Decimal,3>');
    end;


    procedure LookupSubDept()
    begin
        //Find SMS subdepartment based on commodity code
        CommCode.SetCurrentkey("Commodity Code");
        CommCode.SetRange("Commodity Code",VLookupCommCode);
        if CommCode.Find('-') then VSubDept := CommCode."SMS Sub Department" else Message('Sub Department not found comm code %1',
           VLookupCommCode);
        SMSSubDept.SetCurrentkey("Sub Department");
        SMSSubDept.SetRange("Sub Department",VSubDept);
        if SMSSubDept.Find('-') then VDept := SMSSubDept."SMS Department";

        VDeptText := Format(VDept,3,'<Integer>');
        VSubDeptText := Format(VSubDept,3,'<Integer>');
    end;


    procedure WriteSMSRecord()
    begin
        //Get rid of commas and apostrohpes in description, causes problems with SMS PDA function
        VDesc := ConvertStr(VDesc,',',' ');
        VDesc := ConvertStr(VDesc,'(',' ');
        VDesc := ConvertStr(VDesc,')',' ');
        VDesc := ConvertStr(VDesc,'[',' ');
        VDesc := ConvertStr(VDesc,']',' ');
        VDesc := ConvertStr(VDesc,'-',' ');
        VApostrophe := '''';
        VDesc := ConvertStr(VDesc,VApostrophe,' ');
        VOutputFileLine := PadStr(VItemNo,20,' ') + PadStr(VUPCCode,13,' ')
        + PadStr(VDesc,60,' ') + PadStr(VSize,10,' ') + PadStr(VPack,10,' ')
        + PadStr(VTarget,5,' ') + PadStr(VTelxonVendor,10,' ') + PadStr(VUnitPrice,12,' ')
        + PadStr(VDeptText,3,' ') + PadStr(VSubDeptText,3,' ') + PadStr(VRetail2,10,' ') + PadStr(VReptCode,4,' ')
        + VWIC + VFoodStamp + VFollowSubDept + VTax + VStartDate;

        VLineOutputFile.Write(VOutputFileLine);
    end;
}

