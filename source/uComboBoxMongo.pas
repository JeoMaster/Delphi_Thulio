unit uComboBoxMongo;

interface

uses
  FMX.ListBox, System.Classes, System.SysUtils, System.Variants,
  uMongo_Tipificacoes, bsonDoc, mongoWire, bsonUtils,
  System.Generics.Collections, uMongoQuery;

type
  TComboBoxMongo = class(TComboBox)
  private
    FMongoCampo: String;
    FMongoTipoCampo: TCampo;
    FText: string;
    FLookupDisplayField: string;
    FLookupQuery: TMongoQuery;
    procedure SetLookupDisplayField(const Value: string);
    procedure SetText(const Value: string);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function toNumerico : Integer;
    function toMoeda : Currency;
    function toDataHora : TDateTime;
    procedure PreencheItens;
    procedure DoChange; override;
  published
    property MongoTipoCampo : TCampo  read FMongoTipoCampo write FMongoTipoCampo default TCampo.Texto;
    property MongoCampo : String read FMongoCampo write FMongoCampo;
    property LookupQuery: TMongoQuery read FLookupQuery write FLookupQuery;
    property LookupDisplayField: string read FLookupDisplayField write SetLookupDisplayField;
    property Text: string read FText write SetText;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mongo Components', [TComboBoxMongo]);
end;

{ TLookupMongo }

destructor TComboBoxMongo.Destroy;
var i: integer;
begin
     for i := 0 to Self.Items.Count-1 do
         Self.Items.Objects[i].Free;
         //DisposeStr( PAnsiString(PString(Self.Items.Objects[i])) );
     inherited;
end;

procedure TComboBoxMongo.DoChange;
begin
     //PUnicodeString(Self.Items.Objects[Self.ItemIndex])^ ;
     if Self.ItemIndex > -1 then
        SetText(Self.Items[Self.ItemIndex]);
     inherited;
end;

constructor TComboBoxMongo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TComboBoxMongo.Loaded;
begin
     inherited;
     PreencheItens;
end;

procedure TComboBoxMongo.PreencheItens;
var d : IBSONDocument;
    q : TMongoWireQuery;
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
             //Self.Items.AddObject(VarToStr(d[Self.LookupDisplayField]),
             //                     TObject(LongInt(NewStr( VarToStr(d[Self.LookupKeyField]) ))) );
             Self.Items.Add(VarToStr(d[Self.LookupDisplayField]));
        end;
     except
           on E : Exception do
           begin
                Self.Items.Add(E.Message)
           end;
     end;
end;

procedure TComboBoxMongo.SetLookupDisplayField(const Value: string);
begin
  FLookupDisplayField := Value;
end;

procedure TComboBoxMongo.SetText(const Value: string);
begin
  FText := Value;
end;

function TComboBoxMongo.toDataHora: TDateTime;
begin
     try
        Result := TTipificacao.toDataHora(Self.Text);
     except
           raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
     end;
end;

function TComboBoxMongo.toMoeda: Currency;
begin
     try
        Result := TTipificacao.toMoeda(Self.Text);
     except
           raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
     end;
end;

function TComboBoxMongo.toNumerico: Integer;
begin
     try
        Result := TTipificacao.toNumerico(Self.Text);
     except
           raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
     end;
end;

end.
