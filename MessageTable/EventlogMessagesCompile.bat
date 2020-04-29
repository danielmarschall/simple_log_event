@echo on

del EventlogMessages.rc
del EventlogMessages.res
del MSG*.bin

rem MC => RC+BIN
"C:\Program Files (x86)\Windows Kits\10\bin\10.0.17763.0\x64\mc.exe" -c EventlogMessages.mc
rem "C:\Program Files (x86)\Windows Kits\10\bin\10.0.17763.0\x64\mc.exe" EventlogMessages.mc

rem RC => RES
"C:\Program Files (x86)\Windows Kits\10\bin\10.0.17763.0\x64\rc.exe" EventlogMessages.rc

rem RES => DLL
rem "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Tools\MSVC\14.22.27905\bin\Hostx64\x64\link.exe" /dll /noentry /machine:x86 EventlogMessages.res

pause.
