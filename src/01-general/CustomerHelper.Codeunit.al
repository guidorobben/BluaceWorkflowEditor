codeunit 83826 "Customer Helper WFE"
{
    internal procedure AllowRecordUsage(var Customer: Record Customer)
    var
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
    begin
        TestIsApprovalAdministrator();
        RecordRestrictionMgt.AllowRecordUsage(Customer);
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;

    internal procedure ShowApprovalInfo(Customer: Record Customer)
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalMgt: Codeunit "Approval Mgt. WFE";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InfoDialog: Codeunit "Info Dialog WFE";
        RecordInfo: Codeunit "Record Info WFE";
        RestrictionMgt: Codeunit "Restriction Mgt. WFE";
        UserManagement: Codeunit "User Management WFE";
        WorkflowHelper: Codeunit "Workflow Helper WFE";
    begin
        RecordInfo.Initialize();
        RecordInfo.SourceRecord(Customer);

        InfoDialog.Initialize();
        InfoDialog.RecordInfo(RecordInfo);
        InfoDialog.SetCaption('Approval');
        UserManagement.GetUserInfo(InfoDialog);
        InfoDialog.AddHeader('Purchase Info');
        InfoDialog.Add('OpenApprovalEntriesExist', ApprovalsMgmt.HasOpenApprovalEntries(Customer.RecordId()));
        InfoDialog.Add('OpenApprovalEntriesExistForCurrUser', ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Customer.RecordId()));
        InfoDialog.Add('CanCancelApprovalForRecord', ApprovalsMgmt.CanCancelApprovalForRecord(Customer.RecordId()));
        WorkflowHelper.GetWorkflowInfo(Customer.RecordId(), InfoDialog);
        InfoDialog.AddHeader('Approval Entries');
        InfoDialog.Add('All', ApprovalMgt.ApprovalEntriesCount(Customer.RecordId().TableNo(), Customer.RecordId()), "Info Dialog Event Code WFE"::"Approval Entries");
        InfoDialog.Add('Open', ApprovalMgt.ApprovalEntriesCount(Customer.RecordId().TableNo(), Customer.RecordId(), ApprovalEntry.Status::Open, false), "Info Dialog Event Code WFE"::"Approval Entries");
        InfoDialog.Add('Overdue', ApprovalMgt.ApprovalEntriesCount(Customer.RecordId().TableNo(), Customer.RecordId(), ApprovalEntry.Status::Open, true), "Info Dialog Event Code WFE"::"Approval Entries");
        InfoDialog.AddHeader('Posting');
        InfoDialog.Add('Record Restriction', RestrictionMgt.RecordHasUsageRestrictions(Customer));
        InfoDialog.OpenInfoDialog();
    end;

    internal procedure OpenApprovalEntries(var Customer: Record Customer)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", Customer.RecordId().TableNo());
        ApprovalEntry.SetRange("Record ID to Approve", Customer.RecordId());
        Page.RunModal(Page::"Approval Entries WFE", ApprovalEntry);
    end;
}