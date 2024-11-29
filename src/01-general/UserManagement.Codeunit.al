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
}
