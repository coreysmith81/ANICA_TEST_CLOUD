XmlPort 50070 "Ditomaso Retail Update"
{
    Caption = 'Ditomaso Retail Update';
    Direction = Import;
    FileName = '\\filestore\Purchasing\Grocery\Produce\Ditomaso\Export\ABP&SR.csv';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer;Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(VItem)
                {
                }
                textelement(txtRetail1)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VRetail1,txtRetail1) = false then Message('Invalid Amount');
                    end;
                }
                textelement(txtRetail3)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VRetail3,txtRetail3) = false then Message('Invalid Amount');
                    end;
                }
                textelement(txtRetailN)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VRetailN,txtRetailN) = false then Message('Invalid Amount');
                    end;
                }
                textelement(txtRetail075)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        //Convert Amount
                        if Evaluate(VRetail075,txtRetail075) = false then Message('Invalid Amount');
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    //For Status Box
                    begin
                      Window.Update(1,VItem);
                    end;

                    //CS 04-10-17: Switched to Targets, from Zone and UPC table retails.
                    TargetRetail.SetCurrentkey("Item No.",UPC,Target);
                    TargetRetail.SetRange("Item No.",VItem);
                    //TargetRetail.SETRANGE(UPC,VUPC); // Need to figure this part out.

                    if TargetRetail.FindFirst then repeat
                        VTarget := TargetRetail.Target;

                        case VTarget of
                            'Z01': TargetRetail.Retail := VRetail1;
                            'Z03': TargetRetail.Retail := VRetail3;
                            'Z0N': TargetRetail.Retail := VRetailN;
                            '031': TargetRetail.Retail := VRetail075;
                        end;

                        TargetRetail."Last Modified" := Today();
                        TargetRetail."Last User" := UserId;
                        TargetRetail.Modify;

                        until TargetRetail.Next = 0
                    else
                        CreateTargetRetail;

                    Clear(TargetRetail);
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
        ItemUPC: Record "Item UPC Table";
        TargetRetail: Record "Item Target Retail";
        VTarget: Text;
        VRetail1: Decimal;
        VRetail3: Decimal;
        VRetailN: Decimal;
        VRetail075: Decimal;
        VFilename: Text;
        Window: Dialog;


    procedure CreateTargetRetail()
    begin
        //CS 4-10-17: Create Z01 Record.
        if VRetail1 <> 0 then
            begin
                TargetRetail.Init;
                TargetRetail."Item No." := VItem;
                //TargetRetail.UPC := VUPC //Need to figure out still
                TargetRetail.Target := 'Z01';
                TargetRetail.Insert;
                TargetRetail.Retail := VRetail1;
                TargetRetail."Date Created" := Today;
                TargetRetail."Last Modified" := Today;
                TargetRetail."Last User" := UserId;
                TargetRetail.Modify;
            end;

        if VRetail3 <> 0 then
            begin
                TargetRetail.Init;
                TargetRetail."Item No." := VItem;
                //TargetRetail.UPC := VUPC //Need to figure out still
                TargetRetail.Target := 'Z03';
                TargetRetail.Insert;
                TargetRetail.Retail := VRetail3;
                TargetRetail."Date Created" := Today;
                TargetRetail."Last Modified" := Today;
                TargetRetail."Last User" := UserId;
                TargetRetail.Modify;
            end;

        if VRetailN <> 0 then
            begin
                TargetRetail.Init;
                TargetRetail."Item No." := VItem;
                //TargetRetail.UPC := VUPC //Need to figure out still
                TargetRetail.Target := 'Z0N';
                TargetRetail.Insert;
                TargetRetail.Retail := VRetailN;
                TargetRetail."Date Created" := Today;
                TargetRetail."Last Modified" := Today;
                TargetRetail."Last User" := UserId;
                TargetRetail.Modify;
            end;

        if VRetail075 <> 0 then
            begin
                TargetRetail.Init;
                TargetRetail."Item No." := VItem;
                //TargetRetail.UPC := VUPC //Need to figure out still
                TargetRetail.Target := '031';
                TargetRetail.Insert;
                TargetRetail.Retail := VRetail075;
                TargetRetail."Date Created" := Today;
                TargetRetail."Last Modified" := Today;
                TargetRetail."Last User" := UserId;
                TargetRetail.Modify;
            end;
    end;
}

