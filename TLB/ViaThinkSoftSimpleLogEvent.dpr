library ViaThinkSoftSimpleLogEvent;

uses
  ComServ,
  ViaThinkSoftSimpleLogEvent_TLB in 'ViaThinkSoftSimpleLogEvent_TLB.pas',
  ViaThinkSoftSimpleLogEvent_Impl in 'ViaThinkSoftSimpleLogEvent_Impl.pas' {ViaThinkSoftSimpleEventLog: CoClass};

{$R *.TLB}

{$R *.RES}

{$R '..\MessageTable\EventlogMessages.RES'}

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

begin
end.
