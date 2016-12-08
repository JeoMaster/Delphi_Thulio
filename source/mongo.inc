{$IFDEF FMX}
  {$UNDEF VCL}
{$ELSE}
  {$IFDEF VCL}
    {$UNDEF FMX}
  {$ELSE}
    {$DEFINE FMX}
  {$ENDIF}
{$ENDIF}


