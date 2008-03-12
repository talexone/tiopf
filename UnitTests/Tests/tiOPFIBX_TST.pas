unit tiOPFIBX_TST;

{$I tiDefines.inc}

interface

uses
  tiQuery_TST,
  tiQuerySQL_TST,
  tiAutoMap_TST,
  tiOID_TST,
  tiAutomapCriteria_TST;

type

  TTestTIPersistenceLayersIBX = class(TTestTIPersistenceLayers)
  public
    class function PersistenceLayerName: string; override;
  end;

  TTestTIDatabaseIBX = class(TTestTIDatabase)
  public
    class function PersistenceLayerName: string; override;
  published
    procedure DatabaseExists; override;
    procedure CreateDatabase; override;
  end;

  TTestTIQueryIBX = class(TTestTIQuerySQL)
  public
    class function PersistenceLayerName: string; override;
  end;

  TTestTIAutoMapOperationIBX = class(TTestTIAutoMapOperation)
  public
    class function PersistenceLayerName: string; override;
  end;

  TTestAutomappingCriteriaIBX = class(TTestAutomappingCriteria)
  public
    class function PersistenceLayerName: string; override;
  end;

  TTestTIOIDPersistentGUIDIBX = class(TTestTIOIDPersistentGUID)
  public
    class function PersistenceLayerName: string; override;
  end;

  TTestTIOIDPersistentIntegerIBX = class(TTestTIOIDPersistentInteger)
  public
    class function PersistenceLayerName: string; override;
  end;

procedure RegisterTests;

implementation

uses
  tiConstants,
  {$IFDEF FPC}
  tiFPCUnitUtils,
  {$ELSE}
  TestFramework,
  {$ENDIF}
  tiOPFTestManager,
  SysUtils,
  tiUtils,
  tiTestDependencies;

procedure RegisterTests;
begin
  tiRegisterPersistenceTest(TTestTIPersistenceLayersIBX);
  tiRegisterPersistenceTest(TTestTIDatabaseIBX);
  tiRegisterPersistenceTest(TTestTIQueryIBX);
  tiRegisterPersistenceTest(TTestTIOIDPersistentGUIDIBX);
  tiRegisterPersistenceTest(TTestTIOIDPersistentIntegerIBX);
  tiRegisterPersistenceTest(TTestTIAutoMapOperationIBX);
  tiRegisterPersistenceTest(TTestAutomappingCriteriaIBX);
end;

{ TTestTIDatabaseIBX }

procedure TTestTIDatabaseIBX.CreateDatabase;
var
  lDB:       string;
  lDBExists: boolean;
begin
  lDB := ExpandFileName(PerFrameworkSetup.DBName);
  lDB := tiSwapExt(lDB, 'tmp');
  if FileExists(lDB) then
  begin
    tiDeleteFile(lDB);
    if FileExists(lDB) then
      Fail('Can not remove old database file');
  end;

  Check(not FileExists(lDB), 'Database exists when it should not');
  FDatabaseClass.CreateDatabase(
    lDB,
    PerFrameworkSetup.Username,
    PerFrameworkSetup.Password);
  Check(FileExists(lDB), 'Database not created');

  lDBExists :=
    FDatabaseClass.DatabaseExists(
    lDB,
    PerFrameworkSetup.Username,
    PerFrameworkSetup.Password);

  Check(lDBExists, 'Database does not exist when it should do');
  tiDeleteFile(lDB);
end;

procedure TTestTIDatabaseIBX.DatabaseExists;
var
  lDB:       string;
  lDBExists: boolean;
begin
  SetAllowedLeakArray([504]);
  lDB       := PerFrameworkSetup.DBName;
  Check(FileExists(lDB), 'Database file not found so test can not be performed');
  lDBExists :=
    FDatabaseClass.DatabaseExists(
    PerFrameworkSetup.DBName,
    PerFrameworkSetup.Username,
    PerFrameworkSetup.Password);
  Check(lDBExists, 'DBExists returned false when it should return true');
  Check(not FileExists(lDB + 'Tmp'), 'Database file found so test can not be performed');
  lDBExists :=
    FDatabaseClass.DatabaseExists(
    PerFrameworkSetup.DBName + 'Tmp',
    PerFrameworkSetup.Username,
    PerFrameworkSetup.Password);
  Check(not lDBExists, 'DBExists returned true when it should return false');
end;

class function TTestTIDatabaseIBX.PersistenceLayerName: string;
begin
  Result := cTIPersistIBX;
end;

{ TTestTIPersistenceLayersIBX }

class function TTestTIPersistenceLayersIBX.PersistenceLayerName: string;
begin
  Result := cTIPersistIBX;
end;

{ TTestTIQueryIBX }

class function TTestTIQueryIBX.PersistenceLayerName: string;
begin
  Result := cTIPersistIBX;
end;

{ TTestTIAutoMapOperationIBX }

class function TTestTIAutoMapOperationIBX.PersistenceLayerName: string;
begin
  Result := cTIPersistIBX;
end;

{ TTestAutomappingCriteriaIBX }

class function TTestAutomappingCriteriaIBX.PersistenceLayerName: string;
begin
  Result := cTIPersistIBX;
end;

{ TTestTIOIDPersistentGUIDIBX }

class function TTestTIOIDPersistentGUIDIBX.PersistenceLayerName: string;
begin
  Result := cTIPersistIBX;
end;

{ TTestTIOIDPersistentIntegerIBX }

class function TTestTIOIDPersistentIntegerIBX.PersistenceLayerName: string;
begin
  Result := cTIPersistIBX;
end;

end.
