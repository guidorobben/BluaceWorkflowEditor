codeunit 83808 "User Management WFE"
{
    Permissions =
        tabledata "User Setup" = RIM;

    internal procedure IsApprovalAdministrator(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then
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
        InfoDialog.Add('User ID', UserId(), "Info Dialog Event Code WFE"::USERSETUP);
        InfoDialog.Add('User Setup', UserSetup.Get(UserId()));
        InfoDialog.Add('Approval Administrator', UserSetup."Approval Administrator");
        InfoDialog.Add('Approver ID', UserSetup."Approver ID");
        InfoDialog.Add('Unlimited Purchase', UserSetup."Unlimited Purchase Approval");
        InfoDialog.Add('Unlimited Sales', UserSetup."Unlimited Sales Approval");
    end;

    internal procedure AddCurrentUserAsApprovalAdmin()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then begin
            UserSetup.Init();
            UserSetup.Validate("User ID", UserId());
            UserSetup.Insert(true);
        end;

        MakeUserApprovalAdmin(UserSetup."User ID");
    end;

    internal procedure MakeUserApprovalAdmin(CurrUserID: Code[50])
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(CurrUserID) then
            exit;

        UserSetup.Validate("Unlimited Purchase Approval", true);
        UserSetup.Validate("Unlimited Sales Approval", true);
        UserSetup.Validate("Approval Administrator", true);
        UserSetup.Modify(true);
    end;
}
