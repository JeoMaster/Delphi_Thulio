unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, uAction_MongoQuery, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Edit, uEditMongo, FMX.Layouts, uMongoQuery, uConexaoMongo, uComboBoxMongo,
  FMX.ListBox, uCheckBoxMongo, uGroupBoxMongo;

type
  TForm2 = class(TForm)
    MongoConexao1: TMongoConexao;
    MongoQuery1_Cliente: TMongoQuery;
    Layout1: TLayout;
    EditMongo1: TEditMongo;
    ActionList1: TActionList;
    MongoInsert1: TMongoInsert;
    ToolBar1: TToolBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    MongoUpdate1: TMongoUpdate;
    MongoDelete1: TMongoDelete;
    MongoSelectEdit1: TMongoSelectEdit;
    EditMongo2: TEditMongo;
    EditMongo3: TEditMongo;
    EditMongo4: TEditMongo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MongoLimpar1: TMongoLimpar;
    Button5: TButton;
    Label5: TLabel;
    MongoQuery2_UF: TMongoQuery;
    ComboBoxMongo1: TComboBoxMongo;
    CheckBoxMongo1: TCheckBoxMongo;
    GroupBoxMongo1: TGroupBoxMongo;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
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
