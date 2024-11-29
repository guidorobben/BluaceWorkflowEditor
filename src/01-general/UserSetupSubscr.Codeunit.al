codeunit 83802 "User Setup Subscr. WFE"
{
    [EventSubscriber(ObjectType::Table, Database::"User Setup", OnBeforeValidateApprovalAdministrator, '', false, false)]
    local procedure OnBeforeValidateApprovalAdministrator(var UserSetup: Record "User Setup"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
}