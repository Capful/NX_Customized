@echo off
rem ���ñ���
rem NX Customized ��Ŀ¼
set Capful=D:\NX Customized

rem NX Customized ����Ŀ¼
set post=%Capful%\Postprocessor\

rem ����Ŀ¼
set backup=%Capful%\backup\

for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX12.ini" ^|findstr /i "NX12"') do  set "NX12=%%b"
echo ===============================================================
echo.
set "NX12meun=%NX12%\MACH\resource\template_set\"
set "NX12post=%NX12%\MACH\resource\Postprocessor\"
echo.
echo �ָ�NX 12ģ��˵�
echo.
if exist "%backup%NX 12.0\cam_general.bak" del /q "%NX12meun%cam_general.opt"
copy /y "%backup%NX 12.0\cam_general.bak" "%NX12meun%"
ren "%NX12meun%cam_general.bak" cam_general.opt
echo.
echo �Ƴ�NX 12ģ�屸��
echo.
if exist "%NX12meun%cam_general.opt" del /q "%backup%NX 12.0\cam_general.bak"
echo.
echo �ָ�NX 12����˵�
echo.
if exist "%backup%NX 12.0\template_post.bak" del /q "%NX12post%template_post.dat"
copy /y "%backup%NX 12.0\template_post.bak" "%NX12post%"
ren "%NX12post%template_post.bak" template_post.dat
echo.
echo �Ƴ�NX 12������
echo.
if exist "%NX12post%template_post.dat" del /q "%backup%NX 12.0\template_post.bak"
echo.
echo �Ƴ�NX 12����
echo.
del /q "%NX12post%post.def"
del /q "%NX12post%post.tcl"
del /q "%NX12post%ugpost_base_group1.tcl"
rmdir /q /s "%backup%NX 12.0"
rd "%backup%"
echo.
echo ===============================================================
pause
exit

