unit mongo.VCL.DateTimePicker;

interface

{$I mongo.inc}
{$IFDEF FMX}
  'codigo não pode ser utilizado em projetos FMX}
{$ENDIF}
uses
  System.SysUtils, System.Classes, VCL.ComCtrls,
  mongo.Interf, mongo.Types, mongo.Tipificacoes;

type

  TMongoDateTimePicker = class(TDateTimePicker, IMongoControl, IMongoText)
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
    property MongoTipoCampo: TCampo read GetMongoTipoCampo write SetMongoTipoCampo default DataHora;
  end;

implementation

{ TMongoGroupBox }

function TMongoDateTimePicker.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

function TMongoDateTimePicker.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

function TMongoDateTimePicker.GetText: String;
begin
  if Kind = TDateTimeKind.dtkDate then
    result := DateToStr(Date)
  else
    result := TimeToStr(Time);
end;

procedure TMongoDateTimePicker.SetMongoCampo(const value: String);
begin
  FMongoCampo := value;
end;

procedure TMongoDateTimePicker.SetMongoTipoCampo(const value: TCampo);
begin
  FMongoTipoCampo := value;
end;

procedure TMongoDateTimePicker.SetText(const value: string);
begin
  if Kind = TDateTimeKind.dtkDate then
    Date := strToDateTimeDef(value, 0)
  else
    Time := strToTimeDef(value, 0);
end;

function TMongoDateTimePicker.toDataHora: TDateTime;
begin
  result := strToDateTimeDef(Text, 0);
end;

function TMongoDateTimePicker.toMoeda: Currency;
begin
  result := strToFloatDef(Text, 0);
end;

function TMongoDateTimePicker.toNumerico: Integer;
begin
  result := strToIntDef(Text, 0);
end;

end.
