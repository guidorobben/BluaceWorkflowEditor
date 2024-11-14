pageextension 83810 "Posted Purchase Invoices WPTE" extends "Posted Purchase Invoices"
{
    actions
    {
        addlast(navigation)
        {
            group(WorkFlowEditorWPTE)
            {
                Caption = 'Workflow Editor';

                action(OpenActiveWorkflowWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Open active workflow';
                    Image = Open;

                    trigger OnAction()
                    var
                        WorkflowEditor: Codeunit "Workflow Editor WPTE";
                    begin
                        WorkflowEditor.OpenActiveWorkflow(Rec.RecordId);
                    end;
                }
                action(RemoveRecordRestrictionWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Remove Record Restriction';
                    Image = Lock;

                    trigger OnAction()
                    begin
                        PurchInvHeaderHelperWPTE.AllowRecordUsage(xRec);
                    end;
                }
                action(ApprovalInfoWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Approval Info';
                    Image = Info;

                    trigger OnAction()
                    begin
                        Rec.ShowApprovalInfoWPTE();
                    end;
                }
            }
        }

        addlast(Promoted)
        {
            group(WorkFlowEditorWPTE_PromotedWPTE)
            {
                Caption = 'Workflow Editor';

                actionref(ApprovalInfoWPTE_Promoted; ApprovalInfoWPTE) { }
                actionref(OpenActiveWorkflowWPTE_Promoted; OpenActiveWorkflowWPTE) { }
                actionref(AllowRecordUsageWPTE_Promoted; RemoveRecordRestrictionWPTE) { }
            }
        }
    }
    var
        PurchInvHeaderHelperWPTE: Codeunit "Purch. Inv. Header Helper WPTE";
}
