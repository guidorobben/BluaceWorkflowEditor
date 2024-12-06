codeunit 83808 "User Management WFE"
{
    Permissions = tabledata "User Setup" = R;

    internal procedure IsApprovalAdministrator(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            exit(false);

        exit(UserSetup."Approval Administrator");
    end;

    internal procedure TestIsApprovalAdministrator(): Boolean
    var
        UserManagement: Codeunit "User Management WFE";
        OnlyApproverAdminErr: Label 'Only a Approval Administrator can run this.';
    begin
        if not UserManagement.IsApprovalAdministrator() then
            Error(OnlyApproverAdminErr);
    end;

    internal procedure GetUserInfo(var InfoDialog: Codeunit "Info Dialog WFE")
    var
        UserSetup: Record "User Setup";
    begin
        InfoDialog.AddHeader('User Info');
        InfoDialog.Add('User ID', UserId, "Info Dialog Event Code WFE"::USERSETUP);
        InfoDialog.Add('User Setup', UserSetup.Get(UserId));
        InfoDialog.Add('Approval Administrator', UserSetup."Approval Administrator");
        InfoDialog.Add('Approver ID', UserSetup."Approver ID");
    end;
}
