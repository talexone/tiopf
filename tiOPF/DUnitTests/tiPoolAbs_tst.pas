{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  The contents of this file are subject to the Mozilla Public
  License Version 1.1 (the "License"); you may not use this file
  except in compliance with the License. You may obtain a copy of
  the License at http://www.mozilla.org/MPL/

  Software distributed under the License is distributed on an "AS
  IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
  implied. See the License for the specific language governing
  rights and limitations under the License.

  Originally developed and released by Peter Hinrichsen, TechInsite Pty. Ltd.
  as the tiOPF (TechInsite Object Persistence Framework)

    23 Victoria Pde, Collingwood, Melbourne, Victoria 3066 Australia
    PO Box 429, Abbotsford, Melbourne, Victoria 3067 Australia
    Phone: +61 3 9419 6456 Fax:   +61 3 9419 1682
    Latest source:   www.techinsite.com.au/tiOPF/Download.htm
    Documentation:   www.techinsite.com.au/tiOPF/Doc/
    Support:         www.techinsite.com.au/tiOPF/MailingList.htm

  Please submit changes to tiOPF@techinsite.com.au

  Revision history:
    June, 2002, Peter Hinrichsen, Created
  Purpose:

  ToDo:

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit tiPoolAbs_tst;

interface
uses
  TestFrameWork
  ,tiPoolAbs
  ,tiObjAbs
  ,Classes
  ,Contnrs
  ;

type

  TTestPoolItemData = class( TtiObjAbs ) ;

  TThresPoolThread = class( TThread )
  private
    FItemCount: integer;
    FPool: TtiPool;
    FItemList : TObjectList ;
    procedure LockItems ;
    procedure UnLockItems;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor  Destroy ; override ;
    property    Pool : TtiPool read FPool write FPool ;
    property    ItemCount : integer read FItemCount write FItemCount ;
    procedure   Execute ; override ;
  end;

  TTestTiPoolAbs = class( TTestCase )
  private
    procedure DoOnAddItem( pPooledItem : TPooledItem );
    procedure CheckCountInPool(const pPool: TtiPool; pCount, pCountLocked: integer; pTestID: string);
    procedure DoLock_Unlock(pCount: integer);
    procedure DoLock_UnLockData(pCount: integer);
  published
    procedure Lock_Unlock_1 ;
    procedure Lock_UnLockData_1 ;
    procedure Lock_UnLockData_BadData ;
    procedure Lock_Unlock_10;
    procedure Lock_UnLockData_10;
    procedure Lock_UnLock_Threaded;
    procedure MinPoolSize;
    procedure MaxPoolSize;
    procedure TimeOut;
  end ;

procedure RegisterTests ;

implementation
uses
  tiDUnitDependencies
  ,Windows
  ,SysUtils
  ,tiDialogs
  ,Forms
  ;

const
  cThreadCount = 10 ;
  cThreadItemCount = 10 ;

procedure RegisterTests ;
begin
  if gPerFrameworkSetupFactory.TestNonPersistentClasses then
    RegisterTest( TTestTIPoolAbs.Suite );
end ;

{ TTestTiPoolAbs }

procedure TTestTiPoolAbs.DoOnAddItem(pPooledItem: TPooledItem);
begin
  pPooledItem.Data := TTestPoolItemData.Create ;
end;

procedure TTestTiPoolAbs.DoLock_Unlock(pCount : integer);
var
  lPool : TtiPool ;
  lItem : TPooledItem ;
  lList : TObjectList ;
  i     : integer ;
begin
  lPool := TtiPool.Create ;
  try
    lList := TObjectList.Create(false) ;
    try
      lPool.OnAddPooledItem := DoOnAddItem;
      for i := 1 to pCount do
      begin
        lItem := lPool.Lock ;
        CheckCountInPool(lPool,i,i, IntToStr(i));
        lList.Add(lItem);
      end;
      for i := 0 to pCount - 1 do
      begin
        lPool.UnLock(lList.Items[i] as TPooledItem);
        CheckCountInPool(lPool,pCount,pCount-i-1, IntToStr(pCount-i));
      end ;
    finally
      lList.Free;
    end;
  finally
    lPool.Free ;
  end;
end;

procedure TTestTiPoolAbs.DoLock_UnLockData(pCount : integer);
var
  lPool : TtiPool ;
  lItem : TPooledItem ;
  lData : TTestPoolItemData ;
  lList : TObjectList ;
  i     : integer ;
begin
  lPool := TtiPool.Create ;
  try
    lList := TObjectList.Create(false) ;
    try
      lPool.OnAddPooledItem := DoOnAddItem;
      for i := 1 to pCount do
      begin
        lItem := lPool.Lock ;
        lData := lItem.Data as TTestPoolItemData;
        CheckCountInPool(lPool,i,i, IntToStr(i));
        lList.Add(lData);
      end;
      for i := 0 to pCount - 1 do
      begin
        lPool.UnLockByData(lList.Items[i]);
        CheckCountInPool(lPool,pCount,pCount-i-1, IntToStr(pCount-i));
      end ;
    finally
      lList.Free;
    end;
  finally
    lPool.Free ;
  end;
end;

procedure TTestTiPoolAbs.Lock_Unlock_1;
begin
  DoLock_Unlock(1);
  DoLock_Unlock(1);
end;

procedure TTestTiPoolAbs.Lock_UnLockData_1;
begin
  DoLock_UnLockData(1);
  DoLock_UnLockData(1);
end;

procedure TTestTiPoolAbs.Lock_Unlock_10;
begin
  DoLock_Unlock(10);
  DoLock_Unlock(10);
end;

procedure TTestTiPoolAbs.Lock_UnLockData_10;
begin
  DoLock_UnLockData(10);
  DoLock_UnLockData(10);
end;

procedure TTestTiPoolAbs.Lock_UnLock_Threaded;
var
  lPool : TtiPool ;
  i : integer ;
  lThrd : TThresPoolThread ;
  lList : TObjectList ;
begin
  lList := TObjectList.Create(true) ;
  try
    lPool := TtiPool.Create ;
    try
      lPool.OnAddPooledItem := DoOnAddItem;
      for i := 1 to cThreadCount do
      begin
        lThrd := TThresPoolThread.Create(true) ;
        lThrd.ItemCount := cThreadItemCount ;
        lThrd.Pool := lPool;
        lList.Add(lThrd);
        lThrd.Resume ;
        Sleep(50);
      end;

      for i := 0 to lList.Count - 1 do
        TThread(lList.Items[i]).WaitFor ;
        
    finally
      lPool.Free;
    end;
  finally
    lList.Free;
  end;
end;

procedure TTestTiPoolAbs.MaxPoolSize;
var
  lPool : TtiPool ;
begin
  lPool := TtiPool.Create ;
  try
    lPool.OnAddPooledItem := DoOnAddItem;
    lPool.WaitTime := 1 ;
    lPool.MaxPoolSize := 1 ;
    lPool.Lock ;
    try
      lPool.Lock ;
      Fail('Exception not raised when it should have been' ) ;
    except
      on e:exception do
      begin
        CheckIs( e, Exception, 'Wrong class of exception' ) ;
        Check( Pos('Timed out waiting for a PooledItem', e.message ) <> 0,
               'Wrong error message' ) ;
      end;
    end;
  finally
    lPool.Free ;
  end;
end;

procedure TTestTiPoolAbs.MinPoolSize;
var
  lPool : TtiPool ;
  lItem1 : TPooledItem ;
  lItem2 : TPooledItem ;
begin
  lPool := TtiPool.Create ;
  try
    lPool.OnAddPooledItem := DoOnAddItem;
    lPool.TimeOut := 0 ;
    lPool.MinPoolSize := 1 ;

    lItem1 := lPool.Lock ;
    lItem2 := lPool.Lock ;
    Check( lItem1 <> lItem2, 'Items should not be same' ) ;

    lPool.UnLock(lItem1);
    lPool.UnLock(lItem2);
    Sleep(1000);
    lPool.SweepForTimeOuts;

    lItem2 := lPool.Lock ;
    Check(lItem1 = lItem2, 'Items should be same' ) ;

  finally
    lPool.Free ;
  end;
end;

procedure TTestTiPoolAbs.CheckCountInPool(const pPool : TtiPool ; pCount, pCountLocked : integer ; pTestID : string ) ;
var
  lCount : integer ;
  lCountLocked : integer ;
begin
  lCount := pPool.Count ;
  lCountLocked := pPool.CountLocked ;
  CheckEquals( pCount, lCount, 'Count ' + pTestID ) ;
  CheckEquals( pCountLocked, lCountLocked, 'CountLocked ' + pTestID ) ;
end;

procedure TTestTiPoolAbs.TimeOut;
var
  lPool : TtiPool ;
  lItem2 : TPooledItem ;
  lItem3 : TPooledItem ;
begin
  lPool := TtiPool.Create ;
  try

    lPool.OnAddPooledItem := DoOnAddItem;
    lPool.TimeOut := 1/60 ;

    lPool.Lock ;
    lPool.SweepForTimeOuts ;
    CheckCountInPool( lPool, 1, 1, 'Test #1' ) ;

    lItem2 := lPool.Lock ;
    lPool.SweepForTimeOuts ;
    CheckCountInPool( lPool, 2, 2, 'Test #2' ) ;

    lPool.UnLock(lItem2);
    Sleep(2000);
    lPool.SweepForTimeOuts ;
    CheckCountInPool( lPool, 1, 1, 'Test #3' ) ;

    lItem3 := lPool.Lock ;
    lPool.SweepForTimeOuts ;
    CheckCountInPool( lPool, 2, 2, 'Test #4' ) ;

    lPool.UnLock(lItem3);
    CheckCountInPool( lPool, 2, 1, 'Test #5' ) ;

    Sleep(2000);
    lPool.SweepForTimeOuts ;
    CheckCountInPool( lPool, 1, 1, 'Test #6' ) ;

  finally
    lPool.Free ;
  end;
end;

procedure TTestTiPoolAbs.Lock_UnLockData_BadData;
var
  lPool : TtiPool ;
  lData : TTestPoolItemData ;
begin
  lPool := TtiPool.Create ;
  try
    lPool.OnAddPooledItem := DoOnAddItem;
    lPool.Lock ;
    CheckCountInPool(lPool,1,1, '1' );
    lData := TTestPoolItemData.Create ;
    try
      try
        lPool.UnLockByData(lData);
        Fail('Exception not raised when it should have been');
      except
        on e:exception do
        begin
          CheckIs( e, Exception, 'Wrong class of exception' ) ;
          Check( Pos( cErrorPoolUnlockByData_BadData, e.Message ) <> 0, 'Wrong error message' ) ;
        end;
      end;
    finally
      lData.Free;
    end ;
  finally
    lPool.Free ;
  end;
end;

{ TThresPoolThread }

constructor TThresPoolThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate := false ;
  FItemList := TObjectList.Create(false) ;
end;

destructor TThresPoolThread.Destroy;
begin
  FItemList.Free;
  inherited;
end;

procedure TThresPoolThread.Execute;
begin
  LockItems;
  UnLockItems;
end;

procedure TThresPoolThread.LockItems;
var
  lItem : TPooledItem ;
  i     : integer ;
begin
  for i := 1 to FItemCount do
  begin
    lItem := Pool.Lock ;
    FItemList.Add(lItem);
    Sleep(100);
  end;
end;

procedure TThresPoolThread.UnLockItems;
var
  i     : integer ;
begin
  for i := 0 to FItemCount - 1 do
  begin
    Pool.UnLock(FItemList.Items[i] as TPooledItem);
    Sleep(100);
  end ;
end;

end.
