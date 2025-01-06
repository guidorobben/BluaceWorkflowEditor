codeunit 83817 "Restriction Mgt. WFE"
{
    Permissions =
        tabledata "Restricted Record" = R;

    internal procedure RecordHasUsageRestrictions(RecVar: Variant): Boolean
    var
        RestrictedRecord: Record "Restricted Record";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(RecVar);
        if RecRef.IsTemporary then
            exit;

        if RestrictedRecord.IsEmpty() then
            exit;

        SetRestrictedRecordFiltersForRecRef(RestrictedRecord, RecRef);
        exit(not RestrictedRecord.IsEmpty());
    end;

    local procedure SetRestrictedRecordFiltersForRecRef(var RestrictedRecord: Record "Restricted Record"; RecordRef: RecordRef)
    begin
        RestrictedRecord.SetRange("Record ID", RecordRef.RecordId);
    end;
}