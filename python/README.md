
# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ                                                          |
| ------------- |----------------------------------------------------------------|
| Какое значение будет присвоено переменной `c`?  | получим ошибку при исполнении, так как переменные разных типов |
| Как получить для переменной `c` значение 12?  | c = str(a) + b                                                 |
| Как получить для переменной `c` значение 3?  | c = a + int(b)                                                 |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

repo_root = "/media/stranger/repo/devops-netology/"
bash_command = ["cd " + repo_root, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        result = result.replace('\tизменено:   ', '').strip()
        prepare_result = repo_root + result
        print(prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
stranger@nairsharifDellG3:/media/stranger/repo/devops-netology$ python/task_2.sh 
/media/stranger/repo/devops-netology/python/README.md
/media/stranger/repo/devops-netology/python/task_2.sh

```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys

try:
  sys.argv[1]
  repo_root = sys.argv[1] + "/"
except:
  repo_root = "/media/stranger/repo/devops-netology/"

bash_command = ["cd " + repo_root, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        result = result.replace('\tизменено:   ', '').strip()
        prepare_result = repo_root + result
        print(prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
stranger@nairsharifDellG3:/media/stranger/repo/devops-netology$ python/task_3.sh 
/media/stranger/repo/devops-netology/python/README.md
/media/stranger/repo/devops-netology/python/task_2.sh
/media/stranger/repo/devops-netology/python/task_3.sh
stranger@nairsharifDellG3:/media/stranger/repo/devops-netology$ python/task_3.sh /media/stranger/repo/devops-netology
/media/stranger/repo/devops-netology/python/README.md
/media/stranger/repo/devops-netology/python/task_2.sh
/media/stranger/repo/devops-netology/python/task_3.sh

```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
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


```

### Вывод скрипта при запуске при тестировании:
```
stranger@nairsharifDellG3:/media/stranger/repo/devops-netology$ python/task_4.sh 
2022-05-28 11:54:47.560491 [ERROR] drive.google.com IP mistmatch: None 173.194.73.194
2022-05-28 11:54:50.569292 [ERROR] mail.google.com IP mistmatch: None 74.125.131.83
2022-05-28 11:54:53.575764 [ERROR] google.com IP mistmatch: None 108.177.14.138
2022-05-28 11:54:56.577563 [INFO] drive.google.com - 173.194.73.194
2022-05-28 11:54:59.581144 [ERROR] mail.google.com IP mistmatch: 74.125.131.83 74.125.131.17
2022-05-28 11:55:02.585260 [ERROR] google.com IP mistmatch: 108.177.14.138 108.177.14.113
2022-05-28 11:55:05.589274 [INFO] drive.google.com - 173.194.73.194
2022-05-28 11:55:08.593438 [ERROR] mail.google.com IP mistmatch: 74.125.131.17 74.125.131.18
2022-05-28 11:55:11.597590 [ERROR] google.com IP mistmatch: 108.177.14.113 108.177.14.138
2022-05-28 11:55:14.601495 [INFO] drive.google.com - 173.194.73.194
2022-05-28 11:55:17.605575 [ERROR] mail.google.com IP mistmatch: 74.125.131.18 74.125.131.19
2022-05-28 11:55:20.609698 [ERROR] google.com IP mistmatch: 108.177.14.138 108.177.14.102
2022-05-28 11:55:23.613552 [INFO] drive.google.com - 173.194.73.194
^CTraceback (most recent call last):
  File "/media/stranger/repo/devops-netology/python/task_4.sh", line 18, in <module>
    t.sleep(timeout)
KeyboardInterrupt

```

