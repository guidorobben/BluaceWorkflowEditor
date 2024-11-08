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
                field(Enabled; Rec.Enabled)
                {
                    ToolTip = 'Specifies that the workflow will start when the event in the first entry-point workflow step occurs.';
                }
                field(Template; Rec.Template)
                {
                    ToolTip = 'Specifies if the workflow is a template.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ToggleEnabled)
            {
                Caption = 'Toggel Enable';
                Image = ToggleBreakpoint;

                trigger OnAction()
                begin
                    Rec.ToggleEnableWorkflow();
                end;
            }
        }
        area(Navigation)
        {
            group(WorkFlowsGroup)
            {
                Caption = 'Workflow';

                action(OpenWorkflows)
                {
                    Caption = 'Workflows';
                    RunObject = page Workflows;
                }
                action(WorkflowList)
                {
                    Caption = 'Workflow List';
                    RunObject = page "Workflow List WPTE";
                }
                action(WorkflowStepEditor)
                {
                    Caption = 'Workflow Step Editor';
                    RunObject = page "Workflow Step Editor WPTE";
                    RunPageLink = "Workflow Code" = field(Code);
                }
                action(WorkflowEvents)
                {
                    Caption = 'Workflow Events';
                    RunObject = page "Workflow Events WPTE";
                }
                action(WorkflowTableRelations)
                {
                    Caption = 'Workflow Table Relations';
                    RunObject = page "Workflow - Table Relations";
                }
                action(WFEventResponseCombi)
                {
                    Caption = 'Workflow Event/Response Combinations Matrix';
                    RunObject = page "WF Event/Response Combinations";
                }
                action(WFEventResponseCombiList)
                {
                    Caption = 'Workflow Event/Response Combinations List';
                    RunObject = page "WF Event/Response Combi. WPTE";
                }
                action(WorkflowDefinitions)
                {
                    Caption = 'Workflow Definitions';
                    RunObject = query "Workflow Definition";
                }
                action(WorkflowStepInstances)
                {
                    Caption = 'Workflow Step Instances';
                    RunObject = page "Workflow Step Instances";
                }
                action(WorkflowWebhookEntries)
                {
                    Caption = 'Workflow Webhook Entries';
                    RunObject = page "Workflow Webhook Entries";
                }
                action(ApprovalEntries)
                {
                    Caption = 'Approval Entries';
                    RunObject = page "Approval Entries";
                }
                action(WorkflowEventLog)
                {
                    Caption = 'Workflow Event Log';
                    Image = Log;
                    RunObject = page "Workflow Event Log WPTE";
                }
                action(NotificationEntries)
                {
                    Caption = 'Notification Entries';
                    Image = OverdueMail;
                    RunObject = page "Notification Entries";
                }
            }
            group(Purchase)
            {
                Caption = 'Purchase';

                action(PostedPurchaseInvoices)
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = page "Posted Purchase Invoices";
                }
                action(PurchaseOrders)
                {
                    Caption = 'Purchase Orders';
                    RunObject = page "Purchase Order List";
                }
                action(PurchaseInvoices)
                {
                    Caption = 'Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                }
                action(PurchaseCreditMemos)
                {
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                }
            }

            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;

                action("Workflow Editor Setup")
                {
                    Caption = 'Workflow Editor Setup';
                    Image = Setup;
                    RunObject = page "Workflow Editor Setup WPTE";
                }
                action(ApprovalUserSetup)
                {
                    Caption = 'Approval User Setup';
                    RunObject = page "Approval User Setup";
                }
            }
        }

        area(Promoted)
        {
            actionref(WorkflowStep_Promoted; WorkflowStepEditor) { }
            actionref(ToggleEnabled_Promoted; ToggleEnabled) { }
            actionref(WorkflowEventLog_Promoted; WorkflowEventLog) { }

            group(WorkFlowGroup_Promoted)
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
                actionref(NotificationEntries_Promoted; NotificationEntries) { }
            }

            group(PurchasePromoted)
            {
                Caption = 'Purchase';
                Image = Purchase;

                actionref(PostedPurchaseInvoicesTPTE_Promoted; PostedPurchaseInvoices) { }
                actionref(PurchaseOrders_Promoted; PurchaseOrders) { }
                actionref(PurchaseInvoicesTPTE_Promoted; PurchaseInvoices) { }
                actionref(PurchaseCreditMemosTPTE_Promoted; PurchaseCreditMemos) { }
            }

            group(SetupPromoted)
            {
                Caption = 'Setup';
                Image = Setup;

                actionref("Workflow Editor Setup_Promoted"; "Workflow Editor Setup") { }
                actionref(ApprovalUserSetup_Promoted; ApprovalUserSetup) { }
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
        view(Activated)
        {
            Caption = 'Activated';
            Filters = where(Enabled = const(true));
            SharedLayout = true;
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Template, false);
    end;
}