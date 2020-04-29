unit ViaThinkSoftSimpleLogEvent_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 8291 $
// File generated on 29.04.2020 21:22:15 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\VtsEventLog\ComTest2\ViaThinkSoftSimpleLogEvent.tlb (1)
// LIBID: {D7654BA7-41D0-4FF9-8543-C3A4DA936856}
// LCID: 0
// Helpfile: 
// HelpString: ViaThinkSoftSimpleLogEvent Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ViaThinkSoftSimpleLogEventMajorVersion = 1;
  ViaThinkSoftSimpleLogEventMinorVersion = 0;

  LIBID_ViaThinkSoftSimpleLogEvent: TGUID = '{D7654BA7-41D0-4FF9-8543-C3A4DA936856}';

  IID_IViaThinkSoftSimpleEventLog: TGUID = '{4094657E-8199-460F-A3DD-5BB63B6B0F65}';
  CLASS_ViaThinkSoftSimpleEventLog: TGUID = '{E4270053-A217-498C-B395-9EF33187E8C2}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IViaThinkSoftSimpleEventLog = interface;
  IViaThinkSoftSimpleEventLogDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ViaThinkSoftSimpleEventLog = IViaThinkSoftSimpleEventLog;


// *********************************************************************//
// Interface: IViaThinkSoftSimpleEventLog
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4094657E-8199-460F-A3DD-5BB63B6B0F65}
// *********************************************************************//
  IViaThinkSoftSimpleEventLog = interface(IDispatch)
    ['{4094657E-8199-460F-A3DD-5BB63B6B0F65}']
    procedure LogEvent(EventType: Integer; const LogMsg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IViaThinkSoftSimpleEventLogDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4094657E-8199-460F-A3DD-5BB63B6B0F65}
// *********************************************************************//
  IViaThinkSoftSimpleEventLogDisp = dispinterface
    ['{4094657E-8199-460F-A3DD-5BB63B6B0F65}']
    procedure LogEvent(EventType: Integer; const LogMsg: WideString); dispid 201;
  end;

// *********************************************************************//
// The Class CoViaThinkSoftSimpleEventLog provides a Create and CreateRemote method to          
// create instances of the default interface IViaThinkSoftSimpleEventLog exposed by              
// the CoClass ViaThinkSoftSimpleEventLog. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoViaThinkSoftSimpleEventLog = class
    class function Create: IViaThinkSoftSimpleEventLog;
    class function CreateRemote(const MachineName: string): IViaThinkSoftSimpleEventLog;
  end;

implementation

uses ComObj;

class function CoViaThinkSoftSimpleEventLog.Create: IViaThinkSoftSimpleEventLog;
begin
  Result := CreateComObject(CLASS_ViaThinkSoftSimpleEventLog) as IViaThinkSoftSimpleEventLog;
end;

class function CoViaThinkSoftSimpleEventLog.CreateRemote(const MachineName: string): IViaThinkSoftSimpleEventLog;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ViaThinkSoftSimpleEventLog) as IViaThinkSoftSimpleEventLog;
end;

end.
