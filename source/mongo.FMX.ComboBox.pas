unit mongo.FMX.ComboBox;

interface

{$I mongo.inc}
{$ifndef FMX}
     'codigo não pode ser utilizado em projetos VCL}
{$endif}

uses
  FMX.ListBox, System.Classes, System.SysUtils, System.Variants,
  System.Generics.Collections, bsonDoc, mongoWire, bsonUtils,
  mongo.Tipificacoes, mongo.interf, mongo.types, mongo.Query;

type
  TMongoComboBox = class(TComboBox, IMongoText, IMongoControl, IMongoIndexList)
  private
    FMongoCampo: String;
    FMongoTipoCampo: TCampo;
    FText: string;
    FLookupDisplayField: string;
    FLookupQuery: TMongoQuery;
    procedure SetLookupDisplayField(const Value: string);
    procedure SetText(const Value: string);
    function GetText: string;
    function GetMongoCampo: String;
    procedure SetMongoCampo(const Value: String);
    function GetMongoTipoCampo: TCampo;
    procedure SetMongoTipoCampo(const Value: TCampo);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function toNumerico: Integer;
    function toMoeda: Currency;
    function toDataHora: TDateTime;
    procedure PreencheItens;
    procedure DoChange; override;
    function IndexOf(const nome:string):integer;
  published
    property MongoTipoCampo: TCampo read GetMongoTipoCampo write SetMongoTipoCampo default TCampo.Texto;
    property MongoCampo: String read GetMongoCampo write SetMongoCampo;
    property LookupQuery: TMongoQuery read FLookupQuery write FLookupQuery;
    property LookupDisplayField: string read FLookupDisplayField write SetLookupDisplayField;
    property Text: string read GetText write SetText;
  end;

implementation

{ TMongoComboBox }

destructor TMongoComboBox.Destroy;
var
  i: Integer;
begin
  for i := 0 to Self.Items.Count - 1 do
    Self.Items.Objects[i].Free;
  // DisposeStr( PAnsiString(PString(Self.Items.Objects[i])) );
  inherited;
end;

procedure TMongoComboBox.DoChange;
begin
  // PUnicodeString(Self.Items.Objects[Self.ItemIndex])^ ;
  if Self.ItemIndex > -1 then
    SetText(Self.Items[Self.ItemIndex]);
  inherited;
end;

function TMongoComboBox.GetMongoCampo: String;
begin
  result := FMongoCampo;
end;

function TMongoComboBox.GetMongoTipoCampo: TCampo;
begin
  result := FMongoTipoCampo;
end;

function TMongoComboBox.GetText: string;
begin
  result := FText;
end;

function TMongoComboBox.IndexOf(const nome: string): integer;
begin
   result := Items.IndexOf(nome);
end;

constructor TMongoComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TMongoComboBox.Loaded;
begin
  inherited;
  PreencheItens;
end;

procedure TMongoComboBox.PreencheItens;
var
  d: IBSONDocument;
  q: TMongoWireQuery;
begin
  if Self.FLookupQuery.Collection = '' then
    exit;
  Self.Items.Clear;
  d := BSON;
  q := TMongoWireQuery.Create(Self.FLookupQuery.MongoConexao.FMongoWire);
  try
    q.Query(Self.FLookupQuery.Collection, d);
    while q.Next(d) do
    begin
      // Self.Items.AddObject(VarToStr(d[Self.LookupDisplayField]),
      // TObject(LongInt(NewStr( VarToStr(d[Self.LookupKeyField]) ))) );
      Self.Items.Add(VarToStr(d[Self.LookupDisplayField]));
    end;
  except
    on E: Exception do
    begin
      Self.Items.Add(E.Message)
    end;
  end;
end;

procedure TMongoComboBox.SetLookupDisplayField(const Value: string);
begin
  FLookupDisplayField := Value;
end;

procedure TMongoComboBox.SetMongoCampo(const Value: String);
begin
  FMongoCampo := Value;
end;

procedure TMongoComboBox.SetMongoTipoCampo(const Value: TCampo);
begin
   FMongoTipoCampo := value;
end;

procedure TMongoComboBox.SetText(const Value: string);
begin
  FText := Value;
end;

function TMongoComboBox.toDataHora: TDateTime;
begin
  try
    result := TMongoTipificacao.toDataHora(Self.Text);
  except
    raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
  end;
end;

function TMongoComboBox.toMoeda: Currency;
begin
  try
    result := TMongoTipificacao.toMoeda(Self.Text);
  except
    raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
  end;
end;

function TMongoComboBox.toNumerico: Integer;
begin
  try
    result := TMongoTipificacao.toNumerico(Self.Text);
  except
    raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
  end;
end;

end.
