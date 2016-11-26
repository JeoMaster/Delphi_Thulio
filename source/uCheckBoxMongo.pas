unit uCheckBoxMongo;

interface

uses
  FMX.StdCtrls, System.Classes;

type
  TCheckBoxMongo = class(TCheckBox)
  private
    FMongoCampo: String;
  published
    property MongoCampo : String read FMongoCampo write FMongoCampo;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mongo Components', [TCheckBoxMongo]);
end;

end.
