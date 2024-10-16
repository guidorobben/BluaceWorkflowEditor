tableextension 83803 "Purchase Header WPTE" extends "Purchase Header"
{
    var
        PurchaseHeaderHelper: Codeunit "Purchase Header Helper WPTE";

    procedure ShowApprovalInfo()
    begin
        PurchaseHeaderHelper.ShowApprovalInfo(Rec);
    end;
}