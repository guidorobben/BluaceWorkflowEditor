page 83805 "Workflow Editor WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Editor';
    CardPageId = Workflow;
    PageType = List;
    SourceTable = Workflow;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the workflow.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the workflow.';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the category that the workflow belongs to.';
                }
                field(Template; Rec.Template)
                {
                    ToolTip = 'Specifies if the workflow is a template.';
                }
                field(Enabled; Rec.Enabled)
                {
                    ToolTip = 'Specifies that the workflow will start when the event in the first entry-point workflow step occurs.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(WorkFlowsGroup)
            {
                Caption = 'Workflow';

                action(OpenWorkflows)
                {
                    ApplicationArea = All;
                    Caption = 'Workflows';
                    RunObject = page Workflows;
                }
                action(WorkflowList)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow List';
                    RunObject = page "Workflow List WPTE";
                }
                action(WorkflowEvents)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Events';
                    RunObject = page "Workflow Events WPTE";
                }
                action(WorkflowTableRelations)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Table Relations';
                    RunObject = page "Workflow - Table Relations";
                }
                action(WFEventResponseCombi)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Event/Response Combinations Matrix';
                    RunObject = page "WF Event/Response Combinations";
                }
                action(WFEventResponseCombiList)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Event/Response Combinations List';
                    RunObject = page "WF Event/Response Combi. WPTE";
                }
                action(WorkflowDefinitions)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Definitions';
                    RunObject = query "Workflow Definition";
                }
                action(WorkflowStepInstances)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Step Instances';
                    RunObject = page "Workflow Step Instances";
                }
                action(WorkflowWebhookEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Webhook Entries';
                    RunObject = page "Workflow Webhook Entries";
                }
                action(ApprovalEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Approval Entries';
                    RunObject = page "Approval Entries";
                }
            }
        }

        area(Navigation)
        {
            group(Purchase)
            {
                Caption = 'Purchase';

                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = page "Posted Purchase Invoices";
                }
                action(PurchaseInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                }
                action(PurchaseCreditMemos)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                }
            }
        }

        area(Promoted)
        {
            group(WorkFlowGroupWPTE_Promoted)
            {
                Caption = 'Workflow';
                Image = Workflow;

                actionref(OpenWorkflows_Promoted; OpenWorkflows) { }
                actionref(WorkflowList_Promoted; WorkflowList) { }
                actionref(ApprovalEntries_Promoted; ApprovalEntries) { }
                actionref(WorkflowEvents_Promoted; WorkflowEvents) { }
                actionref(WorkflowTableRelations_Promoted; WorkflowTableRelations) { }
                actionref(WFEventResponseCombi_Promoted; WFEventResponseCombi) { }
                actionref(WFEventResponseCombiList_Promoted; WFEventResponseCombiList) { }
                actionref(WorkflowDefinitionsRef_Promted; WorkflowDefinitions) { }
                actionref(WorkflowStepInstances_Promoted; WorkflowStepInstances) { }
                actionref(WorkflowWebhookEntries_Promoted; WorkflowWebhookEntries) { }
            }

            group(PurchasePromoted)
            {
                Caption = 'Purchase';

                actionref(PostedPurchaseInvoicesTPTE_Promoted; PostedPurchaseInvoices) { }
                actionref(PurchaseInvoicesTPTE_Promoted; PurchaseInvoices) { }
                actionref(PurchaseCreditMemosTPTE_Promoted; PurchaseCreditMemos) { }
            }
        }
    }

    views
    {
        view(Workflows)
        {
            Caption = 'Workflows';
            Filters = where(Template = const(false));
            SharedLayout = true;
        }
        view(Templates)
        {
            Caption = 'Templates';
            Filters = where(Template = const(true));
            SharedLayout = true;
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Template, false);
    end;
}