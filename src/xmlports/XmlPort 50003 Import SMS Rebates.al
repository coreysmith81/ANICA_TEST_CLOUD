XmlPort 50003 "Import SMS Rebates"
{
    // This program imports rebate detail exported from the SMS POS system.
    // The import files are at \\filestore\EDI\SMS\Rebates from SMS.

    Direction = Import;
    FieldSeparator = '~';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer;Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(VCustNo)
                {
                }
                textelement(TxtDate)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Evaluate(VDate,TxtDate) = false then Message('Invalid Date');
                    end;
                }
                textelement(VStore)
                {
                }
                textelement(VImportAmt)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    if VCustNo = '1' then
                        currXMLport.Skip;

                    if VCustNo = '' then
                        currXMLport.Skip;

                    VCust := CopyStr(VCustNo,1,2);
                    VCustNo2 := CopyStr(VCustNo,3,4);

                    if VCustNo2 = '' then
                        currXMLport.Skip;

                    if VStore = '006' then
                        VCust := '06';

                    if VStore = '009' then
                        VCust := '09';

                    //08-02-12 CS: Check for Position of 'E' (VEPos), and skip if there is an E.
                    VEPos := StrPos(Format(VImportAmt),'E');

                    if VEPos <> 0 then
                        currXMLport.Skip;

                    //Convert Text "VImportAmt" to a Decimal (VAmt).
                    Evaluate(VAmt,VImportAmt);

                    Customer.SetCurrentkey(Customer."Telxon Store number");
                    Customer.SetRange(Customer."Telxon Store number",VCust);

                    if Customer.Find('-') then
                        RebCust := Customer."No.";

                    Evaluate(ICustNo,VCustNo2);

                    GetSequenceNo;
                end;
            }
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

    trigger OnPostXmlPort()
    begin
        //For Status Box
        Window.Close;
        Clear(Window);
        Message('Import is Done');
    end;

    trigger OnPreXmlPort()
    begin
        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
        end;
    end;

    var
        VDate: Date;
        VAmt: Decimal;
        RebateDetail: Record "Rebates Detail";
        VCustNo2: Text;
        TSequence: Integer;
        VStoreNo: Text;
        Customer: Record Customer;
        RebCust: Text;
        VCust: Text;
        ICustNo: Integer;
        VEPos: Integer;
        Window: Dialog;

    local procedure GetSequenceNo()
    begin
        //LCC 7-8-15 Removed Locktable
        //RebateDetail.LOCKTABLE;
        RebateDetail.SetCurrentkey("Sequence No.");
        RebateDetail.SetRange("Sequence No.");
        if RebateDetail.Find('+') then
        TSequence := RebateDetail."Sequence No." + 1
        else TSequence := 1;

        //Create a new rebate record
        RebateDetail.SetCurrentkey(RebateDetail."Sequence No.");
        RebateDetail.Init;
        RebateDetail."Sequence No." := TSequence;
        RebateDetail."Customer No." := ICustNo;
        RebateDetail."Store No." := RebCust;
        RebateDetail.Date := VDate;
        RebateDetail.Amount := VAmt;


        RebateDetail.Insert(true);
    end;
}

