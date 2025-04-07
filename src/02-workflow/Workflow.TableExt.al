tableextension 83802 "Workflow WFE" extends Workflow
{
    var
        WorkflowHelperWFE: Codeunit "Workflow Helper WFE";

    // internal procedure EnableWorkflowWFE()
    // begin
    //     WorkflowHelperWFE.EnableWorkflow(Rec);
    // end;

    internal procedure ToggleEnableWorkflowWFE()
    begin
        WorkflowHelperWFE.ToggleEnableWorkflow(Rec);
    end;

    internal procedure ShowApprovalInfoWFE()
    begin
        WorkflowHelperWFE.ShowApprovalInfo(Rec);
    end;
}