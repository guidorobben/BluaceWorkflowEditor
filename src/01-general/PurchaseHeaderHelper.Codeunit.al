codeunit 83807 "Purchase Header Helper WFE"
{
    Permissions =
        tabledata "Purchase Header" = RM,
        tabledata "User Setup" = R,
        tabledata Workflow = R,
        tabledata "Workflow Step Instance" = R;

    internal procedure SetStatusToOpen(var PurchaseHeader: Record "Purchase Header")
    begin
        SetStatusTo(PurchaseHeader, "Purchase Document Status"::Open);
    end;

    internal procedure SetStatusToPendingApproval(var PurchaseHeader: Record "Purchase Header")
    begin
        SetStatusTo(PurchaseHeader, "Purchase Document Status"::"Pending Approval");
    end;

    internal procedure SetStatusToPendingPrepayment(var PurchaseHeader: Record "Purchase Header")
    begin
        SetStatusTo(PurchaseHeader, "Purchase Document Status"::"Pending Prepayment");
    end;

    internal procedure SetStatusToReleased(var PurchaseHeader: Record "Purchase Header")
    begin
        SetStatusTo(PurchaseHeader, "Purchase Document Status"::Released);
    end;

    internal procedure SetStatusTo(var PurchaseHeader: Record "Purchase Header"; PurchaseDocumentStatus: Enum "Purchase Document Status")
    begin
        TestIsApprovalAdministrator();
        PurchaseHeader.Status := PurchaseDocumentStatus;
        PurchaseHeader.Modify(false);
    end;

    internal procedure AllowRecordUsage(var PurchaseHeader: Record "Purchase Header")
    var
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
    begin
        TestIsApprovalAdministrator();
        RecordRestrictionMgt.AllowRecordUsage(PurchaseHeader);
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;

    internal procedure ShowApprovalInfo(var PurchaseHeader: Record "Purchase Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InfoDialog: Codeunit "Info Dialog WFE";
        UserManagement: Codeunit "User Management WFE";
        WorkflowHelper: Codeunit "Workflow Helper WFE";
    begin
        InfoDialog.Initialize();
        InfoDialog.SetCaption('Approval');
        UserManagement.GetUserInfo(InfoDialog);
        InfoDialog.AddHeader('Purchase Info');
        InfoDialog.Add('OpenApprovalEntriesExist', ApprovalsMgmt.HasOpenApprovalEntries(PurchaseHeader.RecordId()));
        InfoDialog.Add('OpenApprovalEntriesExistForCurrUser', ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(PurchaseHeader.RecordId()));
        InfoDialog.Add('CanCancelApprovalForRecord', ApprovalsMgmt.CanCancelApprovalForRecord(PurchaseHeader.RecordId()));
        WorkflowHelper.GetWorkflowInfo(PurchaseHeader.RecordId, InfoDialog);
        InfoDialog.OpenInfoDialog();
    end;

    // local procedure GetWorkflowInfo(var PurchaseHeader: Record "Purchase Header"; var InfoDialog: Codeunit "Info Dialog WFE")
    // var
    //     Workflow: Record Workflow;
    //     WorkflowStepInstance: Record "Workflow Step Instance";
    //     WorkFlowCode: Code[20];
    //     InfoDialogEventCode: Enum "Info Dialog Event Code WFE";
    //     InstanceID: Guid;
    //     WorkflowDescription: Text[100];
    // begin
    //     WorkflowStepInstance.SetRange("Record ID", PurchaseHeader.RecordId);
    //     if WorkflowStepInstance.FindFirst() then begin
    //         InstanceID := WorkflowStepInstance.ID;
    //         WorkFlowCode := WorkflowStepInstance."Workflow Code";
    //         if Workflow.Get(WorkFlowCode) then
    //             WorkflowDescription := Workflow.Description;
    //     end;

    //     InfoDialog.AddHeader('Workflow');
    //     InfoDialog.Add('ID', InstanceID, InfoDialogEventCode::INSTANCEID);
    //     InfoDialog.Add('Code', WorkFlowCode, InfoDialogEventCode::WORKFLOWCODE);
    //     InfoDialog.Add('Description', WorkflowDescription);
    // end;
}