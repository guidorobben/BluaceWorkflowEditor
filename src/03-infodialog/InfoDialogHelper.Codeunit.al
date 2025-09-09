codeunit 83813 "Info Dialog Helper WFE"
{
    internal procedure ActivateEventCode(InfoDialog: Record "Info Dialog WFE"; RecordInfo: Codeunit "Record Info WFE")
    begin
        OnActivateEventCode(InfoDialog, InfoDialog."Event Code", RecordInfo);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnActivateEventCode(var InfoDialog: Record "Info Dialog WFE"; EventCode: Enum "Info Dialog Event Code WFE"; RecordInfo: Codeunit "Record Info WFE")
    begin
    end;
}