
#devops-netology

#1)Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?
#ip -c -br link
#lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
#enp0s3           UP             08:00:27:19:5d:56 <BROADCAST,MULTICAST,UP,LOWER_UP>
#lo, локальный интерфейс  (т.н. называемый Loopback), работает, имеет фиксированный для всех loopback-интерфейсов IP-адрес 127.0.0.1, 
#маску подсети 255.0.0.0
#enp0s3  физический интерфейс проводного сетевого подключения, работает, выведен MAC адрес.


#в windows используют команду 'arp' ключи -а все записи таблицы ARP, -s добавить в таблицу статическую запись,
#-d* - полная очистка таблицы ARP.

#2)Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?
#LLDP - протокол обмена между соседними устройствами.
#включаем вторую виртуальную машину, устанавлиаем на двух машинах необходимые пакеты и добавлеим их а автозагрузку
#sudo apt-get install lldpd
#sudo systemctl enable lldpd && systemctl start lldpd
#lldpctl
-------------------------------------------------------------------------------
#LLDP neighbors:
-------------------------------------------------------------------------------
#Interface:    enp0s8, via: LLDP, RID: 1, Time: 0 day, 00:02:33
#Chassis:     
#ChassisID:    mac 08:00:27:c7:ac:7c
#SysName:      ubu2
#SysDescr:     Ubuntu 20.04.3 LTS Linux 5.11.0-41-generic #45~20.04.1-Ubuntu SMP Wed Nov 10 10:20:10 UTC 2021 x86_64
#MgmtIP:       10.0.2.15
#MgmtIP:       fe80::ce97:72fc:4f49:7048
#Capability:   Bridge, off
#Capability:   Router, off
#Capability:   Wlan, off
#Capability:   Station, on
#Port:        
#PortID:       mac 08:00:27:f8:aa:08
#PortDescr:    enp0s8
#TTL:          120
#PMD autoneg:  supported: yes, enabled: yes
#Adv:          10Base-T, HD: yes, FD: yes
#Adv:          100Base-TX, HD: yes, FD: yes
#Adv:          1000Base-T, HD: no, FD: yes
#MAU oper type: 1000BaseTFD - Four-pair Category 5 UTP, full duplex mode
-------------------------------------------------------------------------------

#3)Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? 
#Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

#sudo apt-get install vlan
#vconfig add enp0s8 500
#были ошибки на переход на новую команду ip. 
#sudo modprobe 8021q
#ifconfig -a посмотрим список всех интерфейсов, добавим IP адрес для интерфейса и запустим его
#sudo ifconfig enp0s8 500 add 192.168.0.1 netmask 255.255.255.0 up

#ifconfig -a
#enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
#inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
#inet6 fe80::bdd2:a202:ae4a:6761  prefixlen 64  scopeid 0x20<link>
#ether 08:00:27:19:5d:56  txqueuelen 1000  (Ethernet)
#RX packets 1  bytes 590 (590.0 B)
#RX errors 0  dropped 0  overruns 0  frame 0
#TX packets 49  bytes 7648 (7.6 KB)
#TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

#enp0s8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
#ether 08:00:27:dc:f2:1a  txqueuelen 1000  (Ethernet)
#RX packets 0  bytes 0 (0.0 B)
#RX errors 0  dropped 0  overruns 0  frame 0
#TX packets 465  bytes 92451 (92.4 KB)
#TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

#enp0s8.500: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
#inet6 fe80::a00:27ff:fedc:f21a  prefixlen 64  scopeid 0x20<link>
#ether 08:00:27:dc:f2:1a  txqueuelen 1000  (Ethernet)
#RX packets 0  bytes 0 (0.0 B)
#RX errors 0  dropped 0  overruns 0  frame 0
#TX packets 63  bytes 7234 (7.2 KB)
#TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

#enp0s8.500:0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
#inet 192.168.0.1  netmask 0.0.0.0  broadcast 0.0.0.0
#ether 08:00:27:dc:f2:1a  txqueuelen 1000  (Ethernet)

#lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
#inet 127.0.0.1  netmask 255.0.0.0
#inet6 ::1  prefixlen 128  scopeid 0x10<host>
#loop  txqueuelen 1000  (Локальная петля (Loopback))
#RX packets 40252  bytes 2859012 (2.8 MB)
#RX errors 0  dropped 0  overruns 0  frame 0
#TX packets 40252  bytes 2859012 (2.8 MB)
#TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

#Для того, чтобы интерфейс поднимался каждый раз после перезагрузки системы, его нужно прописать через netplan
#создаем конфигурационный файл e8.yaml в директории /etc/netplan
#network:
#version: 2
#renderer: NetworkManager
#ethernets:
#enp0s8:
#dhcp4: true
#dhcp6: true
#vlans:
#vlan500:
#id: 500
#link: enp0s8
#dhcp4: no
#addresses: [192.168.0.1/24]
#gateway4: 192.168.0.1

#т.к. не знаком с yaml было куча ошибок в редакции конфикурационного файла
#netplan apply - применяем конфигурацию

#после перезагрузки
#ip -c -br link
#lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
#enp0s3           UP             08:00:27:19:5d:56 <BROADCAST,MULTICAST,UP,LOWER_UP> 
#enp0s8           UP             08:00:27:dc:f2:1a <BROADCAST,MULTICAST,UP,LOWER_UP> 
#enp0s8.500@enp0s8 UP             08:00:27:dc:f2:1a <BROADCAST,MULTICAST,UP,LOWER_UP>


#4)Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.
#LAG - в Linux бондинг не что иное, как слияние нескольких сетевых соединений в одно параллельное. 
#Это позволяет увеличить пропускную способность канала и повысить отказоустойчивость сети в случае отказа одной из сетевых карт. 
#Ifenslave используется для присоединения сетевых карт к bond-интерфейсу.
#Bond0 будет считаться в системе как обычный сетевой интерфейс, но будет посылать пакеты через присоединенные (slave) устройства. 
#Это позволит обеспечить простую и сбалансированную систему. Проверить на все 100% не получиться, т.к. необходима настройка интерфейсов
#с двух сторон канала (не только сервера).

#apt-get install ifenslave 
#остановим сетевую службу  /etc/init.d/networking stop
#сделаем копию  /etc/network/interfaces, 
#cp /etc/network/interfaces /etc/network/interfaces.bak
#редактируем, добавляем необходимые опции
#nano /etc/network/interfaces

#auto lo
#iface lo inet loopback
#
# The primary network interface
#auto bond0
#iface bond0 inet static
#address 192.168.1.10
#netmask 255.255.255.0
#network 192.168.1.0
#gateway 192.168.1.254
#slaves enp0s3 enp0s8
# jumbo frame support
#mtu 9000
## Load balancing and fault tolerance
#bond-mode balance-rr
#bond-miimon 100
#bond-downdelay 200
#bond-updelay 200
#dns-nameservers 8.8.8.8

#address 192.168.1.10 : ip адрес для bond0.
#netmask 255.255.255.0 : маска сети для bond0
#network 192.168.1.0 : сетевой адрес для bond0
#gateway 192.168.1.254  : шлюз по умолчанию для bond0.
#bond-mode balance-rr  - режим циклического выбора активного интерфейса для исходящего трафика 
#(рекомендован для включения по умолчанию, не требует применения специальных коммутаторов).
#slaves enp0s3 enp0s8: настройка bond0 и привязка двух настоящих сетевых интерфейсов к нему.
#bond-miimon 100 : Установка MII link частоты наблюдения в 100 миллисекунд. 
#Это значение определяет как часто будет проверяться состояние соединения на каждом из интерфейсов.
#bond-downdelay 200 : Устанавливает время в 200 миллисекунд ожидания, прежде чем отключить slave в случае отказа соединения. 
#Эта опция действует только на bond-miimon.
#bond-updelay 200 : Устанавливает время в 200 миллисекунд ожидания, прежде чем включить slave после восстановления соединения.
#Эта опция действует только на bond-miimon.
#dns-nameservers 8.8.8.8 Устанавливает 8.8.8.8 как dns сервер.
# jumbo frame support mtu 9000 включаем поддержку Jumbo-кадров, для увеличения производительности сети.

#/etc/init.d/networking restart   перезапускаем сетевую службу, 
#ifconfig -a видим состояние.


#5)Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. 
#Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

#будем ленивыми и устанивим ipcalc, либо воспользуемся интернетовским калькулятором.
#sudo apt-get install ipcalc
#проверим количество адресов в сети с маской /29 и с маской /24

#в итоге имеем: количество адресов в сети с маской 24 равно 256, рабочих адресов для хостов 254
#количество адресов в сети с маской 29 равно 8, рабочих адресов для хостов 6
#и соответственно будем иметь 10.10.10.0/29 ,10.10.10.8/29 , 10.10.10.16/29 и т.д., всего 32 подсети.


#6)Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. 
#Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети. 

#Соответственно, если все адреса заняты можно попросить у провайдера предоставить выдать публичный IPv4-адрес.
#Технология CG-NAT (Carrier Grade Network Address Translation) дает провайдеру возможность заменить локальный IP-адрес пользователя
#на публичный в TCP/IP-сетях,
#либо мы сами можем использовать это для связи между организациями эти адреса.
#как нам рассказывали на лекции и зарезервировать адреса из сети 100.64.0.0/26  
#с максимальным числом адресов 64, маска равная /27 не обеспечит требованиям по числу адресов(32).


#7)Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?

#arp -a – отобразить все записи таблицы ARP.

#arp -d * - полная очистка таблицы ARP. Аналогично - arp -d без параметров. Если имеется несколько сетевых интерфейсов,
#то очистка может быть выполнена только для одного из них - arp -d * 192.168.0.56.
#arp -d 192.168.1.1 - удалить из таблицы ARP запись для IP-адреса 192.168.1.1
