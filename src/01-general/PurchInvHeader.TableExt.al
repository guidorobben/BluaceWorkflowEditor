tableextension 83805 "Purch. Inv. Header WFE" extends "Purch. Inv. Header"
{
    var
        PurchInvHeaderHelperWFE: Codeunit "Purch. Inv. Header Helper WFE";

    procedure ShowApprovalInfoWFE()
    begin
        PurchInvHeaderHelperWFE.ShowApprovalInfo(Rec);
    end;
}
