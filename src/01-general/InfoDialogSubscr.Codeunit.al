codeunit 83814 "Info Dialog Subscr. WPTE"
{
    Access = Internal;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Info Dialog Helper WPTE", OnActivateEventCode, '', false, false)]
    local procedure OnActivateEventCode(InfoDialog: Record "Info Dialog WPTE"; EventCode: Code[128])
    begin
        Message(EventCode);
    end;
}
