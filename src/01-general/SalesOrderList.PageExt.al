pageextension 83818 "Sales Order List WFE" extends "Sales Order List"
{
    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWFE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                group(StatusWFE)
                {
                    Caption = 'Status';

                    action(StatusToOpenWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Open';
                        Image = Open;

                        trigger OnAction()
                        begin
                            SalesHeaderHelperWFE.SetStatusToOpen(Rec);
                        end;
                    }
                    action(StatusToReleasedWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Released';
                        Image = ReleaseDoc;

                        trigger OnAction()
                        begin
                            SalesHeaderHelperWFE.SetStatusToReleased(Rec);
                        end;
                    }
                    action(StatusToPendingApprovalWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Approval';
                        Image = Status;

                        trigger OnAction()
                        begin
                            SalesHeaderHelperWFE.SetStatusToPendingApproval(Rec);
                        end;
                    }
                    action(StatusToPendingPrepaymentWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Prepayment';
                        Image = Status;

                        trigger OnAction()
                        begin
                            SalesHeaderHelperWFE.SetStatusToPendingPrepayment(Rec);
                        end;
                    }
                }
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
                        SalesHeaderHelperWFE.AllowRecordUsage(xRec);
                    end;
                }
                action(RestrictRecordUsageWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Add Record Restriction';
                    Image = Lock;

                    trigger OnAction()
                    begin
                        SalesHeaderHelperWFE.RestrictRecordUsage(Rec);
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
            group(WorkflowEditorWFE_PromotedWFE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                actionref(ApprovalInfoWFE_Promoted; ApprovalInfoWFE) { }
                actionref(ApprovalsWFE_Promoted; ApprovalsWFE) { }
                actionref(OpenActiveWorkflowWFE_Promoted; OpenActiveWorkflowWFE) { }
                actionref(AllowRecordUsageWFE_Promoted; RemoveRecordRestrictionWFE) { }
                actionref(RestrictRecordUsageWFE_Promoted; RestrictRecordUsageWFE) { }

                group(StatusWFE_PromotedWFE)
                {
                    Caption = 'Status';
                    Image = Status;

                    actionref(StatusToOpenWFE_Promoted; StatusToOpenWFE) { }
                    actionref(StatusToReleasedWFE_Promoted; StatusToReleasedWFE) { }
                    actionref(StatusToPendingApprovalWFE_Promoted; StatusToPendingApprovalWFE) { }
                    actionref(StatusToPendingPrepaymentWFE_Promoted; StatusToPendingPrepaymentWFE) { }
                }
            }
        }
    }

    var
        SalesHeaderHelperWFE: Codeunit "Sales Header Helper WFE";
}