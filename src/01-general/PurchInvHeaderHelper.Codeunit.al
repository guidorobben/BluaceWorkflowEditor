codeunit 83815 "Purch. Inv. Header Helper WFE"
{
    Permissions =
        tabledata "Purch. Inv. Header" = R,
        tabledata "User Setup" = R,
        tabledata Workflow = R,
        tabledata "Workflow Step Instance" = R;

    internal procedure AllowRecordUsage(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
    begin
        TestIsApprovalAdministrator();
        RecordRestrictionMgt.AllowRecordUsage(PurchInvHeader);
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;

    internal procedure ShowApprovalInfo(PurchInvHeader: Record "Purch. Inv. Header")
    var
        UserSetup: Record "User Setup";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InfoDialog: Codeunit "Info Dialog WFE";
    begin
        InfoDialog.Initialize();
        InfoDialog.SetCaption('Approval');
        InfoDialog.AddHeader('User Info');
        InfoDialog.Add('User ID', UserId);
        InfoDialog.Add('User Setup', UserSetup.Get(UserId));
        InfoDialog.Add('Approval Administrator', UserSetup."Approval Administrator");
        InfoDialog.Add('Approver ID', UserSetup."Approver ID");
        InfoDialog.AddHeader('Purchase Info');
        InfoDialog.Add('OpenApprovalEntriesExist', ApprovalsMgmt.HasOpenApprovalEntries(PurchInvHeader.RecordId()));
        InfoDialog.Add('OpenApprovalEntriesExistForCurrUser', ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(PurchInvHeader.RecordId()));
        InfoDialog.Add('CanCancelApprovalForRecord', ApprovalsMgmt.CanCancelApprovalForRecord(PurchInvHeader.RecordId()));
        InfoDialog.AddHeader('Workflow');
        GetWorkflowInfo(PurchInvHeader, InfoDialog);
        InfoDialog.OpenInfoDialog();
    end;

    local procedure GetWorkflowInfo(PurchInvHeader: Record "Purch. Inv. Header"; var InfoDialog: Codeunit "Info Dialog WFE")
    var
        Workflow: Record Workflow;
        WorkflowStepInstance: Record "Workflow Step Instance";
        WorkFlowCode: Code[20];
        InstanceID: Guid;
        WorkflowDescription: Text[100];
    begin
        WorkflowStepInstance.SetRange("Record ID", PurchInvHeader.RecordId);
        if WorkflowStepInstance.FindFirst() then begin
            InstanceID := WorkflowStepInstance.ID;
            WorkFlowCode := WorkflowStepInstance."Workflow Code";
            if Workflow.Get(WorkFlowCode) then
                WorkflowDescription := Workflow.Description;
        end;

        InfoDialog.Add('ID', InstanceID, 'INSTANCEID');
        InfoDialog.Add('Code', WorkFlowCode, 'WORKFLOWCODE');
        InfoDialog.Add('Description', WorkflowDescription);
    end;
}
