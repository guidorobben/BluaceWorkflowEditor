// codeunit 83810 "Workflow Mgt. Subscr. WFE"
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Management", OnBeforeHandleEventWithxRec, '', false, false)]
//     local procedure OnBeforeHandleEventWithxRec(FunctionName: Code[128]; Variant: Variant; xVariant: Variant; var IsHandled: Boolean)
//     var
//         WorkflowEventMonitor: Codeunit "Workflow Event Monitor WFE";
//     begin
//         WorkflowEventMonitor.AddEvent(FunctionName, Variant);
//     end;
// }