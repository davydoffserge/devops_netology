
#devops-netology

#1)На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background.
#Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением.
#Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

#поместите его в автозагрузку,
#предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
#удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

#Ставим prometheus(можно не ставить) устанавливаем node_exporter. + настройка служб и опций (спасибо Булату Замилову)
#проверяем работоспособность (старт, стоп, рестарт) конфигурационный файл по адресу /etc/systemd/system/nods_exporter.service

#[Unit]
#Description=Node Exporter
#After=network-online.targets

#[Service]
#Type=symple
#ExecStart=/home/vagrant/node_exporter-1.3.0.linux-amd64/node_exporter --collector.systemd
#--collector.systemd данная опция указывает экспортеру мониторить состояние каждой службы.
#при необходимости, мы можем либо мониторить отдельные службы, добавив collector.systemd.unit-whitelist:
#--collector.systemd --collector.systemd.unit-whitelist="(chronyd|mariadb|nginx).service"
#перечислив необходимые для мониторинга службы.
#EnvironmentFile=-/home/vagrant/node_exporter-1.3.0.linux-amd64/nd_exp.txt
#EnvironmentFile считывает переменные среды из текстового файла, в nd_exp.txt также можно указать набор опций при загрузке службы.
#https://github.com/coreos/docs/blob/master/os/using-environment-variables-in-systemd-units.md

#[Install]
#WantedBy=multi-user.target

#2)curl http://localhost:9100/metrics | grep mdadm -по диску
#curl http://localhost:9100/metrics | grep netstat -по сети
#curl http://localhost:9100/metrics | grep meminfo -по памяти
#curl http://localhost:9100/metrics | grep cpu - по CPU

#3)изименяем содержимое файла /etc/netdata/netdata.conf
#vagrant@vagrant:~$ sudo lsof -i :19999
#COMMAND PID    USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
#netdata 616 netdata    4u  IPv4  23542      0t0  TCP *:19999 (LISTEN)
#netdata 616 netdata    5u  IPv6  23543      0t0  TCP *:19999 (LISTEN)
#в файле конфигурации Vagrantfile вставил строку. перезаргузагрузил вагрант, перезаргузил ssh, перезагрузил браузер.
#http://localhost:19999/#menu_system_submenu_cpu;theme=slate - появилась информация о сосоянии системы.

#4)Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?
#запустим команду dmesg |grep -i hypervisor
#vagrant@vagrant:~$ dmesg |grep -i hypervisor
#[    0.000000] Hypervisor detected: KVM
#[    0.323848] SRBDS: Unknown: Dependent on hypervisor status.
#на домашней виртуальной Ubuntu на Oracle VM VirtualBox,также был обнаружен гипервизор с определенными параметрами.
#к сожалению, проверить на "голом" железе не получилось.

#5)Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр.
#Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

#Максимальное количество файловых дескрипторов, поддерживаемых ядром,
#то есть максимальное количество файловых дескрипторов, используемых процессом.
#Значение по умолчанию = 1024 * 1024 (1048576), чего должно хватить для большинства машин.
#Фактический лимит зависит от лимита ресурсов RLIMIT_NOFILE.
#Указан в файлах конфигурации (/etc/security/limits.conf и /etc/security/limits.d)
#или может быть установлен в отдельной оболочке и ее процессах с помощью функции оболочки ‘ulimit’.

#6)Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h)
#в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter.
#Для простоты работайте в данном задании под root (sudo -i).
#Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

#Открываем три консоли под администратором, в первом запускаем процесс
#root@serge-VirtualBox:~#sleep на 2020, во втором запускаем
#root@serge-VirtualBox:~#ps –e |grep sleep который нам выдает <PID> нашего «спящего» процесса 3496, и далее
#root@serge-VirtualBox:~#nsenter --target 3496 --pid --mount

#7)Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04
#(это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться.
#Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию,
#и как изменить число процессов, которое можно создать в сессии?

#Это логическая бомба (известная также как fork bomb), забивающая память системы, что в итоге приводит к её зависанию.

#..определяет функцию с именем :, которая создается сама собой (дважды, одной трубы в другую), и фоны сама.
#С переносами строк:
#:()
#{
#:|:&
#};
#:
#Переименование : функции forkbomb:
#forkbomb()
#{
#forkbomb | forkbomb &
#};
#forkbomb
#можете предотвратить подобные атаки, используя ограничение, чтобы ограничить количество процессов на пользователя:
#ulimit -u 50, но может понадобиться увеличить это в зависимости от того, что машина делает.
#не стабилизировалась, проверить процессы по dmesg не удалось.
