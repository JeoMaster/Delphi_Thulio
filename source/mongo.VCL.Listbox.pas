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

unit mongo.VCL.Listbox;

interface

{$I mongo.inc}
{$IFDEF FMX}
  'codigo não pode ser utilizado em projetos FMX}
{$ENDIF}
uses
  System.SysUtils, System.Classes, mongo.Interf, VCL.StdCtrls,
  mongo.Types, mongo.Tipificacoes;

type
  TMongoListBox = class(TListBox, IMongoControl, IMongoText)
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

constructor TMongoListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TMongoListBox.GetMongoCampo: String;
begin
  result := FCampoMongo;
end;

function TMongoListBox.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

function TMongoListBox.GetText: String;
begin
  if FMongoTipoCampo = Numerico then
    result := intToStr(itemIndex)
  else if itemIndex >= 0 then
    result := items[itemIndex]
  else
    result := inherited Text;
end;

procedure TMongoListBox.SetMongoCampo(const Value: String);
begin
  FCampoMongo := Value;
end;

procedure TMongoListBox.SetMongoTipoCampo(const Value: TCampo);
begin
  FMongoTipoCampo := Value;
end;

procedure TMongoListBox.SetText(const Value: string);
var
  i: Integer;
begin
  if FMongoTipoCampo = Numerico then
    itemIndex := strToIntDef(Value, -1)
  else
  begin
    i := items.IndexOf(Value);
    if i >= 0 then
      itemIndex := i
    else
      inherited Text := Value;
  end;
end;

function TMongoListBox.toDataHora: TDateTime;
begin
  result := strToDateTimeDef(Text, 0);
end;

function TMongoListBox.toMoeda: Currency;
begin
  result := strToFloatDef(Text, 0);
end;

function TMongoListBox.toNumerico: Integer;
begin
  result := strToIntDef(Text, 0);
end;

end.
