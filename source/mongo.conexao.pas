unit mongo.Conexao;

interface

uses
  System.SysUtils, System.Classes, mongoWire, bsonDoc;

type
  TMongoConexao = class(TComponent)
  private
    FDatabase: String;
    FHost: String;
    FPorta: Integer;
    FAtivar: Boolean;
    procedure setAtivar(const Value: Boolean);
  public
    FMongoWire: TMongoWire;
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
  published
    property Database: String read FDatabase write FDatabase;
    property Host: String read FHost write FHost;
    property Porta: Integer read FPorta write FPorta;
    property Ativar: Boolean read FAtivar write setAtivar;
  end;

implementation

{$R 'MongoComponentes.res' 'MongoComponentes.rc'}

constructor TMongoConexao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDatabase := 'MeuBanco';
  FHost := 'localhost';
  FPorta := 27017;
end;

destructor TMongoConexao.destroy;
begin
  if assigned(FMongoWire) then
    FMongoWire.DisposeOf;
  inherited;
end;

procedure TMongoConexao.setAtivar(const Value: Boolean);
begin
  FMongoWire := TMongoWire.Create(FDatabase);
  FMongoWire.Open(FHost, FPorta);
  FAtivar := Value;
end;

end.
