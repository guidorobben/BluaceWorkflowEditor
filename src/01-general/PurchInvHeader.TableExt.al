tableextension 83805 "Purch. Inv. Header WPTE" extends "Purch. Inv. Header"
{
    var
        PurchInvHeaderHelperWPTE: Codeunit "Purch. Inv. Header Helper WPTE";

    procedure ShowApprovalInfoWPTE()
    begin
        PurchInvHeaderHelperWPTE.ShowApprovalInfo(Rec);
    end;
}
