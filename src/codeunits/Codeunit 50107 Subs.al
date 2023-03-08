codeunit 50107 "Subs"
{
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterOnInsert', '', true, true)]
    local procedure MyProcedure(var Vendor: Record Vendor)
    begin
        //<<ANICA 9-10-15 Add defaults for check formats on new vendors
        Vendor."Check Date Format" := 2;
        Vendor."Check Date Separator" := 1;
        Vendor.Modify;
    end;

}