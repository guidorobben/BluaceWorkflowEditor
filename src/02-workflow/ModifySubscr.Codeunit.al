codeunit 83825 "Modify Subscr. WFE"
{
    Access = Internal;
    Permissions = tabledata "Workflow Editor Setup WFE" = R;

    var
        UserManagement: Codeunit "User Management WFE";
        CallStackMsg: Label '%1:\\%2', Locked = true;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeModifyEvent, '', true, true)]
    local procedure OnBeforeModifyPurchaseHeader(var Rec: Record "Purchase Header")
    begin
        if not UserManagement.IsApprovalAdministrator() then
            exit;

        if not DebugModifyPurchaseHeader() then
            exit;

        Message(StrSubstNo(CallStackMsg, Format(Rec.RecordId()), SessionInformation.Callstack()));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Inv. Header", OnBeforeModifyEvent, '', true, true)]
    local procedure OnBeforeModifyPurchInvHeader(var Rec: Record "Purch. Inv. Header")
    begin
        if not UserManagement.IsApprovalAdministrator() then
            exit;

        if not DebugModifyPurchInvHeader() then
            exit;

        Message(StrSubstNo(CallStackMsg, Format(Rec.RecordId()), SessionInformation.Callstack()));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeModifyEvent, '', true, true)]
    local procedure OnBeforeModifySalesHeader(var Rec: Record "Sales Header")
    begin
        if not UserManagement.IsApprovalAdministrator() then
            exit;

        if not DebugModifySalesHeader() then
            exit;

        Message(StrSubstNo(CallStackMsg, Format(Rec.RecordId()), SessionInformation.Callstack()));
    end;

    local procedure DebugModifyPurchaseHeader(): Boolean
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WFE";
    begin
        if not GetWorkflowEditorSetup(WorkflowEditorSetup) then
            exit;

        exit(WorkflowEditorSetup."Debug Modify Purchase Header");
    end;

    local procedure DebugModifyPurchInvHeader(): Boolean
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WFE";
    begin
        if not GetWorkflowEditorSetup(WorkflowEditorSetup) then
            exit;

        exit(WorkflowEditorSetup."Debug Modify Purch. Inv Header");
    end;

    local procedure DebugModifySalesHeader(): Boolean
    var
        WorkflowEditorSetup: Record "Workflow Editor Setup WFE";
    begin
        if not GetWorkflowEditorSetup(WorkflowEditorSetup) then
            exit;

        exit(WorkflowEditorSetup."Debug Modify Sales Header");
    end;

    local procedure GetWorkflowEditorSetup(var WorkflowEditorSetup: Record "Workflow Editor Setup WFE"): Boolean
    begin
        if not WorkflowEditorSetup.ReadPermission() then
            exit;

        if not WorkflowEditorSetup.Get() then
            exit;

        exit(true);
    end;
}