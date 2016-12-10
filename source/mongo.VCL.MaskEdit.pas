unit mongo.VCL.MaskEdit;

interface

uses System.Classes, System.SysUtils, mongo.interf, mongo.types, VCL.Mask;

type

  TMongoMaskEdit = class(TMaskEdit, IMongoText, IMongoControl)

  private
    FAutoInc: boolean;
    FMongoTipoCampo: TCampo;
    FMongoCampo: string;
    FCampoChave: boolean;
  protected
    // IMongoText
    procedure SetText(const value: string);
    function GetText: String;
    function toNumerico: Integer;
    function toMoeda: Currency;
    function toDataHora: TDateTime;

    // IMongoControl
    function GetMongoCampo: String;
    procedure SetMongoCampo(const value: String);
    function GetMongoTipoCampo: TCampo;
    procedure SetMongoTipoCampo(const value: TCampo);

    // IMongoChave
    function GetCampoChave: boolean;
    procedure SetCampoChave(const value: boolean);

    // IMongoAutoInc
    function GetAutoInc: boolean;
    procedure SetAutoInc(const value: boolean);

  public

  published
    property Text: string read GetText write SetText;
    property AutoInc: boolean read GetAutoInc write SetAutoInc;
    property CampoChave: boolean read GetCampoChave write SetCampoChave;
    property MongoTipoCampo: TCampo read GetMongoTipoCampo write SetMongoTipoCampo;
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;

  end;

implementation

{ TMongoMaskEdit }

function TMongoMaskEdit.GetAutoInc: boolean;
begin
  result := FAutoInc;
end;

function TMongoMaskEdit.GetCampoChave: boolean;
begin
  result := FCampoChave;
end;

function TMongoMaskEdit.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

function TMongoMaskEdit.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

function TMongoMaskEdit.GetText: String;
begin
  result := inherited Text;
end;

procedure TMongoMaskEdit.SetAutoInc(const value: boolean);
begin
  FAutoInc := value;
end;

procedure TMongoMaskEdit.SetCampoChave(const value: boolean);
begin
  FCampoChave := value;
end;

procedure TMongoMaskEdit.SetMongoCampo(const value: String);
begin
  FMongoCampo := value;
end;

procedure TMongoMaskEdit.SetMongoTipoCampo(const value: TCampo);
begin
  FMongoTipoCampo := value;
end;

procedure TMongoMaskEdit.SetText(const value: string);
begin
  inherited Text := Text;
end;

function TMongoMaskEdit.toDataHora: TDateTime;
begin
  result := strToDateTimeDef(Text, 0);
end;

function TMongoMaskEdit.toMoeda: Currency;
begin
  result := StrToFloatDef(Text, 0);
end;

function TMongoMaskEdit.toNumerico: Integer;
begin
  result := StrToIntDef(Text, 0);
end;

end.
