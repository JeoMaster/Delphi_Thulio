unit mongo.Aniversary.CalendarView;

interface

{$I mongo.inc}
{$IFDEF FMX}
  'codigo não pode ser utilizado em projetos FMX}
{$ENDIF}
  uses System.SysUtils, System.Classes, mongo.Interf, mongo.Types, Vcl.WinXCalendars, uMongo_Tipificacoes;

type

  TMongoCalendarView = class(TCalendarView, IMongoControl, IMongoText)
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

function TMongoCalendarView.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

function TMongoCalendarView.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

function TMongoCalendarView.GetText: String;
begin
  result := DateToStr(Date)
end;

procedure TMongoCalendarView.SetMongoCampo(const value: String);
begin
  FMongoCampo := value;
end;

procedure TMongoCalendarView.SetMongoTipoCampo(const value: TCampo);
begin
  FMongoTipoCampo := value;
end;

procedure TMongoCalendarView.SetText(const value: string);
begin
    Date := strToDateTimeDef(value, 0);
end;

function TMongoCalendarView.toDataHora: TDateTime;
begin
  result := strToDateTimeDef(Text, 0);
end;

function TMongoCalendarView.toMoeda: Currency;
begin
  result := strToFloatDef(Text, 0);
end;

function TMongoCalendarView.toNumerico: Integer;
begin
  result := strToIntDef(Text, 0);
end;

end.
