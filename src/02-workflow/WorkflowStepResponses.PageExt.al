pageextension 83804 "Workflow Step Responses WFE" extends "Workflow Step Responses"
{
    layout
    {
        addlast(content)
        {
            group(WorkflowEditorWFE)
            {
                Caption = 'Workflow Editor';

                field("Response Step ID WFE"; Rec."Response Step ID")
                {
                    ApplicationArea = All;
                    DrillDown = false;
                    Editable = false;
                    Lookup = false;
                    ToolTip = 'Specifies the value of the Response Step ID field.';
                }
                field(FunctionNameWFE; FunctionNameWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Function Name';
                    Editable = false;
                    ToolTip = 'Specifies the Function Name of the response.';
                }
            }
        }
    }

    var
        FunctionNameWFE: Text[100];

    trigger OnAfterGetRecord()
    var
        WorkflowHelper: Codeunit "Workflow Helper WFE";
    begin
        FunctionNameWFE := WorkflowHelper.GetFunctionName(Rec."Workflow Code", Rec."Response Step ID");
    end;
}