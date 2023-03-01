XmlPort 50073 "Import Item Target Retails"
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
                textelement(VTarget)
                {
                }
                textelement(VRetail)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    Target.SetCurrentkey("Item No.",UPC,Target);
                    Target.SetRange("Item No.",VItemNo);
                    Target.SetRange(UPC,VUPC);
                    Target.SetRange(Target,VTarget);

                    if Target.Find('-') then
                        begin
                            Evaluate(Target.Retail,VRetail);
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end
                    else
                        begin
                            Target.Init;
                            Target."Item No." := VItemNo;
                            Target.UPC := VUPC;
                            Target.Target := VTarget;
                            Target.Insert;
                            Evaluate(Target.Retail,VRetail);
                            Target."Date Created" := Today;
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
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

    local procedure LookupItemRetail()
    begin
    end;
}

