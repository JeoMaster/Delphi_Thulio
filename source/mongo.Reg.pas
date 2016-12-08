unit mongo.Reg;

interface

uses
  System.Classes;

procedure Register;

implementation

uses
  mongo.Conexao, mongo.Query, mongo.Relatorio;

procedure Register;
begin
     RegisterComponents('Mongo Components', [TMongoConexao, TMongoQuery, TMongoRelatorio]);
end;

end.
