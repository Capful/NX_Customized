@echo off

rem NX Customized ��Ŀ¼
set Capful=D:\NX Customized

rem NX Customized ģ��Ŀ¼
set Template=%Capful%\Template\

rem NX Customized ����Ŀ¼
set post=%Capful%\Postprocessor\

rem ����Ŀ¼
set backup=%Capful%\backup\


for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX11.ini" ^|findstr /i "NX11"') do  set "NX11=%%b"
echo ===============================================================
echo.
echo NX10��װ·��Ϊ%NX11%
echo.
set "NX10meun=%NX11%\MACH\resource\template_set\"
set "NX10post=%NX11%\MACH\resource\Postprocessor\"
echo.
echo ����NX11����
echo.
if not exist "%backup%NX 11.0"con md "%backup%NX 11.0"
if not exist "%backup%NX 11.0\cam_general.bak" copy /y "%NX11meun%cam_general.opt" "%backup%NX 11.0\cam_general.bak"
if not exist "%backup%NX 11.0\template_post.bak" copy /y "%NX11post%template_post.dat" "%backup%NX 11.0\template_post.bak"
echo.
echo �滻NX11�ӹ�ģ��˵�..
copy /y "%Template%cam_general.opt" "%NX11meun%"
echo.
echo �滻NX 11����˵�
copy /y "%post%template_post.dat" "%NX11post%"
echo.
echo ����NX 11����
copy /y "%post%post.def" "%NX11post%"
copy /y "%post%post.tcl" "%NX11post%"
copy /y "%post%ugpost_base_group1.tcl" "%NX11post%"
echo.
echo ===============================================================
pause
exit

