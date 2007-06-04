unit Client_BOM;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}

interface
uses
  tiObject
  ,tiOID
  ,tiOIDGUID
  ;

const
  cErrorClientName   = 'Please enter a client name' ;
  cErrorAdrsText     = 'Please enter an address' ;
  cErrorAdrsLocality = 'Please enter an address locality' ;
  cErrorAdrsState    = 'Please enter an address state' ;
  cErrorAdrsPostCode = 'Please enter a post code' ;

type
  { forward declarations }
  TClient  = class ;
  TClients = class ;
  TAdrs    = class ;

  TClients = class( TtiObjectList ) ;

  TClient = class( TtiObject )
  private
    FClientName: string;
    FAdrs: TAdrs;
  protected
    procedure   AssignClassProps(pSource: TtiObject); override ;
  public
    constructor Create ; override ;
    destructor  Destroy ; override ;
    constructor CreateNew( const pDatabaseName : string = '' ; const pPerLayerName : string = '' ) ; override ;
    function    IsValid( const pErrors : TPerObjErrors ) : boolean ; override ;
  published
    property    ClientName : string read FClientName write FClientName ;
    property    Adrs       : TAdrs read FAdrs ;
  end ;

  TAdrs = class( TtiObject )
  private
    FAdrsText: string ;
    FLocality: string;
    FState   : string;
    FPostCode: string;
    function    GetAsOneLine: string;
  protected
    function    GetOID : TOID ; override ;
  public
    function    IsValid( const pErrors : TPerObjErrors ) : boolean ; override ;
  published
    property    AdrsText         : string     read FAdrsText write FAdrsText ;
    property    Locality         : string     read FLocality write FLocality ;
    property    State            : string     read FState    write FState ;
    property    PostCode         : string     read FPostCode write FPostCode ;
    property    AsOneLine        : string     read GetAsOneLine ;
  end ;


procedure RegisterMappings ;


implementation
uses
  tiOPFManager
  ,tiClassToDBMap_BOM
  ,tiConstants
  ;


procedure RegisterMappings ;
begin
  //                                              Class,    Table,    Property,     Column,       Special Info
  gTIOPFManager.ClassDBMappingMgr.RegisterMapping(TClient,  'Client', 'OID',        'OID',        [pktDB] );
  gTIOPFManager.ClassDBMappingMgr.RegisterMapping(TClient,  'Client', 'ClientName', 'Client_Name'         );
  gTIOPFManager.ClassDBMappingMgr.RegisterCollection(TClients, TClient);

  gTIOPFManager.ClassDBMappingMgr.RegisterMapping(TAdrs,    'Adrs',   'OID',        'OID',        [pktDB, pktFK] );
  gTIOPFManager.ClassDBMappingMgr.RegisterMapping(TAdrs,    'Adrs',   'AdrsText',   'Adrs_Text');
  gTIOPFManager.ClassDBMappingMgr.RegisterMapping(TAdrs,    'Adrs',   'Locality',   'Locality' );
  gTIOPFManager.ClassDBMappingMgr.RegisterMapping(TAdrs,    'Adrs',   'State',      'State' );
  gTIOPFManager.ClassDBMappingMgr.RegisterMapping(TAdrs,    'Adrs',   'PostCode',   'Post_Code' );
end ;

{ TClient }

procedure TClient.AssignClassProps(pSource: TtiObject);
begin
  Adrs.Assign(( pSource as TClient ).Adrs ) ;
end;


constructor TClient.Create;
begin
  inherited;
  FAdrs := TAdrs.Create ;
  FAdrs.Owner := Self ;
end;


constructor TClient.CreateNew(const pDatabaseName : string = '' ; const pPerLayerName : string = '');
begin
  inherited;
  FAdrs.OID.GetNextValue(pDatabaseName, pPerLayerName) ;
  FAdrs.ObjectState := posCreate ;
end;


destructor TClient.Destroy;
begin
  FAdrs.Free ;
  inherited;
end;


function TClient.IsValid(const pErrors: TPerObjErrors): boolean;
begin
  inherited IsValid( pErrors ) ;
  if ClientName = '' then
    pErrors.AddError( 'ClientName', cErrorClientName ) ;

  Adrs.IsValid(pErrors);

  result := pErrors.Count = 0 ;
end;


{ TAdrs }

function TAdrs.GetAsOneLine: string;
begin
  result :=
    AdrsText + ', ' + Locality + ' ' +
    State + '  ' + PostCode;
end;


function TAdrs.GetOID: TOID;
begin
  Assert(Owner.TestValid, cTIInvalidObjectError);
  result := Owner.OID;
end;


function TAdrs.IsValid(const pErrors: TPerObjErrors): boolean;
begin
  // Do not call inherited, because we do not want to clear pErrors
  if AdrsText = '' then
    pErrors.AddError( 'AdrsText', cErrorAdrsText ) ;

  if Locality = '' then
    pErrors.AddError( 'Locality', cErrorAdrsLocality ) ;

  if State = '' then
    pErrors.AddError( 'State', cErrorAdrsState ) ;

  if PostCode = '' then
    pErrors.AddError( 'State', cErrorAdrsPostCode ) ;

  result := pErrors.Count = 0 ;
end;


end.
