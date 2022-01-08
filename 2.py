#!/usr/bin/env python3

import os
import pathlib
import subprocess as sp

path = cmd=os.getcwd()
print (path)
status = sp.run("git status")
print (status)
with sp.Popen(['git', 'status'], stdout=sp.PIPE) as sp:
    result = sp.stdout.read().decode("utf-8")
if result.find('not') == -1:
    print('fatal: not a git repository (or any of the parent directories)')

else:
    cmd=os.getcwd()
bash_command = ["cd "+cmd, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', ' ')
        print(cmd+prepare_result)       
        break
