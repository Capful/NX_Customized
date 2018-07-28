@echo off

rem NX Customized 主目录
set Capful=D:\NX Customized

rem NX Customized 模板目录
set Template=%Capful%\Template\

rem NX Customized 后处理目录
set post=%Capful%\Postprocessor\

rem 备份目录
set backup=%Capful%\backup\

for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX11.ini" ^|findstr /i "NX11"') do  set "NX11=%%b"
echo ===============================================================
echo.
echo NX11安装路径为%NX11%
echo.
set "NX11meun=%NX11%\MACH\resource\template_set\"
set "NX11post=%NX11%\MACH\resource\Postprocessor\"
set "NX11moban=%NX11%\LOCALIZATION\prc\simpl_chinese\startup\"
echo.
echo 创建NX11备份
echo.
if not exist "%backup%NX 11.0"con md "%backup%NX 11.0"
if not exist "%backup%NX 11.0\cam_general.bak" copy /y "%NX11meun%cam_general.opt" "%backup%NX 11.0\cam_general.bak"
if not exist "%backup%NX 11.0\template_post.bak" copy /y "%NX11post%template_post.dat" "%backup%NX 11.0\template_post.bak"
if not exist "%backup%NX 11.0\ugs_model_templates_simpl_chinese.bak" copy /y "%NX11moban%ugs_model_templates_simpl_chinese.pax" "%backup%NX 11.0\ugs_model_templates_simpl_chinese.bak"
echo.
echo 替换NX11加工模板菜单..
copy /y "%Template%cam_general.opt" "%NX11meun%"
echo.
echo 替换NX 11后处理菜单
copy /y "%post%template_post.dat" "%NX11post%"
echo.
echo 替换NX 11系统模板菜单
copy /y "%Template%ugs_model_templates_simpl_chinese.pax" "%NX11moban%"
echo.
echo 复制NX 11后处理
copy /y "%post%post.def" "%NX11post%"
copy /y "%post%post.tcl" "%NX11post%"
copy /y "%post%ugpost_base_group1.tcl" "%NX11post%"
echo.
echo ===============================================================
pause
exit

