pageextension 83800 "Approval Entries WFE" extends "Approval Entries"
{

    actions
    {
        addlast(processing)
        {
            group(WorkflowEditorWFE)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                group(DeleteEntryGroupWFE)
                {
                    Caption = 'Delete';

                    action(DeleteEntryWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Delete Current Entry';
                        Image = Delete;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWFE.DeleteEntry(Rec);
                        end;
                    }
                    // action(DeleteAllEntriesWFE)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Delete All Entries';

                    //     trigger OnAction()
                    //     begin
                    //         ApprovalEntryHelperWFE.DeleteAllentries(Rec);
                    //     end;
                    // }
                }
                group(EntryStatusWFE)
                {
                    Caption = 'Status';

                    action(EntryStatusOpenWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Open';
                        Image = Open;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWFE.SetApprovalEntryToStatusOpen(Rec);
                        end;
                    }
                    action(EntryStatusApprovedWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Approved';
                        Image = Approve;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWFE.SetApprovalEntryToStatusApproved(Rec);
                        end;
                    }
                    action(EntryStatusCanceledWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Canceled';
                        Image = Cancel;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWFE.SetApprovalEntryToStatusCanceled(Rec);
                        end;
                    }
                    action(EntryStatusCreatedWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Created';
                        Image = Create;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWFE.SetApprovalEntryToStatusCreated(Rec);
                        end;
                    }
                    action(EntryStatusRejectedWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Rejected';
                        Image = Reject;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelperWFE.SetApprovalEntryToStatusRejected(Rec);
                        end;
                    }
                }
            }
        }
    }

    var
        ApprovalEntryHelperWFE: Codeunit "Approval Entry Helper WFE";
}