codeunit 83805 "WF Resp. Handling Subscr. WFE"
{
    Access = Internal;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnBeforeExecuteResponse, '', false, false)]
    local procedure OnBeforeExecuteResponse(var Variant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance"; xVariant: Variant; var IsHandled: Boolean)
    var
        WorkflowEventLog: Codeunit "Workflow Event Log WFE";
    begin
        WorkflowEventLog.AddEvent(Variant, ResponseWorkflowStepInstance);
    end;
}