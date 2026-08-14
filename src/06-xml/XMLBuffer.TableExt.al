tableextension 83810 "XML Buffer WFE" extends "XML Buffer"
{
    DrillDownPageId = "Open XML WFE";
    LookupPageId = "Open XML WFE";

    keys
    {
        key(PathWFE; Path) { }
        key(ParentNameWFE; "Parent Entry No.", Type, Name) { }
    }

    var
        XMLBufferHelperWFE: Codeunit "XML Buffer Helper WFE";

    procedure SelectSingleNode(XPath: Text; var XMLBuffer: Record "XML Buffer"): Text
    begin
        exit(XMLBufferHelperWFE.SelectSingleNode(XPath, XMLBuffer));
        // XMLBuffer.Reset();
        // XMLBuffer.SetFilter(Path, XPath);
        // if XMLBuffer.FindFirst() then
        //     exit(XMLBuffer.Value);
    end;

    procedure SelectSingleNodeByNameWFE(Name: Text; var XmlBuffer: array[3] of Record "XML Buffer"; Index: Integer; XMLType: Enum "XML Type WFE"; var Value: Text)
    begin
        Value := XMLBufferHelperWFE.SelectSingleNodeByName(Name, XmlBuffer, Index, XMLType);
    end;

    procedure SelectSingleNodeByNameWFE(Name: Text; var XmlBuffer: array[3] of Record "XML Buffer"; Index: Integer; XMLType: Enum "XML Type WFE"; var Value: Integer)
    var
        NodeValue: Text;
    begin
        SelectSingleNodeByNameWFE(Name, XmlBuffer, Index, XMLType, NodeValue);
        if NodeValue = '' then
            exit;

        Evaluate(Value, NodeValue);
    end;

    procedure SelectNodes(XPath: Text; var XMLBuffer: Record "XML Buffer")
    begin
        XMLBuffer.Reset();
        XMLBuffer.SetCurrentKey(Path);
        XMLBuffer.SetFilter(Path, XPath);
        // if XMLBuffer.FindSet();
    end;

    procedure GetAttributes(var XMLBuffer: Record "XML Buffer")
    begin
        XMLBuffer.Reset();
        XMLBuffer.SetCurrentKey("Parent Entry No.", Type);
        XMLBuffer.SetRange("Parent Entry No.", Rec."Entry No.");
        XMLBuffer.SetRange(Type, XMLBuffer.Type::Attribute);
        // if XMLBuffer.FindSet() then;
    end;

    procedure GetAttribute(Name: Text; var XMLBuffer: Record "XML Buffer"): Text
    begin
        exit(XMLBufferHelperWFE.GetAttribute(Rec, Name, XMLBuffer));
    end;

    procedure GetChildElements(var XMLBuffer: Record "XML Buffer")
    begin
        XMLBuffer.Reset();
        XMLBuffer.SetCurrentKey("Parent Entry No.", Type);
        XMLBuffer.SetRange("Parent Entry No.", Rec."Entry No.");
        XMLBuffer.SetRange(Type, XMLBuffer.Type::Element);
        // if XMLBuffer.FindSet() then;
    end;

    procedure GetValueWFE(var Value: Integer; Fatal: Boolean)
    begin
        Value := (XMLBufferHelperWFE.GetValueAsInteger(Rec, Fatal));
    end;

    procedure GetValueWFE(var Value: Decimal; Fatal: Boolean)
    begin
        Value := XMLBufferHelperWFE.GetValueAsDecimal(Rec, Fatal);
    end;

    procedure GetValueWFE(var Value: Date; Fatal: Boolean)
    begin
        Value := XMLBufferHelperWFE.GetValueAsDate(Rec, Fatal);
    end;

    procedure GetValueWFE(var Value: Boolean; Fatal: Boolean)
    begin
        Value := XMLBufferHelperWFE.GetValueAsBoolean(Rec, Fatal);
    end;

    procedure LoadFromXMLDocumentWFE(Document: XmlDocument)
    begin
        XMLBufferHelperWFE.LoadFromXMLDocument(Rec, Document);
    end;
}