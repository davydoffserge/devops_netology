#!/usr/bin/env python3

import socket
import time

servers = {"google.com": "", "mail.google.com": "", "drive.google.com": ""}
while True:
    for url, ip_old in servers.items():
        ip_new = socket.gethostbyname(url)
        if ip_old == "":
            servers[url] = ip_new
            print("{} - {}".format(url, ip_new))
        elif ip_old != ip_new:
            print("[ERROR] {} IP mismatch: {} -> {}".format(url, ip_old, ip_new))
            servers[url] = ip_new
    time.sleep(1)
