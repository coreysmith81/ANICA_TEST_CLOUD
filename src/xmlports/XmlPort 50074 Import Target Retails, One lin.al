XmlPort 50074 "Import Target Retails, One lin"
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
                textelement(VDirectCost)
                {
                }
                textelement(VUnitPrice)
                {
                }
                textelement(VZ01)
                {
                }
                textelement(VZ03)
                {
                }
                textelement(VZ0N)
                {
                }
                textelement(V031)
                {
                }
                textelement(VARC)
                {
                }
                textelement(VKEB)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    //Update Item Card
                    Item.SetCurrentkey("No.");
                    Item.SetRange("No.",VItemNo);

                    //IF Item.FIND('-') THEN
                    //    BEGIN
                    //        EVALUATE(Item."Last Direct Cost",VDirectCost);
                    //        EVALUATE(Item."Unit Price",VUnitPrice);
                    //        Item.MODIFY;
                    //    END;

                    //Update Z01
                    Target.SetCurrentkey("Item No.",UPC,Target);
                    Target.SetRange("Item No.",VItemNo);
                    Target.SetRange(UPC,VUPC);
                    Target.SetRange(Target,'Z01');

                    if Target.Find('-') then
                        begin
                            Evaluate(Target.Retail,VZ01);
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end
                    else
                        begin
                            Target.Init;
                            Target."Item No." := VItemNo;
                            Target.UPC := VUPC;
                            Target.Target := 'Z01';
                            Target.Insert;
                            Evaluate(Target.Retail,VZ01);
                            Target."Date Created" := Today;
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end;

                    //Update Z03
                    Target.SetCurrentkey("Item No.",UPC,Target);
                    Target.SetRange("Item No.",VItemNo);
                    Target.SetRange(UPC,VUPC);
                    Target.SetRange(Target,'Z03');

                    if Target.Find('-') then
                        begin
                            Evaluate(Target.Retail,VZ03);
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end
                    else
                        begin
                            Target.Init;
                            Target."Item No." := VItemNo;
                            Target.UPC := VUPC;
                            Target.Target := 'Z03';
                            Target.Insert;
                            Evaluate(Target.Retail,VZ03);
                            Target."Date Created" := Today;
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end;


                    //Update Z0N
                    Target.SetCurrentkey("Item No.",UPC,Target);
                    Target.SetRange("Item No.",VItemNo);
                    Target.SetRange(UPC,VUPC);
                    Target.SetRange(Target,'Z0N');

                    if Target.Find('-') then
                        begin
                            Evaluate(Target.Retail,VZ0N);
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end
                    else
                        begin
                            Target.Init;
                            Target."Item No." := VItemNo;
                            Target.UPC := VUPC;
                            Target.Target := 'Z0N';
                            Target.Insert;
                            Evaluate(Target.Retail,VZ0N);
                            Target."Date Created" := Today;
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end;


                    //Update 031
                    Target.SetCurrentkey("Item No.",UPC,Target);
                    Target.SetRange("Item No.",VItemNo);
                    Target.SetRange(UPC,VUPC);
                    Target.SetRange(Target,'031');

                    if Target.Find('-') then
                        begin
                            Evaluate(Target.Retail,V031);
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end
                    else
                        begin
                            Target.Init;
                            Target."Item No." := VItemNo;
                            Target.UPC := VUPC;
                            Target.Target := '031';
                            Target.Insert;
                            Evaluate(Target.Retail,V031);
                            Target."Date Created" := Today;
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end;


                    //Update ARC
                    Target.SetCurrentkey("Item No.",UPC,Target);
                    Target.SetRange("Item No.",VItemNo);
                    Target.SetRange(UPC,VUPC);
                    Target.SetRange(Target,'ARC');

                    if Target.Find('-') then
                        begin
                            Evaluate(Target.Retail,VARC);
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end
                    else
                        begin
                            Target.Init;
                            Target."Item No." := VItemNo;
                            Target.UPC := VUPC;
                            Target.Target := 'ARC';
                            Target.Insert;
                            Evaluate(Target.Retail,VARC);
                            Target."Date Created" := Today;
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end;


                    //Update KEB
                    Target.SetCurrentkey("Item No.",UPC,Target);
                    Target.SetRange("Item No.",VItemNo);
                    Target.SetRange(UPC,VUPC);
                    Target.SetRange(Target,'KEB');

                    if Target.Find('-') then
                        begin
                            Evaluate(Target.Retail,VKEB);
                            Target."Last Modified" := Today;
                            Target."Last User" := UserId;
                            Target.Modify;
                        end
                    else
                        begin
                            Target.Init;
                            Target."Item No." := VItemNo;
                            Target.UPC := VUPC;
                            Target.Target := 'KEB';
                            Target.Insert;
                            Evaluate(Target.Retail,VKEB);
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

