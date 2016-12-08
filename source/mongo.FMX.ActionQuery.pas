unit mongo.FMX.ActionQuery;

interface

{$I mongo.inc}
{$ifndef FMX}
     'codigo não pode ser utilizado em projetos VCL}
{$endif}

uses
  {$ifdef FMX}
    FMX.ActnList, FMX.Forms, FMX.Dialogs,
  {$else}
    VCL.ActnList, VCL.Forms,VCL.Dialogs,
  {$endif}
    System.Actions, System.SysUtils,
    mongo.Query,
    mongo.ui;

type
  TMongoInsert = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;

type
  TMongoUpdate = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;

type
  TMongoDelete = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;

type
  TMongoSelect = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;

type
  TMongoSelectEdit = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;

type
  TMongoLimpar = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;

implementation

{TMongoInsert}

procedure TMongoInsert.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.InserirLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;

end;

function TMongoInsert.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoInsert.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{TMongoUpdate}

procedure TMongoUpdate.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.UpdateLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;

end;

function TMongoUpdate.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoUpdate.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{TMongoDelete}

procedure TMongoDelete.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.DeleteLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;

end;

function TMongoDelete.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoDelete.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;


{TMongoSelect}

procedure TMongoSelect.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.SelectLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

function TMongoSelect.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoSelect.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{TMongoSelectEdit}

procedure TMongoSelectEdit.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.SelectEditLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

function TMongoSelectEdit.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoSelectEdit.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{TMongoLimpar}

procedure TMongoLimpar.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.LimparLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

function TMongoLimpar.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoLimpar.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

end.


