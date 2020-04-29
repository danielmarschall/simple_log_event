unit ViaThinkSoftSimpleLogEvent_Impl;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, ViaThinkSoftSimpleLogEvent_TLB, StdVcl;

type
  TViaThinkSoftSimpleEventLog = class(TAutoObject, IViaThinkSoftSimpleEventLog)
  protected
    procedure LogEvent(EventType: Integer; const LogMsg: WideString); safecall;
  end;

const
  LOGEVENT_PROVIDER_NAME = 'ViaThinkSoft';

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

procedure TViaThinkSoftSimpleEventLog.LogEvent(EventType: Integer;
  const LogMsg: WideString);
begin
  case EventType of
    0:
      WriteEventLog(LOGEVENT_PROVIDER_NAME, EVENTLOG_SUCCESS,          MSG_SUCCESS,       LogMsg);
    1:
      WriteEventLog(LOGEVENT_PROVIDER_NAME, EVENTLOG_INFORMATION_TYPE, MSG_INFORMATIONAL, LogMsg);
    2:
      WriteEventLog(LOGEVENT_PROVIDER_NAME, EVENTLOG_WARNING_TYPE,     MSG_WARNING,       LogMsg);
    3:
      WriteEventLog(LOGEVENT_PROVIDER_NAME, EVENTLOG_ERROR_TYPE,       MSG_ERROR,         LogMsg);
    else
      // TODO: Exception/Error ?
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TViaThinkSoftSimpleEventLog, Class_ViaThinkSoftSimpleEventLog,
    ciMultiInstance, tmApartment);
end.
