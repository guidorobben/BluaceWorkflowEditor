pageextension 83807 "Purchase Order List WPTE" extends "Purchase Order List"
{
    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWPTE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                group(StatusWPTE)
                {
                    Caption = 'Status';

                    action(StatusToOpenWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Open';
                        Image = Open;

                        trigger OnAction()
                        begin
                            PurchaseHeaderHelperWPTE.SetStatusToOpen(Rec);
                        end;
                    }
                    action(StatusToReleasedWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Released';
                        Image = ReleaseDoc;

                        trigger OnAction()
                        begin
                            PurchaseHeaderHelperWPTE.SetStatusToReleased(Rec);
                        end;
                    }
                    action(StatusToPendingApprovalWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Approval';
                        Image = Status;

                        trigger OnAction()
                        begin
                            PurchaseHeaderHelperWPTE.SetStatusToPendingApproval(Rec);
                        end;
                    }
                    action(StatusToPendingPrepaymentWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Prepayment';
                        Image = Status;

                        trigger OnAction()
                        begin
                            PurchaseHeaderHelperWPTE.SetStatusToPendingPrepayment(Rec);
                        end;
                    }
                }
                action(RemoveRecordRestrictionWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Remove Record Restriction';
                    Image = Lock;

                    trigger OnAction()
                    begin
                        PurchaseHeaderHelperWPTE.AllowRecordUsage(xRec);
                    end;
                }
                action(ApprovalInfoWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Approval Info';
                    Image = Info;

                    trigger OnAction()
                    begin
                        Rec.ShowApprovalInfo();
                    end;
                }
            }
        }

        addlast(Promoted)
        {
            group(WorkflowEditorWPTE_Promoted)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                actionref(ApprovalInfoWPTE_Promoted; ApprovalInfoWPTE) { }

                group(StatusWPTE_Promoted)
                {
                    Caption = 'Status';
                    Image = Status;

                    actionref(StatusToOpenWPTE_Promoted; StatusToOpenWPTE) { }
                    actionref(StatusToReleasedWPTE_Promoted; StatusToReleasedWPTE) { }
                    actionref(StatusToPendingApprovalWPTE_Promoted; StatusToPendingApprovalWPTE) { }
                    actionref(StatusToPendingPrepaymentWPTE_Promoted; StatusToPendingPrepaymentWPTE) { }
                }

                actionref(AllowRecordUsageWPTE_Promoted; RemoveRecordRestrictionWPTE) { }
            }
        }
    }

    var
        PurchaseHeaderHelperWPTE: Codeunit "Purchase Header Helper WPTE";
}
