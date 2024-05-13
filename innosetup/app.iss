[Setup]
AppName=OpenRune Launcher
AppPublisher=OpenRune
UninstallDisplayName=OpenRune
AppVersion=${project.version}
AppSupportURL=https://openrune.net/
DefaultDirName={localappdata}\OpenRune

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\OpenRune.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=OpenRuneSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\app.ico"; DestDir: "{app}"
Source: "${basedir}\left.bmp"; DestDir: "{app}"
Source: "${basedir}\app_small.bmp"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\OpenRune.exe"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\OpenRune.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\OpenRune\OpenRune"; Filename: "{app}\OpenRune.exe"
Name: "{userprograms}\OpenRune\OpenRune (configure)"; Filename: "{app}\OpenRune.exe"; Parameters: "--configure"
Name: "{userprograms}\OpenRune\OpenRune (safe mode)"; Filename: "{app}\OpenRune.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\OpenRune"; Filename: "{app}\OpenRune.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\OpenRune.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\OpenRune.exe"; Description: "&Open OpenRune"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\OpenRune.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.openrune\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"