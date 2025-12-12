codeunit 83816 "Vendor Helper WFE"
{
    internal procedure AllowRecordUsage(var Vendor: Record Vendor)
    var
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
    begin
        TestIsApprovalAdministrator();
        RecordRestrictionMgt.AllowRecordUsage(Vendor);
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;

    internal procedure ShowApprovalInfo(Vendor: Record Vendor)
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InfoDialog: Codeunit "Info Dialog WFE";
        RecordInfo: Codeunit "Record Info WFE";
        RestrictionMgt: Codeunit "Restriction Mgt. WFE";
        UserManagement: Codeunit "User Management WFE";
        WorkflowHelper: Codeunit "Workflow Helper WFE";
    begin
        RecordInfo.Initialize();
        RecordInfo.SourceRecord(Vendor);

        InfoDialog.Initialize();
        InfoDialog.RecordInfo(RecordInfo);
        InfoDialog.SetCaption('Approval');
        UserManagement.GetUserInfo(InfoDialog);
        InfoDialog.AddHeader('Purchase Info');
        InfoDialog.Add('OpenApprovalEntriesExist', ApprovalsMgmt.HasOpenApprovalEntries(Vendor.RecordId()));
        InfoDialog.Add('OpenApprovalEntriesExistForCurrUser', ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Vendor.RecordId()));
        InfoDialog.Add('CanCancelApprovalForRecord', ApprovalsMgmt.CanCancelApprovalForRecord(Vendor.RecordId()));
        WorkflowHelper.GetWorkflowInfo(Vendor.RecordId(), InfoDialog);
        InfoDialog.Add('Record Restriction', RestrictionMgt.RecordHasUsageRestrictions(Vendor));
        InfoDialog.OpenInfoDialog();
    end;

    internal procedure OpenApprovalEntries(var Vendor: Record Vendor)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", Vendor.RecordId().TableNo());
        ApprovalEntry.SetRange("Record ID to Approve", Vendor.RecordId());
        Page.RunModal(Page::"Approval Entries WFE", ApprovalEntry);
    end;
}