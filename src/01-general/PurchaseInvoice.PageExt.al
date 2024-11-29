pageextension 83806 "Purchase Invoice WFE" extends "Purchase Invoice"
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
                action(OpenActiveWorkflowWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Open active workflow';
                    Image = Open;

                    trigger OnAction()
                    var
                        WorkflowEditor: Codeunit "Workflow Editor WFE";
                    begin
                        WorkflowEditor.OpenActiveWorkflow(Rec.RecordId);
                    end;
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
            }
        }

        addlast(Promoted)
        {
            group(WorkflowEditorWFE_Promoted)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                actionref(ApprovalInfoWFE_Promoted; ApprovalInfoWFE) { }
                actionref(OpenActiveWorkflowWFE_Promoted; OpenActiveWorkflowWFE) { }
                actionref(AllowRecordUsageWFE_Promoted; RemoveRecordRestrictionWFE) { }

                group(StatusWFE_Promoted)
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
        PurchaseHeaderHelperWFE: Codeunit "Purchase Header Helper WFE";
}