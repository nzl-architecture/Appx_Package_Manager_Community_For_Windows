if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb runAs; exit}
Write-Output "Set Location to install location......"
$scriptPath = $MyInvocation.MyCommand.Definition
$scriptDir  = Split-Path -Parent $scriptPath
Set-Location -Path $scriptDir
Write-Output "Enter to start install Appx Package Installer Community"
pause
Write-Output "Installing Certificate......"
Import-Certificate -FilePath "Key.cer" -CertStoreLocation Cert:\LocalMachine\Root
Write-Output "Installing appx package......"
$releasePath = (resolve-path .)
Add-AppxPackage ${releasePath}\base.appx
Pause
