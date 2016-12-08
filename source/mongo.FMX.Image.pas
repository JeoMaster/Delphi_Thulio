unit mongo.FMX.Image;

interface

{$I mongo.inc}
{$ifndef FMX}
     'codigo não pode ser utilizado em projetos VCL}
{$endif}

uses
  System.Classes, FMX.Objects, EncdDecd, FMX.Types, FMX.Controls, FMX.Forms,
  FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation,
  mongo.Interf;

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
    // property DataImage : String read getDataImage write setDataImage;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mongo Components', [TMongoImage]);
end;

procedure TMongoImage.setDataImage(const Value: String);
var
  s: TStringStream;
begin
  if Value <> '' then
  begin
    s := TStringStream.Create();
    try
      s.WriteString(Value);
      Self.Bitmap.LoadFromStream(s);
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
  Bitmap := nil;
end;

function TMongoImage.getDataImage: String;
var
  s: TStringStream;
begin
  Result := '';
  if Self.MultiResBitmap.Count > 0 then
  begin
    s := TStringStream.Create();
    try
      Self.Bitmap.SaveToStream(s);
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
