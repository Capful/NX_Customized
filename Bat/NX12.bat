@echo off

rem NX Customized ��Ŀ¼
set Capful=D:\NX Customized

rem NX Customized ģ��Ŀ¼
set Template=%Capful%\Template\

rem NX Customized ����Ŀ¼
set post=%Capful%\Postprocessor\

rem ����Ŀ¼
set backup=%Capful%\backup\

for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX12.ini" ^|findstr /i "NX12"') do  set "NX12=%%b"
echo ===============================================================
echo.
echo NX12��װ·��Ϊ%NX12%
echo.
set "NX12meun=%NX12%\MACH\resource\template_set\"
set "NX12post=%NX12%\MACH\resource\Postprocessor\"
set "NX12moban=%NX12%\LOCALIZATION\prc\simpl_chinese\startup\"
echo.
echo ����NX12����
echo.
if not exist "%backup%NX 12.0"con md "%backup%NX 12.0"
if not exist "%backup%NX 12.0\cam_general.bak" copy /y "%NX12meun%cam_general.opt" "%backup%NX 12.0\cam_general.bak"
if not exist "%backup%NX 12.0\template_post.bak" copy /y "%NX12post%template_post.dat" "%backup%NX 12.0\template_post.bak"
if not exist "%backup%NX 12.0\ugs_model_templates_simpl_chinese.bak" copy /y "%NX12moban%ugs_model_templates_simpl_chinese.pax" "%backup%NX 12.0\ugs_model_templates_simpl_chinese.bak"
echo.
echo �滻NX12�ӹ�ģ��˵�..
copy /y "%Template%cam_general.opt" "%NX12meun%"
echo.
echo �滻NX 12����˵�
copy /y "%post%template_post.dat" "%NX12post%"
echo.
echo �滻NX 12ϵͳģ��˵�
copy /y "%Template%ugs_model_templates_simpl_chinese.pax" "%NX12moban%"
echo.
echo ����NX 12����
copy /y "%post%post.def" "%NX12post%"
copy /y "%post%post.tcl" "%NX12post%"
copy /y "%post%ugpost_base_group1.tcl" "%NX12post%"
echo.
echo ===============================================================
pause
exit

