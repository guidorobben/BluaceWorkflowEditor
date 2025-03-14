page 83805 "Workflow Editor WFE"
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
                    Rec.ToggleEnableWorkflowWFE();
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
                    Image = Workflow;
                    RunObject = page Workflows;
                }
                action(WorkflowList)
                {
                    Caption = 'Workflow List';
                    Image = Workflow;
                    RunObject = page "Workflow List WFE";
                }
                action(WorkflowStepEditor)
                {
                    Caption = 'Workflow Step Editor';
                    Image = Edit;
                    RunObject = page "Workflow Step Editor WFE";
                    RunPageLink = "Workflow Code" = field(Code);
                }
                action(WorkflowEvents)
                {
                    Caption = 'Workflow Events';
                    Image = List;
                    RunObject = page "Workflow Events WFE";
                }
                action(WorkflowTableRelations)
                {
                    Caption = 'Workflow Table Relations';
                    Image = List;
                    RunObject = page "Workflow - Table Relations";
                }
                action(WFEventResponseCombi)
                {
                    Caption = 'Workflow Event/Response Combinations Matrix';
                    Image = List;
                    RunObject = page "WF Event/Response Combinations";
                }
                action(WFEventResponseCombiList)
                {
                    Caption = 'Workflow Event/Response Combinations List';
                    Image = List;
                    RunObject = page "WF Event/Response Combi. WFE";
                }
                action(WorkflowDefinitions)
                {
                    Caption = 'Workflow Definitions';
                    Image = List;
                    RunObject = query "Workflow Definition";
                }
                action(WorkflowStepInstances)
                {
                    Caption = 'Workflow Step Instances';
                    Image = List;
                    RunObject = page "Workflow Step Instances";
                }
                action(WorkflowWebhookEntries)
                {
                    Caption = 'Workflow Webhook Entries';
                    Image = List;
                    RunObject = page "Workflow Webhook Entries";
                }
                action(ApprovalEntries)
                {
                    Caption = 'Approval Entries';
                    Image = List;
                    RunObject = page "Approval Entries";
                }
                action(WorkflowEventLog)
                {
                    Caption = 'Workflow Event Log';
                    Image = Log;
                    RunObject = page "Workflow Event Log WFE";
                }
                action(NotificationEntries)
                {
                    Caption = 'Notification Entries';
                    Image = OverdueMail;
                    RunObject = page "Notification Entries";
                }
                action(RestrictedRecords)
                {
                    Caption = 'Restricted Records';
                    Image = Lock;
                    RunObject = page "Restricted Records";
                }
                group(Purchase)
                {
                    Caption = 'Purchase';

                    action(PostedPurchaseInvoices)
                    {
                        Caption = 'Posted Purchase Invoices';
                        Image = Invoice;
                        RunObject = page "Posted Purchase Invoices";
                    }
                    action(PurchaseOrders)
                    {
                        Caption = 'Purchase Orders';
                        Image = Order;
                        RunObject = page "Purchase Order List";
                    }
                    action(PurchaseInvoices)
                    {
                        Caption = 'Purchase Invoices';
                        Image = Invoice;
                        RunObject = page "Purchase Invoices";
                    }
                    action(PurchaseCreditMemos)
                    {
                        Caption = 'Purchase Credit Memos';
                        Image = CreditMemo;
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
                        RunObject = page "Workflow Editor Setup WFE";
                    }
                    action(ApprovalUserSetup)
                    {
                        Caption = 'Approval User Setup';
                        Image = UserSetup;
                        RunObject = page "Approval User Setup";
                    }
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
                actionref(RestrictedRecords_Promoted; RestrictedRecords) { }
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