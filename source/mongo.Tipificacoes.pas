{ *************************************************************************** }
{ Data:  04/12/2016                                                           }
{ Resenha:                                                                    }
{ *************************************************************************** }
{ Licen�a segue a mesma estabelecida no c�digo original determinada pelo seu  }
{ autor                                                                       }
{                                                                             }
{ *************************************************************************** }
{
 Altera��es:
}

unit mongo.Tipificacoes;

interface

uses
  mongo.types, System.SysUtils;

type
  TMongoTipificacao = class
  public
    class function toNumerico (AText: string): Integer;
    class function toMoeda (AText: string): Currency;
    class function toDataHora (AText: string): TDateTime;
  end;

implementation

{ TMongoTipificacao }

class function TMongoTipificacao.toDataHora(AText: string): TDateTime;
var aux : TDateTime;
begin
     Result := Now;
     if TryStrToDateTime(AText, aux) then
        Result := StrToDateTime(AText)
end;

class function TMongoTipificacao.toMoeda(AText: string): Currency;
var aux : Currency;
begin
     Result := 0.00;
     if (Pos('.', AText) > 0) and (Pos(',', AText) > 0) then
        AText := StringReplace(AText, '.', '', [rfReplaceAll, rfIgnoreCase])
     else
         AText := StringReplace(AText, '.', ',', [rfReplaceAll, rfIgnoreCase]);

     if TryStrToCurr(AText, aux) then
        Result := StrToCurr(AText)
end;

class function TMongoTipificacao.toNumerico(AText: string): Integer;
var aux : Integer;
begin
     Result := 0;
     if TryStrToInt(AText, aux) then
        Result := StrToInt(AText)
end;

end.
