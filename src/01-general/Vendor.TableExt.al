tableextension 83806 "Vendor WFE" extends Vendor
{
    var
        VendorHelperWFE: Codeunit "Vendor Helper WFE";

    internal procedure ShowApprovalInfoWFE()
    begin
        VendorHelperWFE.ShowApprovalInfo(Rec);
    end;

    internal procedure OpenApprovalEntriesWFE()
    begin
        VendorHelperWFE.OpenApprovalEntries(Rec);
    end;

    internal procedure OpenRestrictedRecordWFE()
    begin
        VendorHelperWFE.OpenRestrictedRecord(Rec);
    end;
}