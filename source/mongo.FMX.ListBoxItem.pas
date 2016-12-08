unit mongo.FMX.ListBoxItem;

interface

{$I mongo.inc}
{$ifndef FMX}
     'codigo não pode ser utilizado em projetos VCL}
{$endif}


uses
  System.SysUtils, System.Classes,
  {$ifdef FMX}
    FMX.Types, FMX.Controls, FMX.Forms,
    FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.ListBox,
  {$else}
    VCL.Controls, VCL.Forms,
  {$endif}
  mongo.Interf, mongo.Tipificacoes;

type
  TMongoListBoxItem = class(TListBoxItem{, IMongoJSON})
  private
    FJSON: String;
    FListBox: TListBox;
    function GetJSON: String;
    procedure SetJSON(const Value: String);
  protected

  public
    constructor Create(AOwner: TComponent); override;

  published
    property JSON: String read GetJSON write SetJSON;
    property ListBox: TListBox read FListBox write FListBox;
  end;

implementation

{ TMongoListBoxItem }

constructor TMongoListBoxItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TMongoListBoxItem.GetJSON: String;
begin
  result := FJSON;
end;

procedure TMongoListBoxItem.SetJSON(const Value: String);
begin
  FJSON := Value;
end;

end.
