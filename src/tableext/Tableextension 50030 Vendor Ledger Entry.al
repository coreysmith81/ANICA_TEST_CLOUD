tableextension 50030 "Vendor Ledger Entry" extends "Vendor Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
    }

    keys
    {
        key(Key50000; "Document Type", "Document No.", "Vendor No.") { }
        key(key50001; Open, "Due Date", "Vendor No.", "External Document No.") { }
        key(key50002; "External Document No.", "Due Date", "Vendor No.") { }
    }
    var
        myInt: Integer;
}