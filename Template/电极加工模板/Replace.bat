@echo off
echo �滻���²˵��ļ�
echo %cd%
for /f "delims=" %%i in ('dir/b/on *.prt')do set "fn=%%i"
echo %fn%
copy "%fn%" Capful-EDM.prt