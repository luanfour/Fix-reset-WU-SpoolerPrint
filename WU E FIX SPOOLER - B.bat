@echo off
echo  DROGARIA GLOBO T.I
echo Fix Print Spooler
REG ADD "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\printers" /v RegisterSpoolerRemoteRpcEndPoint /t REG_DWORD /d 00000002
echo Restart Spooler
net stop spooler
net start spooler
echo --------------------------
echo Ativando e configurando o Windows Update.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\AU" /v AutomaticMaintenanceEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\AU" /v ScheduledInstallDay /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\AU" /v ScheduledInstallTime /t REG_DWORD /d 24 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\AU" /v AllowMUUpdateService /t REG_DWORD /d 1 /f
gpupdate /force
echo ------------------------
echo Restarting Windows Update
net stop wuauserv
net stop bits
rename %windir%\SoftwareDistribution SoftwareDistribution.bak
net start wuauserv
net start bits
wuauclt /resetauthorization
wuauclt /detectnow
wuauclt /updatenow
echo --------------------------
timeout 1
