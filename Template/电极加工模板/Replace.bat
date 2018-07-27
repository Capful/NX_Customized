@echo off
echo 替换最新菜单文件
echo %cd%
for /f "delims=" %%i in ('dir/b/on *.prt')do set "fn=%%i"
echo %fn%
copy "%fn%" Capful-EDM.prt