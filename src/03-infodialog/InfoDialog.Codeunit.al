codeunit 83809 "Info Dialog WFE"
{
    var
        BufferInfoDialog: Record "Info Dialog WFE";
        CurrentRecordInfo: Codeunit "Record Info WFE";
        LastEntryNo: Integer;
        PageCaption: Text;

    procedure Initialize()
    begin
        LastEntryNo := 0;
        Clear(CurrentRecordInfo);
        BufferInfoDialog.DeleteAll(false);
    end;

    procedure RecordInfo(): Codeunit "Record Info WFE"
    begin
        exit(CurrentRecordInfo);
    end;

    procedure RecordInfo(NewRecordInfo: Codeunit "Record Info WFE"): Codeunit "Record Info WFE"
    begin
        CurrentRecordInfo := NewRecordInfo;
    end;

    procedure Add(Name: Text[100])
    begin
        Add(Name, '', false, "Info Dialog Event Code WFE"::" ");
    end;

    procedure Add(Name: Text[100]; Value: Text[100])
    begin
        Add(Name, Value, false, "Info Dialog Event Code WFE"::" ");
    end;

    procedure Add(Name: Text[100]; Value: Integer)
    begin
        Add(Name, Format(Value), false, "Info Dialog Event Code WFE"::" ");
    end;

    procedure Add(Name: Text[100]; Value: Integer; EventCode: Enum "Info Dialog Event Code WFE")
    begin
        Add(Name, Format(Value), false, EventCode);
    end;

    procedure Add(Name: Text[100]; Value: Boolean; EventCode: Enum "Info Dialog Event Code WFE")
    begin
        Add(Name, Format(Value), false, EventCode);
    end;

    procedure Add(Name: Text[100]; Value: Boolean)
    begin
        Add(Name, Format(Value), false, "Info Dialog Event Code WFE"::" ");
    end;

    procedure AddHeader(Name: Text[100])
    begin
        Add(Name, '', true, "Info Dialog Event Code WFE"::" ");
    end;

    procedure Add(Name: Text[100]; Value: Text[100]; Header: Boolean; EventCode: Enum "Info Dialog Event Code WFE")
    begin
        CreateInfoBufferLine(Name, Value, Header, EventCode);
    end;

    procedure Add(Name: Text[100]; Value: Text[100]; EventCode: Enum "Info Dialog Event Code WFE")
    begin
        Add(Name, Value, false, EventCode);
    end;

    procedure AddEmptyLine()
    begin
        Add('', '', false, "Info Dialog Event Code WFE"::" ");
    end;

    procedure OpenInfoDialog()
    var
        InfoDialog: Page "Info Dialog WFE";
    begin
        BufferInfoDialog.Reset();
        if BufferInfoDialog.FindFirst() then; //Set pointer to first
        InfoDialog.TransferInfoDialog(BufferInfoDialog);
        InfoDialog.RecordInfo(CurrentRecordInfo);
        InfoDialog.Run();
    end;

    local procedure CreateInfoBufferLine(Name: Text[100]; Value: Text[100]; Header: Boolean; EventCode: Enum "Info Dialog Event Code WFE")
    var
        EntryNo: Integer;
    begin
        EntryNo := GetNewEntryNo();

        BufferInfoDialog.Init();
        BufferInfoDialog.Validate("Entry No.", EntryNo);
        BufferInfoDialog.Validate(Name, Name);
        BufferInfoDialog.Validate("Value", Value);
        BufferInfoDialog.Validate(Header, Header);
        BufferInfoDialog.Validate("Event Code", EventCode);
        BufferInfoDialog.Insert(true);
    end;

    procedure SetCaption(CaptionText: Text)
    begin
        PageCaption := CaptionText;
    end;

    local procedure GetNewEntryNo(): Integer
    begin
        LastEntryNo += 1;
        exit(LastEntryNo);
    end;

    // procedure TransferInfoDialog(var ToInfoDialog: Record "Info Dialog WFE")
    // begin
    //     if BufferInfoDialog.FindSet() then
    //         repeat
    //             ToInfoDialog.Init();
    //             ToInfoDialog := BufferInfoDialog;
    //             ToInfoDialog.Insert(false);
    //         until BufferInfoDialog.Next() = 0;
    // end;
}