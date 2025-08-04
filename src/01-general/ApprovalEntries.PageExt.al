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

                action(MeAsApproverWFE)
                {
                    ApplicationArea = All;
                    Caption = 'Set Me as Approver';
                    Image = User;

                    trigger OnAction()
                    begin
                        ApprovalEntryHelperWFE.SetMeAsApprover(Rec);
                    end;
                }
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
                    Image = Status;

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
                        Image = New;

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

        addlast(Promoted)
        {
            group(WorkflowEditorWFE_Promoted)
            {
                Caption = 'Workflow Editor';
                Image = Workflow;

                actionref(MeAsApproverWFE_Promoted; MeAsApproverWFE) { }
                actionref(DeleteEntryWFE_Promoted; DeleteEntryWFE) { }

                group(EntryStatus_Promoted)
                {
                    Caption = 'Status';
                    Image = Status;

                    actionref(EntryStatusOpenWFE_Promoted; EntryStatusOpenWFE) { }
                    actionref(EntryStatusApprovedWFE_Promoted; EntryStatusApprovedWFE) { }
                    actionref(EntryStatusCanceledWFE_Promoted; EntryStatusCanceledWFE) { }
                    actionref(EntryStatusCreatedWFE_Promoted; EntryStatusCreatedWFE) { }
                    actionref(EntryStatusRejectedWFE_Promoted; EntryStatusRejectedWFE) { }
                }
            }
        }
    }

    var
        ApprovalEntryHelperWFE: Codeunit "Approval Entry Helper WFE";
}