unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes,
  fpg_base, fpg_main, fpg_form, fpg_grid, fpg_button,
  tiModelMediator,
  customer;

type

  TMainForm = class(TfpgForm)
  private
    {@VFD_HEAD_BEGIN: MainForm}
    btnAdd: TfpgButton;
    btnEdit: TfpgButton;
    btnDelete: TfpgButton;
    btnHelp: TfpgButton;
    grdCustomers: TfpgStringGrid;
    btnOrders: TfpgButton;
    btnQuit: TfpgButton;
    btnProducts: TfpgButton;
    btnNewOrder: TfpgButton;
    {@VFD_HEAD_END: MainForm}
    FMediator: TtiModelMediator;
    FData: TCustomerList;
    procedure   SetupMediators;
    procedure   FormShow(Sender: TObject);
    procedure   btnAddClicked(Sender: TObject);
    procedure   btnEditClicked(Sender: TObject);
    procedure   btnDeleteClicked(Sender: TObject);
    procedure   btnHelpClicked(Sender: TObject);
    procedure   btnShowOrdersClicked(Sender: TObject);
    procedure   btnQuitClicked(Sender: TObject);
    procedure   btnProductClicked(Sender: TObject);
    procedure   btnNewOrderClicked(Sender: TObject);
  public
    destructor  Destroy; override;
    procedure   AfterCreate; override;
  end;

{@VFD_NEWFORM_DECL}

implementation

uses
  tiLog,
  frm_orders,
  frm_products,
  frm_neworder,
  app_bom;

{@VFD_NEWFORM_IMPL}

procedure TMainForm.btnAddClicked(Sender: TObject);
begin

end;

procedure TMainForm.btnEditClicked(Sender: TObject);
begin

end;

procedure TMainForm.btnDeleteClicked(Sender: TObject);
begin

end;

procedure TMainForm.btnHelpClicked(Sender: TObject);
begin

end;

procedure TMainForm.btnShowOrdersClicked(Sender: TObject);
begin
  ShowOrders(FMediator.SelectedObject[grdCustomers] as TCustomer);
  grdCustomers.SetFocus;
end;

procedure TMainForm.btnQuitClicked(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.btnProductClicked(Sender: TObject);
begin
  ShowProducts;
  grdCustomers.SetFocus;
end;

procedure TMainForm.btnNewOrderClicked(Sender: TObject);
begin
  ShowNewOrder;
  grdCustomers.SetFocus;
end;

procedure TMainForm.SetupMediators;
begin
  FMediator := TtiModelMediator.Create(self);
  FMediator.AddComposite('FirstName(120);LastName(200);Phone(85,'',>)', grdCustomers);
  FMediator.Subject := FData;
  FMediator.Active := True;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  gDemoApp.CustomerList.Read;
  gDemoApp.ProductList.Read;
  FData := gDemoApp.CustomerList;
  SetupMediators;
  Log('Customer count = ' + IntToStr(FData.Count));
end;

destructor TMainForm.Destroy;
begin
  FMediator.Active := False;
  inherited Destroy;
end;

procedure TMainForm.AfterCreate;
begin
  {%region 'Auto-generated GUI code' -fold}
  {@VFD_BODY_BEGIN: MainForm}
  Name := 'MainForm';
  SetPosition(521, 216, 511, 260);
  WindowTitle := 'Demo 22: Many-to-Many';
  Hint := '';
  IconName := '';
  ShowHint := True;
  WindowPosition := wpOneThirdDown;
  OnShow := @FormShow;

  btnAdd := TfpgButton.Create(self);
  with btnAdd do
  begin
    Name := 'btnAdd';
    SetPosition(12, 8, 92, 24);
    Text := 'Add';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := 'stdimg.add';
    TabOrder := 2;
    OnClick := @btnAddClicked;
  end;

  btnEdit := TfpgButton.Create(self);
  with btnEdit do
  begin
    Name := 'btnEdit';
    SetPosition(106, 8, 92, 24);
    Text := 'Edit';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := 'stdimg.edit';
    TabOrder := 3;
    OnClick := @btnEditClicked;
  end;

  btnDelete := TfpgButton.Create(self);
  with btnDelete do
  begin
    Name := 'btnDelete';
    SetPosition(200, 8, 92, 24);
    Text := 'Delete';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := 'stdimg.remove';
    TabOrder := 4;
    OnClick := @btnDeleteClicked;
  end;

  btnHelp := TfpgButton.Create(self);
  with btnHelp do
  begin
    Name := 'btnHelp';
    SetPosition(12, 229, 24, 24);
    Anchors := [anLeft,anBottom];
    Text := '';
    FontDesc := '#Label1';
    Hint := '';
    ImageMargin := 0;
    ImageName := 'stdimg.help';
    TabOrder := 5;
    OnClick := @btnHelpClicked;
  end;

  grdCustomers := TfpgStringGrid.Create(self);
  with grdCustomers do
  begin
    Name := 'grdCustomers';
    SetPosition(10, 35, 491, 187);
    Anchors := [anLeft,anRight,anTop,anBottom];
    BackgroundColor := TfpgColor($80000002);
    FontDesc := '#Grid';
    HeaderFontDesc := '#GridHeader';
    Hint := '';
    RowCount := 0;
    RowSelect := False;
    TabOrder := 1;
  end;

  btnOrders := TfpgButton.Create(self);
  with btnOrders do
  begin
    Name := 'btnOrders';
    SetPosition(430, 10, 70, 23);
    Anchors := [anRight,anTop];
    Text := 'Orders';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 6;
    OnClick := @btnShowOrdersClicked;
  end;

  btnQuit := TfpgButton.Create(self);
  with btnQuit do
  begin
    Name := 'btnQuit';
    SetPosition(420, 230, 80, 23);
    Text := 'Quit';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 6;
    OnClick := @btnQuitClicked;
  end;

  btnProducts := TfpgButton.Create(self);
  with btnProducts do
  begin
    Name := 'btnProducts';
    SetPosition(358, 10, 70, 23);
    Text := 'Products';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 8;
    OnClick := @btnProductClicked;
  end;

  btnNewOrder := TfpgButton.Create(self);
  with btnNewOrder do
  begin
    Name := 'btnNewOrder';
    SetPosition(60, 230, 80, 23);
    Text := 'New Order';
    FontDesc := '#Label1';
    Hint := '';
    ImageName := '';
    TabOrder := 9;
    OnClick := @btnNewOrderClicked;
  end;

  {@VFD_BODY_END: MainForm}
  {%endregion}
end;


end.