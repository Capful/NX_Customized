@echo off
rem ���ñ���
rem NX Customized ��Ŀ¼
set Capful=D:\NX Customized

rem NX Customized ����Ŀ¼
set post=%Capful%\Postprocessor\

rem ����Ŀ¼
set backup=%Capful%\backup\

for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX10.ini" ^|findstr /i "NX10"') do  set "NX10=%%b"
echo ===============================================================
echo.
set "NX10meun=%NX10%\MACH\resource\template_set\"
set "NX10post=%NX10%\MACH\resource\Postprocessor\"
echo.
echo �ָ�NX 10ģ��˵�
echo.
if exist "%backup%NX 10.0\cam_general.bak" del /q "%NX10meun%cam_general.opt"
copy /y "%backup%NX 10.0\cam_general.bak" "%NX10meun%"
ren "%NX10meun%cam_general.bak" cam_general.opt
echo.
echo �Ƴ�NX 10ģ�屸��
echo.
if exist "%NX10meun%cam_general.opt" del /q "%backup%NX 10.0\cam_general.bak"
echo.
echo �ָ�NX 10����˵�
echo.
if exist "%backup%NX 10.0\template_post.bak" del /q "%NX10post%template_post.dat"
copy /y "%backup%NX 10.0\template_post.bak" "%NX10post%"
ren "%NX10post%template_post.bak" template_post.dat
echo.
echo �Ƴ�NX 10������
echo.
if exist "%NX10post%template_post.dat" del /q "%backup%NX 10.0\template_post.bak"
echo.
echo �Ƴ�NX 10����
echo.
del /q "%NX10post%post.def"
del /q "%NX10post%post.tcl"
del /q "%NX10post%ugpost_base_group1.tcl"
rmdir /q /s "%backup%NX 10.0"
rd "%backup%"
echo.
echo ===============================================================

pause
exit

