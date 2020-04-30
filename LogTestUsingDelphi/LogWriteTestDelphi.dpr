program LogWriteTestDelphi;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  ActiveX,
  ViaThinkSoftSimpleLogEvent_TLB in '..\TLB\ViaThinkSoftSimpleLogEvent_TLB.pas';

var
  x: IViaThinkSoftSimpleEventLog;
begin
  try
    CoInitialize(nil);
    x := CoViaThinkSoftSimpleEventLog.Create;
    {$IFDEF WIN64}
    x.LogEvent('MySourceName', ViaThinkSoftSimpleLogEvent_TLB.Warning, 'This is a test warning written by Delphi 64 bit');
    {$ELSE}
    x.LogEvent('MySourceName', ViaThinkSoftSimpleLogEvent_TLB.Warning, 'This is a test warning written by Delphi 32 bit');
    {$ENDIF}
    x := nil;
    //CoUninitialize; // TODO: If I do this, I get an access violation at process end?!
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
