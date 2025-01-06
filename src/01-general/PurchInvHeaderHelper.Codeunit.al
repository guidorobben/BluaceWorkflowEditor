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
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InfoDialog: Codeunit "Info Dialog WFE";
        UserManagement: Codeunit "User Management WFE";
        WorkflowHelper: Codeunit "Workflow Helper WFE";
        RestrictionMgt: Codeunit "Restriction Mgt. WFE";
    begin
        InfoDialog.Initialize();
        InfoDialog.SetCaption('Approval');
        UserManagement.GetUserInfo(InfoDialog);
        InfoDialog.AddHeader('Purchase Info');
        InfoDialog.Add('OpenApprovalEntriesExist', ApprovalsMgmt.HasOpenApprovalEntries(PurchInvHeader.RecordId()));
        InfoDialog.Add('OpenApprovalEntriesExistForCurrUser', ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(PurchInvHeader.RecordId()));
        InfoDialog.Add('CanCancelApprovalForRecord', ApprovalsMgmt.CanCancelApprovalForRecord(PurchInvHeader.RecordId()));
        WorkflowHelper.GetWorkflowInfo(PurchInvHeader.RecordId, InfoDialog);
        InfoDialog.Add('Record Restriction', RestrictionMgt.RecordHasUsageRestrictions(PurchInvHeader));
        InfoDialog.OpenInfoDialog();
    end;
}