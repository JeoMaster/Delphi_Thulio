unit Unit25;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  mongo.Query, mongo.Conexao, Vcl.StdCtrls, mongo.Vcl.MongoEdit, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, mongo.Vcl.Actions, mongo.Vcl.CheckBox,
  mongo.Vcl.Image, Vcl.ExtDlgs, mongo.VCL.Listbox, mongo.VCL.Combobox,
  mongo.VCL.RadioGroup, Vcl.ComCtrls, mongo.VCL.DateTimePicker, mongo.VCL.memo,
  mongo.VCL.RadioButton, Vcl.WinXCalendars, mongo.Anniversary.CalendarPicker,
  Vcl.WinXCtrls, mongo.Anniversary.ToggleSwitch, mongo.Anniversary.CalendarView;

type
  TForm25 = class(TForm)
    ActionList1: TActionList;
    Panel1: TPanel;
    Button1: TButton;
    MongoEdit1: TMongoEdit;
    MongoInsert1: TVCLMongoInsert;
    MongoConexao1: TMongoConexao;
    MongoQuery1: TMongoQuery;
    MongoCheckBox1: TMongoCheckBox;
    MongoEdit2: TMongoEdit;
    Label1: TLabel;
    Button2: TButton;
    MongoUpdate1: TVCLMongoUpdate;
    MongoDelete1: TVCLMongoDelete;
    Button3: TButton;
    Button4: TButton;
    MongoSelectEdit1: TVCLMongoSelectEdit;
    MongoLimpar1: TVCLMongoLimpar;
    Button5: TButton;
    MongoImage1: TMongoImage;
    Label2: TLabel;
    Bevel1: TBevel;
    OpenPictureDialog1: TOpenPictureDialog;
    MongoListBox1: TMongoListBox;
    MongoComboBox1: TMongoComboBox;
    MongoRadioGroup1: TMongoRadioGroup;
    MongoDateTimePicker1: TMongoDateTimePicker;
    Mensagens: TMongoMemo;
    MongoRadioButton1: TMongoRadioButton;
    MongoCalendarPicker1: TMongoCalendarPicker;
    MongoToggleSwitch1: TMongoToggleSwitch;
    MongoCalendarView1: TMongoCalendarView;
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form25: TForm25;

implementation

{$R *.dfm}

procedure TForm25.Label2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute() then
  begin
    MongoImage1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TForm25.Label2MouseEnter(Sender: TObject);
begin
  Label2.Cursor := crHandPoint;
end;

procedure TForm25.Label2MouseLeave(Sender: TObject);
begin
  Label2.Cursor := crDefault;
end;

end.
