unit uMongoListBoxItem;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ListBox, uMongo_Tipificacoes, VCL.Controls, VCL.Forms;

type
  TMongoListBoxItem = class(TListBoxItem)
  private
    FJSON: String;
    FListBox: TListBox;
  protected

  public
    constructor Create(AOwner: TComponent); override;

  published
    property JSON : String read FJSON write FJSON;
    property ListBox : TListBox read FListBox write FListBox;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mongo Components', [TMongoListBoxItem]);
end;

{ TMongoListBoxItem }

constructor TMongoListBoxItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

end.
