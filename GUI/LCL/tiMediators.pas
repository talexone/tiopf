{
  Purpose:
    Abstract mediating view and Mediator Factory. This allows you to use
    standard edit components and make them object-aware.  See the demo
    application for usage.

  ToDo:
    * As soon as TSpinEdit has been implemented, port the SpinEdit mediator
}

unit tiMediators;

{$mode objfpc}{$H+}

interface
uses
  tiObject
  ,Classes
  ,tiBaseMediator
  ,Controls
  ,stdctrls
  ,extctrls
  ,comctrls
  ;

type

  { Base class to handle TCustomEdit controls }
  TMediatorEditView = class(TMediatorView)
  private
    FEditControl: TCustomEdit;
  protected
    function    GetGUIControl: TComponent; override;
    procedure   SetGUIControl(const AValue: TComponent); override;
    procedure   UpdateGuiValidStatus(pErrors: TtiObjectErrors); override;
    procedure   SetupGUIandObject; override;
    procedure   SetObjectUpdateMoment (Const AValue : TObjectUpdateMoment); override;
  public
    constructor Create; override;
    constructor CreateCustom(pEditControl: TControl; pSubject: TtiObject; pFieldName: string; pGuiFieldName: string = 'Text'); reintroduce;
    destructor  Destroy; override;
    property    EditControl: TCustomEdit read FEditControl write FEditControl;
    class function ComponentClass: TClass; override;
  end;


  { Base class to handle TCheckBox controls }
  TMediatorCheckBoxView = class(TMediatorView)
  private
    FEditControl: TCheckBox;
  protected
    function    GetGUIControl: TComponent; override;
    procedure   SetGUIControl(const AValue: TComponent);override;
    procedure   UpdateGuiValidStatus(pErrors: TtiObjectErrors); override;
  public
    Constructor Create; override;
    property    EditControl: TCheckBox read FEditControl write FEditControl;
    class function ComponentClass: TClass; override;
  end;


  { Base class to handle TCustomLabel controls }
  TMediatorStaticTextView = class(TMediatorView)
  private
    FEditControl: TCustomLabel;
  protected
    function    GetGUIControl: TComponent; override;
    procedure   SetGUIControl(const AValue: TComponent);override;
    procedure   SetupGUIandObject; override;
  public
    Constructor Create; override;
    property    EditControl: TCustomLabel read FEditControl write FEditControl;
    class function ComponentClass: TClass; override;
  end;


  { Base class to handle TSpinEdit controls }
{
  TMediatorSpinEditView = class(TMediatorView)
  private
    function    GetEditControl: TSpinEdit;
    procedure   OnLostFocus(Sender: TObject);
    procedure   SetEditControl(const AValue: TSpinEdit);
  protected
    procedure   SetupGUIandObject; override;
    procedure   UpdateGuiValidStatus(pErrors: TtiObjectErrors); override;
  public
    property    EditControl: TSpinEdit read GetEditControl write SetEditControl;
    procedure   GuiToObject; override;
    class function ComponentClass: TClass; override;
  end;
}


  { Base class to handle TTrackBar controls }
  TMediatorTrackBarView = class(TMediatorView)
  private
    FEditControl: TTrackBar;
    procedure   DoTrackBarChanged(Sender: TObject; APosition: integer);
  protected
    function    GetGUIControl: TComponent; override;
    procedure   SetGUIControl(const AValue: TComponent);override;
    procedure   SetupGUIandObject; override;
  public
    Constructor Create; override;
    property    EditControl: TTrackBar read FEditControl write FEditControl;
    class function ComponentClass: TClass; override;
  end;


  { Base class to handle TComboBox controls }
  TMediatorComboBoxView = class(TMediatorView)
  private
    FEditControl: TComboBox;
  protected
    function    GetGUIControl: TComponent; override;
    procedure   SetGUIControl(const AValue: TComponent); override;
    procedure   SetupGUIandObject; override;
    procedure   UpdateGuiValidStatus(pErrors: TtiObjectErrors); override;
    procedure   DoObjectToGui; override;
  public
    constructor Create; override;
    property    EditControl: TComboBox read FEditControl write FEditControl;
    class function ComponentClass: TClass; override;
  end;


  { Sets ItemIndex based on integer property }
  TMediatorItemComboBoxView = class(TMediatorComboBoxView)
  protected
    Procedure   DoGUIToObject; override;
    Procedure   DoObjectToGUI; override;
  public
    constructor Create; override;
  end;


  { TComboBox observing a list and setting a Object property }
  TMediatorDynamicComboBoxView = class(TMediatorComboBoxView)
  private
    FExternalOnChange: TNotifyEvent;
    procedure   InternalListRefresh;
  protected
    procedure   SetListObject(const AValue: TtiObjectList); override;
    procedure   SetOnChangeActive(AValue: Boolean); virtual;
    procedure   SetupGUIandObject; override;
    procedure   DoGuiToObject; override;
    procedure   DoObjectToGui; override;
  public
    procedure   RefreshList; virtual;
  end;
  

  { Base class to handle TMemo controls }
  TMediatorMemoView = class(TMediatorView)
  private
    FEditControl: TMemo;
  protected
    function    GetGUIControl: TComponent; override;
    procedure   SetGUIControl(const AValue: TComponent);override;
    procedure   SetupGUIandObject; override;
    procedure   DoObjectToGui; override;
    procedure   DoGuiToObject; override;
  public
    property    EditControl: TMemo read FEditControl write FEditControl;
    class function ComponentClass: TClass; override;
  end;


// Registering generic mediators which can handle most cases by default.
procedure RegisterFallBackMediators;


implementation
uses
  SysUtils
  ,TypInfo
  ,graphics
  ,tiExcept
  ;

const
  // RGB color values
  clPaleBlue    = TColor($FEF5E9);
  clError       = clYellow;

const
  cErrorListHasNotBeenAssigned   = 'List has not been assigned';


procedure RegisterFallBackMediators;
begin
  gMediatorManager.RegisterMediator(TMediatorEditView, TtiObject, [tkSString,tkAString,tkInteger,tkFloat]);
  gMediatorManager.RegisterMediator(TMediatorCheckBoxView, TtiObject, [tkBool]);
  gMediatorManager.RegisterMediator(TMediatorComboboxView, TtiObject, [tkSString,tkAString]);
  gMediatorManager.RegisterMediator(TMediatorStaticTextView, TtiObject);
  gMediatorManager.RegisterMediator(TMediatorTrackBarView, TtiObject, [tkInteger]);
  gMediatorManager.RegisterMediator(TMediatorDynamicComboBoxView, TtiObject, [tkClass]);
  gMediatorManager.RegisterMediator(TMediatorMemoView, TtiObject, [tkSString,tkAString]);
end;

{ TMediatorEditView }

function TMediatorEditView.GetGUIControl: TComponent;
begin
  Result := FEditControl;
end;

procedure TMediatorEditView.SetGUIControl(const AValue: TComponent);
begin
  FEditControl := AValue as TEdit;
  inherited SetGUIControl(AValue);
end;

procedure TMediatorEditView.UpdateGuiValidStatus(pErrors: TtiObjectErrors);
var
  oError: TtiObjectError;
begin
  inherited UpdateGuiValidStatus(pErrors);

  oError := pErrors.FindByErrorProperty(FieldName);
  if oError <> nil then
  begin
    EditControl.Color  := clError;
    EditControl.Hint   := oError.ErrorMessage;
  end
  else
  begin
    EditControl.Color  := clWindow;
    EditControl.Hint   := '';
  end;
end;

procedure TMediatorEditView.SetupGUIandObject;
var
  Mi, Ma: Integer;
begin
  inherited;
  if Subject.GetFieldBounds(FieldName,Mi,Ma) and (Ma>0) then
    FEditControl.MaxLength := Ma;
  if ObjectUpdateMoment in [ouOnChange,ouCustom] then
    FEditControl.OnChange := @DoOnChange
  else
    FEditControl.OnExit := @DoOnChange;
end;

procedure TMediatorEditView.SetObjectUpdateMoment(const AValue: TObjectUpdateMoment);
begin
  inherited SetObjectUpdateMoment(AValue);
  if Assigned(FEditControl) then
    If ObjectUpdateMoment in [ouOnchange,ouCustom] then
      FeditControl.OnChange := @DoOnChange
    else
      FeditControl.OnExit := @DoOnChange;
end;

constructor TMediatorEditView.Create;
begin
  inherited Create;
  GuiFieldName:='Text';
end;

constructor TMediatorEditView.CreateCustom(pEditControl: TControl;
  pSubject: TtiObject; pFieldName: string; pGuiFieldName: string);
begin
  inherited;
end;

destructor TMediatorEditView.Destroy;
begin
  if Assigned(EditControl) and Assigned(EditControl.OnChange) then
    EditControl.OnChange := nil;
  inherited Destroy;
end;

class function TMediatorEditView.ComponentClass: TClass;
begin
  Result := TCustomEdit;
end;


{ TMediatorSpinEditView}
(*
class function TMediatorSpinEditView.ComponentClass: TClass;
begin
  Result := TSpinEdit;
end;


procedure TMediatorSpinEditView.GuiToObject;
begin
  { Control is busy clearing the value before replacing it with what the user
    typed. }
  if (TSpinEdit(EditControl).Text = '') then
    Exit; //==>

  { continue as normal }
  inherited;
end;

function TMediatorSpinEditView.GetEditControl: TSpinEdit;
begin
  Result := TSpinEdit(FEditControl);
end;

procedure TMediatorSpinEditView.OnLostFocus(Sender: TObject);
begin
  if (TSpinEdit(EditControl).Text = '') then
  begin
    { Default the EditControl to a valid value }
    TSpinEdit(EditControl).Value := 0;
    GUIChanged;
  end;
end;

procedure TMediatorSpinEditView.SetEditControl(const AValue: TSpinEdit);
begin
  FEditControl := AValue;
end;


procedure TMediatorSpinEditView.SetupGUIandObject;
begin
  inherited;
  TSpinEdit(EditControl).Text := '';
  TSpinEdit(EditControl).OnExit := OnLostFocus;
end;

procedure TMediatorSpinEditView.UpdateGuiValidStatus(pErrors: TtiObjectErrors);
var
  oError: TtiObjectError;
begin
  inherited UpdateGuiValidStatus(pErrors);

  oError := pErrors.FindByErrorProperty(FieldName);
  if oError <> nil then
  begin
    EditControl.Color  := clError;
    EditControl.Hint   := oError.ErrorMessage;
  end
  else
  begin
    EditControl.Color  := ColorToRGB(clWindow);
    EditControl.Hint   := '';
  end;
end;
*)

{ TMediatorTrackBarView}

function TMediatorTrackBarView.GetGUIControl: TComponent;
begin
  Result := FEditControl;
end;

procedure TMediatorTrackBarView.SetGUIControl(const AValue: TComponent);
begin
  FEditControl := AValue as TTrackBar;
  inherited;
end;

procedure TMediatorTrackBarView.DoTrackBarChanged(Sender: TObject; APosition: integer);
begin
  GUIChanged;
end;

procedure TMediatorTrackBarView.SetupGUIandObject;
var
  Mi, Ma: Integer;
begin
  inherited;
  if Subject.GetFieldBounds(FieldName,Mi,Ma) and (Ma>0) then
  begin
    FEditControl.Min := Mi;
    FEditControl.Max := Ma;
  end;
end;

constructor TMediatorTrackBarView.Create;
begin
  inherited;
  GuiFieldName := 'Position';
end;

class function TMediatorTrackBarView.ComponentClass: TClass;
begin
  Result := TTrackBar;
end;


{ TMediatorComboBoxView }

class function TMediatorComboBoxView.ComponentClass: TClass;
begin
  Result := TComboBox;
end;

function TMediatorComboBoxView.GetGUIControl: TComponent;
begin
  Result := FEditControl;
end;

procedure TMediatorComboBoxView.SetGUIControl(const AValue: TComponent);
begin
  FEditControl := AValue as TComboBox;
  inherited SetGUIControl(AValue);
end;

procedure TMediatorComboBoxView.SetupGUIandObject;
begin
  inherited SetupGUIandObject;
  if ObjectUpdateMoment in [ouOnChange,ouCustom] then
    FEditControl.OnChange := @DoOnChange
  else
    FEditControl.OnExit := @DoOnChange;
end;

procedure TMediatorComboBoxView.UpdateGuiValidStatus(pErrors: TtiObjectErrors);
var
  oError: TtiObjectError;
begin
  inherited UpdateGuiValidStatus(pErrors);

  oError := pErrors.FindByErrorProperty(FieldName);
  if oError <> nil then
  begin
    EditControl.Color  := clError;
    EditControl.Hint   := oError.ErrorMessage;
  end
  else
  begin
    EditControl.Color  := clWindow;
    EditControl.Hint   := '';
  end;
end;

constructor TMediatorComboBoxView.Create;
begin
  inherited Create;
  GuiFieldName := 'Text'; //'ItemIndex';
end;

procedure TMediatorComboBoxView.DoObjectToGui;
begin
  EditControl.ItemIndex :=
      EditControl.Items.IndexOf(Subject.PropValue[FieldName]);
end;


{ TMediatorMemoView }

class function TMediatorMemoView.ComponentClass: TClass;
begin
  Result := TMemo;
end;

procedure TMediatorMemoView.DoGuiToObject;
begin
  Subject.PropValue[FieldName] := EditControl.Lines.Text;
end;

procedure TMediatorMemoView.DoObjectToGui;
begin
  EditControl.Lines.Text := Subject.PropValue[FieldName];
end;

function TMediatorMemoView.GetGUIControl: TComponent;
begin
  Result:=FEditControl;
end;

procedure TMediatorMemoView.SetGUIControl(const AValue: TComponent);
begin
  FEditControl:=AValue as TMemo;
  inherited SetGUIControl(AValue);
end;

procedure TMediatorMemoView.SetupGUIandObject;
begin
  inherited;
  EditControl.Lines.Clear;

  //if UseInternalOnChange then
    //EditControl.OnChange := @DoOnChange; // default OnChange event handler
  if ObjectUpdateMoment in [ouOnChange,ouCustom] then
    FEditControl.OnChange := @DoOnChange
  else
    FEditControl.OnExit := @DoOnChange;

//  EditControl.ScrollBars := ssVertical;
//  EditControl.WordWrap   := True;
end;


{ TMediatorDynamicComboBoxView }

procedure TMediatorDynamicComboBoxView.SetListObject(const AValue: TtiObjectList);
begin
  inherited;
  InternalListRefresh;
  if Assigned(ValueList) then
    EditControl.Enabled := ValueList.Count > 0;
end;

procedure TMediatorDynamicComboBoxView.InternalListRefresh;
var
  lItems: TStrings;
  i: Integer;
begin
  lItems := EditControl.Items;
  lItems.Clear;
  EditControl.Text := '';

  if (ValueList = nil) or
     (ValueList.Count < 1) or
     (SameText(FieldName, EmptyStr)) then
    Exit; //==>

  try
    for i := 0 to ValueList.Count - 1 do
    begin
      lItems.Add(ValueList.Items[i].Caption);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt('Error adding list items to combobox ' +
                                 'Message: %s, Item Property Name: %s',
                                 [E.message, FieldName]);
  end;

  ObjectToGui;
end;

procedure TMediatorDynamicComboBoxView.SetOnChangeActive(AValue: Boolean);
begin
  if AValue then
  begin
    if not UseInternalOnChange then
      EditControl.OnChange := FExternalOnChange
    else
      EditControl.OnChange := @DoOnChange;
  end
  else
  begin
    if not UseInternalOnChange then
      FExternalOnChange := EditControl.OnChange;
    EditControl.OnChange := nil;
  end;
end;

procedure TMediatorDynamicComboBoxView.SetupGUIandObject;
begin
  inherited SetupGUIandObject;

  if UseInternalOnChange then
    EditControl.OnChange := @DoOnChange; // default OnChange event handler

  {$Note As far as I can see, ValueList is always going to be nil here! - Graeme }
  if ValueList <> nil then
    EditControl.Enabled := (ValueList.Count > 0);
end;

procedure TMediatorDynamicComboBoxView.DoGuiToObject;
var
  lValue: TtiObject;
  lPropType: TTypeKind;
begin
  if not DataAndPropertyValid then
    Exit; //==>
  if EditControl.ItemIndex < 0 then
    Exit; //==>

  lValue := TtiObject(ValueList.Items[EditControl.ItemIndex]);

  lPropType := typinfo.PropType(Subject, FieldName);
  if lPropType = tkClass then
    typinfo.SetObjectProp(Subject, FieldName, lValue)
  else
    raise EtiOPFProgrammerException.Create('Error property type not a Class');
end;

procedure TMediatorDynamicComboBoxView.DoObjectToGui;
var
  i: Integer;
  lValue: TtiObject;
  lPropType: TTypeKind;
begin
  SetOnChangeActive(false);

  //  Set the index only (We're assuming the item is present in the list)
  EditControl.ItemIndex := -1;
  if Subject = nil then
    Exit; //==>

  if not Assigned(ValueList) then
    raise EtiOPFProgrammerException.Create(cErrorListHasNotBeenAssigned);

  lPropType := typinfo.PropType(Subject, FieldName);
  if lPropType = tkClass then
    lValue := TtiObject(typinfo.GetObjectProp(Subject, FieldName))
  else
    raise Exception.Create('Property is not a class type!');

  for i := 0 to ValueList.Count - 1 do
    if ValueList.Items[i] = lValue then
    begin
      EditControl.ItemIndex := i;
      Break; //==>
    end;

  SetOnChangeActive(true);
end;

procedure TMediatorDynamicComboBoxView.RefreshList;
begin
  InternalListRefresh;
end;


{ TMediatorCheckBoxView }

function TMediatorCheckBoxView.GetGUIControl: TComponent;
begin
  Result:=FEditControl;
end;

procedure TMediatorCheckBoxView.SetGUIControl(const AValue: TComponent);
begin
  FEditControl:=AValue as TCheckBox;
  inherited SetGUIControl(AValue);
end;

procedure TMediatorCheckBoxView.UpdateGuiValidStatus(pErrors: TtiObjectErrors);
var
  oError: TtiObjectError;
begin
  inherited UpdateGuiValidStatus(pErrors);

  oError := pErrors.FindByErrorProperty(FieldName);
  if oError <> nil then
  begin
    EditControl.Color  := clError;
    EditControl.Hint   := oError.ErrorMessage;
  end
  else
  begin
    EditControl.Color  := clWindow;
    EditControl.Hint   := '';
  end;
end;

constructor TMediatorCheckBoxView.Create;
begin
  inherited Create;
  GuiFieldName:='Checked';
end;

class function TMediatorCheckBoxView.ComponentClass: TClass;
begin
  Result := TCheckBox;
end;


{ TMediatorStaticTextView }

procedure TMediatorStaticTextView.SetupGUIandObject;
begin
  inherited SetupGUIandObject;
  EditControl.Caption := '';
end;

constructor TMediatorStaticTextView.Create;
begin
  inherited Create;
  GuiFieldName := 'Caption';
end;

function TMediatorStaticTextView.GetGUIControl: TComponent;
begin
  Result := FEditControl;
end;

procedure TMediatorStaticTextView.SetGUIControl(const AValue: TComponent);
begin
  FEditControl := AValue as TLabel;
  inherited SetGUIControl(AValue);
end;

class function TMediatorStaticTextView.ComponentClass: TClass;
begin
  Result := TCustomLabel;
end;


{ TMediatorItemComboBoxView }

procedure TMediatorItemComboBoxView.DoGUIToObject;
begin
  SetOrdProp(Subject,FieldName,EditControl.ItemIndex);
end;

procedure TMediatorItemComboBoxView.DoObjectToGUI;
begin
  EditCOntrol.ItemIndex := GetOrdProp(Subject,FieldName);
end;

constructor TMediatorItemComboBoxView.Create;
begin
  inherited Create;
  GuiFieldName := 'ItemIndex';
end;

end.
