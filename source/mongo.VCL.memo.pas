unit mongo.VCL.memo;

{ *************************************************************************** }
{ Autor: }
{ Data:  04/12/2016 }
{ Resenha:
  { *************************************************************************** }
{ Licença segue a mesma estabelecida no código original determinada pelo seu }
{ autor }
{ }
{ *************************************************************************** }
{

  Alterações:

}

interface

{$I mongo.inc}
{$IFDEF FMX}
  'codigo não pode ser utilizado em projetos FMX}
{$ENDIF}
uses
  System.SysUtils, System.Classes, VCL.StdCtrls,
  mongo.Interf, mongo.Types, mongo.Tipificacoes;

type
  TMongoMemo = class(TMemo, IMongoControl, IMongoText)
  private
    FJSON: String;
    FMongoTipoCampo: TCampo;
    FCampoMongo: string;
  protected
    function GetMongoCampo: String;
    procedure SetMongoCampo(const Value: String);
    procedure SetText(const Value: string);
    function GetText: String;
    property Text: string read GetText write SetText;
    function toNumerico: Integer;
    function toMoeda: Currency;
    function toDataHora: TDateTime;
    function GetMongoTipoCampo: TCampo;
    procedure SetMongoTipoCampo(const Value: TCampo);

  public
    constructor Create(AOwner: TComponent); override;
  published
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
    property MongoTipoCampo: TCampo read GetMongoTipoCampo write SetMongoTipoCampo default texto;
  end;

implementation

uses System.JSON;

constructor TMongoMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TMongoMemo.GetMongoCampo: String;
begin
  result := FCampoMongo;
end;

function TMongoMemo.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

function TMongoMemo.GetText: String;
begin
  result := lines.Text;
end;

procedure TMongoMemo.SetMongoCampo(const Value: String);
begin
  FCampoMongo := Value;
end;

procedure TMongoMemo.SetMongoTipoCampo(const Value: TCampo);
begin
  FMongoTipoCampo := Value;
end;

procedure TMongoMemo.SetText(const Value: string);
begin
  lines.Text := Value;
end;

function TMongoMemo.toDataHora: TDateTime;
begin
  result := strToDateTimeDef(Text, 0);
end;

function TMongoMemo.toMoeda: Currency;
begin
  result := strToFloatDef(Text, 0);
end;

function TMongoMemo.toNumerico: Integer;
begin
  result := strToIntDef(Text, 0);
end;

end.
