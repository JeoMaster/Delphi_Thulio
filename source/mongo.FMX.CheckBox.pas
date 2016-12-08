unit mongo.FMX.CheckBox;

interface

uses
  FMX.StdCtrls, System.Classes, mongo.Interf, mongo.Types;

type
  TMongoCheckBox = class(TCheckBox, IMongoChecked, IMongoControl)
  private
    FMongoCampo: String;
    FMongoTipoCampo: TCampo;
    function GetCheckedBool: boolean;
    procedure SetCheckedBool(const value: boolean);
    function GetMongoCampo: String;
    procedure SetMongoCampo(const value: String);
    function GetMongoTipoCampo: TCampo;
    procedure SetMongoTipoCampo(const value: TCampo);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Checked: boolean read GetCheckedBool write SetCheckedBool;
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
    property MongoTipoCampo: TCampo read GetMongoTipoCampo default Booleano;
  end;

implementation

{ TMongoCheckBox }

constructor TMongoCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMongoTipoCampo := Booleano;
end;

function TMongoCheckBox.GetCheckedBool: boolean;
begin
     Result := Self.IsChecked;
end;

function TMongoCheckBox.GetMongoCampo: String;
begin
     Result := FMongoCampo;
end;

function TMongoCheckBox.GetMongoTipoCampo: TCampo;
begin
     Result := FMongoTipoCampo;
end;

procedure TMongoCheckBox.SetCheckedBool(const value: boolean);
begin
     Self.IsChecked := value;
end;

procedure TMongoCheckBox.SetMongoCampo(const value: String);
begin
     FMongoCampo := value;
end;

procedure TMongoCheckBox.SetMongoTipoCampo(const value: TCampo);
begin
     FMongoTipoCampo := value;
end;

end.
