@echo off

net session >nul 2>&1
if %errorLevel% == 0 (
	regsvr32 "%~dp0ViaThinkSoftSimpleLogEvent32.dll"
	regsvr32 "%~dp0ViaThinkSoftSimpleLogEvent64.dll"
) else (
	echo.
	echo Failure: Current permissions inadequate.
	echo Please run script as administrator.
	echo.
	pause.
)
