pageextension 83801 "Posted Purchase Invoice WFE" extends "Posted Purchase Invoice"
{
    actions
    {
        addlast(navigation)
        {
            group(WorkFlowEditorWFE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                action(OpenActiveWorkflowWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Open active workflow';
                    Image = Open;

                    trigger OnAction()
                    var
                        WorkflowEditor: Codeunit "Workflow Editor WFE";
                    begin
                        WorkflowEditor.OpenActiveWorkflow(Rec.RecordId());
                    end;
                }
                action(RemoveRecordRestrictionWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Remove Record Restriction';
                    Image = Lock;

                    trigger OnAction()
                    begin
                        PurchInvHeaderHelperWFE.AllowRecordUsage(xRec);
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
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId());
                    end;
                }
            }
        }

        addlast(Promoted)
        {
            group(WorkFlowEditorWFE_Promoted)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                actionref(ApprovalInfoWFE_Promoted; ApprovalInfoWFE) { }
                actionref(OpenActiveWorkflowWFE_Promoted; OpenActiveWorkflowWFE) { }
                actionref(AllowRecordUsageWFE_Promoted; RemoveRecordRestrictionWFE) { }
                actionref(ApprovalsWFE_Promoted; ApprovalsWFE) { }
            }
        }
    }
    var
        PurchInvHeaderHelperWFE: Codeunit "Purch. Inv. Header Helper WFE";
}
