unit uMongo_Tipificacoes;

interface

uses
  System.SysUtils;

type
  TCampo = (Texto, Numerico, Moeda, DataHora);

type
  TTipificacao = class
  public
    class function toNumerico (AText: string): Integer;
    class function toMoeda (AText: string): Currency;
    class function toDataHora (AText: string): TDateTime;
  end;

implementation

{ TTificacao }

class function TTipificacao.toDataHora(AText: string): TDateTime;
var aux : TDateTime;
begin
     if TryStrToDateTime(AText, aux) then
        Result := StrToDateTime(AText)
end;

class function TTipificacao.toMoeda(AText: string): Currency;
var aux : Currency;
begin
     if (Pos('.', AText) > 0) and (Pos(',', AText) > 0) then
        AText := StringReplace(AText, '.', '', [rfReplaceAll, rfIgnoreCase])
     else
         AText := StringReplace(AText, '.', ',', [rfReplaceAll, rfIgnoreCase]);

     if TryStrToCurr(AText, aux) then
        Result := StrToCurr(AText)
end;

class function TTipificacao.toNumerico(AText: string): Integer;
var aux : Integer;
begin
     if TryStrToInt(AText, aux) then
        Result := StrToInt(AText)
end;

end.
