unit tiQueryZeosAbs;

{$I tiDefines.inc}

interface

uses
   tiQuery
  ,tiQueryDataset
  ,Classes
  ,DB
  ,ZConnection
  ,ZDataset
  ;

type

  TtiDatabaseZeosAbs = class( TtiDatabaseSQL )
  private
    FConnection    : TZConnection;
  protected
    procedure SetConnected( pbValue : boolean ) ; override;
    function  GetConnected : boolean ; override ;
    procedure SetupDBParams ; virtual ; abstract ;
  public
    constructor Create ; override ;
    destructor  Destroy ; override ;
    procedure   StartTransaction ; override ;
    function    InTransaction : boolean ; override ;
    procedure   Commit ; override ;
    procedure   RollBack ; override ;
    function    Test : boolean; override;
    function    TIQueryClass: TtiQueryClass; override;
    property    Connection : TZConnection read FConnection write FConnection ;
  end;


  TtiQueryZeos = class( TtiQueryDataset )
  private
    FQuery : TZQuery ;
    FCompatParams: TParams;
    procedure SyncZeosParamsToCompat;
    procedure SyncCompatToZeosParams;
    procedure Prepare;
  protected
    procedure   CheckPrepared; override;
    function    GetSQL: TStrings; override ;
    procedure   SetSQL(const Value: TStrings); override ;
    procedure   SetActive(const Value: boolean); override ;
  public
    constructor Create ; override ;
    destructor  Destroy ; override ;
    function    ExecSQL: integer; override;
    procedure   AttachDatabase( pDatabase : TtiDatabase ) ; override ;
    procedure   DetachDatabase ;  override ;
    procedure   Reset ; override ;
    function    HasNativeLogicalType : boolean ; override ;
  end;


implementation

uses
  tiConstants
  ,tiLog
  ,tiUtils
  ,tiExcept
  ,SysUtils
  ,TypInfo
  ;


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// *
// * TtiQueryZeos
// *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
constructor TtiQueryZeos.Create;
begin
  inherited Create;
  FQuery := TZQuery.Create( nil ) ;
  FCompatParams := TParams.Create;
  Dataset := FQuery;
  Params := FCompatParams;
  SyncZeosParamsToCompat;
  FSupportsRowsAffected := True;
end;

destructor TtiQueryZeos.Destroy;
begin
  Params := nil;
  Dataset := nil;
  FCompatParams.Free;
  FQuery.Free ;
  inherited Destroy;
end;

procedure TtiQueryZeos.SyncZeosParamsToCompat;
begin
  FCompatParams.Clear;
  FQuery.Params.AssignTo(FCompatParams);
end;

procedure TtiQueryZeos.SyncCompatToZeosParams;
var
  I: Integer;
  LParam: TParam;
begin
  for I := 0 to FCompatParams.Count - 1 do
  begin
    LParam := FCompatParams[I];
    if FQuery.Params.FindParam(LParam.Name) <> nil then
      FQuery.Params.ParamByName(LParam.Name).Assign(LParam);
  end;
end;

function TtiQueryZeos.ExecSQL: integer;
begin
  Prepare;
  LogParams;
  if Pos('RETURNING', UpperCase(FQuery.SQL.Text)) <> 0 then
    FQuery.Open
  else
    FQuery.ExecSQL;
  SyncZeosParamsToCompat;
  Result := FQuery.RowsAffected;
end;

procedure TtiQueryZeos.Prepare;
begin
  SyncCompatToZeosParams;
  if FQuery.Prepared then
    Exit; // ==>
  FQuery.Prepare;
end;

procedure TtiQueryZeos.CheckPrepared;
begin
  inherited CheckPrepared;
  Prepare;
end;

function TtiQueryZeos.GetSQL: TStrings;
begin
  Result := FQuery.SQL ;
end;

procedure TtiQueryZeos.SetActive(const Value: boolean);
begin
  Assert(Database.TestValid(TtiDatabase), 'Database is not valid');
  if Value then
  begin
    SyncCompatToZeosParams;
    FQuery.Open;
    SyncZeosParamsToCompat;
  end
  else
  begin
    FQuery.Close;
  end;
end;

procedure TtiQueryZeos.SetSQL(const Value: TStrings);
begin
  FQuery.SQL.Assign( Value ) ;
  SyncZeosParamsToCompat;
end;

procedure TtiQueryZeos.AttachDatabase(pDatabase: TtiDatabase);
begin
  inherited AttachDatabase(pDatabase);
  if (pDatabase is TtiDatabaseZeosAbs) then
  begin
    FQuery.Connection := TtiDatabaseZeosAbs( pDatabase ).Connection;
  end;
end;

procedure TtiQueryZeos.DetachDatabase;
begin
  inherited DetachDatabase;
  if FQuery.Active then
     FQuery.Close;
  FQuery.Connection := Nil;
end;

procedure TtiQueryZeos.Reset;
begin
  Active := False;
  FQuery.SQL.Clear;
  FCompatParams.Clear;
  //FQuery.Params.Clear;
end;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// *
// * TtiDatabaseZeosAbs
// *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
constructor TtiDatabaseZeosAbs.Create;
begin
  inherited Create ;
  FConnection := TZConnection.Create( nil ) ;
  FConnection.LoginPrompt := false ;
end;

destructor TtiDatabaseZeosAbs.Destroy;
begin
  FConnection.Free;
  inherited;
end;

procedure TtiDatabaseZeosAbs.Commit;
begin
  if not InTransaction then
    raise EtiOPFInternalException.Create( 'Attempt to commit but not in a transaction.');

  FConnection.Commit ;
end;

function TtiDatabaseZeosAbs.InTransaction: boolean;
begin
  result := FConnection.InTransaction ;
end;

procedure TtiDatabaseZeosAbs.RollBack;
begin
  FConnection.RollBack ;
end;

procedure TtiDatabaseZeosAbs.StartTransaction;
begin
  if InTransaction then
    raise EtiOPFInternalException.Create(
      'Attempt to start a transaction but transaction already exists.');
  FConnection.StartTransaction ;
end;

function TtiDatabaseZeosAbs.GetConnected: boolean;
begin
  Result := FConnection.Connected ;
end;

procedure TtiDatabaseZeosAbs.SetConnected(pbValue: boolean);
var
  lsErrorMessage : string ;
begin

  if ( not pbValue ) then
  begin
    Log( 'Disconnecting from %s', [DatabaseName] ) ;
    FConnection.Connected := false ;
    Exit ; //==>
  end ;

  SetupDBParams ;
  lsErrorMessage := '' ;
  try
    FConnection.Connected := true ;
  except
    on e: EDatabaseError do
    begin
      lsErrorMessage := 'Error attempting to connect to database.' + Cr + e.Message;
      raise EtiOPFDBExceptionUserNamePassword.Create(
        cTIPersistZeosFB, DatabaseName, UserName, Password, lsErrorMessage);
    end;
    on e:exception do
      raise EtiOPFDBExceptionCanNotConnect.Create( 'Unknown', DatabaseName, UserName, Password, e.message ) ;
  end ;
end;

function TtiQueryZeos.HasNativeLogicalType: boolean;
begin
  result := false ;
end;

function TtiDatabaseZeosAbs.Test: boolean;
begin
  Result := Connected;
end;

function TtiDatabaseZeosAbs.TIQueryClass: TtiQueryClass;
begin
  result:= TtiQueryZeos;
end;

end.
