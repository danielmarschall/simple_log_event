<?php

// You need to do following:
// (1) At PHP.ini you need to make following changes:
//          extension_dir = "ext"
//          extension=com_dotnet
// (2) Run following commands as administrator:
//          regsvr32 ViaThinkSoftSimpleLogEvent32.dll   (if you run 32 bit PHP)
//          regsvr32 ViaThinkSoftSimpleLogEvent64.dll   (if you run 64 bit PHP)
//          (You can also run both)

define('CLASS_ViaThinkSoftSimpleEventLog', '{E4270053-A217-498C-B395-9EF33187E8C2}');

define('LOGEVENT_MSG_SUCCESS',       0);
define('LOGEVENT_MSG_INFORMATIONAL', 1);
define('LOGEVENT_MSG_WARNING',       2);
define('LOGEVENT_MSG_ERROR',         3);

if (!class_exists('COM')) {
	die('To use ViaThinkSoftSimpleEventLog, please enable the lines "extension=com_dotnet" and "extension_dir=ext" in your PHP.ini file');
}

try {
	$x = new COM(CLASS_ViaThinkSoftSimpleEventLog);
} catch (Exception $e) {
	die('Error calling object ViaThinkSoftSimpleEventLog. Was the DLL file registered correctly? (Error: '.$e->getMessage().')');
}

if (PHP_INT_SIZE == 8) {
	$x->LogEvent('MySourceName', LOGEVENT_MSG_WARNING, 'This is a test warning written by 64 bit PHP');
} else if (PHP_INT_SIZE == 4) {
	$x->LogEvent('MySourceName', LOGEVENT_MSG_WARNING, 'This is a test warning written by 32 bit PHP');
} else {
	// Should never happen!
	$x->LogEvent('MySourceName', LOGEVENT_MSG_WARNING, 'This is a test warning written by whatever-bit PHP');
}
