{ *************************************************************************** }
{ Data:  04/12/2016 }
{ Resenha:
  { *************************************************************************** }
{ Licença segue a mesma estabelecida no código original determinada pelo seu }
{ autor }
{ }
{ *************************************************************************** }
{

  Alterações:

  + incluidor checagem diretiva FMX (por: AL)

  projetos FMX precisam indicar que vão carregar a biblioteca FMX

}
unit mongo.VCL.Actions;

interface

{$I mongo.inc}
{$IFDEF FMX}
  'codigo não pode ser utilizado em projetos FMX}
{$ENDIF}
uses
  VCL.ActnList, VCL.Forms, VCL.Dialogs, System.Actions, System.SysUtils,
  mongo.Query, mongo.ui;

type
  TVCLMongoInsert = class(TAction)
  private
    FMongoQuery: TMongoQuery;
    FLayout: TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery: TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout: TLayout read FLayout write FLayout;
  end;

type
  TVCLMongoUpdate = class(TAction)
  private
    FMongoQuery: TMongoQuery;
    FLayout: TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery: TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout: TLayout read FLayout write FLayout;
  end;

type
  TVCLMongoDelete = class(TAction)
  private
    FMongoQuery: TMongoQuery;
    FLayout: TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery: TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout: TLayout read FLayout write FLayout;
  end;

type
  TVCLMongoSelect = class(TAction)
  private
    FMongoQuery: TMongoQuery;
    FLayout: TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery: TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout: TLayout read FLayout write FLayout;
  end;

type
  TVCLMongoSelectEdit = class(TAction)
  private
    FMongoQuery: TMongoQuery;
    FLayout: TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery: TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout: TLayout read FLayout write FLayout;
  end;

type
  TVCLMongoLimpar = class(TAction)
  private
    FMongoQuery: TMongoQuery;
    FLayout: TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery: TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout: TLayout read FLayout write FLayout;
  end;

implementation

{ TVCLMongoInsert }
const
  constFaltaDefinirLayout = 'Não definiu o Layout conteiner para os objetos de edição (%s)';
  constFaltaDefinirQuery = 'Não denifiu a query na Action (%s)';

procedure TVCLMongoInsert.ExecuteTarget(Target: TObject);
begin
  assert(assigned(FLayout), format(constFaltaDefinirLayout, [name]));
  assert(assigned(MongoQuery), format(constFaltaDefinirQuery, [name]));
  try
    MongoQuery.InserirLayout(FLayout);
  Except
    on E: Exception do
      ShowMessage(E.Message);
  end;

end;

function TVCLMongoInsert.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TVCLMongoInsert.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{ TVCLMongoUpdate }

procedure TVCLMongoUpdate.ExecuteTarget(Target: TObject);
begin
  assert(assigned(FLayout), format(constFaltaDefinirLayout, [name]));
  assert(assigned(MongoQuery), format(constFaltaDefinirQuery, [name]));
  try
    MongoQuery.UpdateLayout(FLayout);
  Except
    on E: Exception do
      ShowMessage(E.Message);
  end;

end;

function TVCLMongoUpdate.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TVCLMongoUpdate.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{ TVCLMongoDelete }

procedure TVCLMongoDelete.ExecuteTarget(Target: TObject);
begin
  assert(assigned(FLayout), format(constFaltaDefinirLayout, [name]));
  assert(assigned(MongoQuery), format(constFaltaDefinirQuery, [name]));
  try
    MongoQuery.DeleteLayout(FLayout);
  Except
    on E: Exception do
      ShowMessage(E.Message);
  end;

end;

function TVCLMongoDelete.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TVCLMongoDelete.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{ TVCLMongoSelect }

procedure TVCLMongoSelect.ExecuteTarget(Target: TObject);
begin
  assert(assigned(FLayout), format(constFaltaDefinirLayout, [name]));
  assert(assigned(MongoQuery), format(constFaltaDefinirQuery, [name]));

  try
    MongoQuery.SelectLayout(FLayout);
  Except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

function TVCLMongoSelect.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TVCLMongoSelect.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{ TVCLMongoSelectEdit }

procedure TVCLMongoSelectEdit.ExecuteTarget(Target: TObject);
begin
  assert(assigned(FLayout), format(constFaltaDefinirLayout, [name]));
  assert(assigned(MongoQuery), format(constFaltaDefinirQuery, [name]));
  try
    MongoQuery.SelectEditLayout(FLayout);
  Except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

function TVCLMongoSelectEdit.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TVCLMongoSelectEdit.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{ TVCLMongoLimpar }

procedure TVCLMongoLimpar.ExecuteTarget(Target: TObject);
begin
  assert(assigned(FLayout), format(constFaltaDefinirLayout, [name]));
  assert(assigned(MongoQuery), format(constFaltaDefinirQuery, [name]));
  try
    MongoQuery.LimparLayout(FLayout);
  Except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

function TVCLMongoLimpar.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TVCLMongoLimpar.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

end.
