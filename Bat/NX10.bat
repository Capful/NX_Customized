@echo off

rem NX Customized 主目录
set Capful=D:\NX Customized

rem NX Customized 模板目录
set Template=%Capful%\Template\

rem NX Customized 后处理目录
set post=%Capful%\Postprocessor\

rem 备份目录
set backup=%Capful%\backup\

for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX10.ini" ^|findstr /i "NX10"') do  set "NX10=%%b"
echo ===============================================================
echo.
echo NX10安装路径为%NX10%
echo.
set "NX10meun=%NX10%\MACH\resource\template_set\"
set "NX10post=%NX10%\MACH\resource\Postprocessor\"
set "NX10moban=%NX10%\LOCALIZATION\prc\simpl_chinese\startup\"
echo.
echo 创建NX10备份
echo.
if not exist "%backup%NX 10.0"con md "%backup%NX 10.0"
if not exist "%backup%NX 10.0\cam_general.bak" copy /y "%NX10meun%cam_general.opt" "%backup%NX 10.0\cam_general.bak"
if not exist "%backup%NX 10.0\template_post.bak" copy /y "%NX10post%template_post.dat" "%backup%NX 10.0\template_post.bak"
if not exist "%backup%NX 10.0\ugs_model_templates_simpl_chinese.bak" copy /y "%NX10moban%ugs_model_templates_simpl_chinese.pax" "%backup%NX 10.0\ugs_model_templates_simpl_chinese.bak"
echo.
echo 替换NX10加工模板菜单..
copy /y "%Template%cam_general.opt" "%NX10meun%"
echo.
echo 替换NX 10后处理菜单
copy /y "%post%template_post.dat" "%NX10post%"
echo.
echo 替换NX 10系统模板菜单
copy /y "%Template%ugs_model_templates_simpl_chinese.pax" "%NX10moban%"
echo.
echo 复制NX 10后处理
copy /y "%post%post.def" "%NX10post%"
copy /y "%post%post.tcl" "%NX10post%"
copy /y "%post%ugpost_base_group1.tcl" "%NX10post%"
echo.
echo ===============================================================
pause
exit

