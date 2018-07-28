; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ��װ�����ʼ���峣��
!define PRODUCT_NAME "NX Customized"
!define PRODUCT_VERSION "2.0.0"
!define PRODUCT_PUBLISHER "Capful"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"
!include "WinMessages.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
!define MUI_ICON "Icon\Install.ico"
!define MUI_UNICON "Icon\Uninstall.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "Icon\WizardImage3.bmp"

;�޸ı���
!define MUI_WELCOMEPAGE_TITLE "\r\n   NX Customized V${PRODUCT_VERSION} ��װ��"
;�޸Ļ�ӭҳ���ϵ���������
!define MUI_WELCOMEPAGE_TEXT  "\r\n    NX Customized ��ר���� Capful ʹ��UG ���\r\n    ��ƵĶ����ļ���\r\n\r\n    �������Ҫ���������¶��ƣ�\r\n\r\n    1.����ר����ɫ�ļ���\r\n    2.�Զ���ӹ�ģ�塢�����ļ���\r\n    3.�����Ǵ����&�缫������棬��װ����ʹ�á�\r\n\r\n����$_CLICK"
; ��ӭҳ��
!insertmacro MUI_PAGE_WELCOME

; ������־
!define MUI_PAGE_HEADER_TEXT "NX Customized V${PRODUCT_VERSION} ������־"
!define MUI_PAGE_HEADER_SUBTEXT " "
!define MUI_LICENSEPAGE_TEXT_TOP "Ҫ������־�����ಿ���뻬���������·�ҳ��"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "��� ��һ��(N) > ������װ��"
!define MUI_LICENSEPAGE_BUTTON "��һ��(&N) >"
!insertmacro MUI_PAGE_LICENSE "changelog.txt"

; ���ѡ��ҳ��
!insertmacro MUI_PAGE_COMPONENTS

; ��װĿ¼ѡ��ҳ��
;!insertmacro MUI_PAGE_DIRECTORY

; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES

; ��װ���ҳ��
!insertmacro MUI_PAGE_FINISH
;!define MUI_FINISHPAGE_RUN "$INSTDIR\MAKER.exe"

; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "NX_Customized_v${PRODUCT_VERSION}.exe"
InstallDir "D:\NX Customized"
ShowInstDetails hide
ShowUnInstDetails hide
BrandingText "   Capful Build"


; ------ SEC_A �������� ------
SectionGroup /e "��������"  SEC_A

Section "�����ļ�" SEC_A1
  SectionIn RO
  SetOutPath "$INSTDIR\Bat"
  SetOverwrite ifnewer
  File "Bat\*.*"
  SetOutPath "$INSTDIR\Icon"
  File "Icon\logo.ico"
  #�ļ����Զ���ͼ��
  StrCpy $0 "$INSTDIR"
  StrCpy $1 "$INSTDIR\icon\logo.ico"
  SetOutPath "$0"
  WriteINIStr "$0\desktop.ini" ".ShellClassInfo" "IconResource" '"$1",0'
  nsExec::Exec 'attrib +s +h "$0\desktop.ini"'
  nsExec::Exec 'attrib +s "$0"'
  System::Call 'Shell32::SHChangeNotify(i 0x8000000, i 0, i 0, i 0)'
SectionEnd

Section "��ɫ�ļ�" SEC_A2
  SectionIn 2
  SetOutPath "$INSTDIR\MyRole"
  File "MyRole\*.*"
SectionEnd

SectionGroupEnd

; ------ SEC_B �ӹ�ģ�� ------
SectionGroup /e "�ӹ�ģ��"  SEC_B

Section "���ģ��/����" SEC_B1
  SectionIn RO
  SetOutPath "$INSTDIR\Template"
  File "Template\*.*"
  SetOutPath "$INSTDIR\Template\�缫�ӹ�ģ��"
  File "Template\�缫�ӹ�ģ��\*.*"
  SetOutPath "$INSTDIR\Template\Ĭ�ϼӹ�ģ��"
  File "Template\Ĭ�ϼӹ�ģ��\*.*"
  SetOutPath "$INSTDIR\Postprocessor"
  File "Postprocessor\*.*"
  Call NX10
  Call NX11
  Call NX12
SectionEnd
SectionGroupEnd

; ------ SEC_C ���ģ�� ------
SectionGroup /e "���ģ��" SEC_C

Section "�Ǵ����" SEC_C1
;  SectionIn 1 2
  SetOutPath "$INSTDIR\XcDesignCam"
  File /r "XcDesignCam\*.*"
; File /r "XcDesignCam\log\*.*"
; ����Ǵ���������
  WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "UGII_USER_DIR" "$INSTDIR\XcDesignCam"
; ˢ�»�������
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
SectionEnd

SectionGroupEnd

; �����������
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SEC_A1} "Bat �������ļ���ִ���������"
!insertmacro MUI_DESCRIPTION_TEXT ${SEC_A2} "UG10-UG12��ɫ�ļ�"
!insertmacro MUI_DESCRIPTION_TEXT ${SEC_C1} "���ƹ����Ǵ�ģ��&�缫������"
!insertmacro MUI_DESCRIPTION_TEXT ${SEC_B1} "���Ƶ�UG���ģ��/�Ǵ��Ļ��������ļ�"

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
#��ȡע����ֵ
  ReadRegStr $R0 HKLM \
    "SOFTWARE\WOW6432Node\Unigraphics Solutions\Installed Applications" "Unigraphics V28.0"
  IfFileExists $R0 0 no_nx   ;�����ֵ��������ִ��no_nx
#-----------------------------------------------------------------------
#��ȡ�ϼ�Ŀ¼��������Ŀ¼
  Push "$R0"
  Call GetParent
  Pop $R0
  Push "$R0"
  Call GetParent
  Pop $R0
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#��·��д��ע���
;  MessageBox MB_OK "NX10�Ѱ�װ,·��Ϊ��$R0"
;  WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX10" "$R0"
;  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment"
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#��·��д���ı�
;  MessageBox MB_OK "NX10�Ѱ�װ,·��Ϊ��$R0"
  FileOpen $0 "$INSTDIR\bat\NX10.ini" w
  FileWrite $0 'NX10=$R0'
  FileClose $0
#----------------------------------------------------------------------
#-----------------------------------------------------------------------
#�����ļ�
  nsExec::Exec "$INSTDIR\bat\NX10.bat"
;  ExecWait "$INSTDIR\bat\NX10.bat"
#-----------------------------------------------------------------------
  Goto end
  no_nx:
;  MessageBox MB_OK "NX10δ��װ"
  end:
  Exch $R0
  Exch $0
FunctionEnd

Function NX11
  Push $R0
  Push $0
  ClearErrors
#-----------------------------------------------------------------------
#��ȡע����ֵ
  ReadRegStr $R0 HKLM \
    "SOFTWARE\WOW6432Node\Unigraphics Solutions\Installed Applications" "Unigraphics V29.0"
  IfFileExists $R0 0 no_nx   ;�����ֵ��������ִ��no_nx
#-----------------------------------------------------------------------
#��ȡ�ϼ�Ŀ¼��������Ŀ¼
  Push "$R0"
  Call GetParent
  Pop $R0
  Push "$R0"
  Call GetParent
  Pop $R0
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#��·��д��ע���
;  MessageBox MB_OK "NX11�Ѱ�װ,·��Ϊ��$R0"
;  WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX11" "$R0"
;  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment"
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#��·��д���ı�
;  MessageBox MB_OK "NX11�Ѱ�װ,·��Ϊ��$R0"
  FileOpen $0 "$INSTDIR\bat\NX11.ini" w
  FileWrite $0 'NX11=$R0'
  FileClose $0
#----------------------------------------------------------------------
#-----------------------------------------------------------------------
#�����ļ�
  nsExec::Exec "$INSTDIR\bat\NX11.bat"
;  ExecWait "$INSTDIR\bat\NX11.bat"
#-----------------------------------------------------------------------
  Goto end
  no_nx:
;  MessageBox MB_OK "NX11δ��װ"
  end:
  Exch $R0
  Exch $0
FunctionEnd

Function NX12
  Push $R0
  Push $0
  ClearErrors
#-----------------------------------------------------------------------
#��ȡע����ֵ
  ReadRegStr $R0 HKLM \
    "SOFTWARE\WOW6432Node\Unigraphics Solutions\Installed Applications" "Unigraphics V30.0"
  IfFileExists $R0 0 no_nx   ;�����ֵ��������ִ��no_nx
#-----------------------------------------------------------------------
#��ȡ�ϼ�Ŀ¼��������Ŀ¼
  Push "$R0"
  Call GetParent
  Pop $R0
  Push "$R0"
  Call GetParent
  Pop $R0
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#��·��д��ע���
;  MessageBox MB_OK "NX12�Ѱ�װ,·��Ϊ��$R0"
;  WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX12" "$R0"
;  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment"
#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#��·��д���ı�
;  MessageBox MB_OK "NX12�Ѱ�װ,·��Ϊ��$R0"
  FileOpen $0 "$INSTDIR\bat\NX12.ini" w
  FileWrite $0 'NX12=$R0'
  FileClose $0
#----------------------------------------------------------------------
#-----------------------------------------------------------------------
#�����ļ�
  nsExec::Exec "$INSTDIR\bat\NX12.bat"
;  ExecWait "$INSTDIR\bat\NX12.bat"
#-----------------------------------------------------------------------
  Goto end
  no_nx:
;  MessageBox MB_OK "NX12δ��װ"
  end:
  Exch $R0
  Exch $0
FunctionEnd

;��ȡ�ϼ�Ŀ¼����
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
  ;�رս���
  Push $R0
  CheckProc:
  Push "ugraf.exe"
  ProcessWork::existsprocess
  Pop $R0
  IntCmp $R0 0 Done
  MessageBox MB_OKCANCEL|MB_ICONSTOP "��װ�����⵽ UG �������С�$\r$\n$\r$\n��� ��ȷ���� ǿ�ƹر�UG��ȷ�ϱ���UG�ĵ���$\r$\n��� ��ȡ���� �˳���װ����" IDCANCEL Exit
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
 *  �����ǰ�װ�����ж�ز���  *
 ******************************/

Section Uninstall
  Delete "$INSTDIR\*.*"

  RMDir /r "$INSTDIR"
; ɾ����������
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "UGII_USER_DIR"
; ˢ�»�������
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment"  /TIMEOUT=5000
SectionEnd

#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
  Abort
  ;�������Ƿ�����
  FindProcDLL::FindProc "ugraf.exe"
  Pop $R0
  IntCmp $R0 1 0 no_run
  MessageBox MB_ICONSTOP "ж�س����⵽ UG �������У���ȷ�ϱ���UG�ĵ�֮���ٹر�UG������ж�أ�"
  Quit
  no_run:
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
  Abort
  Call un.NX10
  Call un.NX11
  Call un.NX12
FunctionEnd

Function un.NX10
  Push $R0
  ClearErrors
#-----------------------------------------------------------------------
#��ȡini
  IfFileExists "$INSTDIR\bat\NX10.ini" 0 no_nx   ;����ļ���������ִ��no_nx
#-----------------------------------------------------------------------
#�ָ��ļ�
  nsExec::Exec "$INSTDIR\bat\RNX10.bat"
;  ExecWait "$INSTDIR\bat\RNX10.bat"
  ; ɾ����������
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX10"
; ˢ�»�������
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
#��ȡini
  IfFileExists "$INSTDIR\bat\NX11.ini" 0 no_nx   ;����ļ���������ִ��no_nx
#-----------------------------------------------------------------------
#�ָ��ļ�
  nsExec::Exec "$INSTDIR\bat\RNX11.bat"
;  ExecWait "$INSTDIR\bat\RNX11.bat"
  ; ɾ����������
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX11"
; ˢ�»�������
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
#��ȡini
  IfFileExists "$INSTDIR\bat\NX12.ini" 0 no_nx   ;����ļ���������ִ��no_nx
#-----------------------------------------------------------------------
#�ָ��ļ�
  nsExec::Exec "$INSTDIR\bat\RNX12.bat"
;  ExecWait "$INSTDIR\bat\RNX12.bat"
  ; ɾ����������
  DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "NX12"
; ˢ�»�������
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
#-----------------------------------------------------------------------
  Goto end
  no_nx:
  end:
  Exch $R0
FunctionEnd


