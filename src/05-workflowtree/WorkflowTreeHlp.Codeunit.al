codeunit 83834 "Workflow Tree Hlp WFE"
{
    Access = Internal;

    procedure FunctionNameOnDrillDown(var WorkflowTree: Record "Workflow Tree WFE")
    var
        WorkflowEvent: Record "Workflow Event";
        WorkflowResponse: Record "Workflow Response";
    // WorkflowStepArgument: Record "Workflow Step Argument";
    // PageManagement: Codeunit "Page Management";
    begin
        case WorkflowTree.Type of
            WorkflowTree.Type::"Event":
                begin
                    WorkflowEvent.SetRange("Function Name", WorkflowTree."Function Name");
                    Page.Run(Page::"Workflow Events WFE", WorkflowEvent);
                end;
            WorkflowTree.Type::Response:
                begin
                    WorkflowResponse.SetRange("Function Name", WorkflowTree."Function Name");
                    Page.Run(Page::"Workflow Response WFE", WorkflowResponse);
                end;
        // rec.type::Argument:
        //     begin
        //         // WorkflowStepArgument.SetRange("Function Name", Rec."Function Name");
        //         Page.Run(Page::"Workflow Step Arguments WFE", WorkflowStepArgument);
        //     end;
        end;
    end;


    procedure SetStyleExpression(var WorkflowTree: Record "Workflow Tree WFE") LineStyleExpr: Text
    begin
        LineStyleExpr := Format(PageStyle::Standard);
        if WorkflowTree.Type = WorkflowTree.Type::Workflow then
            LineStyleExpr := Format(PageStyle::Strong);

        if WorkflowTree.Type = WorkflowTree.Type::"Event" then
            LineStyleExpr := Format(PageStyle::Strong);

        if WorkflowTree.Type = WorkflowTree.Type::Response then
            LineStyleExpr := Format(PageStyle::StandardAccent);

        if WorkflowTree.Type = WorkflowTree.Type::Argument then
            LineStyleExpr := Format(PageStyle::Ambiguous);

        if WorkflowTree."Function Name".EndsWith('PTE') then //Custom
            LineStyleExpr := Format(PageStyle::Attention);

        if WorkflowTree."Function Name" = 'ApproverLimitType' then
            if WorkflowTree.Value in ['90000' .. '99999'] then //Custom
                LineStyleExpr := Format(PageStyle::Attention);
    end;
}