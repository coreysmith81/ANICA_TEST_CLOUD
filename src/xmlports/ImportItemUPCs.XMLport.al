XmlPort 50072 "Import Item UPCs"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer;Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(VItemNo)
                {
                }
                textelement(VUPC)
                {
                }
                textelement(VRetail)
                {
                }
                textelement(VPackDesc)
                {
                }
                textelement(VPackDiv)
                {
                }
                textelement(VPackMult)
                {
                }
                textelement(VCatSelect)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    Item.SetCurrentkey("No.");
                    Item.SetRange("No.",VItemNo);

                    if Item.Find('-') then
                        begin
                            LookupUPCTable;
                            Item."UPC for SMS" := VUPC;
                            Item."Price Files Created" := false;
                            Item.Modify;
                        end
                    else
                        currXMLport.Skip;
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

    var
        Item: Record Item;
        Target: Record "Item Target Retail";
        UPC: Record "Item UPC Table";

    local procedure LookupUPCTable()
    begin
        //CS 01-29-19: Clear all catalog select fields for given item number first.
        UPC.SetCurrentkey("Item No.",UPC);
        UPC.SetRange("Item No.",VItemNo);

        if UPC.Find('-') then
            repeat
                begin
                    UPC."Catalogue Select" := false;
                    UPC.Modify;
                end
            until UPC.Next = 0;

        Clear(UPC);


        UPC.SetCurrentkey("Item No.",UPC);
        UPC.SetRange("Item No.",VItemNo);
        UPC.SetRange(UPC,VUPC);

        if UPC.Find('-') then
            begin
                UPC."Item No." := VItemNo;
                UPC.UPC := VUPC;
                UPC."Pack Descrip" := VPackDesc;
                Evaluate(UPC."Pack Divider",VPackDiv);
                Evaluate(UPC."Price Multiplier",VPackMult);
                if VCatSelect = 'Yes' then
                    UPC."Catalogue Select" := true
                else
                    UPC."Catalogue Select" := false;
                UPC."Last Date Updated" := Today;
                UPC."Last User" := UserId;
                UPC.Modify;
            end
        else
            begin
                UPC.Init;
                UPC."Item No." := VItemNo;
                UPC.UPC := VUPC;
                UPC.Insert;
                UPC."Pack Descrip" := VPackDesc;
                Evaluate(UPC."Pack Divider",VPackDiv);
                Evaluate(UPC."Price Multiplier",VPackMult);
                if VCatSelect = 'Yes' then
                    UPC."Catalogue Select" := true
                else
                    UPC."Catalogue Select" := false;
                UPC."Date Created" := Today;
                UPC."Last Date Updated" := Today;
                UPC."Last User" := UserId;
                UPC.Modify;
            end;
    end;
}

