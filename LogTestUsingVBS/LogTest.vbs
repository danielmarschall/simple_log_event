Dim objMyObject

set objMyObject = CreateObject("ViaThinkSoftSimpleLogEvent.ViaThinkSoftSimpleEventLog")

const LOGEVENT_MSG_SUCCESS       = 0
const LOGEVENT_MSG_INFORMATIONAL = 1
const LOGEVENT_MSG_WARNING       = 2
const LOGEVENT_MSG_ERROR         = 3

objMyObject.LogEvent LOGEVENT_MSG_WARNING, "This is a test warning written by VBS"

MsgBox "OK"
