Page 50051 "Target Retail Lookup"
{
    PageType = List;
    SourceTable = 50051;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(UPC; Rec.UPC)
                {
                    ApplicationArea = Basic;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                }
                field(Retail; Rec.Retail)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Package Retail"; Rec."Package Retail")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Modified"; Rec."Last Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last User"; Rec."Last User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        Rec.CalcFields(Priority);
    end;
}

