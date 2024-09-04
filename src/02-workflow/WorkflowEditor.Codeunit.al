codeunit 83801 "Workflow Editor WPTE"
{
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

        Page.Run(Page::"Workflow Step Instance WPTE", WorkflowStepInstance);
    end;

    procedure EditWorkflowSteps(WorkFlowCode: Code[20])
    var
        WorkflowStep: Record "Workflow Step";
    begin
        WorkflowStep.FilterGroup(10);
        WorkflowStep.SetRange("Workflow Code", WorkFlowCode);
        WorkflowStep.FilterGroup(0);
        Page.Run(Page::"Workflow Step Editor WPTE", WorkflowStep);
    end;
}