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
echo  BBBP     dB'dB'dB'    dBP        dBP     dBP  dB' dBBBBP'   dBP  V1.5                                                                                                                      
echo.
echo.
echo A small and pretty basic script for fast first time setup of new VMs. made by Ferixy@Github
color 4
echo Please note that this script disables windows defender to reduce cpu/disk usage of the VM but it is Highly recommended to turn it back on if you are using this script on a real machine.
echo.
echo Choose an option:
echo 1. Start Debloating
echo 2. Disable Windows updates
echo 3. Uninstall Edge and Install Firefox (not ready yet)
echo 4. ReEnable Windows Defender
echo 5. ReEnable Windows Updates
echo 6. Install HitmanPro (Second opinion malware scanner) (not ready yet)
echo 0. Exit

set /p choice=Type the number of your choice:

if "%choice%"=="1" goto option1
if "%choice%"=="2" goto option2
if "%choice%"=="3" goto option3
if "%choice%"=="4" goto option4
if "%choice%"=="5" goto option5
if "%choice%"=="6" goto option6
if "%choice%"=="0" goto endtask

:option1
echo Debloating.
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f >nul 2>&1
echo Dark mode has been enabled.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feed" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f >nul 2>&1
echo News and interests has been disabled.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode " /t REG_DWORD /d 2 /f >nul 2>&1
echo Advertising ID has been reset and disabled.
set "key=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows" >nul
reg add "%key%\WindowsUpdate" /v "" /t REG_SZ /d "" /f >nul
reg add "%key%\WindowsUpdate\AU" /v "" /t REG_SZ /d "" /f >nul
reg add "%key%\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
echo Windows automatic updates have been disabled.
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul 2>&1
echo BingSearch has been disabled.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
echo Cortana has been disabled.
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f >nul 2>&1
echo MeetNow button has been disabled.
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_DWORD /d 0 /f >nul 2>&1
echo Mouse acceleration has been disabled.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul 2>&1
echo SearchBar has been disabled.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo Automatic download of promoted apps has been disabled.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
sc config DiagTrack start= disabledsc config dmwappushservice start= disabled >nul 2>&1
sc delete DiagTrack >nul 2>&1
sc delete dmwappushservice >nul 2>&1
echo Telemetry has been disabled.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul 2>&1
echo Explorer now shows file extensions.
echo Killing OneDrive...
tasklist | find /i "onedrive.exe" >nul

if errorlevel 1 (
    echo OneDrive is not running. skipping OneDrive uninstallation...
) else (
    taskkill /f /im "onedrive.exe"
    echo Starting OneDrive uninstaller.
    ping -n 2 127.0.0.1 > nul
echo Uninstalling OneDrive... This will take around 10 seconds.
%systemroot%\SysWOW64\OneDriveSetup.exe /uninstall /quiet /norestart
ping -n 10 127.0.0.1 > nul
echo OneDrive Uninstalled.
)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f >nul 2>&1
echo Explorer now shows hidden files.
powercfg -h off
echo Hibernation has been disabled.
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f > nul 2>&1
echo Delivery Optimization has been disabled.
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocation /t REG_DWORD /d 1 /f > nul 2>&1
echo Location service has been been disabled.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "Game DVR" /t REG_DWORD /d 1 /f >nul 2>&1
echo Game DVR has been disabled.
del /q/f/s %TEMP%\* >nul 2>&1
echo Temp files have been deleted.
if exist "C:\Windows.old" (
    echo cleaning up Windows.old folder...
    rmdir /s /q "C:\Windows.old"
    echo Windows.old folder deleted.
) else (
    echo Couldn't find Windows.old. skipping...
)
echo Stopping Windows Update service...
net stop wuauserv >nul 2>&1

echo Cleaning up windows updates...
RD /S /Q "C:\Windows\SoftwareDistribution" >nul 2>&1

echo Cleanup done! Reenabling Windows Update service...
sc config wuauserv start=auto >nul 2>&1
net start wuauserv >nul 2>&1
echo Windows Update service has been reenabled.
echo restarting file explorer...
taskkill /f /im explorer.exe
start explorer.exe
echo explorer.exe has been restarted.
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Windows Defender" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Windows Defender" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul 2>&1
echo Windows defender has been disabled!!!.
echo.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo PLEASE RESTART YOUR SYSTEM FOR CHANGES TO TAKE EFFECT.
echo.
pause
goto menu

:option2
echo Warning: Disabling Windows updates can leave your system vulnerable to security threats and other issues.
echo It is strongly recommended to keep Windows updates enabled.
echo.
echo Are you sure you want to disable Windows updates? (Y/N)
set /p confirmation=
if /i "%confirmation%"=="Y" (
echo planting a bomb in windows update service...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "AUOptions" /t REG_DWORD /d 1 /f>nul 2>&1
net stop wuauserv >nul 2>&1
sc config wuauserv start= disabled >nul 2>&1
echo.
echo Windows updates are now disabled. Please restart your computer to detonate the bomb.
) else (
echo Operation canceled. Windows updates will remain enabled.
)
echo.
pause
goto menu

:option3
echo this option is not ready yet ):
echo.
pause
goto menu


:option4
echo About to reenable windows defender...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 0 /f
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

:option5
echo ReEnabling Windows updates, hold tight...
echo.
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "AUOptions" /f>nul 2>&1
sc config wuauserv start= auto >nul 2>&1
net start wuauserv >nul 2>&1
sc config wuauserv start= auto >nul 2>&1
echo Windows updates have been ReEnabled. Please restart your computer for the changes to take effect.
echo.
pause
goto menu

:option6
echo this option is not ready yet ):
echo.
pause
goto menu

:endtask
echo.
echo Exiting...
