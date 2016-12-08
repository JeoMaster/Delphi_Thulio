{ *************************************************************************** }
{ Data:  04/12/2016                                                           }
{ Resenha:                                                                    }
{ *************************************************************************** }
{ Licença segue a mesma estabelecida no código original determinada pelo seu  }
{ autor                                                                       }
{                                                                             }
{ *************************************************************************** }
{
 Alterações:
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
     if TryStrToDateTime(AText, aux) then
        Result := StrToDateTime(AText)
end;

class function TMongoTipificacao.toMoeda(AText: string): Currency;
var aux : Currency;
begin
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
     if TryStrToInt(AText, aux) then
        Result := StrToInt(AText)
end;

end.
