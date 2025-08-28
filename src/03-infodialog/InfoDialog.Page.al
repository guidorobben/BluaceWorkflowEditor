page 83812 "Info Dialog WFE"
{
    AnalysisModeEnabled = false;
    ApplicationArea = All;
    Caption = 'Info';
    Editable = false;
    PageType = List;
    SourceTable = "Info Dialog WFE";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    Style = Strong;
                    StyleExpr = Rec.Header;
                }
                field(Value; Rec."Value")
                {
                    trigger OnAssistEdit()
                    begin
                        Rec.ActivateEventCode();
                    end;
                }
                field("Event Code"; Rec."Event Code")
                {
                    trigger OnDrillDown()
                    begin
                        Rec.ActivateEventCode();
                    end;
                }
                field(Header; Rec.Header)
                {
                    Visible = false;
                }
            }
        }
    }

    var
        CurrentWorkFlowCode: Code[20];

    procedure TransferInfoDialog(var InfoDialog: Record "Info Dialog WFE")
    begin
        if InfoDialog.FindSet() then
            repeat
                Rec.Init();
                Rec := InfoDialog;
                Rec.Insert(false);
            until InfoDialog.Next() = 0;

        if Rec.FindFirst() then; //Set pointer to first
    end;

    procedure SetCurrentWorkFlowCode(WorkflowCode: Code[20])
    begin
        CurrentWorkFlowCode := WorkflowCode;
        Rec.SetWorkFlowCode(CurrentWorkFlowCode);
    end;
}
