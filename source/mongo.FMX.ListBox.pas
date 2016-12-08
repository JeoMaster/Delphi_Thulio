unit mongo.FMX.ListBox;

interface

{$I mongo.inc}
{$IFNDEF FMX}
  'codigo não pode ser utilizado em projetos VCL}
{$ENDIF}
uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Forms,
  FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.ListBox,
  VCL.Controls, VCL.Forms,
  mongo.Types, mongo.Interf, mongo.Tipificacoes;

type
  TMongoListBox = class(TListBox, IMongoJSON)
  private
    FMongoCampo: string;
    FJSON: String;
    function GetJSON: String;
    procedure SetJSON(const Value: String);
  protected
    function GetMongoCampo: String;
    procedure SetMongoCampo(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    property JSON: String read GetJSON write SetJSON;
  published
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
  end;

implementation

uses System.JSON;

{ TMongoListBox }

constructor TMongoListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TMongoListBox.GetJSON: String;
var
  j: TJsonArray;
  s: string;
begin
  j := TJsonArray.Create();
  try
    for s in Items do
    begin
      j.Add('{"text":"' + s + '"}');
    end;
    FJSON := j.ToJSON;
    result := FJSON;
  finally
    j.DisposeOf;
  end;
end;

function TMongoListBox.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

procedure TMongoListBox.SetJSON(const Value: String);
var
  j: TJsonArray;
  it: TJsonValue;
begin
  Items.Clear;
  j := TJsonObject.ParseJSONValue(Value) as TJsonArray;
  try

    for it in j do
    begin
      self.Items.Add(it.Value);
    end;

    FJSON := Value;

  finally
    j.Free;
  end;

end;

procedure TMongoListBox.SetMongoCampo(const Value: String);

begin
  FMongoCampo := Value;
end;

end.
