tableextension 83803 "Purchase Header WFE" extends "Purchase Header"
{
    var
        PurchaseHeaderHelperWFE: Codeunit "Purchase Header Helper WFE";

    procedure ShowApprovalInfoWFE()
    begin
        PurchaseHeaderHelperWFE.ShowApprovalInfo(Rec);
    end;
}