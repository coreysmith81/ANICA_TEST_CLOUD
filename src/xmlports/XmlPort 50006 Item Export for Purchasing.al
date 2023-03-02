XmlPort 50006 "Item Export for Purchasing"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Item;Item)
            {
                RequestFilterFields = "Vendor No.";
                XmlName = 'Item';
                fieldelement(VItemNo;Item."No.")
                {
                }
                fieldelement(VDescription;Item.Description)
                {
                }
                fieldelement(VGrossWt;Item."Gross Weight")
                {
                }
                fieldelement(VCommCode;Item."Commodity Code")
                {
                }
                textelement(VPack)
                {
                }
                textelement(VPackDescription)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VItemNumber := Item."No.";
                    LookupPack;
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
        ItemUOM: Record "Item Unit of Measure";
        VItemNumber: Code[30];

    local procedure LookupPack()
    begin
        ItemUOM.SetCurrentkey("Item No.",Code);
        ItemUOM.SetRange("Item No.",VItemNumber);

        if ItemUOM.Find('-') then
            begin
                VPack := Format(ItemUOM.Pack);
                VPackDescription := ItemUOM."Pack Description";
            end;

        Clear(ItemUOM);

    end;
}

