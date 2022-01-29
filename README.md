

# devops-netology
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
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  |  будет ошибка, т.к. имеем целое число и строку  |
| Как получить для переменной `c` значение 12?  | '1'  нужно исправить,т.е.  'a' + 'b'  или '1' + '2' |
| Как получить для переменной `c` значение 3?  | a + b или 1 + 2  |


_________

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, 
какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, 
потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. 
Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

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
import pathlib

path = pathlib.PureWindowsPath()
print(path)
cmd=os.getcwd()
bash_command = ["cd "+cmd, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
#is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', ' ')
        print(cmd+prepare_result)       
        #break
```
Доработка - была убрана лешняя переменная и команда break.

### Вывод скрипта при запуске при тестировании:
```
E:\DEV_OPS\devops-netology\devops-netology\devopsnetology 1.py
E:\DEV_OPS\devops-netology\devops-netology\devopsnetology README.md
```

[link_4_2_count.jpg](./4_2_count.jpg)

## Обязательная задача 3
Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, 
а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. 
Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, 
которые не являются локальными репозиториями.

### Ваш скрипт:
```python
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
```

### Вывод скрипта при запуске при тестировании:
```
E:\DEV_OPS\devops-netology\devops-netology\devopsnetology
CompletedProcess(args='git status', returncode=0)
E:\DEV_OPS\devops-netology\devops-netology\devopsnetology README.md
```
при тестировании скрипта из папки с рабочего стола 
```
C:\Users\serge\Desktop\python
CompletedProcess(args='git status', returncode=128)
fatal: not a git repository (or any of the parent directories)
```

## Обязательная задача 4
Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем,
что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. 
Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера,
поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена.
Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании,
который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP,
выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность
проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом 
в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать,
что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import time

servers = {"drive.google.com": "", "mail.google.com": "", "google.com": ""}
while True:
    for url, ip_old in servers.items():
        ip_new = socket.gethostbyname(url)
        if ip_old == "":
            servers[url] = ip_new
            print("{} - {}".format(url, ip_new))
        elif ip_old != ip_new:
            print("[ERROR] {} IP mismatch: {} -> {}".format(url, ip_old, ip_new))
            servers[url] = ip_new
    time.sleep(10)
```

### Вывод скрипта при запуске при тестировании:
```
drive.google.com - 209.85.233.194
mail.google.com - 209.85.233.18
google.com - 64.233.161.139
[ERROR] google.com IP mismatch: 64.233.161.139 -> 64.233.161.138
[ERROR] mail.google.com IP mismatch: 209.85.233.18 -> 209.85.233.19
[ERROR] google.com IP mismatch: 64.233.161.138 -> 64.233.161.113
[ERROR] mail.google.com IP mismatch: 209.85.233.19 -> 209.85.233.18
[ERROR] google.com IP mismatch: 64.233.161.113 -> 64.233.161.139
[ERROR] mail.google.com IP mismatch: 209.85.233.18 -> 209.85.233.83
[ERROR] google.com IP mismatch: 64.233.161.139 -> 64.233.161.102
[ERROR] mail.google.com IP mismatch: 209.85.233.83 -> 209.85.233.19
[ERROR] mail.google.com IP mismatch: 209.85.233.19 -> 209.85.233.17
[ERROR] google.com IP mismatch: 64.233.161.102 -> 64.233.161.113
[ERROR] mail.google.com IP mismatch: 209.85.233.17 -> 209.85.233.19
[ERROR] google.com IP mismatch: 64.233.161.113 -> 64.233.161.139
```

[link_4_2_ipold_ipnew.jpg](./4_2_ipold_ipnew.jpg)

пробовал на следующий день чистить DNS кэш, и делаем пинг из консоли, адрес drive.google.com остается прежним

