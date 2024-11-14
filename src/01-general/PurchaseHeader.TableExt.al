tableextension 83803 "Purchase Header WPTE" extends "Purchase Header"
{
    var
        PurchaseHeaderHelperWPTE: Codeunit "Purchase Header Helper WPTE";

    procedure ShowApprovalInfoWPTE()
    begin
        PurchaseHeaderHelperWPTE.ShowApprovalInfo(Rec);
    end;
}