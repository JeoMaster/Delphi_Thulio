unit uMongoListBox;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ListBox, uMongo_Tipificacoes, VCL.Controls, VCL.Forms;

type
  TMongoListBox = class(TListBox)
  private
    FJSON: String;
  protected

  public
    constructor Create(AOwner: TComponent); override;

  published
    property JSON : String read FJSON write FJSON;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mongo Components', [TMongoListBox]);
end;

{ TEditMongo }

constructor TMongoListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

end.
