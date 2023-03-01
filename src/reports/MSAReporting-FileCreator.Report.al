Report 50105 "MSA Reporting - File Creator"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("MSA Reporting - SID";"MSA Reporting - SID")
        {
            DataItemTableView = sorting("Customer No.");
            RequestFilterFields = "Customer No.";
            column(ReportForNavId_2828; 2828)
            {
            }

            trigger OnPreDataItem()
            begin
                //Run MSA Reporting - PUR report, then get values from Req. Form.
                PUR2.RunModal;

                VFormEndDate := PUR2.GetWeekEndDate();
                VTextEndDate := Format(VFormEndDate,0,'<Year4><Month,2><Day,2>');
                //VFormEndDate := PUR2.GetWeekEndDate();

                VFormResubmissionFlag := PUR2.GetResubmissionFlag();
                case VFormResubmissionFlag of
                    true : VResubmission := '1';
                    false : VResubmission := '0';
                end;

                VTestLiveFlag := PUR2.GetTestLiveFlag();

                //Get the counts for BID, SID, and PUR records.
                Item.SetCurrentkey("MSA Reporting");
                Item.SetRange("MSA Reporting",true);
                VBIDmeasures := Format(Item.Count);
                Clear(Item);

                while (StrLen(VBIDmeasures) < 4) do
                    VBIDmeasures := '0' + VBIDmeasures;

                VSIDmeasures := Format(SIDs.Count);
                while (StrLen(VSIDmeasures) < 4) do
                    VSIDmeasures := '0' + VSIDmeasures;

                VPURmeasures := Format(PUR.Count);
                while (StrLen(VPURmeasures) < 4) do
                    VPURmeasures := '0' + VPURmeasures;

                //Create File for output
                VFileName := '\\rdsvr2\MSA Reporting\' + 'MSA Reporting'+' '+ Format(Today,0,'<Year4><Month,2><Day,2>') + '.txt';


                VFileOutput.Create(VFileName);
                VFileOutput.TextMode(true);

                //Write the Single HID record.
                WriteHIDRecord;

                //Write all BID Records.
                WriteBIDRecords;

                //Write SID records.
                WriteSIDRecords;

                //Write the single TOT record
                WriteTOTRecords;
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
        HID: Record "MSA Reporting - HID";
        Item: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        SIDs: Record "MSA Reporting - SID";
        PUR: Record "MSA Reporting - PUR";
        PUR2: Report "MSA Reporting - PUR";
        Customer: Record Customer;
        ItemUPC: Record "Item UPC Table";
        VFileOutput: File;
        VFileName: Text[60];
        VHIDoutput: Text[337];
        VBIDoutput: Text[261];
        VSIDoutput: Text[551];
        VPURoutput: Text[200];
        VTOToutput: Text[200];
        VBIDmeasures: Text[30];
        VSIDmeasures: Text[30];
        VPURmeasures: Text[30];
        VFormEndDate: Date;
        VTextEndDate: Code[10];
        VFormResubmissionFlag: Boolean;
        VResubmission: Text[30];
        VTestLiveFlag: Text[30];
        VPromoIndicatorText: Text[30];
        VItemNo: Code[14];
        VPURItemNo: Code[14];
        VUPC: Code[20];
        VItemsPer: Text[30];
        VPack: Decimal;
        VPackText: Text[30];
        VPackDescription: Text[30];
        VComponentShipperFlag: Text[30];
        VAltUPC1: Code[16];
        VAltUPC2: Code[16];
        VSpiralSize: Code[10];
        VQtyOnHand: Decimal;
        VQtyOnHandText: Text[30];
        VCustomerNo: Code[10];
        VClassOfTrade: Text[30];
        VCashCarry: Text[30];
        VPromoAccept: Text[30];
        VAmount: Text[30];
        VQuantity: Text[30];
        VBIDTotal: Text[30];
        VSIDTotal: Text[30];
        VPURTotal: Text[30];
        VTotalShipped: Decimal;
        VTotalAmount: Decimal;
        VTotalInventory: Decimal;
        VTotalShippedText: Text[30];
        VTotalAmountText: Text[30];
        VTotalInventoryText: Text[30];


    procedure WriteHIDRecord()
    begin
        HID.Find('-');

        with HID do
            begin
                VHIDoutput := 'HID' +
                "Distributor ID Number" +
                PadStr('TOB',4,' ') +
                PadStr(VTestLiveFlag,1,' ') +
                'W' +
                VTextEndDate +
                PadStr("Distributor Name",32,' ') +
                PadStr("Distributor Address",90,' ') +
                PadStr("Distributor City",25,' ') +
                PadStr("Distributor State",2,' ') +
                PadStr("Distributor Zip Code",9,' ') +
                'USA' + PadStr("Distributor Contact First Name",20,' ') +
                PadStr("Distributor Contact Last Name",20,' ') +
                PadStr("Country/City Dialing Code (T)",5,' ') +
                PadStr("Distributor Contact Phone No.",10,' ') +
                PadStr("Country/City Dialing Code (F)",5,' ') +
                PadStr("Distributor Contact Fax No.",10,' ') +
                PadStr("Distributor Contact Email",60,' ') +
                PadStr('0001',4,' ') +
                PadStr('0000',4,' ') +
                PadStr('0001',4,' ') +
                Format(Today,0,'<Year4><Month,2><Day,2>') +
                VResubmission;
            end;

        VFileOutput.Write(VHIDoutput);
    end;


    procedure WriteBIDRecords()
    begin
        Item.SetCurrentkey("MSA Reporting");
        Item.SetRange("MSA Reporting",true);

        if Item.Find('-') then
            repeat
                begin
                    with Item do
                        begin
                            Clear(VBIDoutput);
                            VItemNo := "No.";
                            while (StrLen(VItemNo) < 14) do
                                VItemNo := '0' + VItemNo;

                            //Get MSA UPC from UPC table
                            ItemUPC.SetCurrentkey("Item No.","MSA UPC");
                            ItemUPC.SetRange("Item No.",VItemNo);
                            ItemUPC.SetRange("MSA UPC",true);
                            if ItemUPC.Find('-') then
                                VUPC := ItemUPC.UPC
                            else
                                VUPC := "UPC for SMS";

                            while (StrLen(VUPC) < 14) do
                                VUPC := '0' + VUPC;

                            //05-29-14 CS: Changed the Items Per Selling Unit field to Integer.
                            VItemsPer := Format("Items Per Selling Unit");
                            while (StrLen(VItemsPer)) < 6 do
                                VItemsPer := '0' + VItemsPer;

                            //Handle some conversions and lookups before writing record.
                            VPromoIndicatorText := Format("Promotion Indicator");

                            ItemUOM.SetCurrentkey("Item No.",Code);
                            ItemUOM.SetRange("Item No.",VItemNo);

                            if ItemUOM.Find('-') then
                                begin
                                    VPack := ItemUOM.Pack;
                                    VPackText := Format(VPack);
                                    while (StrLen(VPackText) < 6) do
                                        VPackText := '0' + VPackText;

                                    VPackDescription := ItemUOM."Pack Description";
                                end;
                            Clear(ItemUOM);

                            case "Component Shipper Flag" of
                                0 : VComponentShipperFlag := ' ';
                                1 : VComponentShipperFlag := 'S';
                                2 : VComponentShipperFlag := 'C';
                            end;

                            VAltUPC1 := "Alternate UPC Code 1";
                            while (StrLen(VAltUPC1) < 16) do
                                VAltUPC1 := '0' + VAltUPC1;

                            //CS 07-18-17: Had to make this blank because I changed "Alternate UPC Code 2" to "Inventory Count Order" on
                            // the item card. We never have items with "Alternate UPC Code 2" populated.
                            VAltUPC2 := '';
                            while (StrLen(VAltUPC2) < 16) do
                                VAltUPC2 := '0' + VAltUPC2;

                            VSpiralSize := '00';

                            CalcFields(Inventory);
                            VQtyOnHand := Inventory;
                            VQtyOnHandText := Format(VQtyOnHand);
                            while (StrLen(VQtyOnHandText) < 11) do
                                VQtyOnHandText := '0' + VQtyOnHandText;


                            VBIDoutput := 'BID' +
                                PadStr(VUPC,14,' ') +
                                PadStr(VItemNo,14,' ') +
                                PadStr("MSA Item Description",50,' ') +
                                PadStr("Promotion Description",50,' ') +
                                PadStr(VItemsPer,6,' ') +
                                PadStr(VPromoIndicatorText,1,' ') +
                                PadStr("NACS Standard Category Code",6,' ') +
                                PadStr("MSA Category Code",6,' ') +
                                '          ' +
                                PadStr(VPackText,6,' ') +
                                PadStr(VPackDescription,10,' ') +
                                PadStr(VComponentShipperFlag,1,' ') +
                                PadStr("Manufacturer Promo Code",10,' ') +
                                PadStr("Manufacturer Prod. ID Code",14,' ') +
                                PadStr("UPC Extension",2,' ') +
                                PadStr("UPC year/issue Extension",4,' ') +
                                PadStr('  ',2,' ') +
                                PadStr(VAltUPC1,16,' ') +
                                PadStr(VAltUPC2,16,' ') +
                                PadStr(VSpiralSize,2,' ') +
                                PadStr('',4,' ') +
                                '003' +
                                PadStr(VQtyOnHandText,11,' ');


                        end;

                    VFileOutput.Write(VBIDoutput);
                end;
            until Item.Next = 0;
    end;


    procedure WriteSIDRecords()
    begin
        if SIDs.Find('-') then
            begin
                repeat
                    begin
                        VCustomerNo := SIDs."Customer No.";

                        Customer.SetCurrentkey("No.");
                        Customer.SetRange("No.",VCustomerNo);

                        if Customer.Find('-') then
                            begin

                                //First gather data for SID record.
                                with Customer do
                                    begin
                                        case "Ship-To Cust. Class of Trade" of
                                            0 : VClassOfTrade := 'Retailer';
                                            1 : VClassOfTrade := 'Distributor';
                                            2 : VClassOfTrade := 'Other';
                                        end;

                                        case "Ship-To Cash and Carry" of
                                            true : VCashCarry := 'Y';
                                            false : VCashCarry := 'N';
                                        end;

                                        case "Cust. Prod. Promo Acceptance" of
                                            true : VPromoAccept := 'Y';
                                            false : VPromoAccept := 'N';
                                        end;


                                        VSIDoutput := 'SID' +
                                        PadStr("No.",8,' ') +
                                        PadStr("Telxon Store number",8,' ') +
                                        PadStr("Ship-To Cust. Shipping No. Ext",8,' ') +
                                        PadStr(Name,32,' ') +
                                        PadStr("Telxon Store number",8,' ') +
                                        PadStr("Store Physical Address",90,' ') +
                                        PadStr(City,25,' ') +
                                        PadStr(County,2,' ') +
                                        PadStr("Post Code",9,' ') +
                                        'USA' +
                                        PadStr('AK',2,' ') +
                                        '   ' +
                                        PadStr('',10,' ') +
                                        PadStr(VClassOfTrade,20,' ') +
                                        PadStr("Ship-To Cust. TDLinx No.",7,' ') +
                                        PadStr(VCashCarry,1,' ') +
                                        PadStr("Location No.",9,' ') +
                                        PadStr("Machine Type",9,' ') +
                                        ' ' +
                                        PadStr("No.",24,' ') +
                                        PadStr("Bill-To Cust. Group No.",24,' ') +
                                        PadStr(Name,32,' ') +
                                        PadStr("Store Physical Address",90,' ') +
                                        PadStr(City,25,' ') +
                                        PadStr(County,2,' ') +
                                        PadStr("Post Code",9,' ') +
                                        'USA' +
                                        '     ' +
                                        PadStr('',10,' ') +
                                        PadStr('00000',5,' ') +
                                        PadStr('00000',5,' ') +
                                        PadStr('00000',5,' ') +
                                        PadStr(VPromoAccept,1,' ') +
                                        PadStr("Sales Rep ID No.",10,' ') +
                                        PadStr('',29,' ') +
                                        PadStr('',3,' ') +
                                        PadStr('00000000000',11,'0');

                                    end;
                                VFileOutput.Write(VSIDoutput);

                                //After the SID record is written, write records for each PUR.
                                WritePURRecords;
                            end;
                    end;
                until SIDs.Next = 0;
            end;
    end;


    procedure WritePURRecords()
    begin
        PUR.SetRange("Customer No.",VCustomerNo);

        if PUR.Find('-') then
            repeat
                begin
                    with PUR do
                        begin
                            VAmount := Format(Amount,0,1);
                            while StrLen(VAmount) < 11 do
                                VAmount := '0' + VAmount;

                            VQuantity := Format(Quantity,0,1);
                            while StrLen(VQuantity) < 11 do
                                VQuantity := '0' + VQuantity;

                            VPURItemNo := "Item No.";
                            while StrLen(VPURItemNo) < 14 do
                                VPURItemNo := '0' + VPURItemNo;


                            VPURoutput := 'PUR' +
                            PadStr(VCustomerNo,8,' ') +
                            PadStr("Customer Shipping No.",8,' ') +
                            PadStr("Customer Shipping No. Ext.",8,' ') +
                            VPURItemNo +
                            //PADSTR(VItemNo,14,' ') +
                            //PADSTR("Item No.",14,' ') +
                            PadStr('',3,' ') +
                            PadStr("Invoice No.",30,' ') +
                            PadStr(Date,8,' ') +
                            PadStr('',20,' ') +
                            '001' +
                            PadStr(VQuantity,11,' ') +
                            '002' +
                            PadStr('',11,'0');
                        end;

                    VFileOutput.Write(VPURoutput);
                end;
            until PUR.Next = 0;
    end;


    procedure WriteTOTRecords()
    begin
        if HID.Find('-') then
            begin
                with HID do
                    begin
                        VBIDTotal := VBIDmeasures;
                        while (StrLen(VBIDTotal) < 9) do
                            VBIDTotal := '0' + VBIDTotal;

                        VSIDTotal := VSIDmeasures;
                        while (StrLen(VSIDTotal) < 9) do
                            VSIDTotal := '0' + VSIDTotal;

                        VPURTotal := VPURmeasures;
                        while (StrLen(VPURTotal) < 9) do
                            VPURTotal := '0' + VPURTotal;

                        Clear(PUR);
                        VTotalShipped := 0;
                        if PUR.Find('-') then
                            repeat
                                begin
                                    VTotalShipped := VTotalShipped + PUR.Quantity;
                                end;
                            until PUR.Next = 0;

                        //CS 03-18-14: Remove commas
                        VTotalShippedText := Format(VTotalShipped,0,1);

                        //VTotalShippedText := FORMAT(VTotalShipped);
                        while StrLen(VTotalShippedText) < 15 do
                            VTotalShippedText := '0' + VTotalShippedText;

                        Clear(PUR);

                        if PUR.Find('-') then
                            repeat
                                begin
                                    VTotalAmount := VTotalAmount + PUR.Amount;
                                end;
                            until PUR.Next = 0;
                        VTotalAmountText := Format(VTotalAmount,0,1);
                        while StrLen(VTotalAmountText) < 15 do
                            VTotalAmountText := '0' + VTotalAmountText;

                        Clear(PUR);

                        Item.SetCurrentkey("MSA Reporting");
                        Item.SetRange("MSA Reporting",true);

                        if Item.Find('-') then
                            repeat
                                begin
                                    Item.CalcFields(Inventory);
                                    VTotalInventory := VTotalInventory + Item.Inventory;
                                end;
                            until Item.Next = 0;
                        VTotalInventoryText := Format(VTotalInventory,0,1);
                        while StrLen(VTotalInventoryText) < 15 do
                            VTotalInventoryText := '0' + VTotalInventoryText;

                        Clear(Item);

                        VTOToutput := 'TOT' +
                        PadStr("Distributor ID Number",8,' ') +
                        PadStr(VTextEndDate,8,' ') +
                        PadStr(VBIDTotal,9,' ') +
                        PadStr(VSIDTotal,9,' ') +
                        PadStr(VPURTotal,9,' ') +
                        PadStr('',40,' ') +
                        '001' +
                        PadStr(VTotalShippedText,15,' ') +
                        '002' +
                        PadStr('',15,'0') +
                        '003' +
                        PadStr(VTotalInventoryText,15,' ');
                    end;
            end;

        VFileOutput.Write(VTOToutput);
    end;
}

