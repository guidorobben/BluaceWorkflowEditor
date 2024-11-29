codeunit 83814 "Info Dialog Subscr. WFE"
{
    Access = Internal;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Info Dialog Helper WFE", OnActivateEventCode, '', false, false)]
    local procedure OnActivateEventCode(InfoDialog: Record "Info Dialog WFE"; EventCode: Enum "Info Dialog Event Code WPE")
    begin
        case EventCode of
            EventCode::INSTANCEID:
                OpenActiveWorkflow(InfoDialog);
            EventCode::WORKFLOWCODE:
                ;
        end;
    end;

    local procedure OpenActiveWorkflow(InfoDialog: Record "Info Dialog WFE")
    var
        WorkflowEditor: Codeunit "Workflow Editor WFE";
    begin
        WorkflowEditor.OpenActiveWorkflow(InfoDialog.GetValueAsGuid());
    end;
}
