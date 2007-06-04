unit FtiAdrsListMain;

{$I tiDefines.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ComCtrls, tiListView,
  tiTreeView, ExtCtrls, ToolWin
  ,Adrs_BOM, ActnList, Menus, ImgList, tiFocusPanel
  ;

type
  TFormMain = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    aNew: TAction;
    aDelete: TAction;
    aSave: TAction;
    aCancel: TAction;
    aClose: TAction;
    aNew1: TMenuItem;
    aSave1: TMenuItem;
    aDelete1: TMenuItem;
    N3: TMenuItem;
    aClose1: TMenuItem;
    ilButtons: TImageList;
    TV: TtiTreeView;
    aShowObjects: TAction;
    Utils1: TMenuItem;
    ShowObjects1: TMenuItem;
    StatusBar1: TStatusBar;
    aShowDatabaseConnectionDetails: TAction;
    About1: TMenuItem;
    Showdatabaseconnectiondetails1: TMenuItem;
    ilTreeView: TImageList;
    aCloneCurrentObject: TAction;
    N4: TMenuItem;
    Clonethecurrentobject1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TVClose(Sender: TObject);
    procedure TVSave(Sender: TObject);
    procedure TVCancel(Sender: TObject);
    procedure aNewExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;var Handled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TVSelectNode(ptiTreeView: TtiTreeView; pNode: TTreeNode;
      pData: TObject; pParentNode: TTreeNode; pParentData: TObject);
    procedure aShowObjectsExecute(Sender: TObject);
    procedure tiTVMappingPersonOnDelete(ptiTreeView: TtiTreeView;
      pNode: TTreeNode; pData: TObject; pParentNode: TTreeNode;
      pParentData: TObject);
    procedure tiTVMappingPersonOnInsert(ptiTreeView: TtiTreeView;
      pNode: TTreeNode; pData: TObject; pParentNode: TTreeNode;
      pParentData: TObject);
    procedure tiTVMappingPersonListOnInsert(ptiTreeView: TtiTreeView;
      pNode: TTreeNode; pData: TObject; pParentNode: TTreeNode;
      pParentData: TObject);
    procedure TVFilterData(pData: TObject; var pbInclude: Boolean);
    procedure aShowDatabaseConnectionDetailsExecute(Sender: TObject);
    procedure tiTVMappingCompanyListOnInsert(ptiTreeView: TtiTreeView;
      pNode: TTreeNode; pData: TObject; pParentNode: TTreeNode;
      pParentData: TObject);
    procedure tiTVMappingCompanyOnInsert(ptiTreeView: TtiTreeView;
      pNode: TTreeNode; pData: TObject; pParentNode: TTreeNode;
      pParentData: TObject);
    procedure aCloneCurrentObjectExecute(Sender: TObject);
  private
    procedure Read ;
    procedure Save ;
    procedure AddPerson(pPersonList: TPeople);
    procedure AddCompany(pCompanyList: TCompanies);
  public
  end;

var
  FormMain: TFormMain;

implementation
uses
   FtiAdrsListChild_Person
  ,FtiAdrsListChild_Company
  ,tiOPFManager
  ,cAdrs
  ,tiVisitorDB
  ,tiUtils
  ,tiDialogs
  ,tiRegINI
  ,tiObject
  ;

{$R *.DFM}

// Form's OnCreate event
//------------------------------------------------------------------------------
procedure TFormMain.FormCreate(Sender: TObject);
begin
  TV.Align := alClient ;
  Caption := 'TI Persistence Framework - ' + gtiOPFManager.DefaultDBConnectionName ;
  gReg.ReadFormState( Self ) ;
//  TV.RegisterChildForm( TPerson,  TFormEditPerson ) ;
//  TV.RegisterChildForm( TCompany, TFormEditCompany ) ;
  Read ;
  TV.SelectedAddress := gReg.ReadString( Name, 'SelectedAddress', '' ) ;
end;

// Form's OnDestroy event
//------------------------------------------------------------------------------
procedure TFormMain.FormDestroy(Sender: TObject);
begin
  gReg.WriteFormState( Self ) ;
  gReg.WriteString( Name, 'SelectedAddress', TV.SelectedAddress ) ;
end;

// Create a TAddressBook object and read it's primary key data
//------------------------------------------------------------------------------
procedure TFormMain.Read ;
begin
  TV.Data := nil ;
  gAdrsBook.Clear ;
  gAdrsBook.Read ;
  TV.Data := gAdrsBook ;
end;

// Form's CloseQuery event
//------------------------------------------------------------------------------
procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  if tiPerObjAbsSaveAndClose( gAdrsBook, CanClose ) then
//    Save ;
end;

// TtiTreeViewPlus close action
//------------------------------------------------------------------------------
procedure TFormMain.TVClose(Sender: TObject);
begin
  Close ;
end;

// TtiTreeViewPlus save event
//------------------------------------------------------------------------------
procedure TFormMain.TVSave(Sender: TObject);
begin
//  if not TV.IsCurrentChildFormValid then
//    exit ; //==>
//
//  if not gAdrsBook.Dirty then
//    exit ; //==>
//
//  Save ;

end;

// TtiTreeViewPlus Cancel event
//------------------------------------------------------------------------------
procedure TFormMain.TVCancel(Sender: TObject);
begin
  Read ;
end;

// ActionList's New event
//------------------------------------------------------------------------------
procedure TFormMain.aNewExecute(Sender: TObject);
begin
//  TV.DoInsert ;
end;

// ActionList's Delete event
//------------------------------------------------------------------------------
procedure TFormMain.aDeleteExecute(Sender: TObject);
begin
//  TV.DoDelete
end;

// ActionList's OnUpdate event
//------------------------------------------------------------------------------
procedure TFormMain.ActionList1Update(Action: TBasicAction; var Handled: Boolean);
begin
//  aNew.Enabled    := TV.CanInsertSelected ;
//  aDelete.Enabled := TV.CanDeleteSelected ;
//
//  aSave.Enabled   := gAdrsBook.Dirty ;
//  aCancel.Enabled := aSave.Enabled ;
//  aClose.Enabled  := true ;
//  aShowObjects.Enabled := ( TV.SelectedData <> nil ) ;
//  aCloneCurrentObject.Enabled :=
//    aShowObjects.Enabled and
//    ( not ( TV.SelectedData is TAdrsBook )) ;

end;

// When a node on the TtiTreeViewPlus is selected, this event is triggered.
// Read the detailed data associated with the node's data.
//------------------------------------------------------------------------------
procedure TFormMain.TVSelectNode(ptiTreeView: TtiTreeView;
  pNode: TTreeNode; pData: TObject; pParentNode: TTreeNode;
  pParentData: TObject);
begin
{
  if pData is TPerson then
    gTIOPFManager.Read( TPerson( pData ))
  else
  if pData is TCompany then
    gTIOPFManager.Read( TCompany( pData )) ;
}
end;

procedure TFormMain.aShowObjectsExecute(Sender: TObject);
begin
//  tiShowPerObjAbs( TtiObject( TV.SelectedData ), true ) ;
end;

procedure TFormMain.tiTVMappingPersonOnDelete(ptiTreeView: TtiTreeView;
  pNode: TTreeNode; pData: TObject; pParentNode: TTreeNode;
  pParentData: TObject);
begin
//  if not (( pData is TPerson ) or
//          ( pData is TCompany )) then
//    Exit ; //==>
//  if tiAppConfirmation( 'Are you sure you want to delete <%s> ?',
//                        [TtiObject( pData ).Caption] ) then
//    TtiObject( pData ).Deleted := true ;
end;

procedure TFormMain.tiTVMappingPersonOnInsert( ptiTreeView: TtiTreeView;
                                               pNode: TTreeNode;
                                               pData: TObject;
                                               pParentNode: TTreeNode;
                                               pParentData: TObject);
begin
  if TObject( pParentNode.Data ) is TPeople then
    AddPerson( TPeople( pParentNode.Data ))
  else
    AddPerson( TCompany( pParentNode.Data ).People ) ;
end ;

procedure TFormMain.AddPerson( pPersonList : TPeople ) ;
var
  lData       : TPerson ;
begin
  lData := TPerson.CreateNew;
  lData.FirstName := 'Enter' ;
  lData.LastName  := 'Enter' ;
  pPersonList.Add( lData ) ;
end;

procedure TFormMain.tiTVMappingPersonListOnInsert(ptiTreeView: TtiTreeView;
  pNode: TTreeNode; pData: TObject; pParentNode: TTreeNode;
  pParentData: TObject);
begin
  AddPerson( pData as TPeople ) ;
end;

procedure TFormMain.TVFilterData(pData: TObject; var pbInclude: Boolean);
begin
//  pbInclude := not TtiObject( pData ).Deleted ;
end;


procedure TFormMain.aShowDatabaseConnectionDetailsExecute(Sender: TObject);
var
  ls : string ;
begin
//  ls := gTIOPFManager.DefaultPerLayer.DBConnectionPools.DetailsAsString ;
//  tiShowMessage( ls ) ;
end;

procedure TFormMain.AddCompany( pCompanyList : TCompanies ) ;
var
  lData       : TCompany ;
begin
  lData := TCompany.CreateNew;
  lData.CompanyName := 'Enter' ;
  pCompanyList.Add( lData ) ;
end;

procedure TFormMain.tiTVMappingCompanyListOnInsert(
  ptiTreeView: TtiTreeView; pNode: TTreeNode; pData: TObject;
  pParentNode: TTreeNode; pParentData: TObject);
begin
  AddCompany( pData as TCompanies ) ;
end;

procedure TFormMain.tiTVMappingCompanyOnInsert(ptiTreeView: TtiTreeView;
  pNode: TTreeNode; pData: TObject; pParentNode: TTreeNode;
  pParentData: TObject);
const
  cEmployee = '&Employee' ;
  cCompany  = '&Company' ;
  cCancel   = 'C&ancel' ;
var
  ls : string ;
begin
  ls := tiMessageDlg( 'Do you want to add an employee of ' +
                      ( pData as TCompany ).CompanyName + ' or a new company?',
                      [cEmployee, cCompany, cCancel],
                      mtConfirmation,
                      'What do you want to add?' ) ;
  if ls = cEmployee then
    AddPerson( ( pData as TCompany ).People )
  else if ls = cCompany then
    AddCompany( ( pParentData as TCompanies )) ;

end;

procedure TFormMain.Save;
begin
  gAdrsBook.Save ;
end;

procedure TFormMain.aCloneCurrentObjectExecute(Sender: TObject);
//var
//  lPerson : TtiObject ;
//  ls : string ;
begin
//  lPerson := TtiObject( TV.SelectedData ).Clone ;
//  ls :=
//        '* * * CLONE FROM * * *' + Cr( 2 ) +
//        tiPerObjAbsAsString( TtiObject( TV.SelectedData )) + Cr( 2 ) +
//        '* * * CLONE TO * * *' + Cr( 2 ) +
//        tiPerObjAbsAsString( lPerson );
//  tiShowString( ls ) ;
//  // There is some code in the TtiTreeView which makes it easy to use
//  // drag-and-drop to clone objects and this can be seen in use in the
//  // tiSQLManager application.
//  // Before these objects can be saved, they must be given new OIDs and
//  // their ObjectState must be set to posCreate. This can be done with a
//  // visitor.
end;

end.

