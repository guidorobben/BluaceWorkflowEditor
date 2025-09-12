codeunit 83822 "App Resource Handler WFE"
{
    procedure GetResource(ResourceName: Text; var ResourceInstream: InStream)
    begin
        GetResource(ResourceName, ResourceInstream, TextEncoding::UTF8);
    end;

    procedure GetResource(ResourceName: Text; var ResourceInstream: InStream; Encoding: TextEncoding)
    begin
        NavApp.GetResource(ResourceName, ResourceInstream, Encoding);
    end;

    procedure ListResources(Filter: Text) ResourceList: List of [Text]
    begin
        ResourceList := NavApp.ListResources(Filter);
    end;

    procedure GetResources(var TempAppResource: Record "App Resource WFE" temporary; Filter: Text)
    var
        ResourceList: List of [Text];
        ResourceName: Text;
    begin
        ResourceList := NavApp.ListResources(Filter);

        foreach ResourceName in ResourceList do
            AddResource(TempAppResource, ResourceName);

        if TempAppResource.FindFirst() then; //Pointer to first
    end;

    procedure SelectResource(Filter: Text; var ResourceInstream: InStream) Name: Text
    var
        TempResourceName: Record "App Resource WFE" temporary;
        ResourceList: List of [Text];
        ResourceName: Text;
    begin
        ResourceList := NavApp.ListResources(Filter);

        foreach ResourceName in ResourceList do
            AddResource(TempResourceName, ResourceName);

        if Page.RunModal(Page::"App Resource List WFE", TempResourceName) = Action::LookupOK then begin
            Name := TempResourceName."Name";
            GetResource(Name, ResourceInstream);
        end;
    end;

    internal procedure DownloadResource(var TempAppResource: Record "App Resource WFE" temporary)
    var
        ResourceInStream: InStream;
        FileName: Text;
    begin
        if TempAppResource.Name = '' then
            exit;

        GetResource(TempAppResource.Name, ResourceInStream);
        FileName := 'Guido.xml';
        File.DownloadFromStream(ResourceInStream, '', '', '', FileName);
    end;

    local procedure AddResource(var TempResourceName: Record "App Resource WFE" temporary; ResourceName: Text)
    begin
        TempResourceName.Init();
        TempResourceName."Entry No." := 1;
        TempResourceName."Name" := ResourceName;
        TempResourceName.Insert(false);
    end;

    procedure GetResourceAsJson(ResourceName: Text): JsonObject
    begin
        exit(GetResourceAsJson(ResourceName, TextEncoding::UTF8));
    end;

    procedure GetResourceAsJson(ResourceName: Text; Encoding: TextEncoding): JsonObject
    begin
        exit(NavApp.GetResourceAsJson(ResourceName, Encoding));
    end;

    procedure GetResourceAsText(ResourceName: Text): Text
    begin
        exit(GetResourceAsText(ResourceName, TextEncoding::UTF8));
    end;

    procedure GetResourceAsText(ResourceName: Text; Encoding: TextEncoding): Text
    begin
        exit(NavApp.GetResourceAsText(ResourceName, Encoding));
    end;
}