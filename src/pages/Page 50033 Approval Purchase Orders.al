Page 50033 "Approval Purchase Orders"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Purchase Header";
    SourceTableView = sorting("Document Type", "Buy-from Vendor No.", "No.")
                      order(ascending);

    layout
    {
        area(content)
        {
            field(_DocType; _DocType)
            {
                ApplicationArea = Basic;
                Caption = 'Document Type';

                trigger OnValidate()
                begin
                    DocTypeOnAfterValidate;
                end;
            }
            field(_DocNo; _DocNo)
            {
                ApplicationArea = Basic;
                Caption = 'Document No.';

                trigger OnValidate()
                begin
                    DocNoOnAfterValidate;
                end;
            }
            field("Vendor.""No."""; Vendor."No.")
            {
                ApplicationArea = Basic;
                Caption = 'Vendor';
                Lookup = true;
                LookupPageID = "Vendor List";
                TableRelation = Vendor."No.";

                trigger OnValidate()
                begin
                    VendorNoOnAfterValidate;
                end;
            }
            field(_Approved; _Approved)
            {
                ApplicationArea = Basic;
                Caption = 'Approved';

                trigger OnValidate()
                begin
                    ApprovedOnAfterValidate;
                end;
            }
            repeater(Control2)
            {
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Basic;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&ANICA")
            {
                Caption = '&ANICA';
                action("Document details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Document details';
                    Image = ViewOrder;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        // Run Document, according to Document Type:
                        ShowDocument;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        _DocType := 1; // Orders
        _Approved := 0; // Blank
        Rec.SetRange("Document Type", _DocType); //CS 022123: Added Rec. to the front of these. Need to verify.
        Rec.SetRange(Approved, _Approved);
        Rec.SetRange("No.");
        Rec.SetCurrentkey("Document Type", "No.");
    end;

    var
        _Amount: Decimal;
        _DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order";
        _DocNo: Code[20];
        _Approved: Option " ","On Hold",Approved;
        Vendor: Record Vendor;


    procedure ShowDocument()
    begin
        case Rec."Document Type" of
            Rec."document type"::Quote:
                Page.Run(Page::"Purchase Quote", Rec);
            Rec."document type"::Order:
                Page.Run(Page::"Purchase Order", Rec);
            Rec."document type"::Invoice:
                Page.Run(Page::"Purchase Invoice", Rec);
            Rec."document type"::"Credit Memo":
                Page.Run(Page::"Purchase Credit Memo", Rec);
        end;
    end;

    local procedure ApprovedOnAfterValidate()
    begin
        Rec.SetRange(Approved, _Approved);
        CurrPage.Update;
    end;

    local procedure DocTypeOnAfterValidate()
    begin
        Rec.SetRange("Document Type", _DocType);
        CurrPage.Update;
    end;

    local procedure VendorNoOnAfterValidate()
    begin
        if Vendor."No." <> '' then
            Rec.SetRange("Buy-from Vendor No.", Vendor."No.")
        else
            Rec.SetRange("Buy-from Vendor No.");
        CurrPage.Update;
    end;

    local procedure DocNoOnAfterValidate()
    begin
        Rec.SetRange("No.", _DocNo);
        CurrPage.Update;
    end;
}

