tableextension 83802 "Workflow WPTE" extends Workflow
{
    var
        WorkflowHelperWPTE: Codeunit "Workflow Helper WPTE";

    // internal procedure EnableWorkflowWPTE()
    // begin
    //     WorkflowHelperWPTE.EnableWorkflow(Rec);
    // end;

    internal procedure ToggleEnableWorkflowWPTE()
    begin
        WorkflowHelperWPTE.ToggleEnableWorkflow(Rec);
    end;
}