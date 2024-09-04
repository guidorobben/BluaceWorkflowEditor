pageextension 83804 "Workflow Step Responses WPTE" extends "Workflow Step Responses"
{
    layout
    {
        addlast(content)
        {
            group(WorkflowEditorWPTE)
            {
                Caption = 'Workflow Editor';

                field("Response Step ID WPTE"; Rec."Response Step ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = false;
                    Lookup = false;
                    ToolTip = 'Specifies the value of the Response Step ID field.';
                }
                field(FunctionNameWPTE; FunctionNameWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Function Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Function Name field.', Comment = '%';
                }
            }
        }
    }

    var
        FunctionNameWPTE: Text[100];

    trigger OnAfterGetRecord()
    var
        WorkflowHelper: Codeunit "Workflow Helper WPTE";
    begin
        FunctionNameWPTE := WorkflowHelper.GetFunctionName(Rec."Workflow Code", Rec."Response Step ID");
    end;
}