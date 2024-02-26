@echo off
NET SESSION >NUL 2>&1
if %errorLevel% == 0 (
  echo Running with admin rights...
) else (
  echo VMFIRST A script by Ferixy@Github: Please run the script as admin.
  pause
  exit /b 1
)
:menu
set "_title=VMFIRST 2.1"

title %_title%
cls
echo   dBP dP      dBBBBBBb     dBBBBP     dBP    BBBBBb  .dBBBBP  dBBBBBBP
echo                '   dB'                          dBP  BP               
echo  dB .BP     dB'dB'dB'    dBBBP      dBP     dBBBBK   `BBBBb    dBP    
echo  BB.BP     dB'dB'dB'    dBP        dBP     dBP  BB      dBP   dBP     
echo  BBBP     dB'dB'dB'    dBP        dBP     dBP  dB' dBBBBP'   dBP  V2.1                                                                                                                      
echo.
echo.
echo A small script for fast first time setup of new VMs. Made by Ferixy@Github.
color 4
echo Please note that this script disables windows defender to reduce cpu/disk usage of the VM but it is Highly recommended to turn it back on if you are using this script on a real machine.
echo.
echo Choose an option:
echo 1. Start Debloating
echo 2. Disable Windows updates
echo 3. Tweak performance settings (Reduce animations and more! recommended for low-end VMs)
echo 4. Download Edge uninstaller and Firefox installer
echo 5. ReEnable Windows Defender
echo 6. ReEnable Windows Updates
echo 7. Download HitmanPro (Second opinion malware scanner)
echo 8. Repair windows image (May take a while to complete)
echo 9. Show detailed system info
echo 0. Exit
echo.

set /p choice=Type the number of your choice:

if "%choice%"=="1" goto option1
if "%choice%"=="2" goto option2
if "%choice%"=="3" goto option3
if "%choice%"=="4" goto option4
if "%choice%"=="5" goto option5
if "%choice%"=="6" goto option6
if "%choice%"=="7" goto option7
if "%choice%"=="8" goto option8
if "%choice%"=="9" goto option9
if "%choice%"=="0" goto endtask

echo Please choose a valid option.
pause
goto menu

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
echo Done.
pause
goto menu

:option2
echo Warning: Disabling Windows updates can leave your system vulnerable to security threats and other issues.
echo It is strongly recommended to keep Windows updates enabled.
echo.
echo Are you sure you want to disable Windows updates? (Y/N)
set /p confirmation=
if /i "%confirmation%"=="Y" (
    echo.
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
echo Done.
pause
goto menu

:option3
echo Tweaking the performance stuff... this shouldn't take long...
echo.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
echo Visual effects set to "Best Performance."
powercfg /setactive scheme_min>nul 2>&1
echo High performance mode has been enabled.
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61>nul 2>&1
echo Ultimate performance plan has been added and you can enable it in control panel(Not recommended)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f>nul 2>&1
echo Windows Tips, Tricks, and Suggestions has been disabled.
echo.
echo Done.
pause
goto menu

echo.
pause
goto menu

:option4
@echo off
set EdgeRemoverURL=https://github.com/ShadowWhisperer/Remove-MS-Edge/blob/main/Remove-NoTerm.exe?raw=true
set FirefoxInstallerURL=https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US

echo Downloading Edge uninstaller...
echo.
curl -L -o C:\EdgeRemover.exe "%EdgeRemoverURL%"
echo.
echo Downloading Firefox installer...
echo.
curl -L -o C:\firefoxinstaller.exe "%FirefoxInstallerURL%"

    echo.
    echo Download job successful! You can find the files in the root of the C drive.
    echo.
    pause
    goto menu

:option5
echo About to ReEnable windows defender...
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
echo.
echo Done.                                                                                                                                                                                                                                                                          
pause
goto menu

:option6
echo ReEnabling Windows updates, hold tight...
echo.
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "AUOptions" /f>nul 2>&1
sc config wuauserv start= auto >nul 2>&1
net start wuauserv >nul 2>&1
sc config wuauserv start= auto >nul 2>&1
echo Windows updates have been ReEnabled. Please restart your computer for the changes to take effect.
echo.
echo Done.
pause
goto menu

:option7
echo Downloading HitmanPro...
curl -L -o C:\HitmanPro.exe "https://github.com/Ferixy/VMFirst/raw/main/HitmanPro_x64.exe"
echo Download job successful! You can find the file in the root of the C drive.
echo.
pause
goto menu

:option8
echo Starting the repair process... this will take a while depending on your VM specs...
echo Running System File Checker (sfc)...
sfc /scannow
echo.
echo Running Deployment Imaging Service and Management Tool (DISM)...
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo Round 1 of 2 has been completed. going for the second round...
echo.
echo Running System File Checker (SFC)...
sfc /scannow
echo.
echo Running Deployment Imaging Service and Management Tool (DISM)...
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo Done.
echo.
pause
goto menu

:option9
@echo off
echo.
echo System Information
echo ------------------
echo Hostname: %COMPUTERNAME%
echo Local Username: %USERNAME%
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type"
echo.

echo Hardware Information
echo ------------------
echo CPU Info:
wmic cpu get name
echo.
echo RAM Info:
wmic memorychip get manufacturer
systeminfo | findstr /C:"Total Physical Memory"
echo.
echo Disk Drives:
wmic diskdrive get caption
setlocal enabledelayedexpansion

for /f "tokens=2 delims==" %%A in ('wmic diskdrive get size /value ^| find "Size"') do (
    set "size=%%A"
    set "sizeMB="
    for /f %%B in ('powershell -command "[math]::floor(!size! / (1024*1024))"') do set "sizeMB=%%B"
    echo Size in MB: !sizeMB!
)
endlocal
echo.
echo GPU Info:
dxdiag /t "%temp%\dxdiag_output.txt"
findstr /i "Chip Type: Memory: Approx. Total Memory:" "%temp%\dxdiag_output.txt"
del "%temp%\dxdiag_output.txt"
echo.
echo Checking internet availability...

ping google.com -n 1 > nul

if %errorlevel% == 0 (color 0A
    echo Internet is available. successfully pinged google.com.
) else (color 0C
    echo Internet is not available. failed to ping google.com.
)
echo.
pause
goto menu

:endtask
echo.
echo Exiting...
