@echo off
rem ���ñ���
rem NX Customized ��Ŀ¼
set Capful=D:\NX Customized

rem NX Customized ����Ŀ¼
set post=%Capful%\Postprocessor\

rem ����Ŀ¼
set backup=%Capful%\backup\

for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX11.ini" ^|findstr /i "NX11"') do  set "NX11=%%b"
echo ===============================================================
echo.
set "NX11meun=%NX11%\MACH\resource\template_set\"
set "NX11post=%NX11%\MACH\resource\Postprocessor\"
set "NX11moban=%NX11%\LOCALIZATION\prc\simpl_chinese\startup\"
echo.
echo �ָ�NX 11ģ��˵�
echo.
if exist "%backup%NX 11.0\cam_general.bak" del /q "%NX11meun%cam_general.opt"
copy /y "%backup%NX 11.0\cam_general.bak" "%NX11meun%"
ren "%NX11meun%cam_general.bak" cam_general.opt
echo.
echo �Ƴ�NX 11ģ�屸��
echo.
if exist "%NX11meun%cam_general.opt" del /q "%backup%NX 11.0\cam_general.bak"
echo �ָ�NX 11ϵͳģ��˵�
echo.
if exist "%backup%NX 11.0\ugs_model_templates_simpl_chinese.bak" del /q "%NX11moban%ugs_model_templates_simpl_chinese.pax"
copy /y "%backup%NX 11.0\ugs_model_templates_simpl_chinese.bak" "%NX11moban%"
ren "%NX11moban%ugs_model_templates_simpl_chinese.bak" ugs_model_templates_simpl_chinese.pax
echo.
echo �Ƴ�NX 11ϵͳģ�屸��
echo.
if exist "%NX11moban%ugs_model_templates_simpl_chinese.pax" del /q "%backup%NX 11.0\ugs_model_templates_simpl_chinese.bak"
echo.
echo �ָ�NX 11����˵�
echo.
if exist "%backup%NX 11.0\template_post.bak" del /q "%NX11post%template_post.dat"
copy /y "%backup%NX 11.0\template_post.bak" "%NX11post%"
ren "%NX11post%template_post.bak" template_post.dat
echo.
echo �Ƴ�NX 11������
echo.
if exist "%NX11post%template_post.dat" del /q "%backup%NX 11.0\template_post.bak"
echo.
echo �Ƴ�NX 11����
echo.
del /q "%NX11post%post.def"
del /q "%NX11post%post.tcl"
del /q "%NX11post%ugpost_base_group1.tcl"
rmdir /q /s "%backup%NX 11.0"
rd "%backup%"
echo.
echo ===============================================================
pause
exit

