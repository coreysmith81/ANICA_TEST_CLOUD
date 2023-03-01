Codeunit 50106 "Telxon Recurring Input"
{
    // ANICA 8-7-15 Copied Code Unit 240 and changed so the Template Selection Function is the only function
    //    for Telxon Quick input
    // 
    // Added the following variables that would be sent by a call to this codeunit
    //     ItemJnlLine : Record "Item Journal Line";
    //     JnlSelected : Boolean
    //     ItemJnlTemplate : Record "Item Journal Template"
    //     PageID : Integer
    //     RecurringJnl: Boolean
    //     PageTemplate : Option
    // 
    // //>>  MAS: Modified in TemplateSelection Pagetemplate local with 'Telxon' Option.
    //       Modifications are marked by MAS.

    Permissions = TableData "Item Journal Template"=imd,
                  TableData "Item Journal Batch"=imd;

    trigger OnRun()
    begin
        ItemJnlTemplate.Reset;

        //<<ANICA set variables that would have been set by calling this code unit - Template Selection section
        JnlSelected := true;
        PageID := 50044;//50042 Telxon Quick Input Page, 50044 Telxon Recurring Page
        RecurringJnl := true;
        PageTemplate := 7;//Telxon
        //>>ANICA

        ItemJnlTemplate.SetRange("Page ID",PageID);
        ItemJnlTemplate.SetRange(Recurring,RecurringJnl);
        ItemJnlTemplate.SetRange(Type,PageTemplate);

        case ItemJnlTemplate.Count of

          0:
            begin
              ItemJnlTemplate.Init;
              ItemJnlTemplate.Recurring := RecurringJnl;
              ItemJnlTemplate.Validate(Type,PageTemplate);
              ItemJnlTemplate.Validate("Page ID");
              if not RecurringJnl then begin

        //>>MAS Also added END 3rd line after //>>
                //IF PageTemplate = PageTemplate::Telxon THEN BEGIN
                  if PageTemplate = 7 then begin
                  ItemJnlTemplate.Name := Format(ItemJnlTemplate.Type,MaxStrLen(ItemJnlTemplate.Name));
                  ItemJnlTemplate.Description := 'Telxon Journal';
                  ItemJnlTemplate."Page ID" := 50042; //Telxon Journal
                end
                else begin
        //<<

                ItemJnlTemplate.Name := Format(ItemJnlTemplate.Type,MaxStrLen(ItemJnlTemplate.Name));
                ItemJnlTemplate.Description := StrSubstNo(Text000,ItemJnlTemplate.Type);
                end
              end else begin

        //>>MAS
                //IF PageTemplate = PageTemplate::Telxon THEN BEGIN
                if PageTemplate = 7 then begin
                  //ItemJnlTemplate.Name := FORMAT(ItemJnlTemplate.Type,MAXSTRLEN(ItemJnlTemplate.Name))+'-REC';
                  ItemJnlTemplate.Name := 'TELXON-REC';
                  ItemJnlTemplate.Description := 'Telxon Recurring Journal';
                  ItemJnlTemplate."Page ID" := 50044; //Telxon Recurring Journal
                end
                else begin
        //<<

                if ItemJnlTemplate.Type = ItemJnlTemplate.Type::Item then begin
                  ItemJnlTemplate.Name := Text001;
                  ItemJnlTemplate.Description := Text002;
                end else begin
                  ItemJnlTemplate.Name :=
                    Text005 + Format(ItemJnlTemplate.Type,MaxStrLen(ItemJnlTemplate.Name) - StrLen(Text005));
                  ItemJnlTemplate.Description := Text006 + StrSubstNo(Text000,ItemJnlTemplate.Type);
                end;

        //>> Add END for above modification
                end;

              end;
              ItemJnlTemplate.Insert;
              Commit;
            end;

          1:
            ItemJnlTemplate.FindFirst;
          else
            JnlSelected := Page.RunModal(0,ItemJnlTemplate) = Action::LookupOK;
        end;
        if JnlSelected then begin
          ItemJnlLine.FilterGroup := 2;
          ItemJnlLine.SetRange("Journal Template Name",ItemJnlTemplate.Name);
          ItemJnlLine.FilterGroup := 0;
          if OpenFromBatch then begin
            ItemJnlLine."Journal Template Name" := '';
            Page.Run(ItemJnlTemplate."Page ID",ItemJnlLine);
            end
            //<ANICA CS 4-30-15 Added to make Quick Input links work. 7 is the 'TELXON' option in the "Type" string.
            else if PageTemplate = 7 then
                begin
                    Page.Run(ItemJnlTemplate."Page ID",ItemJnlLine);
                end;
            //>ANICA
        end;
    end;

    var
        Text000: label '%1 journal';
        Text001: label 'RECURRING';
        Text002: label 'Recurring Item Journal';
        Text003: label 'DEFAULT';
        Text004: label 'Default Journal';
        OldItemNo: Code[20];
        OldCapNo: Code[20];
        OldCapType: Option "Work Center","Machine Center";
        OldProdOrderNo: Code[20];
        OldOperationNo: Code[20];
        Text005: label 'REC-';
        Text006: label 'Recurring ';
        OpenFromBatch: Boolean;
        ItemJnlLine: Record "Item Journal Line";
        JnlSelected: Boolean;
        ItemJnlTemplate: Record "Item Journal Template";
        PageID: Integer;
        RecurringJnl: Boolean;
        PageTemplate: Option;
}

