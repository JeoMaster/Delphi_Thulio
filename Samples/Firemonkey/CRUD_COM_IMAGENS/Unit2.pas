unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  uAction_MongoQuery, System.Actions, FMX.ActnList, FMX.Objects, uImageMongo,
  uMongoQuery, uConexaoMongo, FMX.Controls.Presentation, FMX.Edit, uEditMongo,
  FMX.Layouts, FMX.ListBox, uComboBoxMongo;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    EditMongo1: TEditMongo;
    MongoConexao1: TMongoConexao;
    MongoQuery1: TMongoQuery;
    ActionList1: TActionList;
    MongoInsert1: TMongoInsert;
    MongoSelectEdit1: TMongoSelectEdit;
    ImageMongo1: TImageMongo;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    OpenDialog2: TOpenDialog;
    StyleBook1: TStyleBook;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    EditMongo2: TEditMongo;
    EditMongo3: TEditMongo;
    Button1: TButton;
    Button2: TButton;
    MongoUpdate1: TMongoUpdate;
    MongoDelete1: TMongoDelete;
    MongoLimpar1: TMongoLimpar;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button3Click(Sender: TObject);
var
  s : TStringStream;
begin
  If OpenDialog1.Execute Then
  begin
    s   := TStringStream.Create();
    Try
      s.LoadFromFile(OPenDialog1.FileName);
      ImageMongo1.Bitmap.LoadFromStream(s);
    Finally
      FreeAndNil(s);
    End;
  end;
end;

end.
