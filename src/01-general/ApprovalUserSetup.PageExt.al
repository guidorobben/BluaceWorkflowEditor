pageextension 83811 "Approval User Setup WFE" extends "Approval User Setup"
{
    actions
    {
        addlast(processing)
        {
            action(AddUserAsApprovalAdminWPEWFE)
            {
                ApplicationArea = All;
                Caption = 'Add ME as Approval Admin';
                Image = UserSetup;

                trigger OnAction()
                var
                    UserManagement: Codeunit "User Management WFE";
                begin
                    UserManagement.AddCurrentUserAsApprovalAdmin();
                end;
            }
        }

        addlast(Category_Process)
        {
            actionref(AddUserAsApprovalAdminWPEWFE_Promoted; AddUserAsApprovalAdminWPEWFE) { }
        }
    }
}