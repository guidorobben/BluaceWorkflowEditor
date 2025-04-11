pageextension 83811 "Approval User Setup WFE" extends "Approval User Setup"
{
    layout
    {
        addlast(factboxes)
        {
            part("Notification Setup Part WFE"; "Notification Setup Part WFE")
            {
                ApplicationArea = All;
                SubPageLink = "User ID" = field("User ID");
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action(AddUserAsApprovalAdminWFE)
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
            action(DeleteUserAsApprovalAdminWFE)
            {
                ApplicationArea = All;
                Caption = 'Delete ME';
                Image = UserSetup;

                trigger OnAction()
                var
                    UserManagement: Codeunit "User Management WFE";
                begin
                    UserManagement.DeleteCurrentUserAsApprovalAdmin();
                end;
            }
        }

        addlast(Category_Process)
        {
            group(User_Promoted)
            {
                ShowAs = SplitButton;

                actionref(AddUserAsApprovalAdminWPEWFE_Promoted; AddUserAsApprovalAdminWFE) { }
                actionref(DeleteUserAsApprovalAdminWFE_Promoted; DeleteUserAsApprovalAdminWFE) { }
            }
        }
    }
}