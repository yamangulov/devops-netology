# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

Исправленная версия:

```
    { "info" : "Sample JSON output from our service\t",
        "elements" : [
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            },
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
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


```

### Вывод скрипта при запуске при тестировании:
```
stranger@nairsharifDellG3:/media/stranger/repo/devops-netology$ json_yaml/task_2.sh 
2022-05-28 20:44:58.187014 [ERROR] drive.google.com IP mistmatch: None 64.233.162.194
2022-05-28 20:45:01.194982 [ERROR] mail.google.com IP mistmatch: None 209.85.233.83
2022-05-28 20:45:04.205499 [ERROR] google.com IP mistmatch: None 74.125.131.102
2022-05-28 20:45:07.212398 [INFO] drive.google.com - 64.233.162.194
2022-05-28 20:45:10.218248 [ERROR] mail.google.com IP mistmatch: 209.85.233.83 209.85.233.19
2022-05-28 20:45:13.224731 [ERROR] google.com IP mistmatch: 74.125.131.102 74.125.131.138
2022-05-28 20:45:16.230379 [INFO] drive.google.com - 64.233.162.194
2022-05-28 20:45:19.236232 [ERROR] mail.google.com IP mistmatch: 209.85.233.19 209.85.233.83
^CTraceback (most recent call last):
  File "/media/stranger/repo/devops-netology/json_yaml/task_2.sh", line 26, in <module>
    t.sleep(timeout)
KeyboardInterrupt

```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{"drive.google.com": "64.233.162.194", "mail.google.com": "209.85.233.83", "google.com": "74.125.131.138"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
drive.google.com: 64.233.162.194
google.com: 74.125.131.138
mail.google.com: 209.85.233.83

```
