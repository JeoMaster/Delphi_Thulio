unit mongo.VCL.RadioGroup;

interface

{$I mongo.inc}
{$IFDEF FMX}
  'codigo não pode ser utilizado em projetos FMX}
{$ENDIF}
uses
  System.SysUtils, System.Classes, VCL.StdCtrls, VCL.ExtCtrls,
  mongo.Interf, mongo.Types, mongo.Tipificacoes;

type
  TMongoRadioGroup = class(TRadioGroup, IMongoControl, IMongoText)
  private
    FMongoCampo: string;
    FMongoTipoCampo: TCampo;
  protected
    function GetMongoCampo: String;
    procedure SetMongoCampo(const value: String);
    function GetMongoTipoCampo: TCampo;
    procedure SetMongoTipoCampo(const value: TCampo);

    procedure SetText(const value: string);
    function GetText: String;
    function toNumerico: Integer;
    function toMoeda: Currency;
    function toDataHora: TDateTime;

  public
    property Text: string read GetText write SetText;
  published
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
    property MongoTipoCampo: TCampo read GetMongoTipoCampo write SetMongoTipoCampo default texto;
  end;

implementation

{ TMongoGroupBox }

function TMongoRadioGroup.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

function TMongoRadioGroup.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

function TMongoRadioGroup.GetText: String;
begin
  result := '';
  if FMongoTipoCampo = Numerico then
    result := IntToStr(ItemIndex)
  else if ItemIndex >= 0 then
    result := items[ItemIndex];
end;

procedure TMongoRadioGroup.SetMongoCampo(const value: String);
begin
  FMongoCampo := value;
end;

procedure TMongoRadioGroup.SetMongoTipoCampo(const value: TCampo);
begin
  FMongoTipoCampo := value;
end;

procedure TMongoRadioGroup.SetText(const value: string);
begin
  if FMongoTipoCampo = Numerico then
    ItemIndex := strToIntDef(value, -1)
  else
    ItemIndex := items.IndexOf(value);
end;

function TMongoRadioGroup.toDataHora: TDateTime;
begin
  result := strToDateTimeDef(Text, 0);
end;

function TMongoRadioGroup.toMoeda: Currency;
begin
  result := strToFloatDef(Text, 0);
end;

function TMongoRadioGroup.toNumerico: Integer;
begin
  result := strToIntDef(Text, 0);
end;

end.
