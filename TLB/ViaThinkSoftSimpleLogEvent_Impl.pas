unit ViaThinkSoftSimpleLogEvent_Impl;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, ViaThinkSoftSimpleLogEvent_TLB, StdVcl;

type
  TViaThinkSoftSimpleEventLog = class(TAutoObject, IViaThinkSoftSimpleEventLog)
  protected
    procedure LogEvent(const SourceName: WideString; EventType: LogEventType; const LogMsg: WideString);
          safecall;
  end;

implementation

uses ComServ, Windows;

const
  MSG_SUCCESS        = $20000000;
  MSG_INFORMATIONAL  = $60000001;
  MSG_WARNING        = $A0000002;
  MSG_ERROR          = $E0000003;

function WriteEventLog(AProvider: string; AEventType: word; AEventId: Cardinal; AEntry: string): boolean;
var
  EventLog: integer;
  P: Pointer;
begin
  Result := False;
  P := PChar(AEntry);
  EventLog := RegisterEventSource(nil, PChar(AProvider));
  if EventLog <> 0 then
  try
    ReportEvent(EventLog, // event log handle
          AEventType,     // event type
          0,              // category zero
          AEventId,       // event identifier
          nil,            // no user security identifier
          1,              // one substitution string
          0,              // no data
          @P,             // pointer to string array
          nil);           // pointer to data
    Result := True;
  finally
    DeregisterEventSource(EventLog);
  end;
end;

procedure TViaThinkSoftSimpleEventLog.LogEvent(const SourceName: WideString; EventType: LogEventType;
          const LogMsg: WideString);
begin
  case EventType of
    ViaThinkSoftSimpleLogEvent_TLB.Success:
      WriteEventLog(SourceName, EVENTLOG_SUCCESS,          MSG_SUCCESS,       LogMsg);
    ViaThinkSoftSimpleLogEvent_TLB.Informational:
      WriteEventLog(SourceName, EVENTLOG_INFORMATION_TYPE, MSG_INFORMATIONAL, LogMsg);
    ViaThinkSoftSimpleLogEvent_TLB.Warning:
      WriteEventLog(SourceName, EVENTLOG_WARNING_TYPE,     MSG_WARNING,       LogMsg);
    ViaThinkSoftSimpleLogEvent_TLB.Error:
      WriteEventLog(SourceName, EVENTLOG_ERROR_TYPE,       MSG_ERROR,         LogMsg);
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TViaThinkSoftSimpleEventLog, Class_ViaThinkSoftSimpleEventLog,
    ciMultiInstance, tmApartment);
end.
