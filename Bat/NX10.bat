@echo off

rem NX Customized ��Ŀ¼
set Capful=D:\NX Customized

rem NX Customized ģ��Ŀ¼
set Template=%Capful%\Template\

rem NX Customized ����Ŀ¼
set post=%Capful%\Postprocessor\

rem ����Ŀ¼
set backup=%Capful%\backup\

for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX10.ini" ^|findstr /i "NX10"') do  set "NX10=%%b"
echo ===============================================================
echo.
echo NX10��װ·��Ϊ%NX10%
echo.
set "NX10meun=%NX10%\MACH\resource\template_set\"
set "NX10post=%NX10%\MACH\resource\Postprocessor\"
set "NX10moban=%NX10%\LOCALIZATION\prc\simpl_chinese\startup\"
echo.
echo ����NX10����
echo.
if not exist "%backup%NX 10.0"con md "%backup%NX 10.0"
if not exist "%backup%NX 10.0\cam_general.bak" copy /y "%NX10meun%cam_general.opt" "%backup%NX 10.0\cam_general.bak"
if not exist "%backup%NX 10.0\template_post.bak" copy /y "%NX10post%template_post.dat" "%backup%NX 10.0\template_post.bak"
if not exist "%backup%NX 10.0\ugs_model_templates_simpl_chinese.bak" copy /y "%NX10moban%ugs_model_templates_simpl_chinese.pax" "%backup%NX 10.0\ugs_model_templates_simpl_chinese.bak"
echo.
echo �滻NX10�ӹ�ģ��˵�..
copy /y "%Template%cam_general.opt" "%NX10meun%"
echo.
echo �滻NX 10����˵�
copy /y "%post%template_post.dat" "%NX10post%"
echo.
echo �滻NX 10ϵͳģ��˵�
copy /y "%Template%ugs_model_templates_simpl_chinese.pax" "%NX10moban%"
echo.
echo ����NX 10����
copy /y "%post%post.def" "%NX10post%"
copy /y "%post%post.tcl" "%NX10post%"
copy /y "%post%ugpost_base_group1.tcl" "%NX10post%"
echo.
echo ===============================================================
pause
exit

