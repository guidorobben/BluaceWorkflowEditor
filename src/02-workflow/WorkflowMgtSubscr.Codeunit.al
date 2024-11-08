// codeunit 83810 "Workflow Mgt. Subscr. WPTE"
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Management", OnBeforeHandleEventWithxRec, '', false, false)]
//     local procedure OnBeforeHandleEventWithxRec(FunctionName: Code[128]; Variant: Variant; xVariant: Variant; var IsHandled: Boolean)
//     var
//         WorkflowEventMonitor: Codeunit "Workflow Event Monitor WPTE";
//     begin
//         WorkflowEventMonitor.AddEvent(FunctionName, Variant);
//     end;
// }