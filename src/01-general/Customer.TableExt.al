tableextension 83808 "Customer WFE" extends Customer
{
    var
        CustomerHelperWFE: Codeunit "Customer Helper WFE";

    procedure ShowApprovalInfoWFE()
    begin
        CustomerHelperWFE.ShowApprovalInfo(Rec);
    end;

    procedure OpenApprovalEntriesWFE()
    begin
        CustomerHelperWFE.OpenApprovalEntries(Rec);
    end;
}