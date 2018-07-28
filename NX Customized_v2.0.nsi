; 该脚本使用 HM VNISEdit 脚本编辑器向导产生

; 安装程序初始定义常量
!define PRODUCT_NAME "NX Customized"
!define PRODUCT_VERSION "2.0.0"
!define PRODUCT_PUBLISHER "Capful"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"
!include "WinMessages.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON "Icon\Install.ico"
!define MUI_UNICON "Icon\Uninstall.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "Icon\WizardImage3.bmp"

;修改标题
!define MUI_WELCOMEPAGE_TITLE "\r\n   NX Customized V${PRODUCT_VERSION} 安装向导"
;修改欢迎页面上的描述文字
!define MUI_WELCOMEPAGE_TEXT  "\r\n    NX Customized 是专属于 Capful 使用UG 编程\r\n    设计的定制文件。\r\n\r\n    本软件主要进行了以下定制：\r\n\r\n    1.集成专属角色文件；\r\n    2.自定义加工模板、后处理文件；\r\n    3.集成星创设计&电极外挂正版，安装即可使用。\r\n\r\n　　$_CLICK"
; 欢迎页面
!insertmacro MUI_PAGE_WELCOME

; 更新日志
!define MUI_PAGE_HEADER_TEXT "NX Customized V${PRODUCT_VERSION} 更新日志"
!define MUI_PAGE_HEADER_SUBTEXT " "
!define MUI_LICENSEPAGE_TEXT_TOP "要更新日志的其余部分请滑动滚轮往下翻页。"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "点击 下一步(N) > 继续安装。"
!define MUI_LICENSEPAGE_BUTTON "下一步(&N) >"
!insertmacro MUI_PAGE_LICENSE "changelog.txt"

; 组件选择页面
!insertmacro MUI_PAGE_COMPONENTS

; 安装目录选择页面
;!insertmacro MUI_PAGE_DIRECTORY

; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES

; 安装完成页面
!insertmacro MUI_PAGE_FINISH
;!define MUI_FINISHPAGE_RUN "$INSTDIR\MAKER.exe"

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "NX_Customized_v${PRODUCT_VERSION}.exe"
InstallDir "D:\NX Customized"
ShowInstDetails hide
ShowUnInstDetails hide
BrandingText "   Capful Build"


; ------ SEC_A 基本定制 ------
SectionGroup /e "基本定制"  SEC_A

Section "基础文件" SEC_A1
  SectionIn RO
  SetOutPath "$INSTDIR\Bat"
  SetOverwrite ifnewer
  File "Bat\*.*"
  SetOutPath "$INSTDIR\Icon"
  File "Icon\logo.ico"
  #文件夹自定义图标
  StrCpy $0 "$INSTDIR"
  StrCpy $1 "$INSTDIR\icon\logo.ico"
  SetOutPath "$0"
  WriteINIStr "$0\desktop.ini" ".ShellClassInfo" "IconResource" '"$1",0'
  nsExec::Exec 'attrib +s +h "$0\desktop.ini"'
  nsExec::Exec 'attrib +s "$0"'
  System::Call 'Shell32::SHChangeNotify(i 0x8000000, i 0, i 0, i 0)'
SectionEnd

Section "角色文件" SEC_A2
  SectionIn 2
  SetOutPath "$INSTDIR\MyRole"
  File "MyRole\*.*"
SectionEnd

SectionGroupEnd

; ------ SEC_B 加工模块 ------
SectionGroup /e "加工模块"  SEC_B

Section "编程模板/后处理" SEC_B1
  SectionIn RO
  SetOutPath "$INSTDIR\Template"
  File "Template\*.*"
  SetOutPath "$INSTDIR\Template\电极加工模板"
  File "Template\电极加工模板\*.*"
  SetOutPath "$INSTDIR\Template\默认加工模板"
  File "Template\默认加工模板\*.*"
  SetOutPath "$INSTDIR\Postprocessor"
  File "Postprocessor\*.*"
  Call NX10
  Call NX11
  Call NX12
SectionEnd
SectionGroupEnd

; ------ SEC_C 设计模块 ------
SectionGroup /e "设计模块" SEC_C

Section "星创外挂" SEC_C1
;  SectionIn 1 2
  SetOutPath "$INSTDIR\XcDesignCam"
  File /r "XcDesignCam\*.*"
; File /r "XcDesignCam\log\*.*"
; 添加星创环境变量
  WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "UGII_USER_DIR" "$INSTDIR\XcDesignCam"
; 刷新环境变量
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
SectionEnd

SectionGroupEnd

; 区段组件描述
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SEC_A1} "Bat 批处理文件，执行相关配置"
!insertmacro MUI_DESCRIPTION_TEXT ${SEC_A2} "UG10-UG12角色文件"
!insertmacro MUI_DESCRIPTION_TEXT ${SEC_C1} "定制过的星创模具&电极设计外挂"
!insertmacro MUI_DESCRIPTION_TEXT ${SEC_B1} "定制的UG编程模板/星创的机床后处理文件"

!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section -Post
  WriteUninstaller "$INSTDIR\Uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\icon\logo.ico"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function NX10
  Push $R0
  Push $0
  ClearErrors
#-----------------------------------------------------------------------
#获取注册表键值
  ReadRegStr $R0 HKLM \
    "SOFTWARE\WOW6432Node\Unigraphics Solutions\Installed Applications" "Unigraphics V28.0"
  IfFileExists $R0 0 no_nx   ;如果键值不存在则执行no_nx
#-----------------------------------------------------------------------
#获取上级目录，上三级目录
  Push "$R0"
  Call GetParent
  Pop $R0
  Push "$R0"
  Call GetParent
  Pop $R0
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#将路径写入注册表
;  MessageBox MB_OK "NX10已安装,路径为：$R0"
;  WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX10" "$R0"
;  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment"
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#将路径写入文本
;  MessageBox MB_OK "NX10已安装,路径为：$R0"
  FileOpen $0 "$INSTDIR\bat\NX10.ini" w
  FileWrite $0 'NX10=$R0'
  FileClose $0
#----------------------------------------------------------------------
#-----------------------------------------------------------------------
#复制文件
  nsExec::Exec "$INSTDIR\bat\NX10.bat"
;  ExecWait "$INSTDIR\bat\NX10.bat"
#-----------------------------------------------------------------------
  Goto end
  no_nx:
;  MessageBox MB_OK "NX10未安装"
  end:
  Exch $R0
  Exch $0
FunctionEnd

Function NX11
  Push $R0
  Push $0
  ClearErrors
#-----------------------------------------------------------------------
#获取注册表键值
  ReadRegStr $R0 HKLM \
    "SOFTWARE\WOW6432Node\Unigraphics Solutions\Installed Applications" "Unigraphics V29.0"
  IfFileExists $R0 0 no_nx   ;如果键值不存在则执行no_nx
#-----------------------------------------------------------------------
#获取上级目录，上三级目录
  Push "$R0"
  Call GetParent
  Pop $R0
  Push "$R0"
  Call GetParent
  Pop $R0
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#将路径写入注册表
;  MessageBox MB_OK "NX11已安装,路径为：$R0"
;  WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX11" "$R0"
;  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment"
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#将路径写入文本
;  MessageBox MB_OK "NX11已安装,路径为：$R0"
  FileOpen $0 "$INSTDIR\bat\NX11.ini" w
  FileWrite $0 'NX11=$R0'
  FileClose $0
#----------------------------------------------------------------------
#-----------------------------------------------------------------------
#复制文件
  nsExec::Exec "$INSTDIR\bat\NX11.bat"
;  ExecWait "$INSTDIR\bat\NX11.bat"
#-----------------------------------------------------------------------
  Goto end
  no_nx:
;  MessageBox MB_OK "NX11未安装"
  end:
  Exch $R0
  Exch $0
FunctionEnd

Function NX12
  Push $R0
  Push $0
  ClearErrors
#-----------------------------------------------------------------------
#获取注册表键值
  ReadRegStr $R0 HKLM \
    "SOFTWARE\WOW6432Node\Unigraphics Solutions\Installed Applications" "Unigraphics V30.0"
  IfFileExists $R0 0 no_nx   ;如果键值不存在则执行no_nx
#-----------------------------------------------------------------------
#获取上级目录，上三级目录
  Push "$R0"
  Call GetParent
  Pop $R0
  Push "$R0"
  Call GetParent
  Pop $R0
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#将路径写入注册表
;  MessageBox MB_OK "NX12已安装,路径为：$R0"
;  WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX12" "$R0"
;  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment"
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#将路径写入文本
;  MessageBox MB_OK "NX12已安装,路径为：$R0"
  FileOpen $0 "$INSTDIR\bat\NX12.ini" w
  FileWrite $0 'NX12=$R0'
  FileClose $0
#----------------------------------------------------------------------
#-----------------------------------------------------------------------
#复制文件
  nsExec::Exec "$INSTDIR\bat\NX12.bat"
;  ExecWait "$INSTDIR\bat\NX12.bat"
#-----------------------------------------------------------------------
  Goto end
  no_nx:
;  MessageBox MB_OK "NX12未安装"
  end:
  Exch $R0
  Exch $0
FunctionEnd

;获取上级目录函数
Function GetParent
  Exch $R0
  Push $R1
  Push $R2
  Push $R3
  StrCpy $R1 0
  StrLen $R2 $R0
  loop:
  IntOp $R1 $R1 + 1
  IntCmp $R1 $R2 get 0 get
  StrCpy $R3 $R0 1 -$R1
  StrCmp $R3 "\" get
  Goto loop
  get:
  StrCpy $R0 $R0 -$R1
  Pop $R3
  Pop $R2
  Pop $R1
  Exch $R0
FunctionEnd

Function .onInit
  ;关闭进程
  Push $R0
  CheckProc:
  Push "ugraf.exe"
  ProcessWork::existsprocess
  Pop $R0
  IntCmp $R0 0 Done
  MessageBox MB_OKCANCEL|MB_ICONSTOP "安装程序检测到 UG 正在运行。$\r$\n$\r$\n点击 “确定” 强制关闭UG，确认保存UG文档。$\r$\n点击 “取消” 退出安装程序。" IDCANCEL Exit
  Push "ugraf.exe"
  Processwork::KillProcess
  Sleep 1000
  Goto CheckProc
  Exit:
  Abort
  Done:
  Pop $R0
FunctionEnd


/******************************
 *  以下是安装程序的卸载部分  *
 ******************************/

Section Uninstall
  Delete "$INSTDIR\*.*"

  RMDir /r "$INSTDIR"
; 删除环境变量
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "UGII_USER_DIR"
; 刷新环境变量
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment"  /TIMEOUT=5000
SectionEnd

#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
  ;检测程序是否运行
  FindProcDLL::FindProc "ugraf.exe"
  Pop $R0
  IntCmp $R0 1 0 no_run
  MessageBox MB_ICONSTOP "卸载程序检测到 UG 正在运行，请确认保存UG文档之后再关闭UG，继续卸载！"
  Quit
  no_run:
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
  Call un.NX10
  Call un.NX11
  Call un.NX12
FunctionEnd

Function un.NX10
  Push $R0
  ClearErrors
#-----------------------------------------------------------------------
#获取ini
  IfFileExists "$INSTDIR\bat\NX10.ini" 0 no_nx   ;如果文件不存在则执行no_nx
#-----------------------------------------------------------------------
#恢复文件
  nsExec::Exec "$INSTDIR\bat\RNX10.bat"
;  ExecWait "$INSTDIR\bat\RNX10.bat"
  ; 删除环境变量
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX10"
; 刷新环境变量
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
#-----------------------------------------------------------------------
  Goto end
  no_nx:
  end:
  Exch $R0
FunctionEnd

Function un.NX11
  Push $R0
  ClearErrors
#-----------------------------------------------------------------------
#获取ini
  IfFileExists "$INSTDIR\bat\NX11.ini" 0 no_nx   ;如果文件不存在则执行no_nx
#-----------------------------------------------------------------------
#恢复文件
  nsExec::Exec "$INSTDIR\bat\RNX11.bat"
;  ExecWait "$INSTDIR\bat\RNX11.bat"
  ; 删除环境变量
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX11"
; 刷新环境变量
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
#-----------------------------------------------------------------------
  Goto end
  no_nx:
  end:
  Exch $R0
FunctionEnd

Function un.NX12
  Push $R0
  ClearErrors
#-----------------------------------------------------------------------
#获取ini
  IfFileExists "$INSTDIR\bat\NX12.ini" 0 no_nx   ;如果文件不存在则执行no_nx
#-----------------------------------------------------------------------
#恢复文件
  nsExec::Exec "$INSTDIR\bat\RNX12.bat"
;  ExecWait "$INSTDIR\bat\RNX12.bat"
  ; 删除环境变量
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX12"
; 刷新环境变量
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
#-----------------------------------------------------------------------
  Goto end
  no_nx:
  end:
  Exch $R0
FunctionEnd


