unit mongo.FMX.GroupBox;

interface
{$I mongo.inc}
{$ifndef FMX}
     'codigo não pode ser utilizado em projetos VCL}
{$endif}

uses
  FMX.StdCtrls, System.Classes, mongo.Interf, mongo.Types, mongo.Tipificacoes,
  System.SysUtils;

type
  TMongoGroupBox = class(TGroupBox, IMongoControl, IMongoGroupBox)
  private
    FCapiton: string;
    FMongoCampo: String;
    FMongoTipoCampo: TCampo;
    FValueText: string;
    //--IMongoText

    //--IMongoControl
    function GetMongoCampo: String;
    procedure SetMongoCampo(const value: String);
    function GetMongoTipoCampo: TCampo;
    procedure SetMongoTipoCampo(const value: TCampo);

    procedure EnableSelectedItem;
    procedure CheckSelectedItem;
    procedure SetValueText(const Value: string);
    function GetValueText: string;
  protected
    procedure Loaded; override;
    procedure DoChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
    property MongoTipoCampo: TCampo read GetMongoTipoCampo write SetMongoTipoCampo;
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

constructor TMongoGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCapiton := Self.Text;
end;

procedure TMongoGroupBox.DoChanged;
var i: integer;
begin
  inherited;
  for i:= 0 to Self.ChildrenCount-1 do
  begin
       if (Self.Children[i] is TRadioButton) then
       begin
            if TRadioButton(Self.Children[i]).GroupName = '' then
               TRadioButton(Self.Children[i]).GroupName := Self.Name;
       end;
  end;

end;

procedure TMongoGroupBox.EnableSelectedItem;
var i: integer;
begin
     {
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
     }
     for i:= 0 to Self.ChildrenCount-1 do
     begin
          if (Self.Children[i] is TRadioButton) then
          begin
               if TRadioButton(Self.Children[i]).Text = FValueText then
                  TRadioButton(Self.Children[i]).IsChecked := True
               else
                   TRadioButton(Self.Children[i]).IsChecked := False;
          end;
     end;
end;

function TMongoGroupBox.GetMongoCampo: String;
begin
     Result := FMongoCampo;
end;

function TMongoGroupBox.GetMongoTipoCampo: TCampo;
begin
     Result := FMongoTipoCampo;
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

procedure TMongoGroupBox.SetMongoCampo(const value: String);
begin
     FMongoCampo := value;
end;

procedure TMongoGroupBox.SetMongoTipoCampo(const value: TCampo);
begin
     FMongoTipoCampo := value;
end;

procedure TMongoGroupBox.SetValueText(const Value: string);
begin
     FValueText := Value;
     EnableSelectedItem;
end;

end.
