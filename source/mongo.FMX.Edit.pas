unit mongo.FMX.Edit;

interface

{$I mongo.inc}
{$IFNDEF FMX}
  'codigo não pode ser utilizado em projetos VCL}
{$ENDIF}
uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Forms,
  FMX.Graphics, FMX.Dialogs, FMX.Edit, mongo.Interf, mongo.Types,
  FMX.Controls.Presentation, mongo.Tipificacoes;

type
  TMongoEdit = class(TEdit, IMongoAutoInc, IMongoText, IMongoControl, IMongoCampoChave)
  private
    FMongoCampo: String;
    FMongoTipoCampo: TCampo;
    FAutoInc: Boolean;
    FCampoChave: Boolean;
    function GetMongoCampo: String;
    procedure SetMongoCampo(const Value: String);
    function GetAutoInc: Boolean;
    procedure SetAutoInc(const Value: Boolean);
    function GetMongoTipoCampo: TCampo;
    procedure SetMongoTipoCampo(const Value: TCampo);
    function GetCampoChave: Boolean;
    procedure SetCampoChave(const Value: Boolean);
  protected

  public
    constructor Create(AOwner: TComponent); override;
    function toNumerico: Integer;
    function toMoeda: Currency;
    function toDataHora: TDateTime;
    function toBooleano: Boolean;

  published
    property MongoTipoCampo: TCampo read GetMongoTipoCampo write SetMongoTipoCampo default TCampo.Texto;
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
    property AutoInc: Boolean read GetAutoInc write SetAutoInc;
    property CampoChave: Boolean read GetCampoChave write SetCampoChave;
  end;

implementation

{ TMongoEdit }

constructor TMongoEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TMongoEdit.GetAutoInc: Boolean;
begin
  result := FAutoInc;
end;

function TMongoEdit.GetCampoChave: Boolean;
begin
  result := FCampoChave;
end;

function TMongoEdit.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

function TMongoEdit.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

procedure TMongoEdit.SetAutoInc(const Value: Boolean);
begin
  FAutoInc := Value;
end;

procedure TMongoEdit.SetCampoChave(const Value: Boolean);
begin
  FCampoChave := Value;
end;

procedure TMongoEdit.SetMongoCampo(const Value: String);
begin
  FMongoCampo := Value;
end;

procedure TMongoEdit.SetMongoTipoCampo(const Value: TCampo);
begin
  FMongoTipoCampo := Value;
end;

function TMongoEdit.toBooleano: Boolean;
begin
  result := StrToBoolDef(self.Text, false);
end;

function TMongoEdit.toDataHora: TDateTime;
begin
  try
    result := TMongoTipificacao.toDataHora(self.Text);
  except
    raise Exception.Create('O Valor do Campo ' + self.FMongoCampo + ' é Inválido');
  end;
end;

function TMongoEdit.toMoeda: Currency;
begin
  try
    result := TMongoTipificacao.toMoeda(self.Text);
  except
    raise Exception.Create('O Valor do Campo ' + self.FMongoCampo + ' é Inválido');
  end;
end;

function TMongoEdit.toNumerico: Integer;
begin
  try
    result := TMongoTipificacao.toNumerico(self.Text);
  except
    raise Exception.Create('O Valor do Campo ' + self.FMongoCampo + ' é Inválido');
  end;
end;

end.
