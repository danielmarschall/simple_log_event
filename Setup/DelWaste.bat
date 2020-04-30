@echo off

rd /s /q "%~dp0\__history"
rd /s /q "%~dp0\__recovery"
del "%~dp0*.dcu"
del "%~dp0*.rsm"
del "%~dp0*.local"
del "%~dp0*.identcache"
