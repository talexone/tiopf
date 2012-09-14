{
  Instead of adding GUI formatting and sorting to our BOM classes, we have
  helper classes defined here that does the fancy display formatting for
  us. These display objects are the Subject in TtiModelMediator.
}

unit DisplayHelpers;

interface

uses
  Classes, SysUtils, tiObject;

type

  TBaseDisplayObject = class(TtiObject)
  public
    procedure Update(ASubject: TtiObject); override;
  end;


  TBaseDisplayList = class(TtiObjectList)
  private
    FSubject: TtiObjectList;
    procedure   ItemAdded(AObject: TtiObject);
    procedure   ItemDeleted(AObject: TtiObject);
    procedure   RebuildList;
  protected
    function    CreateDisplayInstance(AItem: TtiObject): TBaseDisplayObject; virtual; abstract;
    function    FindDisplayObject(AObject: TtiObject): TBaseDisplayObject; virtual; abstract;
  public
    constructor CreateCustom(ASubject: TtiObjectList);
    destructor  Destroy; override;
    procedure   Update(ASubject: TtiObject; AOperation: TNotifyOperation); override;
    property    Subject: TtiObjectList read FSubject;
  end;


implementation

{ TBaseDisplayObject }

procedure TBaseDisplayObject.Update(ASubject: TtiObject);
begin
  inherited Update(ASubject);
  NotifyObservers;
end;


{ TBaseDisplayList }

procedure TBaseDisplayList.ItemAdded(AObject: TtiObject);
begin
  Add(CreateDisplayInstance(AObject));
end;

procedure TBaseDisplayList.ItemDeleted(AObject: TtiObject);
var
  o: TBaseDisplayObject;
begin
  { find display instance and remove that!! NOT the AObject }
  o := FindDisplayObject(AObject);
  if Assigned(o) then
    Remove(o);
end;

procedure TBaseDisplayList.RebuildList;
var
  i: integer;
begin
  Empty;  // empty ourselves
  for i := 0 to FSubject.Count-1 do
  begin
    ItemAdded(FSubject.Items[i]);
  end;
end;

constructor TBaseDisplayList.CreateCustom(ASubject: TtiObjectList);
begin
  Create;
  OwnsObjects := True;
  FSubject := ASubject;
  FSubject.AttachObserver(self);
end;

destructor TBaseDisplayList.Destroy;
begin
  FSubject.DetachObserver(self);
  inherited Destroy;
end;

procedure TBaseDisplayList.Update(ASubject: TtiObject; AOperation: TNotifyOperation);
begin
  if (AOperation=noAddItem) then
    ItemAdded(ASubject)
  else if (AOperation=noDeleteItem) then
    ItemDeleted(ASubject)
  else if (AOperation=noChanged) then
  begin
     { Safety measure: The displaylist could have been created after the
       FSubject was populated. So would wouldn't have received noAddItem changes. }
    if (FSubject.Count<>Count) or (FSubject.Count=0) then
      RebuildList;
  end
  else
    inherited Update(ASubject, AOperation);
end;

end.