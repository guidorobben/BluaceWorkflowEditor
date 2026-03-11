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
                Visible = EnableWFE;

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
                Visible = EnableWFE;

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
                Visible = EnableWFE;

                actionref(JobPlanningLineInvoiceTPTE_Promoted; JobPlanningLineInvoiceWFE) { }
                actionref(PostedPurchaseInvoiceTPTE_Promoted; PostedPurchaseInvoiceWFE) { }
            }
        }
    }

    var
        JobPlanningLineHelperWFE: Codeunit "Job Planning Line Helper WFE";
        EnableWFE: Boolean;

    trigger OnOpenPage()
    begin
        EnableForApprovalAdmin();
    end;

    local procedure EnableForApprovalAdmin()
    var
        UserManagement: Codeunit "User Management WFE";
    begin
        EnableWFE := UserManagement.IsApprovalAdministrator();
    end;
}