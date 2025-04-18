pageextension 83803 "Workflow Subpage WFE" extends "Workflow Subpage"
{
    layout
    {
        addafter(Group)
        {
            group(WorkFlowEditorWFE)
            {
                Caption = 'Workflow Editor';

                field(FunctionNameWFE; FuntionNameWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Function Name';
                    Editable = false;
                    ToolTip = 'Specifies the workflow event that triggers the related workflow response.';
                }
            }
        }
    }

    var
        FuntionNameWFE: Text;

    trigger OnAfterGetCurrRecord()
    begin
        GetFunctionNameWFE();
    end;

    local procedure GetFunctionNameWFE()
    var
        WorkflowHelper: Codeunit "Workflow Helper WFE";
    begin
        FuntionNameWFE := WorkflowHelper.GetFunctionName(Rec."Workflow Code", Rec."Event Step ID");
    end;
}
