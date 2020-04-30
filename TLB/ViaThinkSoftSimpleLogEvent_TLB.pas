unit ViaThinkSoftSimpleLogEvent_TLB;

// ************************************************************************ //
// WARNUNG
// -------
// Die in dieser Datei deklarierten Typen wurden aus Daten einer Typbibliothek
// generiert. Wenn diese Typbibliothek explizit oder indirekt (über eine
// andere Typbibliothek) reimportiert wird oder wenn der Befehl
// 'Aktualisieren' im Typbibliotheks-Editor während des Bearbeitens der
// Typbibliothek aktiviert ist, wird der Inhalt dieser Datei neu generiert und
// alle manuell vorgenommenen Änderungen gehen verloren.
// ************************************************************************ //

// $Rev: 52393 $
// Datei am 30.04.2020 23:02:59 erzeugt aus der unten beschriebenen Typbibliothek.

// ************************************************************************  //
// Typbib.: C:\Users\DELL User\SVN\SimpleLogEvent\trunk\TLB\ViaThinkSoftSimpleLogEvent (1)
// LIBID: {D7654BA7-41D0-4FF9-8543-C3A4DA936856}
// LCID: 0
// Hilfedatei:
// Hilfe-String: ViaThinkSoftSimpleLogEvent Library
// Liste der Abhäng.:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit muss ohne Typüberprüfung für Zeiger compiliert werden.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;

// *********************************************************************//
// In der Typbibliothek deklarierte GUIDS. Die folgenden Präfixe werden verwendet:
//   Typbibliotheken      : LIBID_xxxx
//   CoClasses            : CLASS_xxxx
//   DISPInterfaces       : DIID_xxxx
//   Nicht-DISP-Interfaces: IID_xxxx
// *********************************************************************//
const
  // Haupt- und Nebenversionen der Typbibliothek
  ViaThinkSoftSimpleLogEventMajorVersion = 1;
  ViaThinkSoftSimpleLogEventMinorVersion = 0;

  LIBID_ViaThinkSoftSimpleLogEvent: TGUID = '{D7654BA7-41D0-4FF9-8543-C3A4DA936856}';

  IID_IViaThinkSoftSimpleEventLog: TGUID = '{4094657E-8199-460F-A3DD-5BB63B6B0F65}';
  CLASS_ViaThinkSoftSimpleEventLog: TGUID = '{E4270053-A217-498C-B395-9EF33187E8C2}';

// *********************************************************************//
// Deklaration von in der Typbibliothek definierten Aufzählungen
// *********************************************************************//
// Konstanten für enum LogEventType
type
  LogEventType = TOleEnum;
const
  Success = $00000000;
  Informational = $00000001;
  Warning = $00000002;
  Error = $00000003;

type

// *********************************************************************//
// Forward-Deklaration von in der Typbibliothek definierten Typen
// *********************************************************************//
  IViaThinkSoftSimpleEventLog = interface;
  IViaThinkSoftSimpleEventLogDisp = dispinterface;

// *********************************************************************//
// Deklaration von in der Typbibliothek definierten CoClasses
// (HINWEIS: Hier wird jede CoClass ihrem Standard-Interface zugewiesen)
// *********************************************************************//
  ViaThinkSoftSimpleEventLog = IViaThinkSoftSimpleEventLog;


// *********************************************************************//
// Interface: IViaThinkSoftSimpleEventLog
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4094657E-8199-460F-A3DD-5BB63B6B0F65}
// *********************************************************************//
  IViaThinkSoftSimpleEventLog = interface(IDispatch)
    ['{4094657E-8199-460F-A3DD-5BB63B6B0F65}']
    procedure LogEvent(const SourceName: WideString; EventType: LogEventType;
                       const LogMsg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IViaThinkSoftSimpleEventLogDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4094657E-8199-460F-A3DD-5BB63B6B0F65}
// *********************************************************************//
  IViaThinkSoftSimpleEventLogDisp = dispinterface
    ['{4094657E-8199-460F-A3DD-5BB63B6B0F65}']
    procedure LogEvent(const SourceName: WideString; EventType: LogEventType;
                       const LogMsg: WideString); dispid 201;
  end;

// *********************************************************************//
// Die Klasse CoViaThinkSoftSimpleEventLog stellt die Methoden Create und CreateRemote zur
// Verfügung, um Instanzen des Standard-Interface IViaThinkSoftSimpleEventLog, dargestellt
// von CoClass ViaThinkSoftSimpleEventLog, zu erzeugen. Diese Funktionen können
// von einem Client verwendet werden, der die CoClasses automatisieren
// will, die von dieser Typbibliothek dargestellt werden.
// *********************************************************************//
  CoViaThinkSoftSimpleEventLog = class
    class function Create: IViaThinkSoftSimpleEventLog;
    class function CreateRemote(const MachineName: string): IViaThinkSoftSimpleEventLog;
  end;

implementation

uses System.Win.ComObj;

class function CoViaThinkSoftSimpleEventLog.Create: IViaThinkSoftSimpleEventLog;
begin
  Result := CreateComObject(CLASS_ViaThinkSoftSimpleEventLog) as IViaThinkSoftSimpleEventLog;
end;

class function CoViaThinkSoftSimpleEventLog.CreateRemote(const MachineName: string): IViaThinkSoftSimpleEventLog;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ViaThinkSoftSimpleEventLog) as IViaThinkSoftSimpleEventLog;
end;

end.

