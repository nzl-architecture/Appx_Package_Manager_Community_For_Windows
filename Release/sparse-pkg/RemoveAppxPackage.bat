@echo off
net session >nul 2>&1 || (powershell -NoP -C "Start-Process -FilePath 'cmd.exe' -ArgumentList '/c', '\"\"%~f0\" %*\"' -Verb RunAs" && exit)
cd "%~dp0"
echo "Select a mode to remove appx package"
echo "Mode 1: DISM + Remove-ProvisionedAppxPackage (system-level)"
echo "Mode 2: Powershell + Remove-AppxPackage (per-user)"
echo "Mode 3: Powershell + Remove-AppxPackage + Custom Params (per-user)"
echo "Mode 4: Powershell + Remove-AppxPackage + AllUsers (system-level)"
echo "Mode 5: Powershell + Remove-AppxPackage + AllUsers + Custom Params (system-level)"
echo "Mode 6: Powershell + Remove-AppxPackage + Fuzzy Matching (per-user)"
echo "Mode 7: Powershell + Remove-AppxPackage + Fuzzy Matching + Custom Params (per-user)"
echo "Mode 8: Powershell + Remove-AppxPackage + Fuzzy Matching + AllUsers (system-level)"
echo "Mode 9: Powershell + Remove-AppxPackage + Fuzzy Matching + AllUsers + Custom Params (system-level)"
set /p "choice=Select a mode:"
set /p "packagename=Enter your appx package name (package family name) to uninstall :"
set params=
cmd /c echo "Remove appx package %packagename% forever?"
pause
timeout /t 5 /nobreak >nul
echo "Please CHECK AGAIN!"
pause
if "%choice%"=="1" (
dism.exe -Online -Remove-ProvisionedAppxPackage -PackagePath:"%packagename%"
)
if "%choice%"=="2" (
powershell.exe -Command "Remove-AppxPackage -Package '%packagename%'"
)
if "%choice%"=="3" (
set /p "params=Enter params for remove appx package %* (per-user):"
powershell.exe -Command "Remove-AppxPackage -Package '%packagename%' %params%"
)
if "%choice%"=="4" (
powershell.exe -Command "Remove-AppxPackage -Package '%packagename%' -AllUsers"
)
if "%choice%"=="5" (
set /p "params=Enter params for remove appx package %* (system-level):"
powershell.exe -Command "Remove-AppxPackage -Package '%packagename%' -AllUsers %params%"
)
if "%choice%"=="6" (
powershell.exe -Command "Get-AppxPackage *%packagename%* | Remove-AppxPackage"
)
if "%choice%"=="7" (
set /p "params=Enter params for remove appx package %* (per-user):"
powershell.exe -Command "Get-AppxPackage *%packagename%* | Remove-AppxPackage %params%"
)
if "%choice%"=="8" (
powershell.exe -Command "Get-AppxPackage *%packagename%* -AllUsers | Remove-AppxPackage -AllUsers"
)
if "%choice%"=="9" (
set /p "params=Enter params for remove appx package %* (system-level):"
powershell.exe -Command "Get-AppxPackage *%packagename%* -AllUsers | Remove-AppxPackage -AllUsers %params%"
)
pause