codeunit 83804 "Purch. Inv. Header Subscr WFE"
{
    [EventSubscriber(ObjectType::Table, Database::"Purch. Inv. Header", OnBeforeModifyEvent, '', false, false)]
    local procedure OnBeforeModifyEvent(var xRec: Record "Purch. Inv. Header"; var Rec: Record "Purch. Inv. Header"; RunTrigger: Boolean)
    begin

    end;
}