unit uMongoDiversos;

interface

type
  TMongoDiversos = class
    public
      function GetTemporaryDir : String;
  end;



implementation

uses
  Winapi.Windows, System.SysUtils;

Function TMongoDiversos.GetTemporaryDir: String;
var
  pNetpath: ARRAY [0 .. MAX_path - 1] of Char;
  nlength: Cardinal;
begin
  nlength := MAX_path;
  FillChar(pNetpath, SizeOF(pNetpath), #0);
  GetTemppath(nlength, pNetpath);
  Result := StrPas(pNetpath);
end;

end.
