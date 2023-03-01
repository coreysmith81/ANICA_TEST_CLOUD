XmlPort 50008 "Mass Inactivate by Item No."
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

                trigger OnAfterInsertRecord()
                begin
                    //For Status Box
                    begin
                      Window.Update(1,Item."No.");
                    end;

                    LookupItem;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(ImportDate)
                {
                    field("Import Date";VImportDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //CS 06-26-15: This will populate the Import Date Field with the correct Monday's date. Either the current day
             //if it's a Monday, or the previous Monday if it's any other date. Keeping it as editable for any exceptions.
            if Date2dwy(Today,1) <> 1 then
                VImportDate := CalcDate('<-WD1>')
            else
                VImportDate := Today;
        end;
    }

    trigger OnPostXmlPort()
    begin
        //For Status Box
        Window.Close;
        Clear(Window);
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
        Item: Record Item;
        Window: Dialog;
        MyFile: File;
        TempTextVariable: Text[1000];
        TotalRecNo: Integer;
        VImportDate: Date;

    local procedure LookupItem()
    begin
        Item.SetCurrentkey("No.");
        Item.SetRange("No.",VItemNo);

        if Item.Find('-') then
            begin
                Item."ANICA Inactive":=true;
                Item.Modify;
            end;

        Clear(Item);
    end;
}

