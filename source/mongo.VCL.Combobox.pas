unit mongo.VCL.Combobox;

interface

{$I mongo.inc}
{$IFDEF FMX}
  'codigo não pode ser utilizado em projetos FMX}
{$ENDIF}
uses
  System.SysUtils, System.Classes, VCL.StdCtrls,
  mongo.Interf, mongo.Types, mongo.Tipificacoes;

type
  TMongoComboBox = class(TComboBox, IMongoControl, IMongoText)
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
    property Text: string read GetText write SetText;
    function toNumerico: Integer;
    function toMoeda: Currency;
    function toDataHora: TDateTime;

  public
  published
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
    property MongoTipoCampo: TCampo read GetMongoTipoCampo write SetMongoTipoCampo default texto;
  end;

implementation

{ TMongoComboBox }

function TMongoComboBox.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

function TMongoComboBox.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

function TMongoComboBox.GetText: String;
begin
  if FMongoTipoCampo = numerico then
    result := IntToStr(ItemIndex)
  else
    result := inherited Text;
end;

procedure TMongoComboBox.SetMongoCampo(const value: String);
begin
  FMongoCampo := value;
end;

procedure TMongoComboBox.SetMongoTipoCampo(const value: TCampo);
begin
  FMongoTipoCampo := value;
end;

procedure TMongoComboBox.SetText(const value: string);
begin
  if FMongoTipoCampo = numerico then
    ItemIndex := StrToIntDef(value, -1)
  else
    inherited Text := value;
end;

function TMongoComboBox.toDataHora: TDateTime;
begin
  result := strToDateTimeDef(Text, 0);
end;

function TMongoComboBox.toMoeda: Currency;
begin
  result := strToFloatDef(Text, 0);
end;

function TMongoComboBox.toNumerico: Integer;
begin
  result := StrToIntDef(Text, 0);
end;

end.
