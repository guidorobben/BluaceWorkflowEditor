codeunit 83801 "Workflow Editor WFE"
{
    Permissions =
        tabledata "Workflow Step" = R,
        tabledata "Workflow Step Instance" = R;

    procedure OpenActiveWorkflow(WorkflowStepRecordID: RecordId)
    var
        WorkflowStepInstance: Record "Workflow Step Instance";
        WorkflowInstanceId: Guid;
    begin
        // WorkflowStepInstance.FilterGroup(10);
        WorkflowStepInstance.SetRange("Record ID", WorkflowStepRecordID);
        WorkflowStepInstance.SetRange("Entry Point", true);
        if WorkflowStepInstance.FindFirst() then begin
            WorkflowInstanceId := WorkflowStepInstance.ID;
            WorkflowStepInstance.Reset();
            WorkflowStepInstance.SetRange(ID, WorkflowInstanceId);
        end;
        // WorkflowStepInstance.FilterGroup(0);

        Page.Run(Page::"Workflow Step Instance WFE", WorkflowStepInstance);
    end;

    procedure OpenActiveWorkflow(WorkflowInstanceId: Guid)
    var
        WorkflowStepInstance: Record "Workflow Step Instance";
    begin
        WorkflowStepInstance.SetRange(ID, WorkflowInstanceId);
        Page.Run(Page::"Workflow Step Instance WFE", WorkflowStepInstance);
    end;

    procedure EditWorkflowSteps(WorkFlowCode: Code[20])
    var
        WorkflowStep: Record "Workflow Step";
    begin
        WorkflowStep.FilterGroup(10);
        WorkflowStep.SetRange("Workflow Code", WorkFlowCode);
        WorkflowStep.FilterGroup(0);
        Page.Run(Page::"Workflow Step Editor WFE", WorkflowStep);
    end;
}