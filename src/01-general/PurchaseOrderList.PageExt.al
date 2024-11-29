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
            }
        }

        addlast(Promoted)
        {
            group(WorkflowEditorWFE_Promoted)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                actionref(ApprovalInfoWFE_Promoted; ApprovalInfoWFE) { }

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
