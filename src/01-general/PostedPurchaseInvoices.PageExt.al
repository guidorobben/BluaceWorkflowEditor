pageextension 83810 "Posted Purchase Invoices WFE" extends "Posted Purchase Invoices"
{
    actions
    {
        addlast(navigation)
        {
            group(WorkFlowEditorWFE)
            {
                Caption = 'Workflow Editor';

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
            }
        }

        addlast(Promoted)
        {
            group(WorkFlowEditorWFE_PromotedWFE)
            {
                Caption = 'Workflow Editor';

                actionref(ApprovalInfoWFE_Promoted; ApprovalInfoWFE) { }
                actionref(OpenActiveWorkflowWFE_Promoted; OpenActiveWorkflowWFE) { }
                actionref(AllowRecordUsageWFE_Promoted; RemoveRecordRestrictionWFE) { }
            }
        }
    }
    var
        PurchInvHeaderHelperWFE: Codeunit "Purch. Inv. Header Helper WFE";
}
