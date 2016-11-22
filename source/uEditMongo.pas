unit uEditMongo;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, uMongo_Tipificacoes;

type
  TEditMongo = class(TEdit)
  private
    FMongoCampo: String;
    FMongoTipoCampo: TCampo;
    FAutoInc: Boolean;
    FCampoChave: Boolean;
  protected

  public
    constructor Create(AOwner: TComponent); override;
    function toNumerico : Integer;
    function toMoeda : Currency;
    function toDataHora : TDateTime;

  published
    property MongoTipoCampo : TCampo  read FMongoTipoCampo write FMongoTipoCampo default TCampo.Texto;
    property MongoCampo : String read FMongoCampo write FMongoCampo;
    property AutoInc : Boolean read FAutoInc write FAutoInc;
    property CampoChave : Boolean read FCampoChave write FCampoChave;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mongo Components', [TEditMongo]);
end;

{ TEditMongo }

constructor TEditMongo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TEditMongo.toDataHora: TDateTime;
begin
     try
        Result := TTipificacao.toDataHora(Self.Text);
     except
           raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
     end;
end;

function TEditMongo.toMoeda: Currency;
begin
     try
        Result := TTipificacao.toMoeda(Self.Text);
     except
           raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
     end;
end;

function TEditMongo.toNumerico: Integer;
begin
     try
        Result := TTipificacao.toNumerico(Self.Text);
     except
           raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
     end;
end;

end.
