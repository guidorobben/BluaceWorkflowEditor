tableextension 83802 "Workflow WPTE" extends Workflow
{
    var
        WorkflowHelper: Codeunit "Workflow Helper WPTE";

    internal procedure EnableWorkflow()
    begin
        WorkflowHelper.EnableWorkflow(Rec);
    end;

    internal procedure ToggleEnableWorkflow()
    begin
        WorkflowHelper.ToggleEnableWorkflow(Rec);
    end;
}