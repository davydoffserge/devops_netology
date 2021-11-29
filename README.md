#devops-netology

#1)cd встроенная команда, позволяет изменять каталоги

#2)сравнить строку с файлом и посчитать строки

#grep 'some_string' some_file -c

#3) процесс с PID = 1, является родителем всех процессов /sbin/init

#ps -ef

#4)перенаправление потока ошибок между терминальными сессиями

#ls % 2>/dev/pts/2

#5)создаем файл с данными для ввода через текстовый редактор nano serge.txt

#cat <serge.txt> output.txt

#7)/proc/N/fd - файловые дескрипторы, которые используются процессом.

#bash 5>&1 перенаправит вывод  виртуального терминала №5 в первый

#echo netology >/proc/$$/fd/5 выведет netology на экран, т.к. произошло перенаправление

#в 5 и обратно.

#8)ls -l 5>&2 2>&1 1>&5 новый дескриптор направляем в stderr, stderr перенаправляем в stdout.

#stdout - направляем в новый дескриптор.

#9) cat /proc/$$/environ - описание окружения в котором запущен текущий процесс, 

#заменяем командой printenv возвращает данные в более читабельном виде

#10)cat /proc/<PID>/cmdline - выводит содержимое командной строки, которой был запущен данный процесс

#по PID=1942 выведем bash, /proc/<PID>/exe - ссылка на исполняемый бинарный файл

#11)cat /proc/cpuinfo | grep sse - получим инцормацию со сравнением по sse, старшая версия 4.2

#12)используя команду ssh vagrant@localhost можно установить соединение к себе же (необходимо ввести пароль)

#при вводе команды 'tty' увидим, что соответственно изменилось и имя.(/dev/pts/1)

#13)при первых запусках были ошибки на конфигурационный файл 10-patrace.conf.

#изменил параметры на = 0, пользователь может отлаживать любые процессы, которые он запустил.

#продолжает работу после закрытия терминала

#14)Основное использование tee команды - отобразить стандартный вывод ( stdout ) программы и записать его в файл.

#в данном примере команда получает вывод из stdin, перенаправленный через pipe от stdout команды echo

#Использование tee в сочетании с sudo позволяет записывать в файлы, принадлежащие другим пользователям.





