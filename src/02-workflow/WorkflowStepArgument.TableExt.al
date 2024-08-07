tableextension 83800 "Workflow Step Argument WPTE" extends "Workflow Step Argument"
{
    fields
    {
        field(83800; "Function Name Description WPTE"; Text[250])
        {
            Caption = 'Function Name Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Workflow Response".Description where("Function Name" = field("Response Function Name")));
            Editable = false;
        }
    }
}
