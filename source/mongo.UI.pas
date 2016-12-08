unit mongo.UI;

interface

uses
{$IFDEF FMX}
  FMX.Layouts,
 // FMX.Controls,
{$ELSE}
  VCL.StdCtrls,
  VCL.ExtCtrls,
  VCL.Controls,
{$ENDIF}
  System.Classes;

type
   {$ifdef FMX}
      TLayout = FMX.Layouts.TLayout;
   {$else}
      TLayout = VCL.ExtCtrls.TPanel;
      TMongoControlHelper = class helper for TWinControl
      public
        function ControlsCount:integer;
      end;
   {$endif}



implementation

{$ifndef FMX}
function TMongoControlHelper.ControlsCount: integer;
begin
   result := inherited ControlCount;
end;
{$endif}

end.
