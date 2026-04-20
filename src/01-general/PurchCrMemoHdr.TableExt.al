tableextension 83809 "Purch. Cr. Memo Hdr. WFE" extends "Purch. Cr. Memo Hdr."
{
    var
        PurchCrMemoHdrHlp: Codeunit "Purch. Cr. Memo Hdr. Hlp. WFE";

    procedure ShowApprovalInfoWFE()
    begin
        PurchCrMemoHdrHlp.ShowApprovalInfo(Rec);
    end;

    procedure OpenApprovalsWFE()
    begin
        PurchCrMemoHdrHlp.OpenApprovals(Rec);
    end;

    procedure OpenRestrictedRecordWFE()
    begin
        PurchCrMemoHdrHlp.OpenRestrictedRecord(Rec);
    end;
}