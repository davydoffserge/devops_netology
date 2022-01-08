#!/usr/bin/env python3

import os
import pathlib

path = pathlib.PureWindowsPath()
print(path)
cmd=os.getcwd()
bash_command = ["cd "+cmd, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', ' ')
        print(cmd+prepare_result)       
        break
