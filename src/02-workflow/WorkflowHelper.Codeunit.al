codeunit 83803 "Workflow Helper WPTE"
{
    internal procedure GetFunctionName(WorkflowCode: Code[20]; StepId: Integer): Text[100]
    var
        WorkflowStep: Record "Workflow Step";
    begin
        WorkflowStep.SetRange("Workflow Code", "WorkflowCode");
        WorkflowStep.SetRange(ID, StepId);
        if WorkflowStep.FindFirst() then
            exit(WorkflowStep."Function Name");
    end;

    internal procedure EnableWorkflow(var Workflow: Record Workflow)
    begin
        Workflow.Validate(Enabled, true);
        Workflow.Modify(true);
    end;

    internal procedure ToggleEnableWorkflow(var Workflow: Record Workflow)
    begin
        Workflow.Validate(Enabled, not Workflow.Enabled);
        Workflow.Modify(true);
    end;
}