pageextension 83814 "Job Planning Lines WFE" extends "Job Planning Lines"
{
    actions
    {

        addlast(navigation)
        {
            action(JobPlanningLineInvoiceWFE)
            {
                ApplicationArea = All;
                Caption = 'Job PlanningLine Invoice';
                Image = AllLines;

                trigger OnAction()
                begin
                    JobPlanningLineHelperWFE.OpenJobPlanningLineInvoice(Rec);
                end;
            }
            action(PostedPurchaseInvoiceWFE)
            {
                ApplicationArea = All;
                Caption = 'Posted Purchase Invoice';
                Image = Document;

                trigger OnAction()
                begin
                    JobPlanningLineHelperWFE.OpenPostedPurchaseInvoice(Rec);
                end;
            }
        }

        addlast(Promoted)
        {
            group(WorkFlowEditorWFE_Promoted)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                actionref(JobPlanningLineInvoiceTPTE_Promoted; JobPlanningLineInvoiceWFE) { }
                actionref(PostedPurchaseInvoiceTPTE_Promoted; PostedPurchaseInvoiceWFE) { }
            }
        }
    }

    var
        JobPlanningLineHelperWFE: Codeunit "Job Planning Line Helper WFE";
}