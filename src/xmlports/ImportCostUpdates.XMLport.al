XmlPort 50075 "Import Cost Updates"
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
                textelement(VDirectCost)
                {
                }
                textelement(VUnitPrice)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    //Update Item Card
                    Item.SetCurrentkey("No.");
                    Item.SetRange("No.",VItemNo);

                    if Item.Find('-') then
                        begin
                            Evaluate(Item."Last Direct Cost",VDirectCost);
                            Evaluate(Item."Unit Price",VUnitPrice);
                            Item.Modify;
                        end;
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
}

