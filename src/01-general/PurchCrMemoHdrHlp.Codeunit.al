codeunit 83827 "Purch. Cr. Memo Hdr. Hlp. WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Purch. Cr. Memo Hdr." = R,
        tabledata "Purch. Inv. Header" = R,
        tabledata "Restricted Record" = R,
        tabledata "Vendor Ledger Entry" = R;

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

    local procedure VendorLedgerEntryCount(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."): Integer
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetCurrentKey("Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Document No.", PurchCrMemoHdr."No.");
        VendorLedgerEntry.SetRange("Posting Date", PurchCrMemoHdr."Posting Date");
        exit(VendorLedgerEntry.Count());
    end;

    local procedure VendorLedgerEntryOnHold(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."): Code[3]
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetCurrentKey("Vendor No.", "Posting Date", "Currency Code");
        VendorLedgerEntry.SetRange("Document No.", PurchCrMemoHdr."No.");
        VendorLedgerEntry.SetRange("Posting Date", PurchCrMemoHdr."Posting Date");
        VendorLedgerEntry.SetFilter("On Hold", '<>%1', '');
        if VendorLedgerEntry.FindFirst() then
            exit(VendorLedgerEntry."On Hold");
    end;
}