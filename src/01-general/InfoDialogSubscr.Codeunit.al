codeunit 83814 "Info Dialog Subscr. WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Info Dialog WFE" = R,
        tabledata "User Setup" = R,
        tabledata Workflow = R;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Info Dialog Helper WFE", OnActivateEventCode, '', false, false)]
    local procedure OnActivateEventCode(InfoDialog: Record "Info Dialog WFE"; EventCode: Enum "Info Dialog Event Code WFE")
    begin
        case EventCode of
            EventCode::INSTANCEID:
                OpenActiveWorkflow(InfoDialog);
            EventCode::WORKFLOWCODE:
                OpenWorkFlow(InfoDialog);
            EventCode::USERSETUP:
                OpenUserSetup(InfoDialog);
        end;
    end;

    local procedure OpenActiveWorkflow(InfoDialog: Record "Info Dialog WFE")
    var
        WorkflowEditor: Codeunit "Workflow Editor WFE";
    begin
        WorkflowEditor.OpenActiveWorkflow(InfoDialog.GetValueAsGuid());
    end;

    local procedure OpenWorkFlow(InfoDialog: Record "Info Dialog WFE")
    var
        Workflow: Record Workflow;
        PageManagement: Codeunit "Page Management";
    begin
        if Workflow.Get(InfoDialog.Value) then
            PageManagement.PageRun(Workflow);
    end;

    local procedure OpenUserSetup(InfoDialog: Record "Info Dialog WFE")
    var
        UserSetup: Record "User Setup";
        PageManagement: Codeunit "Page Management";
    begin
        if UserSetup.Get(InfoDialog.Value) then
            PageManagement.PageRun(UserSetup);
    end;
}
