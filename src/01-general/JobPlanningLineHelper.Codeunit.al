codeunit 83818 "Job Planning Line Helper WFE"
{
    Permissions =
        tabledata "Job Planning Line" = R,
        tabledata "Purch. Inv. Header" = R;

    internal procedure OpenPostedPurchaseInvoice(var JobPlanningLine: Record "Job Planning Line")
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PageManagement: Codeunit "Page Management";
    begin
        PurchInvHeader.SetRange("No.", JobPlanningLine."Document No.");
        if PurchInvHeader.FindFirst() then
            PageManagement.PageRun(PurchInvHeader);
    end;

    internal procedure OpenJobPlanningLineInvoice(var JobPlanningLine: Record "Job Planning Line")
    var
        CurrentJobPlanningLine: Record "Job Planning Line";
        JobPlanningLineInvoice: Record "Job Planning Line Invoice";
    begin
        CurrentJobPlanningLine := JobPlanningLine;
        if CurrentJobPlanningLine."Line No." = 0 then
            exit;

        CurrentJobPlanningLine.TestField("Job No.");
        CurrentJobPlanningLine.TestField("Job Task No.");

        JobPlanningLineInvoice.SetRange("Job No.", CurrentJobPlanningLine."Job No.");
        JobPlanningLineInvoice.SetRange("Job Task No.", CurrentJobPlanningLine."Job Task No.");
        JobPlanningLineInvoice.SetRange("Job Planning Line No.", CurrentJobPlanningLine."Line No.");
        Page.Run(Page::"Job Planning Line Invoice WFE", JobPlanningLineInvoice);
    end;
}