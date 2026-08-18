report 83801 "Open Workflow WFE"
{
    ApplicationArea = All;
    Caption = 'Open Workflow File';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(FileNameControl; FileName)
                    {
                        ApplicationArea = All;
                        Caption = 'Filename';
                        Editable = false;
                        ToolTip = 'Specifies the filepath to the xml file.';

                        trigger OnAssistEdit()
                        var
                            SelectedFileName: Text;
                        begin
                            SelectedFileName := SelectFile();
                            if SelectedFileName <> '' then
                                FileName := SelectedFileName;
                        end;
                    }
                }
            }
        }
    }

    var
        CreateWorkflowFileTree: Codeunit "Create Workflow File Tree WFE";
        FileInStream: InStream;
        EnterFileNameErr: Label 'Please enter a filename.';
        FileName: Text;

    trigger OnPreReport()
    begin
        if FileName = '' then
            Error(EnterFileNameErr);
    end;

    trigger OnPostReport()
    begin
        LoadWorkflowFile();
    end;

    local procedure SelectFile(): Text
    begin
        exit(CreateWorkflowFileTree.SelectFile(FileInStream));
    end;

    local procedure LoadWorkflowFile()
    begin
        CreateWorkflowFileTree.Initialize();
        CreateWorkflowFileTree.LoadFromStream();
        CreateWorkflowFileTree.ReadWorkflow();
        CreateWorkflowFileTree.OpenWorkflowTree();
    end;
}
