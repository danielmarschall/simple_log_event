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
    procedure LogSimulate(const SourceName: WideString; EventType: LogEventType; const LogMsg: WideString;
          out Reason: OleVariant); safecall;
  end;

implementation

uses ComServ, Windows, SysUtils;

const
  MSG_SUCCESS        = $20000000;
  MSG_INFORMATIONAL  = $60000001;
  MSG_WARNING        = $A0000002;
  MSG_ERROR          = $E0000003;

procedure WriteEventLog(AProvider: string; AEventType: word; AEventId: Cardinal; AEntry: string);
var
  EventLog: THandle;
  P: Pointer;
begin
  P := PChar(AEntry);
  EventLog := RegisterEventSource(nil, PChar(AProvider));
  if EventLog = 0 then
  begin
    raise Exception.CreateFmt('RegisterEventSource failed with error code %d', [GetLastError]);
  end;
  if EventLog <> 0 then
  try
    if not ReportEvent(EventLog, // event log handle
          AEventType,     // event type
          0,              // category zero
          AEventId,       // event identifier
          nil,            // no user security identifier
          1,              // one substitution string
          0,              // no data
          @P,             // pointer to string array
          nil) then       // pointer to data
    begin
      raise Exception.CreateFmt('ReportEvent failed with error code %d', [GetLastError]);
    end;
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
    else
    begin
      raise Exception.CreateFmt('ViaThinkSoftSimpleEventLog.LogEvent: Unexpected event type %d', [Ord(EventType)]);
    end;
  end;
end;

procedure TViaThinkSoftSimpleEventLog.LogSimulate(const SourceName: WideString; EventType: LogEventType;
          const LogMsg: WideString; out Reason: OleVariant);
var
  EventLog: THandle;
begin
  try
    Reason := '';
    if (EventType < 0) or (EventType > ViaThinkSoftSimpleLogEvent_TLB.Error) then
    begin
      Reason := Format('Unexpected event type %d', [Ord(EventType)]);
      Exit;
    end;

    EventLog := RegisterEventSource(nil, PChar(SourceName));
    if EventLog = 0 then
    begin
      Reason := Format('RegisterEventSource failed with error code %d', [GetLastError]);
      Exit;
    end
    else
    begin
      DeregisterEventSource(EventLog);
    end;
  except
    on E: Exception do
    begin
      Reason := Format('Unexpected error: %s', [e.Message]);
    end;
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TViaThinkSoftSimpleEventLog, Class_ViaThinkSoftSimpleEventLog,
    ciMultiInstance, tmApartment);
end.
