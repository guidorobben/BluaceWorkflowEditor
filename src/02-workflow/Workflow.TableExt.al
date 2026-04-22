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

    internal procedure GetWorkflowInfoWFE(SourceRecordId: RecordId; var InfoDialog: Codeunit "Info Dialog WFE")
    begin
        WorkflowHelperWFE.GetWorkflowInfo(SourceRecordId, InfoDialog);
    end;
}