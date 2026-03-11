pageextension 83822 "Customer Card WFE" extends "Customer Card"
{
    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWFE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;
                Visible = EnableWFE;

                action(RemoveRecordRestrictionWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Remove Record Restriction';
                    Image = Lock;

                    trigger OnAction()
                    begin
                        CustomerHelperWFE.AllowRecordUsage(xRec);
                    end;
                }
                action(ApprovalInfoWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Approval Info';
                    Image = Info;

                    trigger OnAction()
                    begin
                        Rec.ShowApprovalInfoWFE();
                    end;
                }
                action(ApprovalsWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    begin
                        Rec.OpenApprovalEntriesWFE();
                    end;
                }
            }
        }

        addlast(Promoted)
        {
            group(WorkflowEditorWFE_PromotedWFE)
            {
                Caption = 'Workflow Editor';
                Visible = EnableWFE;
                Image = Workflow;

                actionref(ApprovalInfoWFE_Promoted; ApprovalInfoWFE) { }
                actionref(AllowRecordUsageWFE_Promoted; RemoveRecordRestrictionWFE) { }
                actionref(ApprovalsWFE_Promoted; ApprovalsWFE) { }
            }
        }
    }

    var
        CustomerHelperWFE: Codeunit "Customer Helper WFE";
        EnableWFE: Boolean;

    trigger OnOpenPage()
    begin
        EnableForApprovalAdmin();
    end;

    local procedure EnableForApprovalAdmin()
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        EnableWFE := UserManagement.IsApprovalAdministrator();
    end;
}