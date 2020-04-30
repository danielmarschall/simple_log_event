
What is "ViaThinkSoft Simple Log Event"?
----------------------------------------

ViaThinkSoftSimpleLogEvent offers a COM interface for easily
logging things into the Windows Event Log.

Using a COM interface enables some applications which cannot
call arbitary DLL functions (like PHP) to write to the Event Log.

Additionally, ViaThinkSoftSimpleLogEvent registeres a "Log Event Provider"
which will prevent the message "The description for Event ID ... from source ... cannot be found"
that would show up if you would call the WinAPI function "ReportEvent"
without MessageTable/Provider.


Distribution to the end user
----------------------------

You only need to deploy SimpleLogEventSetup.exe
which is located in the folder "Setup".

The EXE file contains everything inside:
- 32 bit and 64 bit DLL (will be unpacked to target location)
- Registration procedure for COM/Typelib
- Registration procedure for SourceNames


Installation
------------

Copy the following files in a path of your choice:

	Register.bat
	UnRegister.bat
	ViaThinkSoftSimpleLogEvent32.dll
	ViaThinkSoftSimpleLogEvent64.dll

Run Register.bat as administrator (right click on the batch file).

Please do not move the DLL files after they were registered;
otherwise you need to re-register them.

If you want to use ViaThinkSoftSimpleLogEvent with PHP, you need to change
following settings in your PHP.ini:

	extension_dir = "ext"
	extension=com_dotnet


Example usage with VBScript
---------------------------

	Dim objMyObject

	set objMyObject = CreateObject("ViaThinkSoftSimpleLogEvent.ViaThinkSoftSimpleEventLog")

	const LOGEVENT_MSG_SUCCESS       = 0
	const LOGEVENT_MSG_INFORMATIONAL = 1
	const LOGEVENT_MSG_WARNING       = 2
	const LOGEVENT_MSG_ERROR         = 3

	objMyObject.LogEvent "MySourceName", LOGEVENT_MSG_WARNING, "This is a test warning written by VBS"


Example usage with PHP
----------------------

	define('CLASS_ViaThinkSoftSimpleEventLog', '{E4270053-A217-498C-B395-9EF33187E8C2}');

	define('LOGEVENT_MSG_SUCCESS',       0);
	define('LOGEVENT_MSG_INFORMATIONAL', 1);
	define('LOGEVENT_MSG_WARNING',       2);
	define('LOGEVENT_MSG_ERROR',         3);

	$x = new COM(CLASS_ViaThinkSoftSimpleEventLog);
	$x->LogEvent('MySourceName', LOGEVENT_MSG_WARNING, 'This is a test warning written by PHP');


Example usage with Delphi
-------------------------

	uses
	  ActiveX,
	  ViaThinkSoftSimpleLogEvent_TLB;

	procedure LogTest;
	var
	  x: IViaThinkSoftSimpleEventLog;
	begin
	  CoInitialize(nil); // needs to be called only once
	  x := CoViaThinkSoftSimpleEventLog.Create;
	  x.LogEvent('MySourceName', ViaThinkSoftSimpleLogEvent_TLB.Warning, 'This is a test warning written by Delphi');
	  x := nil;
	end;


A short note about the compilation workflow (for developers)
-------------------------------------------

This only applies if you want to change/extend/fork ViaThinkSoftSimpleEventLog yourself.
You do not need this if you just want to use ViaThinkSoftSimpleEventLog to log events.

1.	In folder "MessageTable":
	Run "EventlogMessagesCompile.bat", it will do:
	- MC file => RC+BIN files (using "mc.exe" from Windows SDK)
	- RC+BIN files => RES file (using "rc.exe")
	
2.	In folder "TLB":
	Compile using Delphi (it will include the MessageTable RES file):
	- ViaThinkSoftSimpleLogEvent32.dll
	- ViaThinkSoftSimpleLogEvent64.dll

3.	In folder "Setup":
	3.1 Run "DllResCompile.bat", it will do:
	    - RC file => RES file (will include the two DLLs from folder "TLB")
	3.2 Then, compile SimpleLogEventSetup.exe using Delphi

4.	In folder "LogTestUsingDelphi":
	Compile LogWriteTestDelphi*.exe using Delphi
	(it will read "ViaThinkSoftSimpleLogEvent_TLB.pas" from the "TLB" folder)


License
-------

ViaThinkSoft Simple Log Event
Copyright 2020 Daniel Marschall, ViaThinkSoft

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
