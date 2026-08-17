codeunit 83831 "Open Workflow Tree WFE"
{
    Access = Internal;
    Permissions =
        tabledata "Workflow Event" = r,
        tabledata "Workflow Response" = r;

    var
        TempBufferWorkflowTree, TempWorkflowTree : Record "Workflow Tree WFE" temporary;
        TempXMLBuffer: array[5] of Record "XML Buffer" temporary;
        SelectedInstream: InStream;
        CurrentStepID, EntryNo : Integer;
        SelectedFilePath: Text;

    procedure Initialize()
    begin
        TempXMLBuffer[1].DeleteAll(false);
    end;

    procedure SelectFile(var FileInStream: InStream): Text
    var
        AppFileFilterTxt: Label 'XML Files (*.xml)|*.xml';
        FilePath: Text;
    begin
        UploadIntoStream('Select File', '', AppFileFilterTxt, FilePath, FileInStream);
        SelectedInstream := FileInStream;
        SelectedFilePath := FilePath;
        exit(FilePath);
    end;

    procedure LoadFromStream()
    begin
        LoadFromStream(SelectedInstream);
    end;

    procedure LoadFromStream(var TempCurrentXMLBuffer: Record "XML Buffer" temporary)
    begin
        TempCurrentXMLBuffer.LoadFromStream(SelectedInstream);
    end;

    procedure LoadFromStream(FileInStream: InStream)
    begin
        TempXMLBuffer[1].LoadFromStream(FileInStream);
    end;

    // procedure OpenXMLPage()
    // begin
    //     TempXMLBuffer[1].Reset();
    //     Page.Run(Page::"Open XML WFE", TempXMLBuffer[1]);
    // end;

    // procedure GetSelectedFilePath(): Text[250]
    // begin
    //     exit(SelectedFilePath);
    // end;

    // procedure GetSelectFileInStream(): InStream
    // begin
    //     exit(SelectedInstream);
    // end;

    procedure ReaddWorkflow()
    begin
        TempXMLBuffer[1].Reset();
        TempXMLBuffer[1].SetRange(Name, 'WorkflowStep');
        if TempXMLBuffer[1].FindSet() then
            repeat
                ProcessWorkflowStep(TempXMLBuffer);
            until TempXMLBuffer[1].Next() = 0;

        BuildWorkflowTree();
    end;

    local procedure ProcessWorkflowStep(var CurrTempXMLBuffer: array[5] of Record "XML Buffer" temporary)
    begin
        ProcessWorkflowStepAttributes(CurrTempXMLBuffer);
        ProcessWorkflowStepArgument(CurrTempXMLBuffer);
    end;

    local procedure ProcessWorkflowStepArgument(var CurrTempXMLBuffer: array[5] of Record "XML Buffer" temporary)
    begin
        CurrTempXMLBuffer[4].Reset();
        CurrTempXMLBuffer[4].SetRange("Parent Entry No.", CurrTempXMLBuffer[1]."Entry No.");
        CurrTempXMLBuffer[4].SetRange(Name, 'WorkflowStepArgument');
        if CurrTempXMLBuffer[4].FindSet() then begin
            CurrTempXMLBuffer[5].SetRange("Parent Entry No.", CurrTempXMLBuffer[4]."Entry No.");
            if CurrTempXMLBuffer[5].FindSet() then
                repeat
                    if CurrTempXMLBuffer[5].Name = 'ResponseFunctionName' then
                        continue;

                    InsertWorkflowStepArgument(CurrTempXMLBuffer[5], CurrentStepID);
                until CurrTempXMLBuffer[5].Next() = 0;
        end;
    end;

    local procedure InsertWorkflowStepArgument(var CurrTempXMLBuffer: Record "XML Buffer" temporary; PreviouStepID: Integer)
    var
        XmlValue: Text;
    begin
        EntryNo += 1;

        TempBufferWorkflowTree.Init();
        TempBufferWorkflowTree."Entry No." := EntryNo;
        TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::Argument;
        TempBufferWorkflowTree."Function Name" := CurrTempXMLBuffer.Name;
        XmlValue := CurrTempXMLBuffer.GetValue();
        TempBufferWorkflowTree.Value := XmlValue;
        TempBufferWorkflowTree."Step ID" := PreviouStepID;
        TempBufferWorkflowTree."Previous Step ID" := PreviouStepID;
        TempBufferWorkflowTree.Insert(false);

        UpdateWorkflowStepArgument(TempBufferWorkflowTree);
    end;

    local procedure UpdateWorkflowStepArgument(var CurrTempBufferWorkflowTree: Record "Workflow Tree WFE" temporary)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        TableCaption: Text[249];
    begin
        case CurrTempBufferWorkflowTree."Function Name" of
            'ApproverType':
                begin
                    CurrTempBufferWorkflowTree.Description := WorkflowStepArgument.FieldCaption("Approver Type");

                    case CurrTempBufferWorkflowTree.Value of
                        '0':
                            CurrTempBufferWorkflowTree.Value := CurrTempBufferWorkflowTree.Value + ' (Salesperson/Purchaser)';
                        '1':
                            CurrTempBufferWorkflowTree.Value := CurrTempBufferWorkflowTree.Value + ' (Approver)';
                        '2':
                            CurrTempBufferWorkflowTree.Value := CurrTempBufferWorkflowTree.Value + ' (Workflow User Group)';
                    end;
                end;
            'ApproverLimitType':
                begin
                    CurrTempBufferWorkflowTree.Description := WorkflowStepArgument.FieldCaption("Approver Limit Type");

                    case CurrTempBufferWorkflowTree.Value of
                        '0':
                            CurrTempBufferWorkflowTree.Value := CurrTempBufferWorkflowTree.Value + ' (Approver Chain)';
                        '1':
                            CurrTempBufferWorkflowTree.Value := CurrTempBufferWorkflowTree.Value + ' (Direct Approver)';
                        '2':
                            CurrTempBufferWorkflowTree.Value := CurrTempBufferWorkflowTree.Value + ' (First Qualified Approver)';
                        '3':
                            CurrTempBufferWorkflowTree.Value := CurrTempBufferWorkflowTree.Value + ' (Specific Approver)';
                    end;
                end;
            'DueDateFormula':
                CurrTempBufferWorkflowTree.Description := WorkflowStepArgument.FieldCaption("Due Date Formula");
            'TableNumber':
                begin
                    CurrTempBufferWorkflowTree.Description := WorkflowStepArgument.FieldCaption("Table No.");
                    TableCaption := GetTableCaption(CurrTempBufferWorkflowTree.Value);
                    CurrTempBufferWorkflowTree.Value := CurrTempBufferWorkflowTree.Value + ' (' + TableCaption + ')';
                end;
            'ApproverUserID':
                CurrTempBufferWorkflowTree.Description := WorkflowStepArgument.FieldCaption("Approver User ID");
            'EventConditions':
                CurrTempBufferWorkflowTree.Description := 'Table Filter';
            'NotificationEntryType':
                CurrTempBufferWorkflowTree.Description := WorkflowStepArgument.FieldCaption("Notification Entry Type");
            'NotifySender':
                CurrTempBufferWorkflowTree.Description := WorkflowStepArgument.FieldCaption("Notify Sender");
            'Message':
                CurrTempBufferWorkflowTree.Description := WorkflowStepArgument.FieldCaption(Message);
        end;
        CurrTempBufferWorkflowTree.Modify(false);
    end;

    local procedure GetTableCaption(TableNo: Text): Text[249]
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        AllObjWithCaption.Setrange("Object Type", AllObjWithCaption."Object Type"::Table);
        AllObjWithCaption.SetFilter("Object ID", TableNo);
        if AllObjWithCaption.FindFirst() then
            exit(AllObjWithCaption."Object Caption");
    end;

    local procedure ProcessWorkflowStepAttributes(var CurrTempXMLBuffer: array[5] of Record "XML Buffer" temporary)
    var
        WorkflowEvent: Record "Workflow Event";
        WorkflowResponse: Record "Workflow Response";
        NextStepID, PreviousStepID, SequenceNo, StepID, Type : Integer;
        FunctionName: Text;
    begin
        CurrTempXMLBuffer[2].Reset();
        CurrTempXMLBuffer[2].SetRange("Parent Entry No.", CurrTempXMLBuffer[1]."Entry No.");
        if CurrTempXMLBuffer[2].FindSet() then begin
            CurrTempXMLBuffer[3].SetRange("Parent Entry No.", CurrTempXMLBuffer[2]."Parent Entry No.");
            repeat
                CurrTempXMLBuffer[2].SelectSingleNodeByNameWFE('StepID', CurrTempXMLBuffer, 3, "XML Type WFE"::Attribute, StepID);
                CurrTempXMLBuffer[2].SelectSingleNodeByNameWFE('SequenceNo', CurrTempXMLBuffer, 3, "XML Type WFE"::Attribute, SequenceNo);
                CurrTempXMLBuffer[2].SelectSingleNodeByNameWFE('PreviousStepID', CurrTempXMLBuffer, 3, "XML Type WFE"::Attribute, PreviousStepID);
                CurrTempXMLBuffer[2].SelectSingleNodeByNameWFE('NextStepID', CurrTempXMLBuffer, 3, "XML Type WFE"::Attribute, NextStepID);
                CurrTempXMLBuffer[2].SelectSingleNodeByNameWFE('Type', CurrTempXMLBuffer, 3, "XML Type WFE"::Attribute, Type);
                CurrTempXMLBuffer[2].SelectSingleNodeByNameWFE('FunctionName', CurrTempXMLBuffer, 3, "XML Type WFE"::Attribute, FunctionName);
            until CurrTempXMLBuffer[2].Next() = 0;
        end;

        if StepID = 0 then
            exit;

        EntryNo += 1;
        TempBufferWorkflowTree.Init();
        TempBufferWorkflowTree."Entry No." := EntryNo;
        TempBufferWorkflowTree."Step ID" := StepID;
        CurrentStepID := TempBufferWorkflowTree."Step ID";
        TempBufferWorkflowTree."Previous Step ID" := PreviousStepID;
        TempBufferWorkflowTree."Next Step ID" := NextStepID;
        TempBufferWorkflowTree."Sequence No." := SequenceNo;
        case Type of
            0:
                begin
                    TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::"Event";
                    if WorkflowEvent.Get(FunctionName) then
                        TempBufferWorkflowTree.Description := WorkflowEvent.Description;
                end;
            1:
                begin
                    TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::Response;
                    if WorkflowResponse.Get(FunctionName) then
                        TempBufferWorkflowTree.Description := WorkflowResponse.Description;
                end;
            2:
                TempBufferWorkflowTree.Type := TempBufferWorkflowTree.Type::"Sub-Workflow";
        end;

        TempBufferWorkflowTree."Function Name" := FunctionName;
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

    procedure OpenBufferWorkflowTree()
    begin
        TempBufferWorkflowTree.Reset();
        if TempBufferWorkflowTree.FindFirst() then; // Pointer
        Page.Run(Page::"Workflow Tree WFE", TempBufferWorkflowTree);
    end;

    procedure OpenWorkflowTree()
    begin
        TempWorkflowTree.Reset();
        if TempWorkflowTree.FindFirst() then; // Pointer
        Page.Run(Page::"Workflow Tree WFE", TempWorkflowTree);
    end;
}