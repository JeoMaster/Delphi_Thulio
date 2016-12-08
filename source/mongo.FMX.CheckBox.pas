unit mongo.FMX.CheckBox;

interface

uses
  FMX.StdCtrls, System.Classes, mongo.Interf;

type
  TMongoCheckBox = class(TCheckBox, IMongoChecked)
  private
    FMongoCampo: String;
    function GetCheckedBool: boolean;
    procedure SetCheckedBool(const value: boolean);
    function GetMongoCampo: String;
    procedure SetMongoCampo(const value: String);
  published
    property Checked: boolean read GetCheckedBool write SetCheckedBool;
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
  end;

implementation

{ TMongoCheckBox }

function TMongoCheckBox.GetCheckedBool: boolean;
begin
     Result := Self.Checked;
end;

function TMongoCheckBox.GetMongoCampo: String;
begin
     Result := FMongoCampo;
end;

procedure TMongoCheckBox.SetCheckedBool(const value: boolean);
begin
     Self.Checked := value;
end;

procedure TMongoCheckBox.SetMongoCampo(const value: String);
begin
     FMongoCampo := value;
end;

end.
