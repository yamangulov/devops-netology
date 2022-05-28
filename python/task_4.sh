#!/usr/bin/env python3

import socket as s
import time as t
import datetime as dt

timeout = 3
services = {"drive.google.com" : "None", "mail.google.com" : "None", "google.com" : "None"}

while True:
    for service in services.keys():
        new_ip = s.gethostbyname(service)
        if new_ip != services[service]:
            print(str(dt.datetime.now()) + ' [ERROR] ' + service + ' IP mistmatch: ' + services[service] + ' ' + new_ip)
            services[service] = new_ip
        else:
            print(str(dt.datetime.now()) + ' [INFO] ' + service + ' - ' + services[service])
        t.sleep(timeout)

