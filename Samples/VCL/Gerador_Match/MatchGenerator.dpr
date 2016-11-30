program MatchGenerator;

uses
  Vcl.Forms,
  UTeste in 'UTeste.pas' {FormMatch};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMatch, FormMatch);
  Application.Run;
end.
