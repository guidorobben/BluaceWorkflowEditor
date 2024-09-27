pageextension 83805 "Purchase Order WPTE" extends "Purchase Order"
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

                        trigger OnAction()
                        begin
                            PurchaseHeaderHelperWPTE.SetStatusToOpen(Rec);
                        end;
                    }
                    action(StatusToReleasedWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Released';

                        trigger OnAction()
                        begin
                            PurchaseHeaderHelperWPTE.SetStatusToReleased(Rec);
                        end;
                    }
                    action(StatusToPendingApprovalWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Approval';

                        trigger OnAction()
                        begin
                            PurchaseHeaderHelperWPTE.SetStatusToPendingApproval(Rec);
                        end;
                    }
                    action(StatusToPendingPrepaymentWPTE)
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Prepayment';

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

                    trigger OnAction()
                    begin
                        PurchaseHeaderHelperWPTE.AllowRecordUsage(xRec);
                    end;
                }
            }
        }
    }

    var
        PurchaseHeaderHelperWPTE: Codeunit "Purchase Header Helper WPTE";
}
