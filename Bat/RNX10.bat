@echo off
rem 设置变量
rem NX Customized 主目录
set Capful=D:\NX Customized

rem NX Customized 后处理目录
set post=%Capful%\Postprocessor\

rem 备份目录
set backup=%Capful%\backup\

for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX10.ini" ^|findstr /i "NX10"') do  set "NX10=%%b"
echo ===============================================================
echo.
set "NX10meun=%NX10%\MACH\resource\template_set\"
set "NX10post=%NX10%\MACH\resource\Postprocessor\"
set "NX10moban=%NX10%\LOCALIZATION\prc\simpl_chinese\startup\"
echo.
echo 恢复NX 10模板菜单
echo.
if exist "%backup%NX 10.0\cam_general.bak" del /q "%NX10meun%cam_general.opt"
copy /y "%backup%NX 10.0\cam_general.bak" "%NX10meun%"
ren "%NX10meun%cam_general.bak" cam_general.opt
echo.
echo 移除NX 10模板备份
echo.
if exist "%NX10meun%cam_general.opt" del /q "%backup%NX 10.0\cam_general.bak"
echo 恢复NX 10系统模板菜单
echo.
if exist "%backup%NX 10.0\ugs_model_templates_simpl_chinese.bak" del /q "%NX10moban%ugs_model_templates_simpl_chinese.pax"
copy /y "%backup%NX 10.0\ugs_model_templates_simpl_chinese.bak" "%NX10moban%"
ren "%NX10moban%ugs_model_templates_simpl_chinese.bak" ugs_model_templates_simpl_chinese.pax
echo.
echo 移除NX 10系统模板备份
echo.
if exist "%NX10moban%ugs_model_templates_simpl_chinese.pax" del /q "%backup%NX 10.0\ugs_model_templates_simpl_chinese.bak"
echo.
echo 恢复NX 10后处理菜单
echo.
if exist "%backup%NX 10.0\template_post.bak" del /q "%NX10post%template_post.dat"
copy /y "%backup%NX 10.0\template_post.bak" "%NX10post%"
ren "%NX10post%template_post.bak" template_post.dat
echo.
echo 移除NX 10后处理备份
echo.
if exist "%NX10post%template_post.dat" del /q "%backup%NX 10.0\template_post.bak"
echo.
echo 移除NX 10后处理
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

