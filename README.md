#devops-netology

#по умолчанию Ubuntu 20.04 выделенная видеопамять 4Мб, оперативная память 1024Мб процессоры 2, 

#зарезервировано 64Гб.

#чтобы добавить оперативной памяти необходимо изменить vagrant-файл

#разкомментировать строки config.vm.provider "virtualbox" do |vb|

#vb.memory = "2048"

#end

#длину журнала history можно изменить в переменной HISTSIZE

#ignoreboth -запрещает дублирование строк, начинающихся с пробела в журнале history

#символы {} используются в циклах, позволяют сократить описание в командной строке (автоматизация)

#примеры использования line 209 + line 1346

# ! case  coproc  do done elif else esac fi for function if in select then until while {
#      } time [[ ]]

#mkdir /usr/local/src/bash/{old,new,dist,bugs}


#touch file{1..100000} должна создать 100000 файлов, создать 300000 не получится, переполнится максимальная длина аргумента команды;

#xargs --show-limits (результат 131072)

#создаем каталог mkdir /tmp/new_path_directory, переходим в каталог cd /usr/bin, копируем файл 

#cp bash /tmp/new_dir_directory, добавляем новый путь в PATH=/tmp/new_path_directory:$PATH

#batch позволяет системе прерывать очередь команд в зависимости от нагрузки, 

#т.е. выполнять их по очереди, и снова выполнять. (синоним at -b)

#команда at - однократно выполняет задание через определеное время, также может использоваться очередь типа -a.
