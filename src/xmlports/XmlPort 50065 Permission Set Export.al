XmlPort 50065 "Permission Set Export"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Permission;Permission)
            {
                XmlName = 'Permissions';
                fieldelement(RoleID;Permission."Role ID")
                {
                }
                fieldelement(RoleName;Permission."Role Name")
                {
                }
                fieldelement(ObjType;Permission."Object Type")
                {
                }
                fieldelement(ObjName;Permission."Object Name")
                {
                }
                fieldelement(Read;Permission."Read Permission")
                {
                }
                fieldelement(Insert;Permission."Insert Permission")
                {
                }
                fieldelement(Modify;Permission."Modify Permission")
                {
                }
                fieldelement(Delete;Permission."Delete Permission")
                {
                }
                fieldelement(Execute;Permission."Execute Permission")
                {
                }
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
}

