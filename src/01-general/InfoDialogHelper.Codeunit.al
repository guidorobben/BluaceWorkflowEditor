codeunit 83813 "Info Dialog Helper WFE"
{
    internal procedure ActivateEventCode(InfoDialog: Record "Info Dialog WFE")
    begin
        OnActivateEventCode(InfoDialog, InfoDialog."Event Code");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnActivateEventCode(InfoDialog: Record "Info Dialog WFE"; EventCode: Enum "Info Dialog Event Code WFE")
    begin
    end;
}