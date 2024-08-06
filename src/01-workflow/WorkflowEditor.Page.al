page 83805 "Workflow Editor WPTE"
{
    ApplicationArea = All;
    Caption = 'Workflow Editor';
    PageType = List;
    SourceTable = Workflow;
    UsageCategory = Administration;
    CardPageId = Workflow;

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
            group(WorkFlowsGroupWPTE)
            {
                Caption = 'Workflow';

                action(WorkflowsWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Workflows';
                    RunObject = page Workflows;
                }
                action(WorkflowListWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow List';
                    RunObject = page "Workflow List WPTE";
                }
                action(WorkflowEventsWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Events';
                    RunObject = page "Workflow Events WPTE";
                }
                action(WorkflowTableRelationsWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Table Relations';
                    RunObject = page "Workflow - Table Relations";
                }
                action(WFEventResponseCombiWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Event/Response Combinations Matrix';
                    RunObject = page "WF Event/Response Combinations";
                }
                action(WFEventResponseCombiListWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Event/Response Combinations List';
                    RunObject = page "WF Event/Response Combi. WPTE";
                }
                action(WorkflowDefinitionsWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Definitions';
                    RunObject = query "Workflow Definition";
                }
                action(WorkflowStepInstancesWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Step Instances';
                    RunObject = page "Workflow Step Instances";
                }
                action(WorkflowWebhookEntriesWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Workflow Webhook Entries';
                    RunObject = page "Workflow Webhook Entries";
                }
                action(ApprovalEntriesWPTE)
                {
                    ApplicationArea = All;
                    Caption = 'Approval Entries';
                    RunObject = page "Approval Entries";
                }
            }
        }

        area(Promoted)
        {
            group(WorkFlowGroupWPTE_Promoted)
            {
                Caption = 'Workflow';
                Image = Workflow;

                actionref(WorkflowsWPTE_Promoted; WorkflowsWPTE) { }
                actionref(WorkflowListWPTE_Promoted; WorkflowListWPTE) { }
                actionref(ApprovalEntriesWPTE_Promoted; ApprovalEntriesWPTE) { }
                actionref(WorkflowEventsWPTE_Promoted; WorkflowEventsWPTE) { }
                actionref(WorkflowTableRelationsWPTE_Promoted; WorkflowTableRelationsWPTE) { }
                actionref(WFEventResponseCombiWPTE_Promoted; WFEventResponseCombiWPTE) { }
                actionref(WFEventResponseCombiListWPTE_Promoted; WFEventResponseCombiListWPTE) { }
                actionref(WorkflowDefinitionsRefEPTE_Promted; WorkflowDefinitionsWPTE) { }
                actionref(WorkflowStepInstancesWPTE_Promoted; WorkflowStepInstancesWPTE) { }
                actionref(WorkflowWebhookEntriesTPE_Promoted; WorkflowWebhookEntriesWPTE) { }
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