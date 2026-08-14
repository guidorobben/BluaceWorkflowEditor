page 83826 "Workflow Tree WFE"
{
    ApplicationArea = All;
    Caption = 'Workflow Tree';
    Editable = false;
    PageType = List;
    SourceTable = "Workflow Tree WFE";
    UsageCategory = Tasks;

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
                }
                field("Description"; Rec.Description)
                {
                    StyleExpr = LineStyleExpr;
                }
                field("Type"; Rec."Type")
                {
                    StyleExpr = LineStyleExpr;
                }
                field("Value"; Rec."Value")
                {
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

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(OpenWorkflow)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Refresh';
    //             Image = Refresh;

    //             // trigger OnAction()
    //             // var
    //             //     WorkflowTreeHelper: Codeunit "Workflow Tree Helper WFE";
    //             // begin
    //             //     WorkflowTreeHelper.OpenWorkflow();
    //             //     CurrPage.Update();
    //             // end;
    //         }
    //     }
    // }

    var
        LineStyleExpr: Text;

    trigger OnAfterGetRecord()
    begin
        SetStyleExpression();
    end;

    procedure SetStyleExpression()
    begin
        LineStyleExpr := Format(PageStyle::Standard);
        if Rec.Type = Rec.Type::"Event" then
            LineStyleExpr := Format(PageStyle::Strong);

        if Rec.Type = Rec.Type::Response then
            LineStyleExpr := Format(PageStyle::StandardAccent);

        if Rec.Type = Rec.Type::Argument then
            LineStyleExpr := Format(PageStyle::Ambiguous);

        if Rec."Function Name".EndsWith('PTE') then
            LineStyleExpr := Format(PageStyle::Attention);
    end;
}