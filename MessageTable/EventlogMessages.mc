; // ***** ViaThinkSoftSimpleMessage.mc *****
; // This is the header section.

MessageIdTypedef=DWORD

SeverityNames=(Success=0x0:STATUS_SEVERITY_SUCCESS
Informational=0x1:STATUS_SEVERITY_INFORMATIONAL
Warning=0x2:STATUS_SEVERITY_WARNING
Error=0x3:STATUS_SEVERITY_ERROR
)

FacilityNames=(
	SimpleMessage=0x0
)

LanguageNames=(
	Neutral=0x0:MSG00000
	German=0x407:MSG00407
	English=0x409:MSG00409
)

; // The following are message definitions.

MessageId=0x0
Severity=Success
Facility=SimpleMessage
SymbolicName=MSG_SUCCESS
Language=English
Success: %1
.
Language=German
Erfolg: %1
.
Language=Neutral
[OK] %1
.

MessageId=0x1
Severity=Informational
Facility=SimpleMessage
SymbolicName=MSG_INFORMATIONAL
Language=English
Info: %1
.
Language=German
Info: %1
.
Language=Neutral
[i] %1
.

MessageId=0x2
Severity=Warning
Facility=SimpleMessage
SymbolicName=MSG_WARNING
Language=English
Warning: %1
.
Language=German
Warnung: %1
.
Language=Neutral
[!] %1
.

MessageId=0x3
Severity=Error
Facility=SimpleMessage
SymbolicName=MSG_ERROR
Language=English
Error: %1
.
Language=German
Fehler: %1
.
Language=Neutral
[X] %1
.
