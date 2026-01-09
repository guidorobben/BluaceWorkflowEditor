codeunit 83819 "Sales Header Helper WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Sales Header" = RM;

    internal procedure ShowApprovalInfo(SalesHeader: Record "Sales Header")
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
        RecordInfo.SourceRecord(SalesHeader);

        InfoDialog.Initialize();
        InfoDialog.RecordInfo(RecordInfo);
        InfoDialog.SetCaption('Approval');
        UserManagement.GetUserInfo(InfoDialog);
        InfoDialog.AddHeader('Purchase Info');
        InfoDialog.Add('OpenApprovalEntriesExist', ApprovalsMgmt.HasOpenApprovalEntries(SalesHeader.RecordId()));
        InfoDialog.Add('OpenApprovalEntriesExistForCurrUser', ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(SalesHeader.RecordId()));
        InfoDialog.Add('CanCancelApprovalForRecord', ApprovalsMgmt.CanCancelApprovalForRecord(SalesHeader.RecordId()));
        WorkflowHelper.GetWorkflowInfo(SalesHeader.RecordId(), InfoDialog);
        InfoDialog.AddHeader('Approval Entries');
        InfoDialog.Add('All', ApprovalMgt.ApprovalEntriesCount(SalesHeader.RecordId().TableNo(), SalesHeader.RecordId()), "Info Dialog Event Code WFE"::"Approval Entries");
        InfoDialog.Add('Open', ApprovalMgt.ApprovalEntriesCount(SalesHeader.RecordId().TableNo(), SalesHeader.RecordId(), ApprovalEntry.Status::Open, false), "Info Dialog Event Code WFE"::"Approval Entries");
        InfoDialog.Add('Overdue', ApprovalMgt.ApprovalEntriesCount(SalesHeader.RecordId().TableNo(), SalesHeader.RecordId(), ApprovalEntry.Status::Open, true), "Info Dialog Event Code WFE"::"Approval Entries");
        InfoDialog.AddHeader('Posting');
        InfoDialog.Add('Record Restriction', RestrictionMgt.RecordHasUsageRestrictions(SalesHeader));
        InfoDialog.OpenInfoDialog();
    end;

    internal procedure SetStatusToOpen(var SalesHeader: Record "Sales Header")
    begin
        SetStatusTo(SalesHeader, "Purchase Document Status"::Open);
    end;

    internal procedure SetStatusToPendingApproval(var SalesHeader: Record "Sales Header")
    begin
        SetStatusTo(SalesHeader, "Purchase Document Status"::"Pending Approval");
    end;

    internal procedure SetStatusToPendingPrepayment(var SalesHeader: Record "Sales Header")
    begin
        SetStatusTo(SalesHeader, "Purchase Document Status"::"Pending Prepayment");
    end;

    internal procedure SetStatusToReleased(var SalesHeader: Record "Sales Header")
    begin
        SetStatusTo(SalesHeader, "Purchase Document Status"::Released);
    end;

    internal procedure SetStatusTo(var SalesHeader: Record "Sales Header"; PurchaseDocumentStatus: Enum "Purchase Document Status")
    begin
        TestIsApprovalAdministrator();
        SalesHeader.Status := PurchaseDocumentStatus;
        SalesHeader.Modify(false);
    end;

    local procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;

    internal procedure AllowRecordUsage(var SalesHeader: Record "Sales Header")
    var
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
    begin
        TestIsApprovalAdministrator();
        RecordRestrictionMgt.AllowRecordUsage(SalesHeader);
    end;

    internal procedure RestrictRecordUsage(var SalesHeader: Record "Sales Header")
    var
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
    begin
        TestIsApprovalAdministrator();
        RecordRestrictionMgt.RestrictRecordUsage(SalesHeader, 'Manual restriction by user');
    end;

    internal procedure OpenRestrictedRecord(var SalesHeader: Record "Sales Header")
    var
        RestrictedRecord: Record "Restricted Record";
    begin
        RestrictedRecord.SetRange("Record ID", SalesHeader.RecordId());
        Page.Run(Page::"Restricted Records", RestrictedRecord);
    end;
}