function Get-Escaped {
        param (
        $WordParam
    )
    if ($WordParam -eq $null) {
        return ""
    }
    return $WordParam.replace('\','\\').replace('"','\"')
}

$settings=(Get-Content .\settings.json)|ConvertFrom-Json
$app_name = $settings.app_name
$exe_name = $settings.exe_name
$bat_name = $settings.bat_name
$app_id = $settings.app_id
$app_logo = $settings.app_logo
$app_description = $settings.app_description
$icon = Get-Escaped -WordParam $settings.icon
$title = Get-Escaped -WordParam $settings.title
$cmd = Get-Escaped -WordParam $settings.cmd
$uuid = [System.Guid]::NewGuid().toString().toUpper()
$name = $settings.name
$icon2 = Get-Escaped -WordParam $settings.icon2
$title2 = Get-Escaped -WordParam $settings.title2
$cmd2 = Get-Escaped -WordParam $settings.cmd2
$uuid2 = [System.Guid]::NewGuid().toString().toUpper()
$name2 = $settings.name2
$dll_name = $settings.dll_name
$output_package_name = $settings.output_package_name
$publisher_name = $settings.publisher_name
$publisher_location = $settings.publisher_location
$app_version = $settings.app_version
$com_server_name = $settings.com_server_name
$file_type_association_name = $settings.file_type_association_name
$file_type_association_info_tip = $settings.file_type_association_info_tip
$windows_min_version = $settings.windows_min_version
$windows_max_version_tested = $settings.windows_max_version_tested
$app_allow_external_content = $settings.app_allow_external_content
$app_architecture = $settings.app_architecture
$app_visual_elements_background_color = $settings.app_visual_elements_background_color

# Write-Output $cmd $title $icon
(Get-Content .\Source\DLLMain.cpp).Replace("@@TITLE@@",$title).Replace("@@ICON@@",$icon).Replace("@@CMD@@",$cmd).Replace("@@UUID@@",$uuid).Replace("@@TITLE2@@",$title2).Replace("@@ICON2@@",$icon2).Replace("@@CMD2@@",$cmd2).Replace("@@UUID2@@",$uuid2) | Out-File -Encoding utf8 .\Release\ContextMenu.cpp -Force
(Get-Content .\Source\EXEMain.cpp).Replace("@@BATNAME@@",$bat_name) | Out-File -Encoding utf8 .\Release\EXEMain.cpp -Force
(Get-Content .\template\AppxManifest.xml).Replace("@@UUID@@",$uuid).Replace("@@UUID2@@",$uuid2).Replace("@@APPNAME@@",$app_name).Replace("@@APPID@@",$app_id).Replace("@@APPDESCRIPTION@@",$app_description).Replace("@@EXENAME@@",$exe_name).Replace("@@DLLNAME@@",$dll_name).Replace("@@APPLOGO@@",$app_logo).Replace("@@NAME@@",$name).Replace("@@NAME2@@",$name2).Replace("@@PUBLISHERNAME@@",$publisher_name).Replace("@@PUBLISHERLOCATION@@",$publisher_location).Replace("@@APPVERSION@@",$app_version).Replace("@@COMSERVERNAME@@",$com_server_name).Replace("@@FILETYPEASSOCIATIONNAME@@",$file_type_association_name).Replace("@@FILETYPEASSOCIATIONINFOTIP@@",$file_type_association_info_tip).Replace("@@WINDOWSMINVERSION@@",$windows_min_version).Replace("@@WINDOWSMAXVERSIONTESTED@@",$windows_max_version_tested).Replace("@@APPALLOWEXTERNALCONTENT@@",$app_allow_external_content).Replace("@@APPARCHITECTURE@@",$app_architecture).Replace("@@APPVISUALELEMENTSBACKGROUNDCOLOR@@",$app_visual_elements_background_color) | Out-File -Encoding utf8 .\Release\sparse-pkg\AppxManifest.xml -Force
(Get-Content .\template\install.ps1).Replace("@@OUTPUTPACKAGENAME@@",$output_package_name) | Out-File -Encoding utf8 .\Release\install.ps1 -Force
Invoke-WebRequest https://www.nuget.org/api/v2/package/Microsoft.Windows.ImplementationLibrary/1.0.201120.3 -OutFile Release\wil.zip; Expand-Archive -Force -LiteralPath Release\wil.zip Release\WilUnzipped; Copy-Item -Force -r "Release\WilUnzipped\include\wil" Release
# Begin Compile
cl.exe /c /Zi /nologo /W3 /WX- /diagnostics:column /sdl /Oi /GL /O2 /Oy- /D WIN32 /D NDEBUG /D _CONSOLE /D _UNICODE /D UNICODE /Gm- /EHsc /MD /GS /Gy /fp:precise /Zc:wchar_t /Zc:forScope /Zc:inline /permissive- /Fp"Release\EXEMain.pch" /Fo"Release\\" /Fd"Release\vc142.pdb" /external:W3 /Gd /TP /analyze- /FC /errorReport:queue "Release\EXEMain.cpp"
link.exe /ERRORREPORT:QUEUE /OUT:"Release\sparse-pkg\"$exe_name /INCREMENTAL:NO /NOLOGO runtimeobject.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib shlwapi.lib /MANIFEST /MANIFESTUAC:NO /manifest:embed /PDB:"Release\EXEMain.pdb" /SUBSYSTEM:CONSOLE /OPT:REF /OPT:ICF /LTCG:incremental /LTCGOUT:"Release\EXEMain.iobj" /TLBID:1 /DYNAMICBASE /NXCOMPAT /IMPLIB:"Release\EXEMain.lib" /MACHINE:%ARCH% "Release\EXEMain.obj"
cl.exe /c /Zi /nologo /W3 /WX- /diagnostics:column /sdl /Oi /GL /O2 /Oy- /D WIN32 /D NDEBUG /D _WINDOWS /D _USRDLL /D _WINDLL /D _UNICODE /D UNICODE /Gm- /EHsc /MD /GS /Gy /fp:precise /Zc:wchar_t /Zc:forScope /Zc:inline /permissive- /Fp"Release\ContextMenu.pch" /Fo"Release\\" /Fd"Release\vc142.pdb" /external:W3 /Gd /TP /analyze- /FC /errorReport:queue "Release\ContextMenu.cpp"
link.exe /ERRORREPORT:QUEUE /OUT:"Release\sparse-pkg\"$dll_name /INCREMENTAL:NO /NOLOGO runtimeobject.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib shlwapi.lib /DEF:"Source\Source.def" /MANIFEST /MANIFESTUAC:NO /manifest:embed /PDB:"Release\ContextMenu.pdb" /SUBSYSTEM:WINDOWS /OPT:REF /OPT:ICF /LTCG:incremental /LTCGOUT:"Release\ContextMenu.iobj" /TLBID:1 /DYNAMICBASE /NXCOMPAT /IMPLIB:"Release\ContextMenu.lib" /MACHINE:%ARCH% /DLL "Release\ContextMenu.obj"
MakeAppx.exe pack /d "Release\\sparse-pkg\\" /p "Release\"$output_package_name /nv
SignTool.exe sign /fd SHA256 /a /f "Release\Key.pfx" "Release\"$output_package_name
