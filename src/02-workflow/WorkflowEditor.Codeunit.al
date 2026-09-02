codeunit 83801 "Workflow Editor WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Workflow Step" = r,
        tabledata "Workflow Step Instance" = r;

    procedure OpenActiveWorkflow(WorkflowStepRecordID: RecordId)
    var
        WorkflowStepInstance: Record "Workflow Step Instance";
        WorkflowInstanceId: Guid;
    begin
        WorkflowStepInstance.FilterGroup(10);
        WorkflowStepInstance.SetRange("Record ID", WorkflowStepRecordID);
        WorkflowStepInstance.FilterGroup(0);

        WorkflowStepInstance.SetRange("Entry Point", true);
        if WorkflowStepInstance.FindFirst() then begin
            WorkflowInstanceId := WorkflowStepInstance.ID;

            WorkflowStepInstance.Reset();
            WorkflowStepInstance.SetRange(ID, WorkflowInstanceId);
        end;

        Page.Run(Page::"Workflow Step Instances WFE", WorkflowStepInstance);
    end;

    procedure OpenActiveWorkflow(WorkflowInstanceId: Guid)
    var
        WorkflowStepInstance: Record "Workflow Step Instance";
    begin
        WorkflowStepInstance.SetRange(ID, WorkflowInstanceId);
        Page.Run(Page::"Workflow Step Instances WFE", WorkflowStepInstance);
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

    procedure OpenApprovalEntriesPage(SourceRecordId: RecordId)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", SourceRecordId.TableNo());
        ApprovalEntry.SetRange("Record ID to Approve", SourceRecordId);
        Page.RunModal(Page::"Approval Entries WFE", ApprovalEntry);
    end;
}