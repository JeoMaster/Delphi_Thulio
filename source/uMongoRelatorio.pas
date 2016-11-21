unit uMongoRelatorio;

interface

uses
  System.Classes,  VCL.Controls, VCL.Forms, uMongoDiversos;


type
  TMongoRelatorio = class(TComponent)
    private
      function css_bootstrap1 : String;
    public
      constructor Create(AOwner: TComponent); override;
      function gerarRelJson(Json : String) : String;
    published

  end;

procedure Register;

implementation

uses
  System.SysUtils;

procedure Register;
begin
  RegisterComponents('Mongo Components', [TMongoRelatorio]);
end;

constructor TMongoRelatorio.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;


function TMongoRelatorio.css_bootstrap1: String;
begin
  Result := '';

end;

function TMongoRelatorio.gerarRelJson(Json: String) : String;
var
  DirTemp : String;
  Lista : TStringList;
  MongoDiversos : TMongoDiversos;
begin
  MongoDiversos := TMongoDiversos.Create;
  Lista := TStringList.Create;
  try
    DirTemp := MongoDiversos.GetTemporaryDir;
    Lista.Add('<!DOCTYPE html>                                                  ');
    Lista.Add('  <html>                                                         ');
    Lista.Add('  <head>                                                         ');
    Lista.Add('  <meta charset="UTF-8">                                         ');
    Lista.Add('  <title>Title of the document</title>                           ');
    Lista.Add('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">');
    Lista.Add('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">');
    Lista.Add('<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> ');
    Lista.Add('  </head>                                                        ');
    Lista.Add('  <body onLoad="buildHtmlTable()">                               ');
    Lista.Add('<div class="container">');
    Lista.Add('<div class="row">');
    Lista.Add('   <div class="col-sm-12">');
    Lista.Add('<h1 align="center">Relatório de Clientes</h1>');
    Lista.Add('     <table id="excelDataTable" class="table table-striped table-hover"></table>                         ');
    Lista.Add('                                                         ');
    Lista.Add('   </div>');
    Lista.Add('</div>');
    Lista.Add('</div>');
    Lista.Add('<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>');
    Lista.Add(' <script type="text/javascript">                                 ');
    Lista.Add(' var myList=['+Json+'];                                          ');
    Lista.Add('                                                                 ');
    Lista.Add(' function buildHtmlTable() {                                     ');
    Lista.Add('  var columns = addAllColumnHeaders(myList);                     ');
    Lista.Add('                                                                 ');
    Lista.Add('  for (var i = 0 ; i < myList.length ; i++) {                    ');
    Lista.Add('      var row$ = $("<tr/>");                                     ');
    Lista.Add('      for (var colIndex = 0 ; colIndex < columns.length ; colIndex++) {     ');
    Lista.Add('          var cellValue = myList[i][columns[colIndex]];          ');
    Lista.Add('                                                                 ');
    Lista.Add('          if (cellValue == null) { cellValue = ""; }             ');
    Lista.Add('                                                                 ');
    Lista.Add('          row$.append($("<td/>").html(cellValue));               ');
    Lista.Add('      }                                                          ');
    Lista.Add('      $("#excelDataTable").append(row$);                         ');
    Lista.Add('  }                                                              ');
    Lista.Add(' }                                                               ');
    Lista.Add('                                                                 ');
    Lista.Add('                                                                 ');
    Lista.Add('  function addAllColumnHeaders(myList)                           ');
    Lista.Add('  {                                                              ');
    Lista.Add('      var columnSet = [];                                        ');
    Lista.Add('      var headerTr$ = $("<tr/>");                                ');
    Lista.Add('                                                                 ');
    Lista.Add('      for (var i = 0 ; i < myList.length ; i++) {                ');
    Lista.Add('          var rowHash = myList[i];                               ');
    Lista.Add('          for (var key in rowHash) {                             ');
    Lista.Add('              if ($.inArray(key, columnSet) == -1){              ');
    Lista.Add('                  columnSet.push(key);                           ');
    Lista.Add('                  headerTr$.append($("<th/>").html(key));        ');
    Lista.Add('              }                                                  ');
    Lista.Add('          }                                                      ');
    Lista.Add('      }                                                          ');
    Lista.Add('      $("#excelDataTable").append(headerTr$);                    ');
    Lista.Add('                                                                 ');
    Lista.Add('      return columnSet;                                          ');
    Lista.Add('  }                                                              ');
    Lista.Add('</script>                                                        ');
    Lista.Add('  </body>                                                        ');
    Lista.Add('  </html>                                                        ');
    DirTemp := DirTemp + 'htmlrel' + FormatDateTime('dmyhss', now) + '.html';
    Lista.SaveToFile(DirTemp);
    Result := DirTemp;
  finally
    FreeAndNil(Lista);
    FreeAndNil(MongoDiversos);
  end;
end;

end.
