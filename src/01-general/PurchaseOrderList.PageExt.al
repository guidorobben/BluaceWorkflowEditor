pageextension 83807 "Purchase Order List WFE" extends "Purchase Order List"
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
                            PurchaseHeaderHelperWFE.SetStatusToOpen(Rec);
                        end;
                    }
                    action(StatusToReleasedWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Released';
                        Image = ReleaseDoc;

                        trigger OnAction()
                        begin
                            PurchaseHeaderHelperWFE.SetStatusToReleased(Rec);
                        end;
                    }
                    action(StatusToPendingApprovalWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Approval';
                        Image = Status;

                        trigger OnAction()
                        begin
                            PurchaseHeaderHelperWFE.SetStatusToPendingApproval(Rec);
                        end;
                    }
                    action(StatusToPendingPrepaymentWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Prepayment';
                        Image = Status;

                        trigger OnAction()
                        begin
                            PurchaseHeaderHelperWFE.SetStatusToPendingPrepayment(Rec);
                        end;
                    }
                }
                action(RemoveRecordRestrictionWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Remove Record Restriction';
                    Image = Lock;

                    trigger OnAction()
                    begin
                        PurchaseHeaderHelperWFE.AllowRecordUsage(xRec);
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
            group(WorkflowEditorWFE_Promoted)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                actionref(ApprovalInfoWFE_Promoted; ApprovalInfoWFE) { }
                actionref(ApprovalsWFE_Promoted; ApprovalsWFE) { }

                group(StatusWFE_Promoted)
                {
                    Caption = 'Status';
                    Image = Status;

                    actionref(StatusToOpenWFE_Promoted; StatusToOpenWFE) { }
                    actionref(StatusToReleasedWFE_Promoted; StatusToReleasedWFE) { }
                    actionref(StatusToPendingApprovalWFE_Promoted; StatusToPendingApprovalWFE) { }
                    actionref(StatusToPendingPrepaymentWFE_Promoted; StatusToPendingPrepaymentWFE) { }
                }

                actionref(AllowRecordUsageWFE_Promoted; RemoveRecordRestrictionWFE) { }
            }
        }
    }

    var
        PurchaseHeaderHelperWFE: Codeunit "Purchase Header Helper WFE";
}
