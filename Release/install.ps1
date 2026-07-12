Write-Output "Enter to start install Appx Package Installer Community"
pause
Write-Output "Installing Certificate......"
Import-Certificate -FilePath "Key.cer" -CertStoreLocation Cert:\LocalMachine\Root
Write-Output "Installing appx package......"
$releasePath = (resolve-path .)
Add-AppxPackage ${releasePath}\base.appx
Pause