codeunit 83809 "Info Dialog WFE"
{
    var
        InfoDialog: Record "Info Dialog WFE";
        LastEntryNo: Integer;
        PageCaption: Text;

    procedure Initialize()
    begin
        LastEntryNo := 0;
        InfoDialog.DeleteAll(false);
    end;

    procedure Add(Name: Text[100])
    begin
        Add(Name, '', false, '');
    end;

    procedure Add(Name: Text[100]; Value: Text[100])
    begin
        Add(Name, Value, false, '');
    end;

    procedure Add(Name: Text[100]; Value: Integer)
    begin
        Add(Name, Format(Value), false, '');
    end;

    procedure Add(Name: Text[100]; Value: Boolean)
    begin
        Add(Name, Format(Value), false, '');
    end;

    procedure AddHeader(Name: Text[100])
    begin
        Add(Name, '', true, '');
    end;

    procedure Add(Name: Text[100]; Value: Text[100]; Header: Boolean; EventCode: Code[128])
    begin
        CreateInfoBufferLine(Name, Value, Header, EventCode);
    end;

    procedure Add(Name: Text[100]; Value: Text[100]; EventCode: Code[128])
    begin
        Add(Name, Value, false, EventCode);
    end;

    procedure AddEmptyLine()
    begin
        Add('', '', false, '');
    end;

    procedure OpenInfoDialog()
    // var
    //     InfoBufferWFE: Page "Info Buffer WFE";
    begin
        InfoDialog.Reset();
        if InfoDialog.FindFirst() then; //Set pointer to first
        Page.Run(0, InfoDialog);
        // InfoBufferWFE.GetRecord(InfoBuffer); //FIXME
        // InfoBufferWFE.SetRecord(InfoBuffer);
        // InfoBufferWFE.SetTableView(InfoBuffer);
        // InfoBufferWFE.Run();
    end;

    local procedure CreateInfoBufferLine(Name: Text[100]; Value: Text[100]; Header: Boolean; EventCode: Code[128])
    var
        EntryNo: Integer;
    begin
        EntryNo := GetNewEntryNo();

        InfoDialog.Init();
        InfoDialog.Validate("Entry No.", EntryNo);
        InfoDialog.Validate(Name, Name);
        InfoDialog.Validate("Value", Value);
        InfoDialog.Validate(Header, Header);
        InfoDialog.Validate("Event Code", EventCode);
        InfoDialog.Insert(true);
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

    procedure TransferInfoDialog(var ToInfoDialog: Record "Info Dialog WFE")
    begin
        if InfoDialog.FindSet() then
            repeat
                ToInfoDialog.Init();
                ToInfoDialog := InfoDialog;
                ToInfoDialog.Insert(false);
            until InfoDialog.Next() = 0;
    end;
}