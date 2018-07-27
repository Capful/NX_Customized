@echo off
set UGII_BASE_DIR=D:\Program Files\UGS\NX 7.5.4.4
set UGII_ROOT_DIR=%UGII_BASE_DIR%\UGII
set Path=%UGII_BASE_DIR%\ugii;%Path%
start XcDeleteParams.exe
exit