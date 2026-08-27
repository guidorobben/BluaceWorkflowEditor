codeunit 83830 "Create Workflow Tree WFE"
{
    Access = Internal;
    Permissions =
        tabledata Workflow = r,
        tabledata "Workflow Event" = r,
        tabledata "Workflow Response" = r,
        tabledata "Workflow Step" = r,
        tabledata "Workflow Step Argument" = r;

    var
        TempBufferWorkflowTree, TempWorkflowTree : Record "Workflow Tree WFE" temporary;
        // CurrentStepID, 
        EntryNo: Integer;

    procedure Initialize()
    begin
        // TempXMLBuffer[1].DeleteAll(false);
    end;

    procedure ReadWorkflow(Workflow: Record Workflow)
    begin
        ReadWorkflowHeader(Workflow);
        ReadWorkflowSteps(Workflow);
        BuildWorkflowTree();
    end;

    procedure ReadWorkflowHeader(var Workflow: Record Workflow)
    var
    // Code, Description, Category : Text;
    begin
        // TempXMLBuffer[1].Reset();
        // TempXMLBuffer[1].SetRange(Name, 'Workflow');
        // if TempXMLBuffer[1].FindSet() then begin
        //     TempXMLBuffer[2].SetRange("Parent Entry No.", TempXMLBuffer[1]."Entry No.");
        //     repeat
        //         TempXMLBuffer[1].SelectSingleNodeByNameWFE('Code', TempXMLBuffer, 2, "XML Type WFE"::Attribute, Code);
        //         TempXMLBuffer[1].SelectSingleNodeByNameWFE('Description', TempXMLBuffer, 2, "XML Type WFE"::Attribute, Description);
        //         TempXMLBuffer[1].SelectSingleNodeByNameWFE('Category', TempXMLBuffer, 2, "XML Type WFE"::Attribute, Category);

        EntryNo += 1;
        TempBufferWorkflowTree.Init();
        TempBufferWorkflowTree."Entry No." := EntryNo;
        TempBufferWorkflowTree."Step ID" := -1;
        // CurrentStepID := TempBufferWorkflowTree."Step ID";
        // TempBufferWorkflowTree."Previous Step ID" := PreviousStepID;
        // TempBufferWorkflowTree."Next Step ID" := NextStepID;
        // TempBufferWorkflowTree."Sequence No." := SequenceNo;
        // case Type of
        //     0: // Event
        //         begin
        //             TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::"Event";
        //             WorkflowEvent.SetLoadFields(Description);
        //             if WorkflowEvent.Get(FunctionName) then
        //                 TempBufferWorkflowTree.Description := WorkflowEvent.Description
        //             else
        //                 TempBufferWorkflowTree.Description := 'EVENT NOT FOUND';
        //         end;
        //     1: // Response
        //         begin
        //             TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::Response;
        //             WorkflowResponse.SetLoadFields(Description);
        //             if WorkflowResponse.Get(FunctionName) then
        //                 TempBufferWorkflowTree.Description := WorkflowResponse.Description
        //             else
        //                 TempBufferWorkflowTree.Description := 'RESPONSE NOT FOUND';
        //         end;
        //     2:
        //         TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::"Sub-Workflow";
        // end;

        TempBufferWorkflowTree."Function Name" := Workflow.Code;
        TempBufferWorkflowTree.Description := Workflow.Description;
        TempBufferWorkflowTree.Value := Workflow.Category;
        TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::Workflow;
        TempBufferWorkflowTree.Insert(false);
    end;

    procedure ReadWorkflowSteps(Workflow: Record Workflow)
    var
        WorkflowStep: Record "Workflow Step";
    begin
        WorkflowStep.SetRange("Workflow Code", Workflow.Code);
        if WorkflowStep.FindSet() then
            repeat
                ProcessWorkflowStep(WorkflowStep);
            until WorkflowStep.Next() = 0;
        // TempXMLBuffer[1].Reset();
        // TempXMLBuffer[1].SetRange(Name, 'WorkflowStep');
        // if TempXMLBuffer[1].FindSet() then
        //     repeat
        //         ProcessWorkflowStep(TempXMLBuffer);
        //     until TempXMLBuffer[1].Next() = 0;

        // BuildWorkflowTree();
    end;

    local procedure ProcessWorkflowStep(var WorkflowStep: Record "Workflow Step")
    var
        WorkflowEvent: Record "Workflow Event";
        WorkflowResponse: Record "Workflow Response";
    begin
        EntryNo += 1;
        TempBufferWorkflowTree.Init();
        TempBufferWorkflowTree."Entry No." := EntryNo;
        TempBufferWorkflowTree."Step ID" := WorkflowStep.ID;
        TempBufferWorkflowTree."Previous Step ID" := WorkflowStep."Previous Workflow Step ID";
        TempBufferWorkflowTree."Next Step ID" := WorkflowStep."Next Workflow Step ID";
        TempBufferWorkflowTree."Sequence No." := WorkflowStep."Sequence No.";
        TempBufferWorkflowTree."Function Name" := WorkflowStep."Function Name";
        TempBufferWorkflowTree.Insert(false);

        case WorkflowStep.Type of
            WorkflowStep.Type::"Event":
                begin
                    TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::"Event";
                    // TempWorkflowTree.Description := WorkflowStep.Description;
                    TempBufferWorkflowTree.Depth := 0;

                    WorkflowEvent.SetLoadFields(Description);
                    if WorkflowEvent.Get(TempBufferWorkflowTree."Function Name") then
                        TempBufferWorkflowTree.Description := WorkflowEvent.Description
                    else
                        TempBufferWorkflowTree.Description := 'EVENT NOT FOUND';
                    TempBufferWorkflowTree.Modify(false);

                    AddEventConditions(WorkflowStep, TempBufferWorkflowTree."Step ID");
                end;
            WorkflowStep.Type::Response:
                begin
                    TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::Response;
                    // TempWorkflowTree.Description := WorkflowStep.Description;
                    TempBufferWorkflowTree.Depth := 1;

                    WorkflowResponse.SetLoadFields(Description);
                    if WorkflowResponse.Get(TempBufferWorkflowTree."Function Name") then
                        TempBufferWorkflowTree.Description := WorkflowResponse.Description
                    else
                        TempBufferWorkflowTree.Description := 'RESPONSE NOT FOUND';
                    TempBufferWorkflowTree.Modify(false);

                    AddStepArguments(WorkflowStep, TempBufferWorkflowTree."Step ID");
                end;
            WorkflowStep.Type::"Sub-Workflow":
                begin
                    TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::"Sub-Workflow";
                    // TempWorkflowTree.Description := 'Sub-Workflow';
                end;
        //  WorkflowStep.Type::":
        // begin
        //     TempWorkflowTree.Type := TempWorkflowTree.Type::"Sub-Workflow";
        //     // TempWorkflowTree.Description := 'Sub-Workflow';
        // end;
        end;

        // TempWorkflowTree.Value := Format(WorkflowStep.Value);
        // TempBufferWorkflowTree.Modify(false);
    end;

    local procedure AddEventConditions(var WorkflowStep: Record "Workflow Step"; StepID: Integer)
    var
        WorkflowManagement: Codeunit "Workflow Management";
        // WorkflowStepArgument: Record "Workflow Step Argument";
        // EventOutStream: InStream;
        EventConditions: Text;
    begin
        EntryNo += 1;
        TempBufferWorkflowTree."Entry No." := EntryNo;
        TempBufferWorkflowTree.Init();
        TempBufferWorkflowTree."Function Name" := 'EventConditions';
        TempBufferWorkflowTree.Description := 'Table Filter';

        TempBufferWorkflowTree."Step ID" := StepID;
        TempBufferWorkflowTree."Previous Step ID" := StepID;
        TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::Argument;
        // TempBufferWorkflowTree."Next Step ID" := WorkflowStep."Next Workflow Step ID";
        // TempBufferWorkflowTree."Sequence No." := WorkflowStep."Sequence No.";
        TempBufferWorkflowTree.Insert(false);

        // if not WorkflowStepArgument.Get(WorkflowStep.Argument) then
        //     exit;

        // WorkflowStepArgument.CalcFields("Event Conditions");
        // WorkflowStepArgument."Event Conditions".CreateInStream(EventOutStream, TextEncoding::UTF8);
        // EventOutStream.ReadText(EventConditions);

        EventConditions := WorkflowManagement.BuildConditionDisplay(WorkflowStep);
        TempBufferWorkflowTree.Value := EventConditions;
        TempBufferWorkflowTree.Modify(false);
    end;

    local procedure AddStepArguments(var WorkflowStep: Record "Workflow Step"; StepID: Integer)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
    begin
        WorkflowStepArgument.SetLoadFields("Approver Limit Type", "Approver Type", "Approver User ID", "Due Date Formula", "Table No.");
        if not WorkflowStepArgument.Get(WorkflowStep.Argument) then
            exit;

        if WorkflowStepArgument."Table No." = 0 then
            exit;

        // WorkflowStepArgument: Record "Workflow Step Argument";
        InsertWorkflowStepArgument('ApproverType', WorkflowStepArgument.FieldCaption("Approver Type"), StepID, Format(WorkflowStepArgument."Approver Type") + ' (' + Format(WorkflowStepArgument."Approver Type".AsInteger()) + ')');
        InsertWorkflowStepArgument('ApproverLimitType', WorkflowStepArgument.FieldCaption("Approver Limit Type"), StepID, Format(WorkflowStepArgument."Approver Limit Type") + ' (' + Format(WorkflowStepArgument."Approver Limit Type".AsInteger()) + ')');
        InsertWorkflowStepArgument('DueDateFormula', WorkflowStepArgument.FieldCaption("Due Date Formula"), StepID, Format(WorkflowStepArgument."Due Date Formula"));
        InsertWorkflowStepArgument('TableNumber', WorkflowStepArgument.FieldCaption("Table No."), StepID, Format(WorkflowStepArgument."Table No."));
        InsertWorkflowStepArgument('ApproverUserID', WorkflowStepArgument.FieldCaption("Approver User ID"), StepID, WorkflowStepArgument."Approver User ID");
    end;

    local procedure InsertWorkflowStepArgument(FunctionName: Text; Description: Text; PreviousStepID: Integer; Value: Text)
    begin
        EntryNo += 1;

        TempBufferWorkflowTree.Init();
        TempBufferWorkflowTree."Entry No." := EntryNo;
        TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::Argument;
        TempBufferWorkflowTree."Function Name" := FunctionName;
        TempBufferWorkflowTree.Description := CopyStr(Description, 1, MaxStrLen(TempBufferWorkflowTree.Description));
        TempBufferWorkflowTree.Value := CopyStr(Value, 1, MaxStrLen(TempBufferWorkflowTree.Value));
        TempBufferWorkflowTree."Step ID" := PreviousStepID;
        TempBufferWorkflowTree."Previous Step ID" := PreviousStepID;
        TempBufferWorkflowTree.Insert(false);
    end;

    local procedure BuildWorkflowTree()
    begin
        EntryNo := 0;
        FindNextWorkflowSteps(0);
    end;

    local procedure FindNextWorkflowSteps(PreviousStepID: Integer)
    begin
        FindNextWorkflowStep(PreviousStepID);
    end;

    local procedure FindNextWorkflowStep(PreviousStepID: Integer)
    var
        TempSaveWorkflowTree: Record "Workflow Tree WFE" temporary;
    begin
        TempBufferWorkflowTree.Reset();
        TempBufferWorkflowTree.SetRange("Previous Step ID", PreviousStepID);
        if TempBufferWorkflowTree.FindSet() then
            repeat
                TempSaveWorkflowTree := TempBufferWorkflowTree;
                AddWorkflowTreeLine();
                if TempBufferWorkflowTree.Type <> TempBufferWorkflowTree.Type::Argument then
                    FindNextWorkflowSteps(TempBufferWorkflowTree."Step ID");

                TempBufferWorkflowTree := TempSaveWorkflowTree;
                TempBufferWorkflowTree.SetRange("Previous Step ID", PreviousStepID);
            until TempBufferWorkflowTree.Next() = 0;
    end;

    local procedure AddWorkflowTreeLine()
    begin
        EntryNo += 1;
        TempWorkflowTree.Init();
        TempWorkflowTree := TempBufferWorkflowTree;
        TempWorkflowTree."Entry No." := EntryNo;

        case TempWorkflowTree.Type of
            TempBufferWorkflowTree.Type::"Event":
                TempWorkflowTree.Depth := 0;
            TempBufferWorkflowTree.Type::Response:
                TempWorkflowTree.Depth := 1;
            TempBufferWorkflowTree.Type::Argument:
                TempWorkflowTree.Depth := 2;
        end;

        TempWorkflowTree.Insert(false);
    end;

    // procedure OpenBufferWorkflowTree()
    // begin
    //     TempBufferWorkflowTree.Reset();
    //     if TempBufferWorkflowTree.FindFirst() then; // Pointer
    //     Page.Run(Page::"Workflow Tree WFE", TempBufferWorkflowTree);
    // end;

    procedure OpenWorkflowTree()
    begin
        TempWorkflowTree.Reset();
        if TempWorkflowTree.FindFirst() then; // Pointer
        Page.Run(Page::"Workflow Tree WFE", TempWorkflowTree);
    end;
}