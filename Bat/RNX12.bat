@echo off
rem 设置变量
rem NX Customized 主目录
set Capful=D:\NX Customized

rem NX Customized 后处理目录
set post=%Capful%\Postprocessor\

rem 备份目录
set backup=%Capful%\backup\

for /f "delims== tokens=1*" %%a in ('type "%Capful%\bat\NX12.ini" ^|findstr /i "NX12"') do  set "NX12=%%b"
echo ===============================================================
echo.
set "NX12meun=%NX12%\MACH\resource\template_set\"
set "NX12post=%NX12%\MACH\resource\Postprocessor\"
echo.
echo 恢复NX 12模板菜单
echo.
if exist "%backup%NX 12.0\cam_general.bak" del /q "%NX12meun%cam_general.opt"
copy /y "%backup%NX 12.0\cam_general.bak" "%NX12meun%"
ren "%NX12meun%cam_general.bak" cam_general.opt
echo.
echo 移除NX 12模板备份
echo.
if exist "%NX12meun%cam_general.opt" del /q "%backup%NX 12.0\cam_general.bak"
echo.
echo 恢复NX 12后处理菜单
echo.
if exist "%backup%NX 12.0\template_post.bak" del /q "%NX12post%template_post.dat"
copy /y "%backup%NX 12.0\template_post.bak" "%NX12post%"
ren "%NX12post%template_post.bak" template_post.dat
echo.
echo 移除NX 12后处理备份
echo.
if exist "%NX12post%template_post.dat" del /q "%backup%NX 12.0\template_post.bak"
echo.
echo 移除NX 12后处理
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

