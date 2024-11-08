codeunit 83813 "Info Dialog Helper WPTE"
{
    internal procedure ActivateEventCode(InfoDialog: Record "Info Dialog WPTE")
    begin
        OnActivateEventCode(InfoDialog, InfoDialog."Event Code");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnActivateEventCode(InfoDialog: Record "Info Dialog WPTE"; EventCode: Code[128])
    begin
    end;
}