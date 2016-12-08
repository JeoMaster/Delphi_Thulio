unit mongo.UI;

interface

uses
{$IFDEF VCL}
  VCL.StdCtrls,
  VCL.ExtCtrls,
  VCL.Controls,
{$ELSE}
  FMX.Layouts,
{$ENDIF}
  System.Classes;

type
   {$IFDEF VCL}
      TLayout = VCL.ExtCtrls.TPanel;
      TMongoControlHelper = class helper for TWinControl
      public
        function ControlsCount:integer;
      end;
   {$ELSE}
      TLayout = FMX.Layouts.TLayout;
   {$ENDIF}

implementation

{$IFDEF VCL}
function TMongoControlHelper.ControlsCount: integer;
begin
   result := inherited ControlCount;
end;
{$ENDIF}

end.
