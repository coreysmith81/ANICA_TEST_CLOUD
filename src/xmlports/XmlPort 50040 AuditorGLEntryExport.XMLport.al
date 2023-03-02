XmlPort 50040 "Auditor G/L Entry Export"
{
    // This export is used to give our financial statment auditors general journal entries for the year.
    // It is used annually.
    // 
    // 2-5-16 All entries were requested so I commented out the Source Code filter LCC

    Caption = '<Auditor GL Entry Export>';
    Direction = Export;
    FieldDelimiter = '~';
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("G/L Entry";"G/L Entry")
            {
                AutoUpdate = true;
                RequestFilterFields = "Posting Date";
                XmlName = 'GLEntry';
                SourceTableView = sorting("Posting Date","G/L Account No.",Description) order(ascending);
                fieldelement(GLAccountNo;"G/L Entry"."G/L Account No.")
                {
                }
                fieldelement(AccountName;"G/L Entry"."G/L Account Name")
                {
                }
                fieldelement(PostingDate;"G/L Entry"."Posting Date")
                {

                    trigger OnBeforePassField()
                    begin
                        //Convert Date to Text and check for closing date
                        VTextDate := Format("G/L Entry"."Posting Date",10,'<Closing>" "<Month,2>/<Day,2>/<Year,4>');

                        if CopyStr(VTextDate,1,1) = 'C' then
                            VClosingDate := true
                        else
                            VClosingDate := false;

                        //Fix Closing Entry Dates
                        "G/L Entry"."Posting Date" := NormalDate("G/L Entry"."Posting Date");
                    end;
                }
                fieldelement(DocumentType;"G/L Entry"."Document Type")
                {
                }
                fieldelement(DocumentNo;"G/L Entry"."Document No.")
                {
                }
                fieldelement(Description;"G/L Entry".Description)
                {
                }
                fieldelement(Amount;"G/L Entry".Amount)
                {
                }
                fieldelement(GlobalDimension1Code;"G/L Entry"."Global Dimension 1 Code")
                {
                }
                fieldelement(UserID;"G/L Entry"."User ID")
                {
                }
                fieldelement(SourceType;"G/L Entry"."Source Type")
                {
                }
                fieldelement(SourceNo;"G/L Entry"."Source No.")
                {
                }
                fieldelement(SourceCode;"G/L Entry"."Source Code")
                {
                }
                textelement("<vclosingdate>")
                {
                    XmlName = 'ClosingDate';
                }
                textelement(VCreationDate)
                {
                }
                textelement(VCreationTime)
                {
                }
                textelement(VCreationUser)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //IF "G/L Entry"."Source Code" <> 'GENJNL' THEN currXMLport.SKIP;

                    LookupGLRegister;
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
        Message('Export is Done');
    end;

    trigger OnPreXmlPort()
    begin
        //For Status Box
        begin
            Clear(Window);
            Window.Open('Processing Item #1######');
            Window.Update(1,"G/L Entry"."Entry No.");
        end;
    end;

    var
        GLRegister: Record "G/L Register";
        Window: Dialog;
        VTextDate: Text;
        VFromEntry: Integer;
        VToEntry: Integer;
        VFound: Boolean;
        VClosingDate: Boolean;

    local procedure LookupGLRegister()
    begin
        VFound := false;
        //CLEAR(VCreationDate);
        //CLEAR(VCreationTime);
        //CLEAR(VCreationUser);

        GLRegister.SetCurrentkey("From Entry No.","To Entry No.");
        GLRegister.SetRange(GLRegister."From Entry No.","G/L Entry"."Entry No."-100,"G/L Entry"."Entry No.");

        if GLRegister.Find('-') then
            repeat
            begin
                VFromEntry := GLRegister."From Entry No.";
                VToEntry := GLRegister."To Entry No.";

                if ("G/L Entry"."Entry No." >= GLRegister."From Entry No.") and
                        ("G/L Entry"."Entry No." <= GLRegister."To Entry No.") then
                    begin
                        VFound := true;
                        VCreationDate := Format(GLRegister."Creation Date");
                        VCreationTime := Format(GLRegister."Creation Time");
                        VCreationUser := Format(GLRegister."User ID");
                    end

            end;
            until (GLRegister.Next = 0) or (VFound = true);
    end;
}

