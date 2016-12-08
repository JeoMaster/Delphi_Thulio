{ *************************************************************************** }
{ Data:  04/12/2016 }
{ Resenha: Extraido da MongoQuery para reduzir acoplamento
  { *************************************************************************** }
{ Licença segue a mesma estabelecida no código original determinada pelo seu }
{ autor }
{ }
{ *************************************************************************** }
{

  Alterações:

  + criado mongo.types para separar os tipos comuns; (por: Amarildo Lacerda)
}
unit mongo.Interf;

interface

uses mongo.types;

type

  IMongoAutoInc = interface
    ['{E16E1301-9697-449C-A7E8-07C312A44EAD}']
    procedure SetText(const value: string);
    function GetText: String;
    property Text: string read GetText write SetText;
    function GetAutoInc: boolean;
    procedure SetAutoInc(const value: boolean);
    property AutoInc: boolean read GetAutoInc write SetAutoInc;
  end;

  IMongoText = interface
    ['{B6840FCB-41A6-447D-AB63-366BD93F372C}']
    procedure SetText(const value: string);
    function GetText: String;
    property Text: string read GetText write SetText;
    function toNumerico: Integer;
    function toMoeda: Currency;
    function toDataHora: TDateTime;
  end;

  IMongoCampoChave = interface
    ['{843C0750-1D32-4F23-B7D9-E662FA87AB72}']
    function GetCampoChave: boolean;
    procedure SetCampoChave(const value: boolean);
    property CampoChave: boolean read GetCampoChave write SetCampoChave;
  end;

  IMongoControl = interface
    ['{DB37F4DE-021C-4811-881B-FFDB6AD79EB4}']
    function GetMongoCampo: String;
    procedure SetMongoCampo(const value: String);
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
    function GetMongoTipoCampo: TCampo;
    procedure SetMongoTipoCampo(const value: TCampo);
    property MongoTipoCampo: TCampo read GetMongoTipoCampo write SetMongoTipoCampo;
  end;

  IMongoIndexList = interface
    ['{73D3EB1C-4448-4F52-8B10-239643444ACF}']
    function GetItemIndex: Integer;
    procedure SetItemIndex(const value: Integer);
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    procedure SetText(const value: string);
    function GetText: String;
    property Text: string read GetText write SetText;
    function IndexOf(const name: string): Integer;
  end;

  IMongoChecked = interface
    ['{4B103CF6-B7C6-4C9F-B3B9-8E6FCD451220}']
    function GetCheckedBool: boolean;
    procedure SetCheckedBool(const value: boolean);
    property Checked: boolean read GetCheckedBool write SetCheckedBool;
    function GetMongoCampo: String;
    procedure SetMongoCampo(const value: String);
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
  end;

  IMongoJSON = interface
    ['{8A21A1AC-9012-44DB-8E99-FFC04B0CEF05}']
    function GetJSON: string;
    procedure SetJSON(const value: String);
    property JSON: String read GetJSON write SetJSON;
    function GetMongoCampo: String;
    procedure SetMongoCampo(const value: String);
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
  end;

  IMongoBitMap = interface
    ['{05D69AA2-1F3D-4651-B4BF-956824180AB1}']
    procedure Clear;
    procedure SetDataImage(const value: string);
    function getDataImage: string;
    function GetMongoCampo: String;
    procedure SetMongoCampo(const value: String);
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
  end;

implementation

end.
