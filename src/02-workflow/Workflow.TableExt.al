tableextension 83802 "Workflow WPTE" extends Workflow
{
    var
        WorkflowHelperWPTE: Codeunit "Workflow Helper WPTE";

    internal procedure EnableWorkflow()
    begin
        WorkflowHelperWPTE.EnableWorkflow(Rec);
    end;

    internal procedure ToggleEnableWorkflow()
    begin
        WorkflowHelperWPTE.ToggleEnableWorkflow(Rec);
    end;
}