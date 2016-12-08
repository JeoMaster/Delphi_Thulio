{ *************************************************************************** }
{ Data:  04/12/2016                                                           }
{ Resenha: Codigo obtido apartir do codigo FMX                                }
{ *************************************************************************** }
{ Licença segue a mesma estabelecida no código original determinada pelo seu  }
{ autor                                                                       }
{                                                                             }
{ *************************************************************************** }
{
 Alterações:

}
unit mongo.VCL.RadioButton;

interface

Uses System.Classes, System.SysUtils,
  mongo.interf, mongo.types,
  VCL.StdCtrls;

type
  TMongoRadioButton = class(TRadioButton, IMongoChecked)
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

{ TMongoRadioButton }

function TMongoRadioButton.GetCheckedBool: boolean;
begin
  result := inherited Checked;
end;

function TMongoRadioButton.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

function TMongoRadioButton.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

procedure TMongoRadioButton.SetCheckedBool(const value: boolean);
begin
  inherited Checked := value;
end;

procedure TMongoRadioButton.SetMongoCampo(const value: String);
begin
  FMongoCampo := value;
end;

procedure TMongoRadioButton.SetMongoTipoCampo(const value: TCampo);
begin
  FMongoTipoCampo := value;
end;

end.
