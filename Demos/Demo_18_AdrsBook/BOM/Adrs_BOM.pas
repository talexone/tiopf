unit Adrs_BOM;

{.$I tiDefines.inc}

interface
uses
  tiObject,
  Classes,
  tiOID,
  AdrsType_BOM;

const
  CErrorPersonNameNotAssigned = 'Please enter the person''s name';
  CErrorAdrsAbsAdrsTypeNotAssigned = 'Address type not assigned';
  CErrorAdrsAddressNotAssigned = 'Address details not assigned';
  CErrorEAdrsTextNotAssigned = 'E-Address details not assigned';

type

  TAdrsBook = class;
  TPersonList = class;
  TPerson         = class;
  TAddressList       = class;
  TEAddressList      = class;
  TAdrsAbs        = class;
  TAdrs           = class;
  TEAdrs          = class;

  // The TAdrsBook class. Top of the tree of the Address Book BOM
  TAdrsBook = class(TtiObject)
  private
    FPeople   : TPersonList   ;
    FAdrsTypeList: TAdrsTypeList;
    FEAdrsTypeList: TEAdrsTypeList;
  protected
    procedure   SetDeleted(const Value: boolean); override;
  published
    property    People   : TPersonList read FPeople;
    property    EAdrsTypeList: TEAdrsTypeList read FEAdrsTypeList;
    property    AdrsTypeList: TAdrsTypeList read FAdrsTypeList;
  public
    constructor Create; override;
    destructor  Destroy; override;
    procedure   Read; override;
  end;

  TAdrsBookItemAbs = class(TtiObject)
  private
    FAddressList : TAddressList;
    FEAddressList: TEAddressList;
    FNotes: string;
  protected
    procedure   AssignClassProps(ASource: TtiObject); override;
  public
    constructor Create; override;
    destructor  Destroy; override;
    procedure   Save; override;
    procedure   Read; override;
  published
    property EAddressList: TEAddressList read FEAddressList;
    property AddressList : TAddressList  read FAddressList;
    property Notes: string read FNotes write FNotes;
  end;

  // TPerson class. Holds information about a person
  TPerson = class(TAdrsBookItemAbs)
  private
    FFirstname: string;
    FLastName: string;
    FInitials: string;
    FTitle: string;
  protected
    function  GetCaption: string; override;
    function  GetParent: TAdrsBook; reintroduce;
  public
    property  Parent: TAdrsBook read GetParent;
    function  Clone: TPerson; reintroduce;
    function  IsValid(const AErrors: TtiObjectErrors): boolean; override;
  published
    property LastName : string read FLastName  write FLastName;
    property FirstName: string read FFirstname write FFirstName;
    property Title    : string read FTitle     write FTitle;
    property Initials : string read FInitials  write FInitials;
  end;

  TPersonList   = class(TtiObjectList)
  protected
    function    GetItems(i: integer): TPerson; reintroduce;
    procedure   SetItems(i: integer; const AValue: TPerson); reintroduce;
  public
    property    Items[i:integer]: TPerson read GetItems write SetItems;
    procedure   Add(const AObject: TPerson); reintroduce;
    procedure   Read; override;
    procedure   Sort;
  end;

  // A list of TAddress objects
  TAddressList  = class(TtiObjectList)
  protected
    function    GetItems(i: integer): TAdrs; reintroduce;
    procedure   SetItems(i: integer; const Value: TAdrs); reintroduce;
    function    GetOID: TtiOID; override;
  public
    property    Items[i:integer]: TAdrs read GetItems write SetItems;
    procedure   Add(AObject: TAdrs  ; pbDefaultDispOrder: boolean = true); reintroduce;
  end;

  // A list of TEAddress objects
  TEAddressList = class(TtiObjectList)
  protected
    function    GetItems(i: integer): TEAdrs; reintroduce;
    procedure   SetItems(i: integer; const Value: TEAdrs); reintroduce;
    function    GetOID: TtiOID; override;
  public
    property    Items[i:integer]: TEAdrs read GetItems write SetItems;
    procedure   Add(AObject: TEAdrs ; pbDefaultDispOrder: boolean = true); reintroduce;
  end;

  TAdrsAbs = class(TtiObject)
  private
    FOIDAdrsType: String;
    function    GetAdrsTypeAsString: string;
    procedure   SetOIDAdrsType(const AValue: string);
    function GetAdrsType: TAdrsTypeAbs;
  protected
    function    AdrsTypeList: TAdrsTypeListAbs; virtual;
    function    GetParent: TPerson; reintroduce;
  public
    property    Parent      : TPerson read GetParent;
    property    AdrsType: TAdrsTypeAbs read GetAdrsType;
    function    IsValid(const AErrors: TtiObjectErrors): boolean; override;
  published
    property    AdrsTypeAsString: string read GetAdrsTypeAsString ;
    property    OIDAdrsType: String read FOIDAdrsType write SetOIDAdrsType;
  end;

  TAdrs = class(TAdrsAbs)
  private
    FLines  : string;
    FState  : string;
    FCountry: string;
    FPCode: string;
    FSuburb: string;
  protected
    function    GetCaption: string; override;
    function  IsValid(const AErrors: TtiObjectErrors): boolean; override;
  published
    property Lines  : string read FLines   write FLines;
    property Suburb : string read FSuburb  write FSuburb;
    property State  : string read FState   write FState;
    property PCode  : string read FPCode   write FPCode;
    property Country: string read FCountry write FCountry;
  end;

  TEAdrs = class(TAdrsAbs)
  private
    FText: string;
  protected
    function    GetCaption: string; override;
  public
    function  IsValid(const AErrors: TtiObjectErrors): boolean; override;
  published
    property Text: string read FText write FText;
  end;

function gAdrsBook: TAdrsBook;
procedure FreeAndNilAdrsBook;
procedure PopulateAdrsBook(const pAdrsBook: TAdrsBook);

implementation
uses
  tiUtils
  ,TypInfo
  ,tiOPFManager
  ,tiAutoMap
  ,SysUtils
  ,tiVisitorDB
  ,tiConstants
 ;

var
  uAdrsBook: TAdrsBook;

function gAdrsBook: TAdrsBook;
begin
  if uAdrsBook = nil then
    uAdrsBook:= TAdrsBook.Create;
  result:= uAdrsBook;
end;

procedure FreeAndNilAdrsBook;
begin
  FreeAndNil(uAdrsBook);
end;

procedure PopulateAdrsBook(const pAdrsBook: TAdrsBook);
//var
//  lLookupList: TLookupList;
//  lLookupListItem: TLookupListItem;
begin
//Assert(False, 'Under construction');
////  pAdrsBook.AdrsTypes.MarkListItemsForDeletion;
//  lLookupList:= TLookupList.CreateNew;
//  lLookupList.ObjectState:= posCreate;
//  lLookupList.ListName:= 'ADRS';
//  pAdrsBook.AdrsTypes.Add(lLookupList);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Street Address';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Postal Address';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Home Address';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Work Address';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Other';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupList:= TLookupList.CreateNew;
//  lLookupList.ObjectState:= posCreate;
//  lLookupList.ListName:= 'EADRS';
//  pAdrsBook.AdrsTypes.Add(lLookupList);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Home phone';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Work phone';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Mobile phone';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Fax';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'EMail';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Web';
//  lLookupList.Add(lLookupListItem);
//
//  lLookupListItem:= TLookupListItem.CreateNew;
//  lLookupListItem.Text:= 'Other';
//  lLookupList.Add(lLookupListItem);
//
//  gAdrsBook.AdrsTypes.Save;
//
end;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// *
// * TAdrsBook
// *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
constructor TAdrsBook.Create;
begin
  inherited;
  FAdrsTypeList:= TAdrsTypeList.Create;
  FAdrsTypeList.Owner:= self;

  FEAdrsTypeList:= TEAdrsTypeList.Create;
  FEAdrsTypeList.Owner:= self;

  FPeople := TPersonList.Create;
  FPeople.Owner:= Self;
  FPeople.OID.AsString:= 'AdrsBook';

end;

destructor TAdrsBook.Destroy;
begin
  FAdrsTypeList.Free;
  FEAdrsTypeList.Free;
  FPeople.Free;
  inherited;
end;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// *
// * TAdrsBookItemAbs
// *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
procedure TAdrsBookItemAbs.AssignClassProps(ASource: TtiObject);
begin
  FEAddressList.Assign(TAdrsBookItemAbs(ASource).EAddressList);
  FAddressList.Assign(TAdrsBookItemAbs(ASource).AddressList);
end;

constructor TAdrsBookItemAbs.Create;
begin
  inherited;
  FAddressList := TAddressList.Create;
  FAddressList.Owner:= self;
  // ToDo: Refactor to remove need for ItemOwner. Use Parent instead
  FAddressList.ItemOwner:= self;

  FEAddressList:= TEAddressList.Create;
  FEAddressList.Owner:= self;
  // ToDo: Refactor to remove need for ItemOwner. Use Parent instead
  FEAddressList.ItemOwner:= self;

end;

destructor TAdrsBookItemAbs.Destroy;
begin
  FAddressList.Free;
  FEAddressList.Free;
  inherited;
end;

procedure TAdrsBookItemAbs.Read;
begin
  inherited;
end;

procedure TAdrsBookItemAbs.Save;
begin
  inherited;
end;

function TPerson.Clone: TPerson;
begin
  result:= TPerson(inherited Clone);
end;

function TPerson.GetCaption: string;
begin
  result:= LastName + ', ' + FirstName;
end;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// *
// * TEAddress
// *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// *
// * TPeople
// *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
procedure TPersonList.Add(const AObject: TPerson);
begin
  inherited Add(AObject);
end;

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// *
// * TAddress
// *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

{ TAddress }

function TAdrs.GetCaption: string;
begin
  result:= tiStrTran(Lines, CrLf, ' ') + ' ' +
            State + ' ' + PCode;
end;

function TAdrsAbs.GetParent: TPerson;
begin
  result:= TPerson(inherited GetOwner);
end;

function TAdrsAbs.IsValid(const AErrors: TtiObjectErrors): boolean;
begin
  inherited IsValid(AErrors);
  if OIDAdrsType = '' then
    AErrors.AddError(CErrorAdrsAbsAdrsTypeNotAssigned);
  result:= AErrors.Count = 0;
end;

{ TEAddress }

function TEAdrs.GetCaption: string;
begin
  result:= Text;
end;



{ TAdrsList }

procedure TAddressList.Add(AObject: TAdrs; pbDefaultDispOrder: boolean);
begin
  inherited Add(AObject, pbDefaultDispOrder);
end;

function TAddressList.GetItems(i: integer): TAdrs;
begin
  result:= TAdrs(inherited GetItems(i));
end;

function TAddressList.GetOID: TtiOID;
begin
  if Owner <> nil then
    result:= Owner.OID
  else
    result:= inherited GetOID;
end;

procedure TAddressList.SetItems(i: integer; const Value: TAdrs);
begin
  inherited SetItems(i, Value);
end;

{ TEAddressList }

procedure TEAddressList.Add(AObject: TEAdrs; pbDefaultDispOrder: boolean);
begin
  inherited Add(AObject, pbDefaultDispOrder);
end;

function TPersonList.GetItems(i: integer): TPerson;
begin
  result:= TPerson(inherited GetItems(i));
end;


procedure TPersonList.Read;
begin
  inherited;
  Sort;
end;

function TEAddressList.GetItems(i: integer): TEAdrs;
begin
  result:= TEAdrs(inherited GetItems(i));
end;

function TEAddressList.GetOID: TtiOID;
begin
  if Owner <> nil then
    result:= Owner.OID
  else
    result:= inherited GetOID;
end;

procedure TEAddressList.SetItems(i: integer; const Value: TEAdrs);
begin
  inherited SetItems(i, Value);
end;

{ TAdrsAbs }

function TAdrsAbs.AdrsTypeList: TAdrsTypeListAbs;
begin
  Assert(Parent.TestValid, CTIErrorInvalidObject);
  Assert(Parent.Parent.TestValid, CTIErrorInvalidObject);
  result:= Parent.Parent.AdrsTypeList;
end;

function TAdrsAbs.GetAdrsType: TAdrsTypeAbs;
begin
  result:= AdrsTypeList.Find(OIDAdrsType);
end;

function TAdrsAbs.GetAdrsTypeAsString: string;
begin
  Assert(False, 'Under construction');
end;

procedure TPersonList.SetItems(i: integer; const AValue: TPerson);
begin
  inherited SetItems(i, AValue);
end;

function _ComparePerson(AItem1, AItem2: Pointer): integer;
var
  LItem1: TPerson;
  LItem2: TPerson;
begin
  LItem1:= TPerson(AItem1);
  LItem2:= TPerson(AItem2);
  result:= CompareText(LItem1.LastName, LItem2.LastName);
  if Result = 0 then
    result:= CompareText(LItem1.FirstName, LItem2.FirstName);
end;

procedure TPersonList.Sort;
begin
  List.Sort(_ComparePerson);
end;

function TPerson.GetParent: TAdrsBook;
begin
  result:= TAdrsBook(inherited GetParent);
end;

function TPerson.IsValid(const AErrors: TtiObjectErrors): boolean;
begin
  inherited IsValid(AErrors);
  if (FirstName = '') and (LastName = '') then
    AErrors.AddError('', CErrorPersonNameNotAssigned);
  result:= AErrors.Count = 0;
end;

procedure TAdrsAbs.SetOIDAdrsType(const AValue: string);
begin
  FOIDAdrsType:= AValue;
end;

procedure TAdrsBook.Read;
begin
  EAdrsTypeList.Read;
//  GTIOPFManager.ReadPK(Self);
//GTIOPFManager.Read(  Self);
end;

procedure TAdrsBook.SetDeleted(const Value: boolean);
var
  lObjectState: TPerObjectState;
begin
  lObjectState:= ObjectState;
  FPeople.Deleted:= Value;
  ObjectState:= lObjectState;
end;

function TAdrs.IsValid(const AErrors: TtiObjectErrors): boolean;
begin
  inherited IsValid(AErrors);
  if (Lines = '') and (State = '') and
     (Country = '') and (PCode = '') and
     (Suburb = '') then
    AErrors.AddError(CErrorAdrsAddressNotAssigned);
  result:= AErrors.Count = 0;
end;

function TEAdrs.IsValid(const AErrors: TtiObjectErrors): boolean;
begin
  inherited IsValid(AErrors);
  if (Text = '')  then
    AErrors.AddError(CErrorEAdrsTextNotAssigned);
  result:= AErrors.Count = 0;
end;

initialization

finalization
  FreeAndNilAdrsBook;
  
end.








