tableextension 83807 "Sales Header WFE" extends "Sales Header"
{
    var
        SalesHeaderHelperWFE: Codeunit "Sales Header Helper WFE";

    procedure ShowApprovalInfoWFE()
    begin
        SalesHeaderHelperWFE.ShowApprovalInfo(Rec);
    end;

    procedure OpenRestrictedRecord()
    begin
        SalesHeaderHelperWFE.OpenRestrictedRecord(Rec);
    end;
}