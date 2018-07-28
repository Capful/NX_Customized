@echo off

rem NX Customized 主目录
set Capful=D:\NX Customized

rem NX Customized 模板目录
set Template=%Capful%\Template\

rem NX Customized 后处理目录
set post=%Capful%\Postprocessor\

rem 备份目录
set backup=%Capful%\backup\

for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX12.ini" ^|findstr /i "NX12"') do  set "NX12=%%b"
echo ===============================================================
echo.
echo NX12安装路径为%NX12%
echo.
set "NX12meun=%NX12%\MACH\resource\template_set\"
set "NX12post=%NX12%\MACH\resource\Postprocessor\"
set "NX12moban=%NX12%\LOCALIZATION\prc\simpl_chinese\startup\"
echo.
echo 创建NX12备份
echo.
if not exist "%backup%NX 12.0"con md "%backup%NX 12.0"
if not exist "%backup%NX 12.0\cam_general.bak" copy /y "%NX12meun%cam_general.opt" "%backup%NX 12.0\cam_general.bak"
if not exist "%backup%NX 12.0\template_post.bak" copy /y "%NX12post%template_post.dat" "%backup%NX 12.0\template_post.bak"
if not exist "%backup%NX 12.0\ugs_model_templates_simpl_chinese.bak" copy /y "%NX12moban%ugs_model_templates_simpl_chinese.pax" "%backup%NX 12.0\ugs_model_templates_simpl_chinese.bak"
echo.
echo 替换NX12加工模板菜单..
copy /y "%Template%cam_general.opt" "%NX12meun%"
echo.
echo 替换NX 12后处理菜单
copy /y "%post%template_post.dat" "%NX12post%"
echo.
echo 替换NX 12系统模板菜单
copy /y "%Template%ugs_model_templates_simpl_chinese.pax" "%NX12moban%"
echo.
echo 复制NX 12后处理
copy /y "%post%post.def" "%NX12post%"
copy /y "%post%post.tcl" "%NX12post%"
copy /y "%post%ugpost_base_group1.tcl" "%NX12post%"
echo.
echo ===============================================================
pause
exit

