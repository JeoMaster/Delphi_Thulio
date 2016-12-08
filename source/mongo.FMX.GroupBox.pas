unit mongo.FMX.GroupBox;

interface
{$I mongo.inc}
{$ifndef FMX}
     'codigo não pode ser utilizado em projetos VCL}
{$endif}

uses
  FMX.StdCtrls, System.Classes;

type
  TMongoGroupBox = class(TGroupBox)
  private
    FMongoCampo: String;
    FValueText: string;
    procedure EnableSelectedItem;
    procedure CheckSelectedItem;
    procedure SetValueText(const Value: string);
    function GetValueText: string;
  protected
    procedure Loaded; override;
  public
  published
    property MongoCampo : String read FMongoCampo write FMongoCampo;
    property ValueText: string read GetValueText write SetValueText;
  end;

implementation

{ TMongoGroupBox }

procedure TMongoGroupBox.CheckSelectedItem;
var i: integer;
begin
     for i:= 0 to Pred(Self.ControlsCount) do
     begin
          if (Self.Controls[i] is TRadioButton) then
          begin
               if TRadioButton(Self.Controls[i]).IsChecked then
               begin
                    SetValueText(TRadioButton(Self.Controls[i]).Text);
                    Break
               end;
          end;
     end;
end;

procedure TMongoGroupBox.EnableSelectedItem;
var i: integer;
begin
     for i:= 0 to Pred(Self.ControlsCount) do
     begin
          if (Self.Controls[i] is TRadioButton) then
          begin
               if TRadioButton(Self.Controls[i]).Text = FValueText then
                  TRadioButton(Self.Controls[i]).IsChecked := True
               else
                   TRadioButton(Self.Controls[i]).IsChecked := False;
          end;
     end;
end;

function TMongoGroupBox.GetValueText: string;
begin
     CheckSelectedItem;
     Result := FValueText;
end;

procedure TMongoGroupBox.Loaded;
begin
     EnableSelectedItem;
     inherited;
end;

procedure TMongoGroupBox.SetValueText(const Value: string);
begin
     FValueText := Value;
     EnableSelectedItem;
end;

end.
