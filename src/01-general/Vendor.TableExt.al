tableextension 83806 "Vendor WFE" extends Vendor
{
    var
        VendorHelperWFE: Codeunit "Vendor Helper WFE";

    procedure ShowApprovalInfoWFE()
    begin
        VendorHelperWFE.ShowApprovalInfo(Rec);
    end;

    procedure OpenApprovalEntriesWFE()
    begin
        VendorHelperWFE.OpenApprovalEntries(Rec);
    end;
}