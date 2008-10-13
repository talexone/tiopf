unit frmeditcountry;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, model,
  tiFormMediator, StdCtrls;

type

  { TEditCountryForm }

  TEditCountryForm = class(TForm)
    BCancel: TButton;
    BOK: TButton;
    EISo: TEdit;
    EName: TEdit;
    Label1: TLabel;
    LEName: TLabel;
  private
    FMediator: TFormMediator;
    FData: TCountry;
    procedure SetData(const AValue: TCountry);
    procedure SetupMediators;
  public
    property  Data: TCountry read FData write SetData;
  end;

var
  EditCountryForm: TEditCountryForm;

function EditCountry(AData: TCountry): boolean;

implementation

function EditCountry(AData: TCountry): boolean;

var
  frm: TEditCountryForm;

begin
  frm:= TEditCountryForm.Create(nil);
  try
    frm.Data:=AData;
    result:= frm.ShowModal = mrOK;
  finally
    frm.Free;
  end;
end;

{ TEditCountryForm }

procedure TEditCountryForm.SetData(const AValue: TCountry);
begin
  FData:=Avalue;
  SetupMediators;
end;

procedure TEditCountryForm.SetupMediators;
begin
  if not Assigned(FMediator) then
  begin
    FMediator := TFormMediator.Create(self);
    FMediator.AddProperty('Name', eName);
    FMediator.AddProperty('ISO', eISO);
  end;
  FMediator.Subject := FData;
  FMediator.Active := True;
end;

initialization
  {$I frmeditcountry.lrs}

end.
