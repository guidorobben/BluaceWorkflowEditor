page 83826 "Workflow Tree WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow Tree';
    Editable = false;
    PageType = List;
    SourceTable = "Workflow Tree WFE";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                IndentationColumn = Rec.Depth;
                IndentationControls = "Function Name";

                field("Entry No."; Rec."Entry No.")
                {
                    StyleExpr = LineStyleExpr;
                    Visible = false;
                }
                field("Function Name"; Rec."Function Name")
                {
                    StyleExpr = LineStyleExpr;

                    trigger OnDrillDown()
                    begin
                        FunctionNameOnDrillDown();
                    end;
                }
                field(Description; Rec.Description)
                {
                    StyleExpr = LineStyleExpr;
                }
                field("Type"; Rec."Type")
                {
                    StyleExpr = LineStyleExpr;
                }
                field("Value"; Rec."Value")
                {
                    StyleExpr = LineStyleExpr;

                    trigger OnDrillDown()
                    begin
                        Message(Rec.Value);
                    end;
                }
                field("Step ID"; Rec."Step ID")
                {
                    StyleExpr = LineStyleExpr;
                }
                field("Previous Step ID"; Rec."Previous Step ID")
                {
                    StyleExpr = LineStyleExpr;
                }
                field("Next Step ID"; Rec."Next Step ID")
                {
                    StyleExpr = LineStyleExpr;
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    StyleExpr = LineStyleExpr;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GotoNextStepID)
            {
                ApplicationArea = All;
                Caption = 'Goto Next Step ID';
                Enabled = Rec."Next Step ID" <> 0;
                Image = Refresh;

                trigger OnAction()
                begin
                    Rec.GotoNextStepID();
                end;
            }
        }

        area(Promoted)
        {
            actionref(GotoNextStepID_Promoted; GotoNextStepID) { }
        }
    }

    var
        WorkflowTreeHlp: Codeunit "Workflow Tree Hlp WFE";
        LineStyleExpr: Text;

    trigger OnAfterGetRecord()
    begin
        SetStyleExpression();
    end;

    local procedure SetStyleExpression()
    begin
        LineStyleExpr := WorkflowTreeHlp.SetStyleExpression(Rec);

        // LineStyleExpr := Format(PageStyle::Standard);
        // if Rec.Type = Rec.Type::Workflow then
        //     LineStyleExpr := Format(PageStyle::Strong);

        // if Rec.Type = Rec.Type::"Event" then
        //     LineStyleExpr := Format(PageStyle::Strong);

        // if Rec.Type = Rec.Type::Response then
        //     LineStyleExpr := Format(PageStyle::StandardAccent);

        // if Rec.Type = Rec.Type::Argument then
        //     LineStyleExpr := Format(PageStyle::Ambiguous);

        // if Rec."Function Name".EndsWith('PTE') then //Custom
        //     LineStyleExpr := Format(PageStyle::Attention);

        // if Rec."Function Name" = 'ApproverLimitType' then
        //     if Rec.Value in ['90000' .. '99999'] then //Custom
        //         LineStyleExpr := Format(PageStyle::Attention);
    end;

    local procedure FunctionNameOnDrillDown()
    // var
    //     WorkflowEvent: Record "Workflow Event";
    //     WorkflowResponse: Record "Workflow Response";
    // WorkflowStepArgument: Record "Workflow Step Argument";
    // PageManagement: Codeunit "Page Management";
    begin
        WorkflowTreeHlp.FunctionNameOnDrillDown(Rec);
        // case Rec.Type of
        //     Rec.Type::"Event":
        //         begin
        //             WorkflowEvent.SetRange("Function Name", Rec."Function Name");
        //             Page.Run(Page::"Workflow Events WFE", WorkflowEvent);
        //         end;
        //     Rec.Type::Response:
        //         begin
        //             WorkflowResponse.SetRange("Function Name", Rec."Function Name");
        //             Page.Run(Page::"Workflow Response WFE", WorkflowResponse);
        //         end;
        // // rec.type::Argument:
        // //     begin
        // //         // WorkflowStepArgument.SetRange("Function Name", Rec."Function Name");
        // //         Page.Run(Page::"Workflow Step Arguments WFE", WorkflowStepArgument);
        // //     end;
        // end;
    end;
}
