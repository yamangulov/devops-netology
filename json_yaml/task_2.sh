#!/usr/bin/env python3

import socket as s
import time as t
import datetime as dt
import json
import yaml

timeout = 3
services = {"drive.google.com" : "None", "mail.google.com" : "None", "google.com" : "None"}
json_path = "/media/stranger/repo/devops-netology/json_yaml/services.json"
yaml_path = "/media/stranger/repo/devops-netology/json_yaml/services.yml"

while True:
    for service in services.keys():
        new_ip = s.gethostbyname(service)
        if new_ip != services[service]:
            print(str(dt.datetime.now()) + ' [ERROR] ' + service + ' IP mistmatch: ' + services[service] + ' ' + new_ip)
            services[service] = new_ip
        else:
            print(str(dt.datetime.now()) + ' [INFO] ' + service + ' - ' + services[service])
        with open(json_path, 'w') as js:
            js.write(json.dumps(services))
        with open(yaml_path, 'w') as jm:
            jm.write(yaml.dump(services))
        t.sleep(timeout)

