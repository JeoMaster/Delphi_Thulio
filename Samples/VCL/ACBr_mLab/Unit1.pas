unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  mongo.Query, mongo.Conexao, ACBrBase, ACBrDFe, ACBrNFe, pcnNFe, REST.Json,
  mongo.VCL.Actions, System.Actions, Vcl.ActnList, mongo.VCL.MongoEdit,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient;

  
  
type
  TForm1 = class(TForm)
    MongoConexao1: TMongoConexao;
    MongoQuery1: TMongoQuery;
    ToolBar1: TToolBar;
    Button1: TButton;
    Memo1: TMemo;
    ACBrNFe1: TACBrNFe;
    btnBuscar: TButton;
    Button3: TButton;
    Panel1: TPanel;
    edtBuscar: TEdit;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    edtCPF: TMongoEdit;
    Label1: TLabel;
    edtNome: TMongoEdit;
    Label2: TLabel;
    edtFantasia: TMongoEdit;
    Label3: TLabel;
    edtIE: TMongoEdit;
    Label4: TLabel;
    edtIEST: TMongoEdit;
    Label5: TLabel;
    edtIM: TMongoEdit;
    Label6: TLabel;
    edtCNAE: TMongoEdit;
    Label7: TLabel;
    GroupBox2: TGroupBox;
    edtEndLog: TEdit;
    Label9: TLabel;
    edtEndNumero: TMongoEdit;
    edtEndComp: TMongoEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtEndBairro: TMongoEdit;
    Label13: TLabel;
    edtEndCidade: TMongoEdit;
    btnUpdate: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
  private
    { Private declarations }
    procedure _(Msg : String);
    procedure _formToClass(var Emit : TEmit);
    procedure _ClassToForm(var Emit : TEmit);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnBuscarClick(Sender: TObject);
var
  Nfe : TNFe;
  Emit : TEmit;
  Aux : String;
begin
  Nfe := TNFe.Create;
  Emit := TEmit.Create(Nfe);
  try
    Aux := MongoQuery1.Find('{ "cNPJCPF" : "'+ edtBuscar.Text +'"}');
    Emit := TJson.JsonToObject<TEmit>(Aux);
    _ClassToForm(Emit);
  finally
    Nfe.Free;
    Emit.Free;
  end;

end;

procedure TForm1.btnUpdateClick(Sender: TObject);
var
  Nfe : TNFe;
  Emit : TEmit;
begin
  Nfe := TNFe.Create;
  Emit := TEmit.Create(Nfe);
  try
    _formToClass(Emit);
    try
      MongoQuery1.Update('{ "cNPJCPF" : "'+ edtCPF.Text +'"}', TJson.ObjectToJsonString(Emit, []));
      _('Classe Atualizada com Sucesso');
   except
     on E : Exception do
      _(E.Message);
  end;
  finally
    Nfe.Free;
    Emit.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    MongoConexao1.Ativar := true;
    _('Conectado com Sucesso');
   except
     on E : Exception do
      _(E.Message);
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Nfe : TNFe;
  Emit : TEmit;
begin
  Nfe := TNFe.Create;
  Emit := TEmit.Create(Nfe);
  try
    _formToClass(Emit);
    try
      MongoQuery1.Insert(TJson.ObjectToJsonString(Emit, []));
      _('Classe Inserida com Sucesso');
   except
     on E : Exception do
      _(E.Message);
  end;
  finally
    Nfe.DisposeOf;
  end;

end;

procedure TForm1._(Msg: String);
begin
  Memo1.Lines.Clear;
  Memo1.Lines.Add(Msg);
end;

procedure TForm1._ClassToForm(var Emit: TEmit);
begin
  edtCPF.Text := Emit.CNPJCPF;
  edtNome.Text := Emit.xNome;
  edtFantasia.Text := Emit.xFant;
  edtIE.Text := Emit.IE;
  edtIEST.Text := Emit.IEST;
  edtIM.Text := Emit.IM;
  edtCNAE.Text := Emit.CNAE;
  edtEndLog.Text := Emit.EnderEmit.xLgr;
  edtEndNumero.Text := Emit.EnderEmit.nro;
  edtEndComp.Text := Emit.EnderEmit.xCpl;
  edtEndBairro.Text := Emit.EnderEmit.xBairro;
  edtEndCidade.Text := Emit.EnderEmit.xMun;
end;

procedure TForm1._formToClass(var Emit: TEmit);
begin
  Emit.CNPJCPF := edtCPF.Text;
  Emit.xNome := edtNome.Text;
  Emit.xFant := edtFantasia.Text;
  Emit.IE := edtIE.Text;
  Emit.IEST := edtIEST.Text;
  Emit.IM := edtIM.Text;
  Emit.CNAE := edtCNAE.Text;
  Emit.EnderEmit.xLgr := edtEndLog.Text;
  Emit.EnderEmit.nro := edtEndNumero.Text;
  Emit.EnderEmit.xCpl := edtEndComp.Text;
  Emit.EnderEmit.xBairro := edtEndBairro.Text;
  Emit.EnderEmit.xMun := edtEndCidade.Text;
end;

end.
