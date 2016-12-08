program Componentes;

uses
  Vcl.Forms,
  Unit25 in 'Unit25.pas' {Form25};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm25, Form25);
  Application.Run;
end.
