codeunit 83809 "Info Dialog WPTE"
{
    var
        InfoBuffer: Record "Info Dialog WPTE";
        LastEntryNo: Integer;
        PageCaption: Text;

    procedure Initialize()
    begin
        LastEntryNo := 0;
        InfoBuffer.DeleteAll(false);
    end;

    procedure Add(Name: Text[100])
    begin
        Add(Name, '', false);
    end;

    procedure Add(Name: Text[100]; Value: Text[100])
    begin
        Add(Name, Value, false);
    end;


    procedure Add(Name: Text[100]; Value: Boolean)
    begin
        Add(Name, format(Value), false);
    end;

    procedure AddHeader(Name: Text[100])
    begin
        Add(Name, '', true);
    end;

    procedure Add(Name: Text[100]; Value: Text[100]; Header: Boolean)
    begin
        CreateInfoBufferLine(Name, Value, Header);
    end;

    procedure OpenInfoDialog()
    // var
    //     InfoBufferWPTE: Page "Info Buffer WPTE";
    begin
        InfoBuffer.Reset();
        if InfoBuffer.FindFirst() then;
        Page.Run(0, InfoBuffer);
        // InfoBufferWPTE.GetRecord(InfoBuffer); //FIXME
        // InfoBufferWPTE.SetRecord(InfoBuffer);
        // InfoBufferWPTE.SetTableView(InfoBuffer);
        // InfoBufferWPTE.Run();
    end;

    local procedure CreateInfoBufferLine(Name: Text[100]; Value: Text[100]; Header: Boolean)
    var
        EntryNo: Integer;
    begin
        EntryNo := GetNewEntryNo();

        InfoBuffer.Init();
        InfoBuffer.Validate("Entry No.", EntryNo);
        InfoBuffer.Validate("Name", Name);
        InfoBuffer.Validate("Value", Value);
        InfoBuffer.Validate(Header, Header);
        InfoBuffer.Insert(true);
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
}