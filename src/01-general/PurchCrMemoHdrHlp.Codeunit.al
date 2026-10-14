codeunit 83827 "Purch. Cr. Memo Hdr. Hlp. WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Purch. Cr. Memo Hdr." = r,
        tabledata "Purch. Inv. Header" = r,
        tabledata "Restricted Record" = r,
        tabledata "Vendor Ledger Entry" = r,
        tabledata "Workflow Editor Setup WFE" = r;

    internal procedure OpenApprovals(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        ApprovalsMgmt.RunWorkflowEntriesPage(PurchCrMemoHdr.RecordId(), Database::"Purch. Cr. Memo Hdr.", Enum::"Approval Document Type"::"Credit Memo", PurchCrMemoHdr."No.");
    end;

    internal procedure ShowApprovalInfo(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        Workflow: Record Workflow;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InfoDialog: Codeunit "Info Dialog WFE";
        RecordInfo: Codeunit "Record Info WFE";
        RestrictionMgt: Codeunit "Restriction Mgt. WFE";
        UserManagement: Codeunit "User Management WFE";
    begin
        RecordInfo.Initialize();
        RecordInfo.SourceRecord(PurchCrMemoHdr);

        InfoDialog.Initialize();
        InfoDialog.RecordInfo(RecordInfo);
        InfoDialog.SetCaption('Approval');
        UserManagement.GetUserInfo(InfoDialog);
        InfoDialog.AddHeader('Purchase Info');
        InfoDialog.Add('OpenApprovalEntriesExist', ApprovalsMgmt.HasOpenApprovalEntries(PurchCrMemoHdr.RecordId()));
        InfoDialog.Add('OpenApprovalEntriesExistForCurrUser', ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(PurchCrMemoHdr.RecordId()));
        InfoDialog.Add('CanCancelApprovalForRecord', ApprovalsMgmt.CanCancelApprovalForRecord(PurchCrMemoHdr.RecordId()));
        Workflow.GetWorkflowInfoWFE(PurchCrMemoHdr.RecordId(), InfoDialog);

        InfoDialog.AddHeader('Purchase Credit Memo');
        InfoDialog.Add('Record Restriction', RestrictionMgt.RecordHasUsageRestrictions(PurchCrMemoHdr));
        InfoDialog.Add('Vendor Ledger Entries', VendorLedgerEntryCount(PurchCrMemoHdr));
        InfoDialog.Add('Vendor Ledger Entries On Hold', VendorLedgerEntryOnHold(PurchCrMemoHdr));

        InfoDialog.OpenInfoDialog();
    end;

    procedure OpenRestrictedRecord(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        RestrictedRecord: Record "Restricted Record";
    begin
        RestrictedRecord.SetRange("Record ID", PurchCrMemoHdr.RecordId());
        Page.Run(Page::"Restricted Records", RestrictedRecord);
    end;

    local procedure VendorLedgerEntryCount(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.") Records: Integer
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        Records := 0;

        VendorLedgerEntry.SetCurrentKey("Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Document No.", PurchCrMemoHdr."No.");
        VendorLedgerEntry.SetRange("Posting Date", PurchCrMemoHdr."Posting Date");
        exit(VendorLedgerEntry.Count());
    end;

    local procedure VendorLedgerEntryOnHold(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.") OnHold: Code[3]
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        OnHold := '';

        VendorLedgerEntry.SetCurrentKey("Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Document No.", PurchCrMemoHdr."No.");
        VendorLedgerEntry.SetRange("Posting Date", PurchCrMemoHdr."Posting Date");
        VendorLedgerEntry.SetFilter("On Hold", '<>%1', '');
        VendorLedgerEntry.SetLoadFields("On Hold");
        if VendorLedgerEntry.FindFirst() then
            exit(VendorLedgerEntry."On Hold");
    end;

    procedure SetStatusToOpen(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
        SetStatusTo(PurchCrMemoHdr, "Purchase Document Status"::Open);
    end;

    procedure SetStatusToPendingApproval(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
        SetStatusTo(PurchCrMemoHdr, "Purchase Document Status"::"Pending Approval");
    end;

    procedure SetStatusToPendingPrepayment(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
        SetStatusTo(PurchCrMemoHdr, "Purchase Document Status"::"Pending Prepayment");
    end;

    procedure SetStatusToReleased(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
        SetStatusTo(PurchCrMemoHdr, "Purchase Document Status"::Released);
    end;

    procedure SetStatusTo(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchaseDocumentStatus: Enum "Purchase Document Status")
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WFE";
        PurchCrMemoHdrRecordRef: RecordRef;
        StatusFieldRef: FieldRef;
    begin
        TestIsApprovalAdministrator();

        if not WorkflowEditorSetup.ReadPermission() then
            exit;

        WorkflowEditorSetup.SetLoadFields("Posted Purch. Inv. Status ID");
        if not WorkflowEditorSetup.Get() then
            Clear(WorkflowEditorSetup);

        WorkflowEditorSetup.TestField("Posted Purch. Inv. Status ID");

        PurchCrMemoHdrRecordRef.GetTable(PurchCrMemoHdr);
        StatusFieldRef := PurchCrMemoHdrRecordRef.Field(WorkflowEditorSetup."Posted Purch. Inv. Status ID");

        case PurchaseDocumentStatus of
            PurchaseDocumentStatus::Open: //0
                StatusFieldRef.Value(0);
            PurchaseDocumentStatus::Released: //1
                StatusFieldRef.Value(1);
            PurchaseDocumentStatus::"Pending Approval": //2
                StatusFieldRef.Value(2);
            PurchaseDocumentStatus::"Pending Prepayment": //3
                StatusFieldRef.Value(3);
        end;

        PurchCrMemoHdrRecordRef.Modify(false);
    end;

    local procedure TestIsApprovalAdministrator()
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        UserManagement.TestIsApprovalAdministrator();
    end;

    internal procedure AllowRecordUsage(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
    begin
        TestIsApprovalAdministrator();
        RecordRestrictionMgt.AllowRecordUsage(PurchCrMemoHdr);
    end;
}