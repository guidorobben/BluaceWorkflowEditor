tableextension 83800 "Workflow Step Argument WFE" extends "Workflow Step Argument"
{
    fields
    {
        field(83800; "Function Name Description WFE"; Text[250])
        {
            CalcFormula = lookup("Workflow Response".Description where("Function Name" = field("Response Function Name")));
            Caption = 'Function Name Description';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies the value of the hh field.', Comment = '%';
        }
    }
}
