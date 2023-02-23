Page 50032 "Approval Sales Orders"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Sales Header";
    SourceTableView = sorting("Document Type", "Sell-to Customer No.", "No.")
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
            field("Customer.""No."""; Customer."No.")
            {
                ApplicationArea = Basic;
                Caption = 'Customer';
                Lookup = true;
                LookupPageID = "Customer List";
                TableRelation = Customer."No.";

                trigger OnValidate()
                begin
                    CustomerNoOnAfterValidate;
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
                    Editable = true;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
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
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Order Type"; Rec."Sales Order Type")
                {
                    ApplicationArea = Basic;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
        Rec.SetRange("Document Type", _DocType);
        Rec.SetRange(Approved, _Approved);
        Rec.SetRange("No.");
        Rec.SetCurrentkey("Document Type", "No.");
    end;

    var
        _Amount: Decimal;
        _DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order";
        _DocNo: Code[20];
        _Approved: Option " ","On Hold",Approved;
        Customer: Record Customer;


    procedure ShowDocument()
    begin
        case Rec."Document Type" of
            Rec."document type"::Quote:
                Page.Run(Page::"Sales Quote", Rec);
            Rec."document type"::Order:
                Page.Run(Page::"Sales Order", Rec);
            Rec."document type"::Invoice:
                Page.Run(Page::"Sales Invoice", Rec);
            Rec."document type"::"Credit Memo":
                Page.Run(Page::"Sales Credit Memo", Rec);
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

    local procedure CustomerNoOnAfterValidate()
    begin
        if Customer."No." <> '' then
            Rec.SetRange("Sell-to Customer No.", Customer."No.")
        else
            Rec.SetRange("Sell-to Customer No.");
        CurrPage.Update;
    end;

    local procedure DocNoOnAfterValidate()
    begin
        Rec.SetRange("No.", _DocNo);
        CurrPage.Update;
    end;
}

