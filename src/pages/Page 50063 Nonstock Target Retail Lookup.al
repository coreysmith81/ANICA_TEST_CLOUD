Page 50063 "Nonstock Target Retail Lookup"
{
    PageType = List;
    SourceTable = "Nonstock Target Retail";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
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
                field(Retail; Rec.Retail)
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
}

