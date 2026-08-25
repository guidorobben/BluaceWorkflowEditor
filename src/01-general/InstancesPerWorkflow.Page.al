page 83828 "Instances Per Workflow WFE"
{
    ApplicationArea = All;
    Caption = 'Instances Per Workflow';
    Editable = false;
    PageType = List;
    Permissions =
        tabledata "Instances Per Workflow WFE" = ri,
        tabledata "Workflow Step Instance" = r;
    SourceTable = "Instances Per Workflow WFE";
    UsageCategory = Lists;

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
                field("Workflow Code"; Rec."Workflow Code")
                {
                    trigger OnDrillDown()
                    begin
                        Rec.WorkflowCodeOnDrillDown();
                    end;
                }
                field(Description; Rec.Description) { }
                field(ID; Rec."Instance ID") { }
                field("Record ID"; Format(Rec."Record ID"))
                {
                    Caption = 'Record-ID';

                    trigger OnDrillDown()
                    begin
                        Rec.OpenDocument();
                    end;
                }
                field("Document Status"; Rec."Document Status") { }
                field("Created By User ID"; Rec."Created By User ID") { }
                field("Created Date-Time"; Rec."Created Date-Time") { }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(OpenDocument)
            {
                ApplicationArea = All;
                Caption = 'Open Document';
                Image = Open;

                trigger OnAction()
                begin
                    Rec.OpenDocument();
                end;
            }
            action(WorkflowStepInstances)
            {
                ApplicationArea = All;
                Caption = 'Workflow Step Instances';
                Image = List;

                trigger OnAction()
                var
                    WorkflowStepInstance: Record "Workflow Step Instance";
                begin
                    WorkflowStepInstance.SetRange(ID, Rec."Instance ID");
                    Page.Run(Page::"Workflow Step Instance WFE", WorkflowStepInstance);
                end;
            }
        }
    }

    var
        InstancesPerWorkflowHlp: Codeunit "Instances Per Workflow Hlp WFE";

    trigger OnOpenPage()
    begin
        BuildBuffer();
    end;

    local procedure BuildBuffer()
    // var
    //     WorkflowStepInstance: Record "Workflow Step Instance";
    //     EntryNo: Integer;
    begin
        InstancesPerWorkflowHlp.BuildBuffer(Rec);

        // WorkflowStepInstance.SetRange("Entry Point", true);
        // if WorkflowStepInstance.FindSet() then
        //     repeat
        //         EntryNo += 1;

        //         Rec.Init();
        //         Rec."Entry No." := EntryNo;
        //         Rec.ID := WorkflowStepInstance.ID;
        //         Rec."Workflow Code" := WorkflowStepInstance."Workflow Code";
        //         Rec."Record ID" := WorkflowStepInstance."Record ID";
        //         Rec."Document Status" := InstancesPerWorkflowHlp.GetDocumentStatus(WorkflowStepInstance."Record ID");
        //         Rec."Created By User ID" := WorkflowStepInstance."Created By User ID";
        //         Rec."Created Date-Time" := WorkflowStepInstance."Created Date-Time";
        //         Rec.Insert(false);
        //     until WorkflowStepInstance.Next() = 0;

        // if Rec.FindFirst() then; // Pointer
    end;
}