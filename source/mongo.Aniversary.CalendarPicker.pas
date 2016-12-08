unit mongo.Aniversary.CalendarPicker;

interface

{$I mongo.inc}
{$IFDEF FMX}
  'codigo não pode ser utilizado em projetos FMX}
{$ENDIF}
uses
  System.SysUtils, System.Classes, Vcl.WinXCalendars,
  mongo.Interf, mongo.Types, mongo.Tipificacoes;

type

  TMongoCalendarPicker = class(TCalendarPicker, IMongoControl, IMongoText)
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

function TMongoCalendarPicker.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

function TMongoCalendarPicker.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

function TMongoCalendarPicker.GetText: String;
begin
  result := DateToStr(Date)
end;

procedure TMongoCalendarPicker.SetMongoCampo(const value: String);
begin
  FMongoCampo := value;
end;

procedure TMongoCalendarPicker.SetMongoTipoCampo(const value: TCampo);
begin
  FMongoTipoCampo := value;
end;

procedure TMongoCalendarPicker.SetText(const value: string);
begin
    Date := strToDateTimeDef(value, 0);
end;

function TMongoCalendarPicker.toDataHora: TDateTime;
begin
  result := strToDateTimeDef(Text, 0);
end;

function TMongoCalendarPicker.toMoeda: Currency;
begin
  result := strToFloatDef(Text, 0);
end;

function TMongoCalendarPicker.toNumerico: Integer;
begin
  result := strToIntDef(Text, 0);
end;

end.
