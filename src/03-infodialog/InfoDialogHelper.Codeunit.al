codeunit 83813 "Info Dialog Helper WFE"
{
    internal procedure ActivateEventCode(InfoDialog: Record "Info Dialog WFE"; WorkflowCode: Code[20])
    begin
        OnActivateEventCode(InfoDialog, InfoDialog."Event Code", WorkflowCode);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnActivateEventCode(InfoDialog: Record "Info Dialog WFE"; EventCode: Enum "Info Dialog Event Code WFE"; WorkflowCode: Code[20])
    begin
    end;
}