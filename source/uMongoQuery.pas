unit uMongoQuery;

interface

uses
  System.SysUtils, System.Classes, FMX.Forms, FMX.Layouts, FMX.ListBox,
  System.Generics.Collections, System.Variants, DataSnap.DBClient, Data.DB,
  REST.JSON, mongoWire, bsonDoc, bsonUtils, uEditMongo, uConexaoMongo,
  uMongoDocument, uMongo_Tipificacoes, uMongoListBox, uCheckBoxMongo,
  uGroupBoxMongo;

type
  TMongoQuery = class(TComponent)
  strict private
      function GetSequence(AMongoCampo: string) : Int64;
    private
      FMongoConexao : TMongoConexao;
      FAtivar : Boolean;
      FCollection : String;
      FMongoQuery : TMongoWireQuery;
      FDataSet : TClientDataSet;
      FListBox: TListBox;
      procedure setAtivar(const Value: boolean);
      procedure preencherMongoDoc(Layout : TLayout; var MongoDoc : TMongoDocument);
      procedure criarDataSetLayout(Layout : TLayout);
      procedure criarDataSetLista(Lista : TList<String>);
      function WideStringToString(const ws: WideString; codePage: Word): AnsiString;
    public
       FMongoWireQuery : TMongoWireQuery;
       constructor Create(AOwner: TComponent); override;

       function InserirLayout(Layout : TLayout) : Boolean;
       function UpdateLayout(Layout : TLayout) : Boolean;
       function DeleteLayout(Layout : TLayout) : Boolean;
       function SelectLayout(Layout : TLayout) : Boolean;
       function SelectEditLayout(Layout : TLayout) : Boolean;
       function LimparLayout(Layout : TLayout) : Boolean;

       procedure buscaFoneticaDataSet(Texto, Index, Campo : String);
       procedure buscaConteudo(Texto, Campo : String);
       procedure listaListBox(CampoExibir : String);

       function getCamposJsonString(json, value:String): String;

       function Insert(aJson : String) : Boolean;
       function Update(aJsonWhere : String; aJsonDoc : String) : Boolean;
       function Remove(aJson : String) : Boolean;
       function Find(aJson : String) : String;
       function Command(aJson : String) : String;
    published
      property MongoConexao : TMongoConexao read FMongoConexao write FMongoConexao;
      property Ativar : Boolean read FAtivar write setAtivar;
      property Collection : String read FCollection write FCollection;
      property MongoQuery : TMongoWireQuery read FMongoQuery write FMongoQuery;
      property DataSet : TClientDataSet read FDataSet write FDataSet;
      property ListBox : TListBox read FListBox write FListBox;
  end;

procedure Register;

implementation

uses
  System.JSON, Winapi.Windows, uMongoListBoxItem, uComboBoxMongo;

procedure Register;
begin
  RegisterComponents('Mongo Components', [TMongoQuery]);
end;

constructor TMongoQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCollection := 'MinhaCollection';
end;

procedure TMongoQuery.setAtivar(const Value: boolean);
begin
  FAtivar := Value;
end;

function TMongoQuery.InserirLayout(Layout: TLayout) : Boolean;
var
  d : IBSONDocument;
  MongoDoc : TMongoDocument;
  i : Integer;
begin
  Result := True;
  d := nil;
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc);
      MongoDoc.convertBSON(d);
      FMongoConexao.FMongoWire.Insert(FCollection, d);
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;
end;

function TMongoQuery.LimparLayout(Layout : TLayout) : Boolean;
var
  i : Integer;
begin
  for i:= 0 to Pred(Layout.ControlsCount) do
  begin
    if (Layout.Controls[i] is TEditMongo) then
    begin
      TEditMongo(Layout.Controls[i]).Text := '';
    end;
    if (Layout.Controls[i] is TComboBoxMongo) then
    begin
      TComboBoxMongo(Layout.Controls[i]).ItemIndex := -1;
      TComboBoxMongo(Layout.Controls[i]).Text := '';
    end;
  end;
end;

procedure TMongoQuery.listaListBox(CampoExibir : String);
var
  d : IBSONDocument;
  q : TMongoWireQuery;
  Aux, Aux1, Aux2 : String;
  Item : TMongoListBoxItem;
begin
   d := BSON;
   q := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
   try
     q.Query(FCollection,BSON([]));
     FListBox.Items.Clear;
     while q.Next(d) do
     begin

      Aux := BsonToJson(d);
      Aux1 := Copy(Aux, 1, Length(Aux));
      Aux2 := Copy(d[CampoExibir], 1, Length(d[CampoExibir]));

      Item := TMongoListBoxItem.Create(FListBox);
      Item.Text := (Aux2);
      Item.JSON := Aux1;
      FListBox.AddObject(Item);
     end;
   finally
    q.Destroy;
   end;
end;

function TMongoQuery.UpdateLayout(Layout: TLayout) : Boolean;
var
  d, dChave : IBSONDocument;
  MongoDoc : TMongoDocument;
  i : Integer;
begin
  Result := True;
  d := nil;
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc);
      MongoDoc.convertBSON(d);
      MongoDoc.convertCampoChave(dChave);
      FMongoConexao.FMongoWire.Update(FCollection, dChave, d);
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;
end;

function TMongoQuery.DeleteLayout(Layout: TLayout) : Boolean;
var
  d, dChave : IBSONDocument;
  MongoDoc : TMongoDocument;
  i : Integer;
begin
  Result := True;
  d := nil;
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc);
      MongoDoc.convertCampoChave(dChave);
      FMongoConexao.FMongoWire.Delete(FCollection, dChave);
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;
end;

function TMongoQuery.SelectEditLayout(Layout : TLayout) : Boolean;
var
  d, dChave : IBSONDocument;
  MongoDoc : TMongoDocument;
  i : Integer;
  Edit : TEditMongo;
  ComboBox : TComboBoxMongo;
  CheckBox : TCheckBoxMongo;
  GroupBox : TGroupBoxMongo;
begin
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc);
      MongoDoc.convertCampoChave(dChave);
      d:=FMongoConexao.FMongoWire.Get(FCollection,dChave);
      for i:= 0 to Pred(Layout.ControlsCount) do
      begin
        if (Layout.Controls[i] is TEditMongo) then
        begin
          Edit := TEditMongo(Layout.Controls[i]);
          Edit.Text := VarToStr(d[Edit.MongoCampo]);
        end;
        if (Layout.Controls[i] is TComboBoxMongo) then
        begin
          ComboBox := TComboBoxMongo(Layout.Controls[i]);
          ComboBox.Text := VarToStr(d[ComboBox.MongoCampo]);
          ComboBox.ItemIndex := ComboBox.Items.IndexOf(ComboBox.Text);
        end;
        if (Layout.Controls[i] is TCheckBoxMongo) then
        begin
          CheckBox := TCheckBoxMongo(Layout.Controls[i]);
          if VarIsNull( d[CheckBox.MongoCampo] ) then
             CheckBox.IsChecked := false
          else
             CheckBox.IsChecked := d[CheckBox.MongoCampo];
        end;
        if (Layout.Controls[i] is TGroupBoxMongo) then
        begin
          GroupBox := TGroupBoxMongo(Layout.Controls[i]);
          GroupBox.ValueText := VarToStr(d[GroupBox.MongoCampo]);
        end;
      end;
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;

end;

function TMongoQuery.SelectLayout(Layout: TLayout) : Boolean;
var
  d : IBSONDocument;
  i : Integer;
  Edit : TEditMongo;
  ComboBox : TComboBoxMongo;
  CheckBox : TCheckBoxMongo;
  GroupBox : TGroupBoxMongo;
begin
  Result := True;
  d:=BSON;
  try
    FMongoWireQuery := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
    FMongoWireQuery.Query(FCollection, nil);
    criarDataSetLayout(Layout);
    while FMongoWireQuery.Next(d) do
    begin
      FDataSet.Append;
      for i:= 0 to Pred(Layout.ControlsCount) do
      begin
        if (Layout.Controls[i] is TEditMongo) then
        begin
          Edit := TEditMongo(Layout.Controls[i]);
          FDataSet.FieldByName(Edit.MongoCampo).AsVariant := d[Edit.MongoCampo];
        end;
        if (Layout.Controls[i] is TComboBoxMongo) then
        begin
          ComboBox := TComboBoxMongo(Layout.Controls[i]);
          FDataSet.FieldByName(ComboBox.MongoCampo).AsVariant := d[ComboBox.MongoCampo];
        end;
        if (Layout.Controls[i] is TCheckBoxMongo) then
        begin
          CheckBox := TCheckBoxMongo(Layout.Controls[i]);
          FDataSet.FieldByName(CheckBox.MongoCampo).AsBoolean := d[CheckBox.MongoCampo];
        end;
        if (Layout.Controls[i] is TGroupBoxMongo) then
        begin
          GroupBox := TGroupBoxMongo(Layout.Controls[i]);
          FDataSet.FieldByName(GroupBox.MongoCampo).AsVariant := d[GroupBox.MongoCampo];
        end;

      end;
      FDataSet.Post;
    end;
    FDataSet.Open;
  except
    Result := False;
  end;
end;

procedure TMongoQuery.criarDataSetLayout(Layout : TLayout);
var
  i : Integer;
  Edit : TEditMongo;
  ComboBox : TComboBoxMongo;
  CheckBox : TCheckBoxMongo;
begin
  FDataSet.Close;
  FDataSet.FieldDefs.Clear;
  for i:= 0 to Pred(Layout.ControlsCount) do
  begin
    if (Layout.Controls[i] is TEditMongo) then
    begin
      Edit := TEditMongo(Layout.Controls[i]);
      case Edit.MongoTipoCampo of
        Texto: FDataSet.FieldDefs.add(Edit.MongoCampo, ftString, 255);
        Numerico: FDataSet.FieldDefs.add(Edit.MongoCampo, ftInteger);
        Moeda : FDataSet.FieldDefs.add(Edit.MongoCampo, ftFloat);
        DataHora : FDataSet.FieldDefs.add(Edit.MongoCampo, ftString, 50);
      end;
    end;
    if (Layout.Controls[i] is TComboBoxMongo) then
    begin
      ComboBox := TComboBoxMongo(Layout.Controls[i]);
      case ComboBox.MongoTipoCampo of
        Texto: FDataSet.FieldDefs.add(ComboBox.MongoCampo, ftString, 255);
        Numerico: FDataSet.FieldDefs.add(ComboBox.MongoCampo, ftInteger);
        Moeda : FDataSet.FieldDefs.add(ComboBox.MongoCampo, ftFloat);
        DataHora : FDataSet.FieldDefs.add(ComboBox.MongoCampo, ftString, 50);
      end;
    end;
    if (Layout.Controls[i] is TCheckBoxMongo) then
    begin
      CheckBox := TCheckBoxMongo(Layout.Controls[i]);
      FDataSet.FieldDefs.add(CheckBox.MongoCampo, ftBoolean);
    end;

  end;
  FDataSet.CreateDataSet;
end;

procedure TMongoQuery.criarDataSetLista(Lista : TList<String>);
var
  I : Integer;
begin
  FDataSet.Close;
  FDataSet.FieldDefs.Clear;
  for I := 0 to Lista.Count -1 do
  begin
    FDataSet.FieldDefs.add(Lista[I], ftString, 255);
  end;
  FDataSet.CreateDataSet;
end;

procedure TMongoQuery.preencherMongoDoc(Layout: TLayout; var MongoDoc: TMongoDocument);
var
  i : Integer;
begin
  for i:= 0 to Pred(Layout.ControlsCount) do
  begin
    if (Layout.Controls[i] is TEditMongo) then
    begin
      if (TEditMongo(Layout.Controls[i]).AutoInc) then
      begin
        if Trim(TEditMongo(Layout.Controls[i]).Text) = '' then
        begin
          //--Obtem o Sequence criando um campo "_id_%MongoCampo%"
          TEditMongo(Layout.Controls[i]).Text := GetSequence(TEditMongo(Layout.Controls[i]).MongoCampo).ToString;
        end;
      end;

      if (TEditMongo(Layout.Controls[i]).CampoChave) then
      begin
        MongoDoc.addCampoChave(TEditMongo(Layout.Controls[i]).MongoCampo,TEditMongo(Layout.Controls[i]).Text, TEditMongo(Layout.Controls[i]).MongoTipoCampo);
      end;

      case TEditMongo(Layout.Controls[i]).MongoTipoCampo of
        Texto :
          begin
            MongoDoc.addKey(TEditMongo(Layout.Controls[i]).MongoCampo, TEditMongo(Layout.Controls[i]).Text, Texto);
          end;
        Numerico :
          begin
            MongoDoc.addKey(TEditMongo(Layout.Controls[i]).MongoCampo, TEditMongo(Layout.Controls[i]).toNumerico, Numerico);
          end;
        Moeda :
          begin
            MongoDoc.addKey(TEditMongo(Layout.Controls[i]).MongoCampo, TEditMongo(Layout.Controls[i]).toMoeda, Moeda);
          end;
        DataHora :
          begin
            MongoDoc.addKey(TEditMongo(Layout.Controls[i]).MongoCampo, TEditMongo(Layout.Controls[i]).toDataHora, DataHora);
          end;
      end;
    end;
    if (Layout.Controls[i] is TComboBoxMongo) then
    begin
      case TComboBoxMongo(Layout.Controls[i]).MongoTipoCampo of
        Texto :
          begin
            MongoDoc.addKey(TComboBoxMongo(Layout.Controls[i]).MongoCampo, TComboBoxMongo(Layout.Controls[i]).Text, Texto);
          end;
        Numerico :
          begin
            MongoDoc.addKey(TComboBoxMongo(Layout.Controls[i]).MongoCampo, TComboBoxMongo(Layout.Controls[i]).toNumerico, Numerico);
          end;
        Moeda :
          begin
            MongoDoc.addKey(TComboBoxMongo(Layout.Controls[i]).MongoCampo, TComboBoxMongo(Layout.Controls[i]).toMoeda, Moeda);
          end;
        DataHora :
          begin
            MongoDoc.addKey(TComboBoxMongo(Layout.Controls[i]).MongoCampo, TComboBoxMongo(Layout.Controls[i]).toDataHora, DataHora);
          end;
      end;
    end;
    if (Layout.Controls[i] is TCheckBoxMongo) then
    begin
         MongoDoc.addKey(TCheckBoxMongo(Layout.Controls[i]).MongoCampo, TCheckBoxMongo(Layout.Controls[i]).IsChecked, Booleano);
    end;
    if (Layout.Controls[i] is TGroupBoxMongo) then
    begin
         MongoDoc.addKey(TGroupBoxMongo(Layout.Controls[i]).MongoCampo, TGroupBoxMongo(Layout.Controls[i]).ValueText, Texto);
    end;
  end;
end;

function TMongoQuery.GetSequence(AMongoCampo: string) : Int64;
Var
  d, dChave, e: IBSONDocument; //Obj BSON
  j: TJSONObject; //Obj JSON
  sField: TStringBuilder;
  sCollectionSeq, sCollectionField,
  sComand_Save, sComand_Modify: string;
  iRetorno: Int64;
  R : TStringList;
begin
     //-- Gerando o Sequence para o AutoIncremento
     sField := TStringBuilder.Create;
     j := TJSONObject.Create;
     try
        sField.Clear;
        sField.Append('_id_').Append(AMongoCampo);

        sCollectionSeq := '_sequence';
        sCollectionField := '_id';

        sComand_Save := '{ findAndModify: "'+sCollectionSeq+'", query: { '+sCollectionField+': "'+FCollection+'" }, update: {'+sCollectionField+': "'+FCollection+'", '+sField.ToString+': 0 }, upsert:true }';
        sComand_Modify := '{ findAndModify: "'+sCollectionSeq+'", query: { '+sCollectionField+': "'+FCollection+'" }, update: { $inc: { '+sField.ToString+': 1 } }, new:true }';

        j.AddPair(sCollectionField, TJSONString.Create(FCollection));
        dChave := JsonToBson(j.ToJSON);

        try
           d := FMongoConexao.FMongoWire.Get(sCollectionSeq, dChave);
           iRetorno := StrToInt64(VarToStr(d[sField.ToString]));
        except
              d := JsonToBson(sComand_Save);
              e := FMongoConexao.FMongoWire.RunCommand(d);
        end;
        try
           d := JsonToBson(sComand_Modify);
           e := FMongoConexao.FMongoWire.RunCommand(d);

           Result := StrToInt(VarToStr(BSON(e['value'])[sField.ToString]));

        except
              Result := -1;
              raise EMongoException.Create('Mongo: não foi possível gerar o AutoIncremento.');
        end;
     finally
            sField.Free;
            j.Free;
     end;
end;

procedure TMongoQuery.buscaFoneticaDataSet(Texto, Index, Campo : String);
var
  d : IBSONDocument;
  q : TMongoWireQuery;
  Lista : TList<String>;
begin
   d := BSON;
   q := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
   Lista := TList<String>.Create;
   try
     //O index já deve vir com '$'
     Lista.Add(Campo);
     criarDataSetLista(Lista);
     q.Query(FCollection,BSON([Index, BSON(['$search', Texto])]));
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

procedure TMongoQuery.buscaConteudo(Texto, Campo : String);
var
  d : IBSONDocument;
  q : TMongoWireQuery;
  Lista : TList<String>;
  I: Integer;
begin
   d := BSON;
   q := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
   Lista := TList<String>.Create;
   try
     Lista.Add(Campo);
     criarDataSetLista(Lista);
     q.Query(FCollection,BSON([Campo, BSON(['$regex', bsonRegExPrefix+'/^'+Texto, '$options' , 'm'])]));

     FDataSet.DisableControls;
     for I := 0 to 1000 do
     begin
       if q.Next(d) then
       begin
        FDataSet.Append;
        FDataSet.FieldByName(Campo).AsVariant := d[Campo];
        FDataSet.Post;
       end;
     end;
     {while q.Next(d) do
     begin
       FDataSet.Append;
       FDataSet.FieldByName(Campo).AsVariant := d[Campo];
       FDataSet.Post;
     end;}
     FDataSet.EnableControls;
     FDataSet.First;
   finally
    q.Destroy;
    Lista.Destroy;
   end;
end;

function TMongoQuery.getCamposJsonString(Json, value:String): String;
var
  d : IBSONDocument;
begin
  d := JsonToBson(Json);
  Result := d[value];
end;

function TMongoQuery.WideStringToString(const ws: WideString; codePage: Word): AnsiString;
var
  l: integer;
begin
  if ws = '' then
    Result := ''
  else
  begin
    l := WideCharToMultiByte(codePage,
      WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
      @ws[1], - 1, nil, 0, nil, nil);
    SetLength(Result, l - 1);
    if l > 1 then
      WideCharToMultiByte(codePage,
        WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
        @ws[1], - 1, @Result[1], l - 1, nil, nil);
  end;
end;

function TMongoQuery.Insert(aJson : String) : Boolean;
var
  d : IBSONDocument;
begin
   d := JsonToBson(aJson);
   try
    FMongoConexao.FMongoWire.Insert(Self.FCollection, d);
    Result := True;
   except
    Result := false;
    raise EMongoException.Create('Mongo: não foi possível inserir o Documento');
   end;
end;

function TMongoQuery.Update(aJsonWhere : String; aJsonDoc : String) : Boolean;
var
  d, r : IBSONDocument;
begin
   d := JsonToBson(aJsonDoc);
   r := JsonToBson(aJsonWhere);
   try
    FMongoConexao.FMongoWire.Update(Self.FCollection, r, d);
    Result := True;
   except
    Result := false;
    raise EMongoException.Create('Mongo: não foi possível atualizar o Documento');
   end;
end;

function TMongoQuery.Remove(aJson : String) : Boolean;
var
  d : IBSONDocument;
begin
   d := JsonToBson(aJson);
   try
    FMongoConexao.FMongoWire.Delete(Self.FCollection, d);
    Result := True;
   except
    Result := false;
    raise EMongoException.Create('Mongo: não foi possível remover o Documento');
   end;

end;

function TMongoQuery.Find(aJson : String) : String;
var
  d, r : IBSONDocument;
  q : TMongoWireQuery;
begin
  d := JsonToBson(aJson);
  r := BSON;
  q := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
  try
    q.Query(Self.FCollection, d);
    while q.Next(r) do
    begin
      Result := Result + BsonToJson(r) + ',';
    end;
    Result := Copy(Result, 1, Length(Result)-1);
  except
    on E : Exception do
     begin
      Result := E.Message;
     end;
  end;
end;

function TMongoQuery.Command(aJson : String) : String;
var
  d, r : IBSONDocument;
begin
  d := JsonToBson(aJson);
  try
    r := FMongoConexao.FMongoWire.RunCommand(d);
    Result := BsonToJson(r);
  except
    on E : Exception do
     begin
      Result := E.Message;
     end;
  end;
end;

end.
