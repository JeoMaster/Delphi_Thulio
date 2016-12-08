unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  FMX.ListBox, mongo.FMX.ActionQuery, mongo.Query, mongo.Conexao, mongo.FMX.Edit,
  mongo.FMX.CheckBox, mongo.FMX.GroupBox, mongo.FMX.ComboBox;

type
  TForm2 = class(TForm)
    MongoConexao1: TMongoConexao;
    MongoQuery1_Cliente: TMongoQuery;
    MongoQuery2_UF: TMongoQuery;
    Layout1: TLayout;
    ActionList1: TActionList;
    MongoInsert1: TMongoInsert;
    MongoUpdate1: TMongoUpdate;
    MongoDelete1: TMongoDelete;
    MongoSelectEdit1: TMongoSelectEdit;
    MongoLimpar1: TMongoLimpar;
    ToolBar1: TToolBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button5: TButton;
    Label5: TLabel;
    MongoEdit1: TMongoEdit;
    MongoEdit2: TMongoEdit;
    MongoEdit3: TMongoEdit;
    MongoEdit4: TMongoEdit;
    MongoCheckBox1: TMongoCheckBox;
    MongoGroupBox1: TMongoGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    MongoComboBox1: TMongoComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

end.
