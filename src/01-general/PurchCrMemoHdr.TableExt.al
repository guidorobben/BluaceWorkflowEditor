tableextension 83809 "Purch. Cr. Memo Hdr. WFE" extends "Purch. Cr. Memo Hdr."
{
    var
        PurchCrMemoHdrHlpWFE: Codeunit "Purch. Cr. Memo Hdr. Hlp. WFE";

    procedure ShowApprovalInfoWFE()
    begin
        PurchCrMemoHdrHlpWFE.ShowApprovalInfo(Rec);
    end;

    procedure OpenApprovalsWFE()
    begin
        PurchCrMemoHdrHlpWFE.OpenApprovals(Rec);
    end;

    procedure OpenRestrictedRecordWFE()
    begin
        PurchCrMemoHdrHlpWFE.OpenRestrictedRecord(Rec);
    end;

    procedure RestrictRecordUsageWFE()
    begin
        PurchCrMemoHdrHlpWFE.RestrictRecordUsage(xRec, 'Manual restriction by user');
    end;
}