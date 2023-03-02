XmlPort 50044 "Vendor Item By Group Code Exp"
{
    Direction = Export;
    Format = FixedText;

    schema
    {
        textelement(Root)
        {
            tableelement(Item;Item)
            {
                AutoUpdate = true;
                RequestFilterFields = "Catalog Group Code";
                XmlName = 'Item';
                SourceTableView = sorting("No.") order(ascending);
                fieldelement(No;Item."No.")
                {
                    Width = 9;
                }
                textelement(IDescription)
                {
                    Width = 60;
                }
                textelement(IUOM)
                {
                    Width = 6;
                }
                textelement(txtLastDateMod)
                {
                    Width = 8;

                    trigger OnBeforePassVariable()
                    begin
                        //Convert Date to Text
                        txtLastDateMod := Format(ILastDateMod,8,'<Day,2>/<Month,2>/<Year,2>');
                    end;
                }
                textelement(ILRCost)
                {
                    Width = 7;
                }
                textelement(IUnitPrice)
                {
                    Width = 7;
                }
                textelement(IVendorNo)
                {
                    Width = 7;
                }
                textelement(IVendorItem)
                {
                    Width = 12;
                }
                fieldelement(CatalogGroupCode;Item."Catalog Group Code")
                {
                    Width = 4;
                }
                fieldelement(CommodityCode;Item."Commodity Code")
                {
                    Width = 2;
                }

                trigger OnAfterGetRecord()
                begin
                    IDescription := Item.Description + Item."Description 2";
                    IUOM := Item."Base Unit of Measure";
                    ILastDateMod := Item."Last Date Modified";
                    PRLastCost := ROUND(Item."Last Direct Cost",0.01);
                    ILRCost := Format(PRLastCost,7,'<Integer><Decimal,3>');
                    PRUnitPrice := ROUND(Item."Unit Price",0.01);
                    IUnitPrice := Format(PRUnitPrice,7,'<Integer><Decimal,3>');
                    IVendorNo := Item."Vendor No.";
                    IVendorItem := Item."Vendor Item No.";
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
        Message('Export is Done');
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
        ItemFile: Record Item;
        ILastDateMod: Date;
        PRLastCost: Decimal;
        PRUnitPrice: Decimal;
        Window: Dialog;
}

