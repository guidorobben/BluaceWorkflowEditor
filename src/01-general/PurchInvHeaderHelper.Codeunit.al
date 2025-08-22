codeunit 83815 "Purch. Inv. Header Helper WFE"
{
    Permissions =
        tabledata "Purch. Inv. Header" = R,
        tabledata "User Setup" = R,
        tabledata Workflow = R,
        tabledata "Workflow Editor Setup WFE" = R,
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
        RestrictionMgt: Codeunit "Restriction Mgt. WFE";
        UserManagement: Codeunit "User Management WFE";
        WorkflowHelper: Codeunit "Workflow Helper WFE";
    begin
        InfoDialog.Initialize();
        InfoDialog.SetCaption('Approval');
        UserManagement.GetUserInfo(InfoDialog);
        InfoDialog.AddHeader('Purchase Info');
        InfoDialog.Add('OpenApprovalEntriesExist', ApprovalsMgmt.HasOpenApprovalEntries(PurchInvHeader.RecordId()));
        InfoDialog.Add('OpenApprovalEntriesExistForCurrUser', ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(PurchInvHeader.RecordId()));
        InfoDialog.Add('CanCancelApprovalForRecord', ApprovalsMgmt.CanCancelApprovalForRecord(PurchInvHeader.RecordId()));
        WorkflowHelper.GetWorkflowInfo(PurchInvHeader.RecordId(), InfoDialog);
        InfoDialog.Add('Record Restriction', RestrictionMgt.RecordHasUsageRestrictions(PurchInvHeader));
        InfoDialog.OpenInfoDialog();
    end;

    internal procedure OpenApprovals(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        ApprovalsMgmt.RunWorkflowEntriesPage(PurchInvHeader.RecordId(), Database::"Purch. Inv. Header", Enum::"Approval Document Type"::Invoice, PurchInvHeader."No.");
    end;

    internal procedure SetStatusToOpen(var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        SetStatusTo(PurchInvHeader, "Purchase Document Status"::Open);
    end;

    internal procedure SetStatusToPendingApproval(var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        SetStatusTo(PurchInvHeader, "Purchase Document Status"::"Pending Approval");
    end;

    internal procedure SetStatusToPendingPrepayment(var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        SetStatusTo(PurchInvHeader, "Purchase Document Status"::"Pending Prepayment");
    end;

    internal procedure SetStatusToReleased(var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        SetStatusTo(PurchInvHeader, "Purchase Document Status"::Released);
    end;

    internal procedure SetStatusTo(var PurchInvHeader: Record "Purch. Inv. Header"; PurchaseDocumentStatus: Enum "Purchase Document Status")
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WFE";
        PurchInvHeaderRecordRef: RecordRef;
        StatusFieldRef: FieldRef;
    begin
        TestIsApprovalAdministrator();

        if not WorkflowEditorSetup.Get() then
            Clear(WorkflowEditorSetup);

        WorkflowEditorSetup.TestField("Posted Purch. Inv. Status ID");

        PurchInvHeaderRecordRef.GetTable(PurchInvHeader);
        StatusFieldRef := PurchInvHeaderRecordRef.Field(WorkflowEditorSetup."Posted Purch. Inv. Status ID");

        case PurchaseDocumentStatus of
            PurchaseDocumentStatus::Open: //0
                StatusFieldRef.Value := 0;
            PurchaseDocumentStatus::Released: //1
                StatusFieldRef.Value := 1;
            PurchaseDocumentStatus::"Pending Approval": //2
                StatusFieldRef.Value := 2;
            PurchaseDocumentStatus::"Pending Prepayment": //3
                StatusFieldRef.Value := 3;
        end;

        PurchInvHeaderRecordRef.Modify(false);
    end;
}