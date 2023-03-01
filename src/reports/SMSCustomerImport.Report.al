Report 50194 "SMS Customer Import"
{
    // This program takes customer entries in the Rebate Customers table and creates an import file for the SMS system
    // 
    // 7-21-10, LCC Added customer group and risk level to the file

    ProcessingOnly = true;

    dataset
    {
        dataitem("Rebates Customers";"Rebates Customers")
        {
            DataItemTableView = sorting("Rebate Store No.","Rebate Customer No.") order(ascending);
            RequestFilterFields = "Rebate Store No.","Rebate Customer No.";
            column(ReportForNavId_3624; 3624)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Customer.SetCurrentkey(Customer."No.");
                Customer.SetRange(Customer."No.","Rebates Customers"."Rebate Store No.");
                if Customer.Find('-') then
                begin
                TelxNo := Customer."Telxon Store number";
                TCustNo := '0' + TelxNo;
                //Not used
                //TTarget := Customer."Parcel Post Code";
                //  IF TTarget = 'ZONE 1/2' THEN VTarget := 'Z01';
                //  IF TTarget = 'ZONE 3' THEN VTarget := 'Z03';
                //  IF TTarget = 'ZONE N' THEN VTarget := 'Z0N';
                end;
                VCustNo := Format("Rebates Customers"."Rebate Customer No.",4,'<Integer>');
                VCustNo2 := ConvertStr(VCustNo,' ','0');
                NewCustNo := TelxNo + VCustNo2;
                VName := PadStr("Rebates Customers"."Customer Name",30,' ');
                VFirst := PadStr("Rebates Customers"."First Name",30,' ');
                VLast := PadStr("Rebates Customers"."Last Name",30,' ');
                VAdress := PadStr("Rebates Customers".Address,30,' ');
                VAdress2 := PadStr("Rebates Customers"."Address 2",30,' ');
                VCity := PadStr("Rebates Customers".City,30,' ');
                VZip := PadStr("Rebates Customers"."Zip Code",10,' ');
                //7-20-10, LCC Added customer group and risk level
                //VCGroup  := PADSTR("Rebates Customers"."Customer Group",5,' ');
                VCGroup  := PadStr(TCustNo,5,' ');
                //VRiskLev := "Rebates Customers"."Risk Level";
                VRiskLev := '1';
                if StrLen(VRiskLev) = 1 then VRiskLev := ' ' + VRiskLev;

                VOutputLine := NewCustNo + VName + VFirst + VLast + VAdress + VAdress2 + VCity + "Rebates Customers".State + VZip
                   + TCustNo  + VCGroup + VRiskLev;

                VOutputFile.Write(VOutputLine);
            end;

            trigger OnPostDataItem()
            begin
                Message('Export is complete, file is at \\filestore\EDI\SMS Customers\');
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
                    field(VStoreNo;VStoreNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Store Number';
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
        //Create Export File
        VOutputFile.Create('\\filestore\EDI\SMS Customers\RebateCust.TXT');
        VOutputFile.TextMode(true);
    end;

    var
        VCustNo: Text[4];
        VCustNo2: Text[4];
        Customer: Record Customer;
        TelxNo: Text[2];
        NewCustNo: Text[6];
        VOutputFile: File;
        VOutputLine: Text[250];
        VName: Text[30];
        VAdress: Text[30];
        VAdress2: Text[30];
        VCity: Text[30];
        VState: Text[2];
        VZip: Text[10];
        VFirst: Text[30];
        VLast: Text[30];
        VStoreNo: Code[10];
        TTarget: Code[10];
        VTarget: Code[5];
        TCustNo: Code[3];
        VCGroup: Text[5];
        VRiskLev: Text[2];
}

