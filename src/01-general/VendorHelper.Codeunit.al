codeunit 83816 "Vendor Helper WFE"
{
    Access = Internal;

    procedure AllowRecordUsage(var Vendor: Record Vendor)
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

    procedure ShowApprovalInfo(Vendor: Record Vendor)
    var
        ApprovalEntry: Record "Approval Entry";
        Workflow: Record Workflow;
        ApprovalMgt: Codeunit "Approval Mgt. WFE";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InfoDialog: Codeunit "Info Dialog WFE";
        RecordInfo: Codeunit "Record Info WFE";
        RestrictionMgt: Codeunit "Restriction Mgt. WFE";
        UserManagement: Codeunit "User Management WFE";
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
        Workflow.GetWorkflowInfoWFE(Vendor.RecordId(), InfoDialog);
        InfoDialog.AddHeader('Approval Entries');
        InfoDialog.Add('All', ApprovalMgt.ApprovalEntriesCount(Vendor.RecordId().TableNo(), Vendor.RecordId()), "Info Dialog Event Code WFE"::"Approval Entries");
        InfoDialog.Add('Open', ApprovalMgt.ApprovalEntriesCount(Vendor.RecordId().TableNo(), Vendor.RecordId(), ApprovalEntry.Status::Open, false), "Info Dialog Event Code WFE"::"Approval Entries");
        InfoDialog.Add('Overdue', ApprovalMgt.ApprovalEntriesCount(Vendor.RecordId().TableNo(), Vendor.RecordId(), ApprovalEntry.Status::Open, true), "Info Dialog Event Code WFE"::"Approval Entries");
        InfoDialog.AddHeader('Posting');
        InfoDialog.Add('Record Restriction', RestrictionMgt.RecordHasUsageRestrictions(Vendor), "Info Dialog Event Code WFE"::"Record Restriction");
        InfoDialog.OpenInfoDialog();
    end;

    procedure OpenApprovalEntries(var Vendor: Record Vendor)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", Vendor.RecordId().TableNo());
        ApprovalEntry.SetRange("Record ID to Approve", Vendor.RecordId());
#pragma warning disable AC0006
        Page.RunModal(Page::"Approval Entries WFE", ApprovalEntry);
#pragma warning restore AC0006
    end;

    procedure OpenRestrictedRecord(var Vendor: Record Vendor)
    var
        RestrictedRecord: Record "Restricted Record";
    begin
        RestrictedRecord.SetRange("Record ID", Vendor.RecordId());
        Page.Run(Page::"Restricted Records", RestrictedRecord);
    end;
}