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