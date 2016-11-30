unit uImageMongo;

interface

uses
  System.Classes, FMX.Objects, EncdDecd, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation;

type
  TImageMongo = class(TImage)
  private
    FMongoCampo: String;
  public
    function getDataImage : String;
    procedure setDataImage(const Value : String);
  published
    property MongoCampo : String read FMongoCampo write FMongoCampo;
    //property DataImage : String read getDataImage write setDataImage;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mongo Components', [TImageMongo]);
end;

procedure TImageMongo.setDataImage(const Value : String);
var
  s : TStringStream;
begin
  if Value <> '' then
  begin
    s   :=TStringStream.Create();
    try
      s.WriteString(Value);
      Self.Bitmap.LoadFromStream(s);
    finally
      s.Free;
    end;
  end;
end;

function TImageMongo.getDataImage : String;
var
  s    :TStringStream;
begin
  Result := '';
  if Self.MultiResBitmap.Count > 0 then
  begin
    s   := TStringStream.Create();
    try
      Self.Bitmap.SaveToStream(s);
      Result  :=  s.DataString;
    finally
      s.Free;
    end;
  end;
end;

end.
