codeunit 83805 "WF Resp. Handling Subscr. WPTE"
{

    Access = Internal;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnBeforeExecuteResponse, '', false, false)]
    local procedure OnBeforeExecuteResponse(var Variant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance"; xVariant: Variant; var IsHandled: Boolean)
    var
        WFEventLog: Record "WF Event Log WPTE";
    begin
        WFEventLog.AddResponse(variant, ResponseWorkflowStepInstance);
    end;
}