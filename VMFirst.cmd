@echo off
:: Check if running as admin
NET SESSION >NUL 2>&1
if %errorLevel% == 0 (
  echo Running with admin rights...
) else (
  echo Please run the script as admin.
  pause
  exit /b 1
)
:menu
cls
echo   dBP dP      dBBBBBBb     dBBBBP     dBP    BBBBBb  .dBBBBP  dBBBBBBP
echo                '   dB'                          dBP  BP               
echo  dB .BP     dB'dB'dB'    dBBBP      dBP     dBBBBK   `BBBBb    dBP    
echo  BB.BP     dB'dB'dB'    dBP        dBP     dBP  BB      dBP   dBP     
echo  BBBP     dB'dB'dB'    dBP        dBP     dBP  dB' dBBBBP'   dBP                                                                                                                        
echo.
echo.
echo An small and pretty basic script for fast first time setup of new VMs. made by Ferixy@Github
color 4
echo Please note that this script disables windows defender to reduce cpu/disk usage of the VM but it's Highly recommended to turn it back on if you are using this script on a real machine.
echo.
echo Choose an option:
echo 1. Start Debloating
echo 2. Reenable Windows defender
echo 0. Exit

set /p choice=Type the number of your choice:

if "%choice%"=="1" goto option1
if "%choice%"=="2" goto option2
if "%choice%"=="0" goto endtask

:option1
echo Debloating.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feed" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f
echo News and interests has been disabled.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f
echo Advertising ID has been disabled.
set "key=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows"
reg add "%key%\WindowsUpdate" /v "" /t REG_SZ /d "" /f >nul
reg add "%key%\WindowsUpdate\AU" /v "" /t REG_SZ /d "" /f >nul
reg add "%key%\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
echo Windows automatic updates have been disabled.
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f
echo BingSearch has been disabled.
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Windows Search" /t REG_DWORD /d 0 /f
echo Cortana has been disabled.
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f
echo MeetNow button has been disabled.
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_DWORD /d 0 /f
echo Mouse acceleration has been disabled.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
echo SearchBar has been disabled.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
echo Automatic download of promoted apps has been disabled.
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
echo Telemetry has been disabled.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f
echo Explorer now shows file extensions.
echo Killing OneDrive...
tasklist | find /i "onedrive.exe" >nul

if errorlevel 1 (
    echo OneDrive is not running. skipping OneDrive uninstallation...
) else (
    taskkill /f /im "onedrive.exe"
    echo OneDrive has been terminated.
    ping -n 2 127.0.0.1 > nul
echo Uninstalling OneDrive... This will take around 10 seconds.
%systemroot%\SysWOW64\OneDriveSetup.exe /uninstall /quiet /norestart
ping -n 10 127.0.0.1 > nul
echo OneDrive Uninstalled.
)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f
echo Explorer now shows hidden files.
echo NOTE: Please ignore the error messages below(if any appeared).
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Windows Defender" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Windows Defender" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
echo Windows defender has been disabled!!!.
echo.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
pause
goto menu

:option2
echo About to reenable windows defender...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
echo Windows defender has been reactivated. PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.                                                                                                                                                                                                                                                                                 
pause
goto menu

:endtask
echo Exiting...
