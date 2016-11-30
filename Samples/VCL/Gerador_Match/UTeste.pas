unit UTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UCtrlMongo;

type
  TFormMatch = class(TForm)
    Button1: TButton;
    edID: TEdit;
    Button2: TButton;
    edGT: TEdit;
    Button3: TButton;
    Edit1: TEdit;
    Button4: TButton;
    Edit2: TEdit;
    Button5: TButton;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMatch: TFormMatch;

implementation

{$R *.dfm}

procedure TFormMatch.Button1Click(Sender: TObject);
begin
  edID.Text := TMatchID.New(10).Result;
end;

procedure TFormMatch.Button2Click(Sender: TObject);
begin
  edGT.Text := TComparison.New('Valor',tcGt,10).Result;
end;

procedure TFormMatch.Button3Click(Sender: TObject);
begin
  Edit1.Text := TLogical.New(tland, TMatchItens.New
                                .Add(TComparison.New('Valor', tcGt, 10) )
                                .Add(TComparison.New('Valor', tcLt, 20) )).Result;
end;

procedure TFormMatch.Button4Click(Sender: TObject);
begin
  Edit2.Text := TLogical.New(tlor, TMatchItens.New
                                .Add(TComparison.New('nome', tceq, 'Marlon') )
                                .Add(TComparison.New('cidade', tceq, 'Chapecó') )
                                .Add(TComparison.New('salario', tcgte, 15000) )).Result;

end;

procedure TFormMatch.Button5Click(Sender: TObject);
begin
  Edit3.Text := TComparison.New('Nome',tcRegex, 'silva').Result;
end;

end.
