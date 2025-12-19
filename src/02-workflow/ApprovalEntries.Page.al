page 83822 "Approval Entries WFE"
{
    ApplicationArea = All;
    Caption = 'Approval Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Approval Entry";
    SourceTableView = sorting("Table ID", "Document Type", "Document No.", "Date-Time Sent for Approval") order(ascending);
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Overdue; Overdue)
                {
                    Caption = 'Overdue';
                    Editable = false;
                    ToolTip = 'Specifies that the approval is overdue.';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the ID of the table where the record that is subject to approval is stored.';
                    Visible = false;
                }
                field("Limit Type"; Rec."Limit Type")
                {
                    ToolTip = 'Specifies the type of limit that applies to the approval template.';
                }
                field("Approval Type"; Rec."Approval Type")
                {
                    ToolTip = 'Specifies which approvers apply to this approval template.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the type of document that an approval entry has been created for. Approval entries can be created for six different types of sales or purchase documents.';
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number copied from the relevant sales or purchase document, such as a purchase order or a sales quote.';
                    Visible = false;
                }
                field(RecordIDText; RecordIDText)
                {
                    Caption = 'To Approve';
                    ToolTip = 'Specifies the record that you are requested to approve.';
                }
                field(Details; Rec.RecordDetails())
                {
                    Caption = 'Details';
                    ToolTip = 'Specifies the record that the approval is related to.';
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ToolTip = 'Specifies the order of approvers when an approval workflow involves more than one approver.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the approval status for the entry.';
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ToolTip = 'Specifies the ID of the user who sent the approval request for the document to be approved.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(Rec."Sender ID");
                    end;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
#pragma warning disable LC0038
                    ToolTip = 'Specifies the code for the salesperson or purchaser that was in the document to be approved. It is not a mandatory field, but is useful if a salesperson or a purchaser responsible for the customer/vendor needs to approve the document before it is processed.';
#pragma warning restore LC0038
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ToolTip = 'Specifies the ID of the user who must approve the document.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(Rec."Approver ID");
                    end;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the code of the currency of the amounts on the sales or purchase lines.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ToolTip = 'Specifies the total amount (excl. VAT) on the document awaiting approval. The amount is stated in the local currency.';
                }
                field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
                {
                    ToolTip = 'Specifies the remaining credit (in LCY) that exists for the customer.';
                }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ToolTip = 'Specifies the date and the time that the document was sent for approval.';
                }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ToolTip = 'Specifies the date when the approval entry was last modified. If, for example, the document approval is canceled, this field will be updated accordingly.';
                }
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
                {
                    ToolTip = 'Specifies the ID of the user who last modified the approval entry. If, for example, the document approval is canceled, this field will be updated accordingly.';

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(Rec."Last Modified By User ID");
                    end;
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies whether there are comments relating to the approval of the record. If you want to read the comments, choose the field to open the Approval Comment Sheet window.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the record must be approved, by one or more approvers.';
                }
            }
        }
        area(FactBoxes)
        {
            part(Change; "Workflow Change List FactBox")
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                UpdatePropagation = SubPart;
                Visible = ShowChangeFactBox;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                Image = View;
                action(Record)
                {
                    Caption = 'Record';
                    Enabled = ShowRecCommentsEnabled;
                    Image = Document;
                    ToolTip = 'Open the document, journal line, or card that the approval request is for.';

                    trigger OnAction()
                    begin
                        Rec.ShowRecord();
                    end;
                }
                action(Comments)
                {
                    Caption = 'Comments';
                    Enabled = ShowRecCommentsEnabled;
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                    begin
                        RecRef.Get(Rec."Record ID to Approve");
                        Clear(ApprovalsMgmt);
                        ApprovalsMgmt.GetApprovalCommentForWorkflowStepInstanceID(RecRef, Rec."Workflow Step Instance ID");
                    end;
                }
                action("O&verdue Entries")
                {
                    Caption = 'O&verdue Entries';
                    Image = OverdueEntries;
                    ToolTip = 'View approval requests that are overdue.';

                    trigger OnAction()
                    begin
                        Rec.SetFilter(Status, '%1|%2', Rec.Status::Created, Rec.Status::Open);
                        Rec.SetFilter("Due Date", '<%1', Today());
                    end;
                }
                action("All Entries")
                {
                    Caption = 'All Entries';
                    Image = Entries;
                    ToolTip = 'View all approval entries.';

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status);
                        Rec.SetRange("Due Date");
                    end;
                }
            }
        }
        area(Processing)
        {
            action("&Delegate")
            {
                Caption = '&Delegate';
                Enabled = DelegateEnable;
                Image = Delegate;
                ToolTip = 'Delegate the approval request to another approver that has been set up as your substitute approver.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    CurrPage.SetSelectionFilter(ApprovalEntry);
                    ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                end;
            }
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
                        ApprovalEntryHelper.SetMeAsApprover(Rec);
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
                            ApprovalEntryHelper.DeleteEntry(Rec);
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
                            ApprovalEntryHelper.SetApprovalEntryToStatusOpen(Rec);
                        end;
                    }
                    action(EntryStatusApprovedWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Approved';
                        Image = Approve;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelper.SetApprovalEntryToStatusApproved(Rec);
                        end;
                    }
                    action(EntryStatusCanceledWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Canceled';
                        Image = Cancel;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelper.SetApprovalEntryToStatusCanceled(Rec);
                        end;
                    }
                    action(EntryStatusCreatedWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Created';
                        Image = New;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelper.SetApprovalEntryToStatusCreated(Rec);
                        end;
                    }
                    action(EntryStatusRejectedWFE)
                    {
                        ApplicationArea = All;
                        Caption = 'Rejected';
                        Image = Reject;

                        trigger OnAction()
                        begin
                            ApprovalEntryHelper.SetApprovalEntryToStatusRejected(Rec);
                        end;
                    }
                }
            }

        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref("&Delegate_Promoted"; "&Delegate") { }
                actionref(Record_Promoted; Record) { }
                actionref(Comments_Promoted; Comments) { }
                group(Category_Show)
                {
                    Caption = 'Show';

                    actionref("All Entries_Promoted"; "All Entries") { }
                    actionref("O&verdue Entries_Promoted"; "O&verdue Entries") { }
                }
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
    }

    var
        ApprovalEntryHelper: Codeunit "Approval Entry Helper WFE";
        DelegateEnable: Boolean;
        ShowChangeFactBox: Boolean;
        ShowRecCommentsEnabled: Boolean;
#pragma warning disable LC0088
        Overdue: Option Yes," ";
#pragma warning restore LC0088
        RecordIDText: Text;

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;

        RecordIDText := Format(Rec."Record ID to Approve", 0, 1);
    end;

    // trigger OnOpenPage()
    // begin
    //     Rec.MarkAllWhereUserisApproverOrSender();
    // end;

    // procedure SetRecordFilters(TableId: Integer; DocumentType: Enum "Approval Document Type"; DocumentNo: Code[20])
    // begin
    //     if TableId <> 0 then begin
    //         Rec.FilterGroup(2);
    //         Rec.SetCurrentKey("Table ID", "Document Type", "Document No.", "Date-Time Sent for Approval");
    //         Rec.SetRange("Table ID", TableId);
    //         Rec.SetRange("Document Type", DocumentType);
    //         if DocumentNo <> '' then
    //             Rec.SetRange("Document No.", DocumentNo);
    //         Rec.FilterGroup(0);
    //     end;
    // end;

    local procedure FormatField(ApprovalEntry: Record "Approval Entry"): Boolean
    begin
        if Rec.Status in [Rec.Status::Created, Rec.Status::Open] then begin
            if ApprovalEntry."Due Date" < Today() then
                exit(true);

            exit(false);
        end;
    end;

    // procedure CalledFrom()
    // begin
    //     Overdue := Overdue::" ";
    // end;
}

