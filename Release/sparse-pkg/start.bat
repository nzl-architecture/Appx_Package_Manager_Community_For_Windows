@echo off
setlocal enabledelayedexpansion
cd "%~dp0"
set block=0
set "str=%*"
set "lower="
for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    set "str=!str:%%A=%%A!"
)
set "lower=!str!"
echo %lower% | findstr /C:".msix" >nul
set msixMatch=!errorlevel!
echo %lower% | findstr /C:".appx" >nul
set appxMatch=!errorlevel!
if !appxMatch!==0 (
    set block=1
)
if !msixMatch!==0 (
    set block=1
)
if !block!==0 (
echo "Welcome to use Appx Package Installer Community!"
set /p "appxfile=Enter your appx package to install (allowed .appx .msix .appxbundle .msixbundle) :"
)else (
set "appxfile=%*"
)
start AddAppxPackage.bat %appxfile%
