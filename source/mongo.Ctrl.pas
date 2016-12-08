unit mongo.Ctrl;

interface

uses
  System.Classes, System.SysUtils, System.VarUtils, System.Variants,
  System.Generics.Collections, System.JSON,
  System.JSONConsts, System.StrUtils;

type

  IMatch = Interface
  ['{3BF60F61-5B26-47E3-BD0B-6B44EF9A897E}']
    function Add(const Value : IMatch) : IMatch;
    function Result : String;
  end;

  TTypeComparison = (tcEq, tcGt, tcGte, tcLt, tcLte, tcNe, tcIn, tcNin, tcRegex, tcExists);
  TTypeLogical    = (tlor, tland, tlnot, tlnor);

  TMatch = class(TInterfacedObject, IMatch)
  public
    function Add(const Value : IMatch) : IMatch; virtual; abstract;
    function Result: string; virtual; abstract;
  end;

  TComparison = class(TMatch)
  private
    FField      : String;
    FComparison : TTypeComparison;
    FValue      : Variant;
    constructor InternalCreate(const Field : String; Comparison : TTypeComparison; Value : Variant);
  public
    class function New(const Field : String; Comparison : TTypeComparison; Value : Variant) : IMatch;
    function Result : String; override;
  end;

  TMatchID = class(TComparison)
  public
    class function New(const Value : Integer) : IMatch;
  end;

  TLogical = class(TMatch)
  private
    FLogical : TTypeLogical;
    FValue   : TMatch;
    constructor InternalCreate(const Logical : TTypeLogical; Value : IMatch);
  public
    class function New(const Logical : TTypeLogical; Value : IMatch) : IMatch;
    function Result : String; override;
  end;

  TMatchItens = class(TMatch)
  private
    FItens : TObjectList<TMatch>;
    constructor InternalCreate;
  public
    destructor Destroy; override;
    class function New : IMatch;
    function Add(const Value : IMatch) : IMatch; override;
    function Result: string; override;
  end;

implementation

{ TComparison }

constructor TComparison.InternalCreate(const Field: String; Comparison: TTypeComparison; Value: Variant);
begin
  Create;
  FField      := Field;
  FComparison := Comparison;
  FValue      := Value;
end;

class function TComparison.New(const Field: String; Comparison: TTypeComparison; Value: Variant): IMatch;
begin
  Result := InternalCreate(Field, Comparison, Value);
end;

function TComparison.Result: String;

  function RetComparison : String;
  begin
    case FComparison of
      tcEq     : Result := '$eq';
      tcGt     : Result := '$gt';
      tcGte    : Result := '$gte';
      tcLt     : Result := '$lt';
      tcLte    : Result := '$lte';
      tcNe     : Result := '$ne';
      tcIn     : Result := '$in';
      tcNin    : Result := '$nin';
      tcRegex  : Result := '$regex';
      tcExists : Result := '$exists';
    else
      Result := '$eq';
    end;
  end;

  function RetValue : String;
  begin
    if FComparison = tcRegex then
      Result := QuotedStr(VarToStr(FValue)) + ' , $options : ''i'' '
    else
    if FComparison = tcExists then
      Result := LowerCase(VarToStr(FValue))
    else
    if VarIsStr(FValue) then
      Result := QuotedStr(VarToStr(FValue))
    else
      Result := VarToStr(FValue);
  end;

begin
  Result := ' { ' +
            QuotedStr(FField) +
            ' : { ' +
            RetComparison +
            ' : ' +
            RetValue +
            ' } } ';
end;

{ TMatchID }

class function TMatchID.New(const Value: Integer): IMatch;
begin
  Result := InternalCreate('id', tcEq, Value);
end;

{ TLogical }

constructor TLogical.InternalCreate(const Logical: TTypeLogical; Value: IMatch);
begin
  Create;
  FLogical := Logical;
  FValue   := TMatch(Value);
end;

class function TLogical.New(const Logical: TTypeLogical; Value: IMatch): IMatch;
begin
  Result := InternalCreate(Logical, Value);
end;

function TLogical.Result: String;

  function RetLogical : String;
  begin
    case FLogical of
      tlor  : Result := '$or';
      tland : Result := '$and';
      tlnot : Result := '$not';
      tlnor : Result := '$nor';
    end;
  end;

begin
  Result := '{ ' + RetLogical + ' : [ ' + FValue.Result + ' ] }';
end;

{ TMatchItens }

constructor TMatchItens.InternalCreate;
begin
  Create;
  FItens := TObjectList<TMatch>.Create;
end;

function TMatchItens.Add(const Value: IMatch): IMatch;
begin
  FItens.Add(TMatch(Value));
  Result := Self;
end;

destructor TMatchItens.Destroy;
begin
  FItens := nil;
  inherited;
end;

class function TMatchItens.New: IMatch;
begin
  Result := InternalCreate;
end;

function TMatchItens.Result: string;
var
  I: Integer;
begin
  for I := 0 to FItens.Count - 1 do
  begin
    if FItens[I] is TComparison then
    begin
      Result := Result + TComparison(FItens[I]).Result;
      if I < (FItens.Count - 1) then
        Result := Result + ' , ';
    end
    else
    if FItens[I] is TLogical then
    begin
      Result := Result + TLogical(FItens[I]).Result;
      if I < (FItens.Count - 1) then
        Result := Result + ' , ';
    end
    else
  end;
end;

end.
