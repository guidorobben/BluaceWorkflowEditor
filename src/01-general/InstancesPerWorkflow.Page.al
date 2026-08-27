page 83828 "Instances Per Workflow WFE"
{
    ApplicationArea = All;
    Caption = 'Instances per Workflow';
    Editable = false;
    PageType = List;
    Permissions =
        tabledata "Instances Per Workflow WFE" = ri,
        tabledata "Workflow Step Instance" = r;
    SourceTable = "Instances Per Workflow WFE";
    SourceTableView = sorting(Category);
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
                field(Category; Rec.Category) { }
                field("Workflow Enabled"; Rec."Workflow Enabled") { }
                field("Instance ID"; Rec."Instance ID")
                {
                    trigger OnDrillDown()
                    begin
                        Rec.OpenWorkflowStepInstances();
                    end;
                }
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

        area(Promoted)
        {
            actionref(OpenDocument_Promoted; OpenDocument) { }
            actionref(WorkflowStepInstances_Promoted; WorkflowStepInstances) { }
        }
    }

    var
        InstancesPerWorkflowHlp: Codeunit "Instances Per Workflow Hlp WFE";

    trigger OnOpenPage()
    begin
        BuildBuffer();
    end;

    local procedure BuildBuffer()
    begin
        InstancesPerWorkflowHlp.BuildBuffer(Rec);
    end;


}