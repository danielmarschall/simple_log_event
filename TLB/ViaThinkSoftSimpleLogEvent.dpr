library ViaThinkSoftSimpleLogEvent;

uses
  ComServ,
  Registry,
  Vcl.Dialogs,
  Windows,
  SysUtils,
  ViaThinkSoftSimpleLogEvent_TLB in 'ViaThinkSoftSimpleLogEvent_TLB.pas',
  ViaThinkSoftSimpleLogEvent_Impl in 'ViaThinkSoftSimpleLogEvent_Impl.pas' {ViaThinkSoftSimpleEventLog: CoClass};

{$R *.TLB}

{$R *.RES}

{$R '..\MessageTable\EventlogMessages.RES'}

function GetOwnDllPath: string;
var
  reg: TRegistry;
  regKey: string;
begin
  result := '';
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CLASSES_ROOT;
    {$IFDEF WIN64}
    regKey := 'TypeLib\'+GuidToString(LIBID_ViaThinkSoftSimpleLogEvent)+'\1.0\0\win64';
    {$ELSE}
    regKey := 'TypeLib\'+GuidToString(LIBID_ViaThinkSoftSimpleLogEvent)+'\1.0\0\win32';
    {$ENDIF}
    if reg.OpenKeyReadOnly(regKey) then
    begin
      result := reg.ReadString('');
      reg.CloseKey;
    end;
  finally
    reg.Free;
  end;
end;

procedure RegisterEventLogProviderIfRequired;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if not reg.OpenKey('SYSTEM\CurrentControlSet\Services\Eventlog\Application\'+LOGEVENT_PROVIDER_NAME, true) then
    begin
      ShowMessage('Cannot register EventLog provider! Please run the application as administrator');
    end
    else
    begin
      reg.WriteInteger('CategoryCount', 0);
      reg.WriteInteger('TypesSupported', 7);
      reg.WriteString('EventMessageFile', GetOwnDllPath);
      reg.WriteString('CategoryMessageFile', GetOwnDllPath);
      reg.CloseKey;
    end;
  finally
    reg.Free;
  end;
end;

function DllRegisterServer: HResult;
begin
  result := ComServ.DllRegisterServer;
  RegisterEventLogProviderIfRequired;
end;

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

begin
end.
