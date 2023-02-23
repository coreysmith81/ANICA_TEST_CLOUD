Page 50070 "JBG Item Weekly Lookup"
{
    PageType = List;
    SourceTable = "JBG Item Weekly Table";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Import Date"; Rec."Import Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vendor Item No"; Rec."Vendor Item No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Pack; Rec.Pack)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pack Descrip"; Rec."Pack Descrip")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UPC; Rec.UPC)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NCoGroup; Rec.NCoGroup)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Post Indicator"; Rec."Post Indicator")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Hazardous; Rec.Hazardous)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(FoodNFood; Rec.FoodNFood)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Change; Rec.Change)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Discontinued; Rec.Discontinued)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Dept; Rec.Dept)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Price Allow"; Rec."Price Allow")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Target Retail"; Rec."Target Retail")
                {
                    ApplicationArea = Basic;
                }
                field(Vendor; Rec.Vendor)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Warehouse Dept."; Rec."Warehouse Dept.")
                {
                    ApplicationArea = Basic;
                }
                field("Price Change"; Rec."Price Change")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Percent Change"; Rec."Percent Change")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

