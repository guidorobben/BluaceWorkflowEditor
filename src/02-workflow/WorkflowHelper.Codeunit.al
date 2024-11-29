codeunit 83803 "Workflow Helper WFE"
{
    Permissions =
        tabledata Workflow = RM,
        tabledata "Workflow Step" = R;

    internal procedure GetFunctionName(WorkflowCode: Code[20]; StepId: Integer): Text[100]
    var
        WorkflowStep: Record "Workflow Step";
    begin
        WorkflowStep.SetRange("Workflow Code", WorkflowCode);
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

    internal procedure SetToWorkflow(var Workflow: Record Workflow)
    var
        ConfirmManagement: Codeunit "Confirm Management";
        ConvertToWorkflowQst: Label 'Do you want to convert the workflow template to a workflow?';
    begin
        if ConfirmManagement.GetResponse(ConvertToWorkflowQst, false) then begin
            Workflow.TestField(Enabled, false);
            Workflow.Validate(Template, false);
            Workflow.Modify(true);
        end;
    end;

    internal procedure SetToWorkflowTemplate(var Workflow: Record Workflow)
    var
        ConfirmManagement: Codeunit "Confirm Management";
        ConvertToWorkflowTemplateQst: Label 'Do you want to convert the workflow to a workflow template?';
    begin
        if ConfirmManagement.GetResponse(ConvertToWorkflowTemplateQst, false) then begin
            Workflow.TestField(Enabled, false);
            Workflow.Validate(Template, true);
        end;
    end;
}