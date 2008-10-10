{
  Abstract mediating views for GUI list controls. This allows you to use
  standard list components and make them object-aware.  See the demo
  application for usage.
}
unit tiListMediators;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  tiBaseMediator,
  stdctrls,
  comctrls,
  grids,
  tiObject;

type
  { Composite mediator for TListView }

  { TListViewMediator }

  TListViewMediator = class(TCustomListMediator)
  private
    FObserversInTransit: TList;
    FView: TListView;
    procedure SetView(const AValue: TListView);
  protected
    function GetSelectedObject: TtiObject; override;
    procedure SetSelectedObject(const AValue: TtiObject); override;
    procedure CreateColumns; override;
    procedure DoCreateItemMediator(AData: TtiObject; ARowIdx: integer); override;
    function GetGuiControl: TComponent; override;
    procedure SetGuiControl(const AValue: TComponent); override;
    procedure SetupGUIandObject; override;
    procedure ClearList; override;
    procedure RebuildList; override;
  public
    constructor CreateCustom(AModel: TtiObjectList; AView: TListView; ADisplayNames: string; AIsObserving: Boolean = True); overload;
    constructor CreateCustom(AModel: TtiObjectList; AView: TListView; AOnBeforeSetupField: TOnBeforeSetupField; ADisplayNames: string; AIsObserving: Boolean = True); overload;
    class function ComponentClass: TClass; override;
    constructor Create; override;
    destructor Destroy; override;
    procedure HandleSelectionChanged; override;
    class function CompositeMediator: Boolean; override;
  published
    property View: TListView read FView write SetView;
  end;


  // for backwards compatibility
  TCompositeListViewMediator = TListViewMediator;


  { Composite mediator for TStringGrid }

  { TStringGridMediator }

  TStringGridMediator = class(TCustomListMediator)
  private
    FView: TStringGrid;
    procedure DoCreateItemMediator(AData: TtiObject; ARowIdx: integer); override;
    procedure SetView(const AValue: TStringGrid);
  protected
    function GetSelectedObject: TtiObject; override;
    procedure SetSelectedObject(const AValue: TtiObject); override;
    procedure CreateColumns; override;
    function GetGuiControl: TComponent; override;
    procedure SetGuiControl(const AValue: TComponent); override;
    procedure SetupGUIandObject; override;
    procedure RebuildList; override;
  public
    constructor CreateCustom(AModel: TtiObjectList; AGrid: TStringGrid; ADisplayNames: string; AIsObserving: Boolean = True);
    class function ComponentClass: TClass; override;
    class function CompositeMediator: Boolean; override;
  published
    property View: TStringGrid read FView write SetView;
    property SelectedObject: TtiObject read GetSelectedObject write SetSelectedObject;
  end;


  // for backwards compatibility
  TCompositeStringGridMediator = TStringGridMediator;


  { Used internally for sub-mediators in ListView mediator. Moved to interface
    section so it can be overridden. }
  TListViewListItemMediator = class(TListItemMediator)
  private
    FView: TListItem;
    procedure SetupFields; virtual;
  public
    constructor CreateCustom(AModel: TtiObject; AView: TListItem; const AFieldsInfo: TtiMediatorFieldInfoList; IsObserving: Boolean = True);
    constructor CreateCustom(AModel: TtiObject; AView: TListItem; AOnBeforeSetupField: TOnBeforeSetupField; const AFieldsInfo: TtiMediatorFieldInfoList; IsObserving: Boolean = True); overload;
    procedure BeforeDestruction; override;
    procedure Update(ASubject: TtiObject); override;
  published
    property View: TListItem read FView;
  end;


  { Used internally for sub-mediators in StringGrid mediator. Moved to interface
    section so it can be overridden. }
  TStringGridRowMediator = class(TListItemMediator)
  private
    FView: TStringGrid;
    FRowIndex: integer;
  public
    constructor CreateCustom(AModel: TtiObject; AGrid: TStringGrid; const AFieldsInfo: TtiMediatorFieldInfoList; ARowIndex: integer; IsObserving: Boolean = True);
    procedure Update(ASubject: TtiObject); override;
  published
    property View: TStringGrid read FView;
    property RowIndex: integer read FRowIndex;
  end;


Procedure RegisterFallBackListmediators;

implementation

procedure RegisterFallBackListmediators;
begin
  gMediatorManager.RegisterMediator(TListViewMediator, TtiObjectList);
  gMediatorManager.RegisterMediator(TStringGridMediator, TtiObjectList);
end;


{ TListViewMediator }

procedure TListViewMediator.SetView(const AValue: TListView);
begin
  FView := AValue;
  SetGUIControl(AValue);
end;

function TListViewMediator.GetGuiControl: TComponent;
begin
  Result := FView;
end;

procedure TListViewMediator.SetGuiControl(const AValue: TComponent);
begin
  FView := AValue as TListView;
  inherited SetGuiControl(AValue);
end;

procedure TListViewMediator.SetSelectedObject(const AValue: TtiObject);
var
  i: integer;
begin
  for i := 0 to FView.Items.Count - 1 do
    if TtiObject(FView.Items.Item[i].Data) = AValue then
    begin
      FView.Selected:=FView.Items.Item[i];
      HandleSelectionChanged;
      Exit; //==>
    end;
end;

function TListViewMediator.GetSelectedObject: TtiObject;
begin
  if FView.Selected=Nil then
    Result := nil
  else
    Result := TtiObject(FView.Selected.Data);
end;

procedure TListViewMediator.DoCreateItemMediator(AData: TtiObject; ARowIdx: integer);
var
  li: TListItem;
  m: TListViewListItemMediator;
begin
  DataAndPropertyValid(AData);
  { Create ListItem and Mediator }
  li:=FView.Items.Add;
  li.Data := AData;
  m:= TListViewListItemMediator.CreateCustom(AData, li, OnBeforeSetupField, FieldsInfo, Active);
  MediatorList.Add(m);
end;

procedure TListViewMediator.CreateColumns;
var
  c: integer;
  lc: TListColumn;
  lInfo: TtiMediatorFieldInfo;
begin
  if View.Columns.Count = 0 then
  begin
    for c := 0 to FieldsInfo.Count-1 do
    begin
      lInfo        := FieldsInfo[c];
      lc           := View.Columns.Add;
      lc.AutoSize  := False;
      lc.Caption   := lInfo.Caption;
      lc.Width     := lInfo.FieldWidth;
      lc.Alignment := lInfo.Alignment;
    end;
  end;
end;

procedure TListViewMediator.SetupGUIandObject;
begin
  { Setup TListView defaults }
  FView.Columns.Clear;
  FView.Items.Clear;
  FView.ViewStyle         := vsReport;
  FView.ShowColumnHeaders:=True;
  FView.RowSelect         := True;
  FView.ReadOnly:=True;
  //  FView.AutoSize          := False;
  FView.ScrollBars        := ssAutoBoth;
end;

procedure TListViewMediator.ClearList;
begin
  View.Items.Clear;
end;

procedure TListViewMediator.RebuildList;
begin
  MediatorList.Clear;
  ClearList;

  { This rebuilds the whole list. Not very efficient. You can always override
    this in your mediators to create a more optimised rebuild. }
  View.BeginUpdate;
  try
    View.Columns.Clear;
    View.Items.Clear;
    CreateSubMediators;
  finally
    View.EndUpdate;
  end;
end;

constructor TListViewMediator.CreateCustom(AModel: TtiObjectList; AView: TListView; AOnBeforeSetupField: TOnBeforeSetupField; ADisplayNames: string; AIsObserving: Boolean);
begin
  Create; // don't forget this
  OnBeforeSetupField := AOnBeforeSetupField;
  DisplayNames := ADisplayNames;      // Will call ParseDisplaynames.
  Subject    := AModel;
  GUIControl := AView;               // Will call SetupGUIandObject;
  CreateSubMediators;
  Active     := AIsObserving;         // Will attach/Detach
end;

class function TListViewMediator.ComponentClass: TClass;
begin
  Result := TListView;
end;

constructor TListViewMediator.Create;
begin
  inherited Create;
  FObserversInTransit := TList.Create;
end;

constructor TListViewMediator.CreateCustom(AModel: TtiObjectList; AView: TListView; ADisplayNames: string; AIsObserving: Boolean);
begin
  CreateCustom(AModel, AView, nil, ADisplayNames, AIsObserving);
end;

destructor TListViewMediator.Destroy;
begin
  IsObserving := False;
  FView       := nil;
  inherited;
end;

procedure TListViewMediator.HandleSelectionChanged;
var
  i: integer;
begin
  if View.Selected = Nil then
    SelectedObject := nil
  else
  begin
    FObserversInTransit.Clear;
    { If an item is already selected, assign the item's List of observers to a
      temporary container. This is done so that the same observers can be
      assigned to the new item. }
    if Assigned(SelectedObject) then
      FObserversInTransit.Assign(SelectedObject.ObserverList);

    // Assign Newly selected item to SelectedObject Obj.
    SelectedObject := TtiObject(View.Selected.Data);

    { If an object was selected, copy the old item's observer List
      to the new item's observer List. }
    if FObserversInTransit.Count > 0 then
      SelectedObject.ObserverList.Assign(FObserversInTransit);

    { Set the Observers Subject property to the selected object }
    for i := 0 to SelectedObject.ObserverList.Count - 1 do
      TMediatorView(SelectedObject.ObserverList.Items[i]).Subject :=
        SelectedObject;

    // execute the NotifyObservers event to update the observers.
    SelectedObject.NotifyObservers;
  end;
end;

class function TListViewMediator.CompositeMediator: Boolean;
begin
  Result:=True;
end;


{ TListViewListItemMediator }

procedure TListViewListItemMediator.SetupFields;
var
  c: integer;
  lMemberName: string;
  lValue: string;
begin
  lMemberName := FFieldsInfo[0].PropName;
  lValue      := FModel.PropValue[lMemberName];
  if Assigned(OnBeforeSetupField) then
    OnBeforeSetupField(FModel, lMemberName, lValue);
  FView.Caption := lValue;
  for c := 1 to FFieldsInfo.Count - 1 do
  begin
    lMemberName := FFieldsInfo[c].PropName;
    lValue      := FModel.PropValue[lMemberName];
    if Assigned(OnBeforeSetupField) then
      OnBeforeSetupField(FModel, lMemberName, lValue);
    FView.SubItems.Add(lValue);
    writeln('SubItems.Add for ', lMemberName, ' with value <', lValue, '>');
  end;
end;

constructor TListViewListItemMediator.CreateCustom(AModel: TtiObject; AView: TListItem; const AFieldsInfo: TtiMediatorFieldInfoList; IsObserving: Boolean);
begin
  CreateCustom(AModel, AView, nil, AFieldsInfo, IsObserving);
end;

constructor TListViewListItemMediator.CreateCustom(AModel: TtiObject; AView: TListItem; AOnBeforeSetupField: TOnBeforeSetupField; const AFieldsInfo: TtiMediatorFieldInfoList; IsObserving: Boolean);
begin
  inherited Create;
  FModel      := AModel;
  FView       := AView;
  FFieldsInfo := AFieldsInfo;
  OnBeforeSetupField := AOnBeforeSetupField;
  SetupFields;
  Active      := IsObserving; // Will attach
end;

procedure TListViewListItemMediator.BeforeDestruction;
begin
  FModel.DetachObserver(self);
  FModel := nil;
  FView  := nil;
  inherited BeforeDestruction;
end;

procedure TListViewListItemMediator.Update(ASubject: TtiObject);
var
  c: integer;
  lMemberName: string;
  lValue: string;
begin
  Assert(FModel = ASubject);

  lMemberName := FFieldsInfo[0].PropName;
  lValue      := FModel.PropValue[lMemberName];
  if Assigned(OnBeforeSetupField) then
    OnBeforeSetupField(FModel, lMemberName, lValue);

  FView.Caption := lValue;

  for c := 1 to FFieldsInfo.Count - 1 do
  begin
    lMemberName := FFieldsInfo[c].PropName;
    lValue      := FModel.PropValue[lMemberName];
    if Assigned(OnBeforeSetupField) then
      OnBeforeSetupField(FModel, lMemberName, lValue);
    FView.SubItems[c - 1] := lValue;
  end;
end;


{ TStringGridMediator }

function TStringGridMediator.GetSelectedObject: TtiObject;
begin
  if FView.RowCount = 0 then
  begin
    Result := nil;
    Exit;
  end;

  if FView.Row = -1 then
    Result := nil
  else
    Result := TtiObject(FView.Objects[0, FView.Row]);
end;

procedure TStringGridMediator.SetSelectedObject(const AValue: TtiObject);
var
  i: integer;
begin
  for i := 0 to FView.RowCount - 1 do
    if TtiObject(FView.Objects[0, i]) = AValue then
    begin
      FView.Row := i;
      Exit; //==>
    end;
end;

procedure TStringGridMediator.SetView(const AValue: TStringGrid);
begin
  SetGUIControl(AValue);
end;

function TStringGridMediator.GetGuiControl: TComponent;
begin
  Result := fView;
end;

procedure TStringGridMediator.SetGuiControl(const AValue: TComponent);
begin
  FView := AValue as TStringGrid;
end;

procedure TStringGridMediator.DoCreateItemMediator(AData: TtiObject; ARowIdx: integer);
var
  i: integer;
  lFieldName: string;
  lMediatorView: TStringGridRowMediator;
begin
  FView.Objects[0, ARowIdx] := AData;   // set Object reference inside grid
  for i := 0 to FieldsInfo.Count - 1 do
  begin
    lFieldName := FieldsInfo[i].PropName;
    FView.Cells[i, ARowIdx] := AData.PropValue[lFieldName];  // set Cell text
  end;
  lMediatorView := TStringGridRowMediator.CreateCustom(AData, FView, FieldsInfo, ARowIdx, Active);
  MediatorList.Add(lMediatorView);
end;

procedure TStringGridMediator.CreateColumns;
var
  i: integer;
  lColumnTotalWidth: integer;
  C : TGridColumn;
begin
  lColumnTotalWidth := 0;
  FView.Columns.Clear;
  for i := 0 to FieldsInfo.Count - 1 do
  begin
    C:=FView.Columns.Add;// as TGridColumn;
    C.Width    := FieldsInfo[i].FieldWidth;
    C.Title.Caption  := FieldsInfo[i].Caption;
    C.Alignment := FieldsInfo[i].Alignment;
    //resize the last column to fill the grid.
    if i = FieldsInfo.Count - 1 then
      begin
      if FView.Width > (lColumnTotalWidth + 10) then
        C.Width := FView.Width - (lColumnTotalWidth + 10);
      end
    else
      lColumnTotalWidth := lColumnTotalWidth + C.Width + 20;
  end;
end;

procedure TStringGridMediator.SetupGUIandObject;
begin
  //Setup default properties for the StringGrid
  FView.Options:=FView.Options+[goRowSelect];
  if ShowDeleted then
    FView.RowCount := Model.Count
  else
    FView.RowCount := Model.CountNotDeleted;
end;

procedure TStringGridMediator.RebuildList;
begin
  { This rebuilds the whole list. Not very efficient. }
  View.BeginUpdate;
  try
    SetupGUIandObject;
    MediatorList.Clear;
    //    for i := View.ColumnCount-1 downto 0 do
    //      View.DeleteColumn(i);
    CreateSubMediators;
  finally
    View.EndUpdate;
  end;
end;

constructor TStringGridMediator.CreateCustom(AModel: TtiObjectList; AGrid: TStringGrid; ADisplayNames: string; AIsObserving: Boolean);
begin
  inherited Create;
  DisplayNames := ADisplayNames;
  Subject      := AModel;
  GUIControl   := AGrid;
  CreateSubMediators;
  IsObserving  := AIsObserving;
end;

class function TStringGridMediator.ComponentClass: TClass;
begin
  Result := TStringGrid;
end;

class function TStringGridMediator.CompositeMediator: Boolean;
begin
  Result:=true;
end;


{ TStringGridRowMediator }

constructor TStringGridRowMediator.CreateCustom(AModel: TtiObject; AGrid: TStringGrid; const AFieldsInfo: TtiMediatorFieldInfoList; ARowIndex: integer; IsObserving: Boolean);
begin
  inherited Create;
  FModel      := AModel;
  FView       := AGrid;
  FFieldsInfo := AFieldsInfo;
  FRowIndex   := ARowIndex;
  Active      := IsObserving; // Will attach
end;

procedure TStringGridRowMediator.Update(ASubject: TtiObject);
var
  i: integer;
  lvalue, lFieldName: string;
begin
  Assert(FModel = ASubject);
  for i := 0 to FFieldsInfo.Count - 1 do
  begin
    lFieldName := FFieldsInfo[I].PropName;
    lValue     := FModel.PropValue[lFieldName];
    if Assigned(OnBeforeSetupField) then
      OnBeforeSetupField(FModel, lFieldName, lValue);
    FView.Cells[i, FRowIndex] := lValue;
  end;
end;


end.

