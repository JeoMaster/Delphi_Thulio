{ *************************************************************************** }
{ Autor: Amarildo Lacerda }
{ Data:  04/12/2016 }
{ Resenha: Extraido da MongoQuery para reduzir acoplamento
  { *************************************************************************** }
{ Licença segue a mesma estabelecida no código original determinada pelo seu }
{ autor }
{ }
{ *************************************************************************** }
{

  Alterações:

  + Implementado Interface IMongoBitmap para suporte a objeto; (por: Amarildo Lacerda)
}

unit mongo.VCL.Image;

interface

{$I mongo.inc}
{$IFDEF FMX}
  'codigo não pode ser utilizado em projetos FMX}
{$ENDIF}
  uses System.Classes, VCL.ExtCtrls, mongo.interf, FMX.Controls.Presentation;

type
  TMongoImage = class(TImage, IMongoBitMap)
  private
    FMongoCampo: String;
    function GetMongoCampo: String;
    procedure SetMongoCampo(const Value: String);
  public
    function getDataImage: String;
    procedure setDataImage(const Value: String);
    procedure Clear;
  published
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
  end;

implementation

procedure TMongoImage.setDataImage(const Value: String);
var
  s: TStringStream;
begin
  if Value <> '' then
  begin
    s := TStringStream.Create();
    try
      s.WriteString(Value);
      Self.Picture.Bitmap.LoadFromStream(s);
    finally
      s.Free;
    end;
  end;
end;

procedure TMongoImage.SetMongoCampo(const Value: String);
begin
  FMongoCampo := Value;
end;

procedure TMongoImage.Clear;
begin
  Self.Picture.Bitmap := nil;
end;

function TMongoImage.getDataImage: String;
var
  s: TStringStream;
begin
  Result := '';
  begin
    s := TStringStream.Create();
    try
      Self.Picture.Bitmap.SaveToStream(s);
      Result := s.DataString;
    finally
      s.Free;
    end;
  end;
end;

function TMongoImage.GetMongoCampo: String;
begin
  Result := FMongoCampo;
end;

end.
