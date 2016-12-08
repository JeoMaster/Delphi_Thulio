{ *************************************************************************** }
{ Data:  04/12/2016                                                           }
{ Resenha:                                                                    }
{ *************************************************************************** }
{ Licença segue a mesma estabelecida no código original determinada pelo seu  }
{ autor                                                                       }
{                                                                             }
{ *************************************************************************** }
{
  Alterações:
  + 04/12/2016 Adicionado suporte a IMongoChecked
               incluido TMongoOperacao para diferenciar o tipo de operação ao preencher dados do documento
               incluido suporte para IMongoJSON
}

{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit mongo.Query;

interface

uses
  System.SysUtils, System.Classes, mongoWire, bsonDoc, bsonUtils,
  mongo.Interf,
{$IFDEF FMX}
  FMX.Layouts,
  FMX.Forms,
  FMX.ListBox,
{$ELSE}
  VCL.ExtCtrls,
  VCL.StdCtrls,
{$ENDIF}
  mongo.UI,
  mongo.Types,
  mongo.Document,
  mongo.Conexao,
  mongo.Tipificacoes,
  System.Generics.Collections,
  System.Variants,
  Datasnap.DBClient,
  Data.DB,
  Generics.Collections;

type
  TMongoQuery = class(TComponent)
  strict private
    function GetSequence(AMongoCampo: string): Int64;
  private
    FMongoConexao: TMongoConexao;
    FAtivar: Boolean;
    FCollection: String;
    FMongoQuery: TMongoWireQuery;
    FDataSet: TClientDataSet;
    FListBox: {$IFDEF FMX}FMX.ListBox.TListBox{$ELSE}VCL.StdCtrls.TListBox{$ENDIF};

    procedure setAtivar(const Value: Boolean);
    procedure preencherMongoDoc(Layout: TLayout; var MongoDoc: TMongoDocument; MongoOperacao: TMongoOperacao);
    procedure criarDataSetLayout(Layout: TLayout);
    procedure criarDataSetLista(Lista: TList<String>);
    function WideStringToString(const ws: WideString; codePage: Word): AnsiString;
  public
    FMongoWireQuery: TMongoWireQuery;
    constructor Create(AOwner: TComponent); override;

    function InserirLayout(Layout: TLayout): Boolean;
    function UpdateLayout(Layout: TLayout): Boolean;
    function DeleteLayout(Layout: TLayout): Boolean;
    function SelectLayout(Layout: TLayout): Boolean;
    function SelectEditLayout(Layout: TLayout): Boolean;
    function LimparLayout(Layout: TLayout): Boolean;

    procedure buscaFoneticaDataSet(Texto, Index, Campo: String);
    procedure buscaConteudo(Texto, Campo: String);
    procedure listaListBox(CampoExibir: String);

    function getCamposJsonString(JSON, Value: String): String;

    function Insert(aJson: String): Boolean;
    function Update(aJsonWhere: String; aJsonDoc: String): Boolean;
    function Remove(aJson: String): Boolean;
    function Find(aJson: String): String;
    function Command(aJson: String): String;
  published
    property MongoConexao: TMongoConexao read FMongoConexao write FMongoConexao;
    property Ativar: Boolean read FAtivar write setAtivar;
    property Collection: String read FCollection write FCollection;
    property MongoQuery: TMongoWireQuery read FMongoQuery write FMongoQuery;
    property DataSet: TClientDataSet read FDataSet write FDataSet;
    property ListBox: {$IFDEF FMX}FMX.ListBox.TListBox{$ELSE}VCL.StdCtrls.TListBox{$ENDIF} read FListBox write FListBox;
  end;

implementation

uses
  System.JSON, Winapi.Windows;

constructor TMongoQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCollection := 'MinhaCollection';
end;

procedure TMongoQuery.setAtivar(const Value: Boolean);
begin
  FAtivar := Value;
end;

function TMongoQuery.InserirLayout(Layout: TLayout): Boolean;
var
  d: IBSONDocument;
  MongoDoc: TMongoDocument;
  i: Integer;
begin
  assert(assigned(FMongoConexao), 'Não definiu a conexão para a query');
  Result := True;
  d := nil;
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc, moInsert);
      MongoDoc.convertBSON(d);
      FMongoConexao.FMongoWire.Insert(FCollection, d);
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;
end;

function TMongoQuery.LimparLayout(Layout: TLayout): Boolean;
var
  i: Integer;
begin
  for i := 0 to Pred(Layout.ControlsCount) do
  begin
    if Supports(Layout.Controls[i], IMongoText) then
      (Layout.Controls[i] as IMongoText).Text := '';

    if Supports(Layout.Controls[i], IMongoBitmap) then
    begin
      (Layout.Controls[i] as IMongoBitmap).clear;
    end;

    if Supports(Layout.Controls[i], IMongoIndexList) then
      with Layout.Controls[i] as IMongoIndexList do
      begin
        ItemIndex := -1;
        Text := '';
      end;

    if Supports(Layout.Controls[i], IMongoChecked) then
      (Layout.Controls[i] as IMongoChecked).Checked := False;

    if Supports(Layout.Controls[i], IMongoGroupBox) then
      (Layout.Controls[i] as IMongoGroupBox).ValueText := '';
  end;
end;

procedure TMongoQuery.listaListBox(CampoExibir: String);
var
  d: IBSONDocument;
  q: TMongoWireQuery;
  Aux, Aux1, Aux2: String;
  // Item: TMongoListBoxItem;
  { todo -oAmarildo Lacerda -cImportante: se incluir este codigo passa a ter dependencia da FMX - Ver como resolver }
begin
  d := BSON;
  q := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
  try
    q.Query(FCollection, BSON([]));
    FListBox.Items.clear;
    while q.Next(d) do
    begin

      Aux := BsonToJson(d);
      Aux1 := Copy(Aux, 1, Length(Aux));
      Aux2 := Copy(d[CampoExibir], 1, Length(d[CampoExibir]));

{$IFDEF FMX}
       {
       Item := TMongoListBoxItem.Create(FListBox);
       Item.Text := (Aux2);
       Item.JSON := Aux1;
       FListBox.AddObject(Item);
       }
{$ELSE}
      FListBox.Items.Add(Aux2);
      if Supports(FListBox, IMongoJSON) then
        (FListBox as IMongoJSON).JSON := Aux1;
{$ENDIF}
    end;
  finally
    q.Destroy;
  end;
end;

function TMongoQuery.UpdateLayout(Layout: TLayout): Boolean;
var
  d, dChave: IBSONDocument;
  MongoDoc: TMongoDocument;
  i: Integer;
begin
  Result := True;
  d := nil;
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc, moUpdate);
      MongoDoc.convertBSON(d);
      MongoDoc.convertCampoChave(dChave);
      FMongoConexao.FMongoWire.Update(FCollection, dChave, d);
    except
      begin
        { DONE: se houver erro não mostra para o usuario - seria interessante mostrar para orientar o que fazer }
        Result := False;
        raise;
      end;
    end;
  finally
    MongoDoc.Free;
  end;
end;

function TMongoQuery.DeleteLayout(Layout: TLayout): Boolean;
var
  d, dChave: IBSONDocument;
  MongoDoc: TMongoDocument;
  i: Integer;
begin
  Result := True;
  d := nil;
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc, moDelete);
      MongoDoc.convertCampoChave(dChave);
      FMongoConexao.FMongoWire.Delete(FCollection, dChave);
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;
end;

function TMongoQuery.SelectEditLayout(Layout: TLayout): Boolean;
var
  d, dChave: IBSONDocument;
  MongoDoc: TMongoDocument;
  i: Integer;
  suppMongoControl: Boolean;
  mongoControl: IMongoControl;
begin
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc, moBrowse);
      MongoDoc.convertCampoChave(dChave);
      d := FMongoConexao.FMongoWire.Get(FCollection, dChave);
      for i := 0 to Pred(Layout.ControlsCount) do
      begin
        suppMongoControl := Supports(Layout.Controls[i], IMongoControl);
        if suppMongoControl then
          mongoControl := Layout.Controls[i] as IMongoControl;
        // Edit
        if Supports(Layout.Controls[i], IMongoText) and suppMongoControl then
        begin
          (Layout.Controls[i] as IMongoText).Text := VarToStr(d[(mongoControl).MongoCampo]);
        end;

        // IndexList Interface  ( Combobox)
        if Supports(Layout.Controls[i], IMongoIndexList) and suppMongoControl then
          with Layout.Controls[i] as IMongoIndexList do
          begin
            Text := VarToStr(d[mongoControl.MongoCampo]);
            ItemIndex := IndexOf(Text);
          end;

        // Imagem  Interface
        if Supports(Layout.Controls[i], IMongoBitmap) then
          with Layout.Controls[i] as IMongoBitmap do
          begin
            setDataImage(VarToStrDef(d[MongoCampo],''));
          end;

        // checked Interface  (checkbox)
        if Supports(Layout.Controls[i], IMongoChecked) then
          (Layout.Controls[i] as IMongoChecked).Checked := d[(Layout.Controls[i] as IMongoChecked).MongoCampo];
          //(Layout.Controls[i] as IMongoChecked).Checked := StrToBoolDef(d[(Layout.Controls[i] as IMongoChecked).MongoCampo], False);
        if Supports(Layout.Controls[i], IMongoJSON) then
          (Layout.Controls[i] as IMongoJSON).JSON := VarToStr(d[(Layout.Controls[i] as IMongoJSON).MongoCampo]);

        // GroupBox Interface
        if Supports(Layout.Controls[i], IMongoGroupBox) and suppMongoControl then
        begin
          (Layout.Controls[i] as IMongoGroupBox).ValueText := VarToStr(d[(mongoControl).MongoCampo]);
        end;

      end;
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;

end;

function TMongoQuery.SelectLayout(Layout: TLayout): Boolean;
var
  d: IBSONDocument;
  i: Integer;
  // Edit: TEditMongo;
  // ComboBox: TComboBoxMongo;
  suppMongoControl: Boolean;
  mongoControl: IMongoControl;
begin
  Result := True;
  d := BSON;
  try
    FMongoWireQuery := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
    FMongoWireQuery.Query(FCollection, nil);
    criarDataSetLayout(Layout);
    while FMongoWireQuery.Next(d) do
    begin
      FDataSet.Append;
      for i := 0 to Pred(Layout.ControlsCount) do
      begin
        suppMongoControl := Supports(Layout.Controls[i], IMongoControl);
        if suppMongoControl then
          mongoControl := Layout.Controls[i] as IMongoControl;
        if suppMongoControl then
          with mongoControl do
          begin
            FDataSet.FieldByName(MongoCampo).AsVariant := d[MongoCampo];
          end;
      end;
      FDataSet.Post;
    end;
    FDataSet.Open;
  except
    Result := False;
  end;
end;

procedure TMongoQuery.criarDataSetLayout(Layout: TLayout);
var
  i: Integer;
  // Edit: TEditMongo;
  // ComboBox: TComboBoxMongo;
  suppMongoControl: Boolean;
  mongoControl: IMongoControl;
begin
  FDataSet.Close;
  FDataSet.FieldDefs.clear;
  for i := 0 to Pred(Layout.ControlsCount) do
  begin
    suppMongoControl := Supports(Layout.Controls[i], IMongoControl);
    if suppMongoControl then
      mongoControl := Layout.Controls[i] as IMongoControl;
    if suppMongoControl then
      with mongoControl do
      begin
        case MongoTipoCampo of
          Texto:
            FDataSet.FieldDefs.Add(MongoCampo, ftString, 255);
          Numerico:
            FDataSet.FieldDefs.Add(MongoCampo, ftInteger);
          Moeda:
            FDataSet.FieldDefs.Add(MongoCampo, ftFloat);
          DataHora:
            FDataSet.FieldDefs.Add(MongoCampo, ftString, 50);
          Booleano:
            FDataSet.FieldDefs.Add(MongoCampo, ftBoolean);
        end;
      end;
  end;
  FDataSet.CreateDataSet;
end;

procedure TMongoQuery.criarDataSetLista(Lista: TList<String>);
var
  i: Integer;
begin
  FDataSet.Close;
  FDataSet.FieldDefs.clear;
  for i := 0 to Lista.Count - 1 do
  begin
    FDataSet.FieldDefs.Add(Lista[i], ftString, 255);
  end;
  FDataSet.CreateDataSet;
end;

procedure TMongoQuery.preencherMongoDoc(Layout: TLayout; var MongoDoc: TMongoDocument; MongoOperacao: TMongoOperacao);
var
  i: Integer;
  suppIMongoControl: Boolean;
  mongoControl: IMongoControl;
  suppIMongoText: Boolean;
  mongoText: IMongoText;
  suppIMongoGroupBox: Boolean;
  mongoGroupBox: IMongoGroupBox;
begin
  for i := 0 to Pred(Layout.ControlsCount) do
  begin
    suppIMongoControl := Supports(Layout.Controls[i], IMongoControl);
    if suppIMongoControl then
      mongoControl := Layout.Controls[i] as IMongoControl;
    suppIMongoText := Supports(Layout.Controls[i], IMongoText);
    suppIMongoGroupBox := Supports(Layout.Controls[i], IMongoGroupBox);
    if suppIMongoText then
      mongoText := Layout.Controls[i] as IMongoText;
    if suppIMongoGroupBox then
      mongoGroupBox := Layout.Controls[i] as IMongoGroupBox;

    // Mongo Edit
    if Supports(Layout.Controls[i], IMongoAutoInc) then
      with (Layout.Controls[i] as IMongoAutoInc) do
        if AutoInc and suppIMongoControl then
        begin
          { todo: quando esta fazendo select o TEXT esta vazio - na primeira vez; talvez seja necessario checar }
          if (MongoOperacao = moBrowse) and (trim(Text) = '') then
            raise Exception.Create('Falta definir o valor do campo chave para buscar os dados')
          else if (MongoOperacao = moUpdate) and (trim(Text) = '') then
            raise Exception.Create('Falta definir o valor do campo chave para exclusão')
          else if (MongoOperacao = moInsert) or (trim(Text) = '') then
          begin
            // --Obtem o Sequence criando um campo "_id_%MongoCampo%"
            Text := GetSequence(mongoControl.MongoCampo).ToString;
          end;
        end;

    if suppIMongoControl and suppIMongoText then
    begin
      with mongoControl do
      begin
        if Supports(Layout.Controls[i], IMongoCampoChave) then
          with (Layout.Controls[i] as IMongoCampoChave) do
            if CampoChave and suppIMongoText then
            begin
              MongoDoc.addCampoChave(MongoCampo, mongoText.Text, MongoTipoCampo);
            end;
        case MongoTipoCampo of
          Texto:
            begin
              MongoDoc.addKey(MongoCampo, mongoText.Text, Texto);
            end;
          Numerico:
            begin
              MongoDoc.addKey(MongoCampo, mongoText.toNumerico, Numerico);
            end;
          Moeda:
            begin
              MongoDoc.addKey(MongoCampo, mongoText.toMoeda, Moeda);
            end;
          DataHora:
            begin
              MongoDoc.addKey(MongoCampo, mongoText.toDataHora, DataHora);
            end;
          Booleano:
            begin
              MongoDoc.addKey(MongoCampo, StrToBoolDef(mongoText.Text, False), Booleano);
            end;
        end;
      end;
    end else if suppIMongoControl and suppIMongoGroupBox then
    begin
         with mongoControl do
           if Supports(Layout.Controls[i], IMongoGroupBox) then
             MongoDoc.addKey(MongoCampo, mongoGroupBox.ValueText, Texto);
    end else
      // Mongo Image
      if Supports(Layout.Controls[i], IMongoBitmap) then
        with Layout.Controls[i] as IMongoBitmap do
          MongoDoc.addKey(MongoCampo, getDataImage, Texto)
      else if Supports(Layout.Controls[i], IMongoChecked) then // checked
        with (Layout.Controls[i] as IMongoChecked) do
          MongoDoc.addKey(MongoCampo, Checked, Booleano)
     { else if Supports(Layout.Controls[i], IMongoJSON) then
        with Layout.Controls[i] as IMongoJSON do
          MongoDoc.addKey(MongoCampo, JSON, Texto)
      }
  end;
end;

function TMongoQuery.GetSequence(AMongoCampo: string): Int64;
Var
  d, dChave, e: IBSONDocument; // Obj BSON
  j: TJSONObject; // Obj JSON
  sField, sComand_Save, sComand_Modify: TStringBuilder;
  sCollectionSeq, sCollectionField: string;
  iRetorno: Int64;
begin
  // -- Gerando o Sequence para o AutoIncremento
  sField := TStringBuilder.Create;
  sComand_Save := TStringBuilder.Create;
  sComand_Modify := TStringBuilder.Create;
  j := TJSONObject.Create;
  try
    sComand_Save.clear;
    sComand_Modify.clear;
    sField.clear;
    sField.Append('_id_').Append(AnsiLowerCase( AMongoCampo ));

    sCollectionSeq := '_sequence';
    sCollectionField := '_id';

    sComand_Save.Append('{ findAndModify: "')
                .Append(sCollectionSeq)
                .Append('", query: { ')
                .Append(sCollectionField)
                .Append(': "')
                .Append(FCollection)
                .Append('" }, update: {')
                .Append(sCollectionField)
                .Append(': "')
                .Append(FCollection)
                .Append('", ')
                .Append(sField.ToString)
                .Append(': 0 }, upsert:true }');

    sComand_Modify.Append('{ findAndModify: "')
                  .Append(sCollectionSeq)
                  .Append('", query: { ')
                  .Append(sCollectionField)
                  .Append(': "')
                  .Append(FCollection)
                  .Append('" }, update: { $inc: { ')
                  .Append(sField.ToString)
                  .Append(': 1 } }, new:true }');

    j.AddPair(sCollectionField, TJSONString.Create(FCollection));
    dChave := JsonToBson(j.ToJSON);

    try
      d := FMongoConexao.FMongoWire.Get(sCollectionSeq, dChave);
      iRetorno := StrToInt64(VarToStr(d[sField.ToString]));
    except
      d := JsonToBson(sComand_Save.ToString);
      e := FMongoConexao.FMongoWire.RunCommand(d);
    end;
    try
      d := JsonToBson(sComand_Modify.ToString);
      e := FMongoConexao.FMongoWire.RunCommand(d);

      Result := StrToInt(VarToStr(BSON(e['value'])[sField.ToString]));

    except
      Result := -1;
      raise EMongoException.Create('Mongo: não foi possível gerar o AutoIncremento.');
    end;
  finally
    sField.Free;
    sComand_Save.Free;
    sComand_Modify.Free;
    j.Free;
  end;
end;

procedure TMongoQuery.buscaFoneticaDataSet(Texto, Index, Campo: String);
var
  d: IBSONDocument;
  q: TMongoWireQuery;
  Lista: TList<String>;
begin
  d := BSON;
  q := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
  Lista := TList<String>.Create;
  try
    // O index já deve vir com '$'
    Lista.Add(Campo);
    criarDataSetLista(Lista);
    q.Query(FCollection, BSON([Index, BSON(['$search', Texto])]));
    FDataSet.Append;
    while q.Next(d) do
    begin
      FDataSet.FieldByName(Campo).AsVariant := d[Campo];
    end;
    FDataSet.Post;
  finally
    q.Destroy;
    Lista.Destroy;
  end;
end;

procedure TMongoQuery.buscaConteudo(Texto, Campo: String);
var
  d: IBSONDocument;
  q: TMongoWireQuery;
  Lista: TList<String>;
  i: Integer;
begin
  d := BSON;
  q := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
  Lista := TList<String>.Create;
  try
    Lista.Add(Campo);
    criarDataSetLista(Lista);
    q.Query(FCollection, BSON([Campo, BSON(['$regex', bsonRegExPrefix + '/^' + Texto, '$options', 'm'])]));

    FDataSet.DisableControls;
    for i := 0 to 1000 do
    begin
      if q.Next(d) then
      begin
        FDataSet.Append;
        FDataSet.FieldByName(Campo).AsVariant := d[Campo];
        FDataSet.Post;
      end;
    end;
    { while q.Next(d) do
      begin
      FDataSet.Append;
      FDataSet.FieldByName(Campo).AsVariant := d[Campo];
      FDataSet.Post;
      end; }
    FDataSet.EnableControls;
    FDataSet.First;
  finally
    q.Destroy;
    Lista.Destroy;
  end;
end;

function TMongoQuery.getCamposJsonString(JSON, Value: String): String;
var
  d: IBSONDocument;
begin
  d := JsonToBson(JSON);
  Result := d[Value];
end;

function TMongoQuery.WideStringToString(const ws: WideString; codePage: Word): AnsiString;
var
  l: Integer;
begin
  if ws = '' then
    Result := ''
  else
  begin
    l := WideCharToMultiByte(codePage, WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR, @ws[1], -1, nil, 0, nil, nil);
    SetLength(Result, l - 1);
    if l > 1 then
      WideCharToMultiByte(codePage, WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR, @ws[1], -1, @Result[1], l - 1, nil, nil);
  end;
end;

function TMongoQuery.Insert(aJson: String): Boolean;
var
  d: IBSONDocument;
begin
  d := JsonToBson(aJson);
  try
    FMongoConexao.FMongoWire.Insert(Self.FCollection, d);
    Result := True;
  except
    Result := False;
    raise EMongoException.Create('Mongo: não foi possível inserir o Documento');
  end;
end;

function TMongoQuery.Update(aJsonWhere: String; aJsonDoc: String): Boolean;
var
  d, R: IBSONDocument;
begin
  d := JsonToBson(aJsonDoc);
  R := JsonToBson(aJsonWhere);
  try
    FMongoConexao.FMongoWire.Update(Self.FCollection, R, d);
    Result := True;
  except
    Result := False;
    raise EMongoException.Create('Mongo: não foi possível atualizar o Documento');
  end;
end;

function TMongoQuery.Remove(aJson: String): Boolean;
var
  d: IBSONDocument;
begin
  d := JsonToBson(aJson);
  try
    FMongoConexao.FMongoWire.Delete(Self.FCollection, d);
    Result := True;
  except
    Result := False;
    raise EMongoException.Create('Mongo: não foi possível remover o Documento');
  end;

end;

function TMongoQuery.Find(aJson: String): String;
var
  d, R: IBSONDocument;
  q: TMongoWireQuery;
begin
  d := JsonToBson(aJson);
  R := BSON;
  q := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
  try
    q.Query(Self.FCollection, d);
    while q.Next(R) do
    begin
      Result := Result + BsonToJson(R) + ',';
    end;
    Result := Copy(Result, 1, Length(Result) - 1);
  except
    on e: Exception do
    begin
      Result := e.Message;
    end;
  end;
end;

function TMongoQuery.Command(aJson: String): String;
var
  d, R: IBSONDocument;
begin
  d := JsonToBson(aJson);
  try
    R := FMongoConexao.FMongoWire.RunCommand(d);
    Result := BsonToJson(R);
  except
    on e: Exception do
    begin
      Result := e.Message;
    end;
  end;
end;

end.
