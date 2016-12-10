{ *************************************************************************** }
{ Data:  04/12/2016 }
{ Resenha: Codigo obtido apartir do codigo FMX }
{ *************************************************************************** }
{ Licença segue a mesma estabelecida no código original determinada pelo seu }
{ autor }
{ }
{ *************************************************************************** }
{

  Alterações:


}

unit mongo.Anniversary.ToggleSwitch;

interface

Uses
  System.Classes, System.SysUtils, Vcl.WinXCtrls,
  mongo.Interf, mongo.Types;

type
  TMongoToggleSwitch = class(TToggleSwitch, IMongoChecked)
  private
    FMongoCampo: string;
    FMongoTipoCampo: TCampo;
  protected
    function GetMongoCampo: String;
    procedure SetMongoCampo(const value: String);
    function GetMongoTipoCampo: TCampo;
    procedure SetMongoTipoCampo(const value: TCampo);

    property MongoTipoCampo: TCampo read GetMongoTipoCampo write SetMongoTipoCampo default TCampo.Booleano;
    function GetCheckedBool: boolean;
    procedure SetCheckedBool(const value: boolean);

  published
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
    property Checked: boolean read GetCheckedBool write SetCheckedBool;

  end;

implementation

{ TMongoToggleSwitch }

function TMongoToggleSwitch.GetCheckedBool: boolean;
begin
  result := State = tssOn;
end;

function TMongoToggleSwitch.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

function TMongoToggleSwitch.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

procedure TMongoToggleSwitch.SetCheckedBool(const value: boolean);
begin
  if value then
    State := tssOn
  else
    State := tssOff;
end;

procedure TMongoToggleSwitch.SetMongoCampo(const value: String);
begin
  FMongoCampo := value;
end;

procedure TMongoToggleSwitch.SetMongoTipoCampo(const value: TCampo);
begin
  FMongoTipoCampo := value;
end;

end.
