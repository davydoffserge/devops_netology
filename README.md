
#devops-netology

#1)Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

#telnet route-views.routeviews.org
#Username: rviews
#show ip route x.x.x.x/32
#show bgp x.x.x.x/32

#route-views>show ip route 176.194.104.55
#Routing entry for 176.194.0.0/15, supernet
#Known via "bgp 6447", distance 20, metric 0
#Tag 6939, type external
#Last update from 64.71.137.241 4w3d ago
#Routing Descriptor Blocks:
#* 64.71.137.241, from 64.71.137.241, 4w3d ago
#Route metric is 0, traffic share count is 1
#AS Hops 2
#Route tag 6939
#MPLS label: none


#route-views>show bgp 176.194.104.55
#BGP routing table entry for 176.194.0.0/15, version 1363906969
#Paths: (23 available, best #19, table default)
#Not advertised to any peer
#Refresh Epoch 1
#20912 3257 174 12714
#212.66.96.126 from 212.66.96.126 (212.66.96.126)
#Origin IGP, localpref 100, valid, external
#Community: 3257:8070 3257:30155 3257:50001 3257:53900 3257:53902 20912:65004
#path 7FE11D9F71F8 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#3333 12714
#193.0.0.56 from 193.0.0.56 (193.0.0.56)
#Origin IGP, localpref 100, valid, external
#Community: 12714:62000
#path 7FE1660E7058 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#8283 12714
#94.142.247.3 from 94.142.247.3 (94.142.247.3)
#Origin IGP, metric 0, localpref 100, valid, external
#Community: 8283:1 8283:101 12714:62000
#unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
#value 0000 205B 0000 0000 0000 0001 0000 205B
#0000 0005 0000 0001
#path 7FE0E544C350 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#57866 1299 12714
#37.139.139.17 from 37.139.139.17 (37.139.139.17)
#Origin IGP, metric 0, localpref 100, valid, external
#Community: 1299:30000 57866:100 57866:101 57866:501
#path 7FE07C705F40 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#20130 6939 12714
#140.192.8.16 from 140.192.8.16 (140.192.8.16)
#Origin IGP, localpref 100, valid, external
#path 7FE1888BEF48 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#53767 174 12714
#162.251.163.2 from 162.251.163.2 (162.251.162.3)
#Origin IGP, localpref 100, valid, external
#Community: 174:21101 174:22005 53767:5000
#path 7FE14D333FB8 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#852 1299 12714
#154.11.12.212 from 154.11.12.212 (96.1.209.43)
#Origin IGP, metric 0, localpref 100, valid, external
#path 7FE1114F49F8 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#3549 3356 174 12714
#208.51.134.254 from 208.51.134.254 (67.16.168.191)
#Origin IGP, metric 0, localpref 100, valid, external
#Community: 3356:3 3356:22 3356:86 3356:575 3356:666 3356:903 3356:2011 3549:2581 3549:30840
#path 7FE0A8D5E050 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#3356 1299 12714
#4.68.4.46 from 4.68.4.46 (4.69.184.201)
#Origin IGP, metric 0, localpref 100, valid, external
#Community: 3356:3 3356:22 3356:86 3356:575 3356:666 3356:903 3356:2012
#path 7FE166F76CA8 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#101 174 12714
#209.124.176.223 from 209.124.176.223 (209.124.176.223)
#Origin IGP, localpref 100, valid, external
#Community: 101:20100 101:20110 101:22100 174:21101 174:22005
#Extended Community: RT:101:22100
#path 7FE0437D5568 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#2497 174 12714
#202.232.0.2 from 202.232.0.2 (58.138.96.254)
#Origin IGP, localpref 100, valid, external
#path 7FE1346261E0 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#4901 6079 1299 12714
#162.250.137.254 from 162.250.137.254 (162.250.137.254)
#Origin IGP, localpref 100, valid, external
#Community: 65000:10100 65000:10300 65000:10400
#path 7FE15DE18EA8 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 3
#3303 12714
#217.192.89.50 from 217.192.89.50 (138.187.128.158)
#Origin IGP, localpref 100, valid, external
#Community: 3303:1004 3303:1006 3303:1030 3303:1031 3303:3056 12714:62000 65101:1085 65102:1000 65103:276 65104:150      path 7FE0291ABE50 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#7660 2516 1299 12714
#203.181.248.168 from 203.181.248.168 (203.181.248.168)
#Origin IGP, localpref 100, valid, external
#Community: 2516:1030 7660:9003
#path 7FE159445FB8 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#7018 1299 12714
#12.0.1.63 from 12.0.1.63 (12.0.1.63)
#Origin IGP, localpref 100, valid, external
#Community: 7018:5000 7018:37232
#path 7FE151EB08C0 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#49788 12552 12714
#91.218.184.60 from 91.218.184.60 (91.218.184.60)
#Origin IGP, localpref 100, valid, external
#Community: 12552:12000 12552:12100 12552:12101 12552:22000
#Extended Community: 0x43:100:1
#path 7FE13A2BC228 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#1221 4637 1299 12714
#203.62.252.83 from 203.62.252.83 (203.62.252.83)
#Origin IGP, localpref 100, valid, external
#path 7FE114F089A8 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#701 174 12714
#137.39.3.55 from 137.39.3.55 (137.39.3.55)
#Origin IGP, localpref 100, valid, external
#path 7FE0AA27A628 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#6939 12714
#64.71.137.241 from 64.71.137.241 (216.218.252.164)
#Origin IGP, localpref 100, valid, external, best 
#path 7FE040A652C0 RPKI State not found
#rx pathid: 0, tx pathid: 0x0
#Refresh Epoch 1
#3257 1299 12714
#89.149.178.10 from 89.149.178.10 (213.200.83.26)
#Origin IGP, metric 10, localpref 100, valid, external
#Community: 3257:8794 3257:30052 3257:50001 3257:54900 3257:54901
#path 7FE0C65F2060 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#3561 209 3356 174 12714
#206.24.210.80 from 206.24.210.80 (206.24.210.80)
#Origin IGP, localpref 100, valid, external
#path 7FE0B4D810F8 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#1351 6939 12714
#132.198.255.253 from 132.198.255.253 (132.198.255.253)
#Origin IGP, localpref 100, valid, external
#path 7FE17FEC6EE8 RPKI State not found
#rx pathid: 0, tx pathid: 0
#Refresh Epoch 1
#19214 174 12714
#208.74.64.40 from 208.74.64.40 (208.74.64.40)
#Origin IGP, localpref 100, valid, external
#Community: 174:21101 174:22005
#path 7FE13AC47D70 RPKI State not found
#rx pathid: 0, tx pathid: 0


#2)Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

#sudo modprobe -v dummy numdummies=2 
#sudo lsmod | grep dummy
#dummy                  16384  0  -  модуль dummy загружен
#serge@ubu3:~$ sudo ip link add dummy0 type dummy
#serge@ubu3:~$ ip -c -br link
#lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
#enp0s3           UP             08:00:27:7d:c1:02 <BROADCAST,MULTICAST,UP,LOWER_UP> 
#dummy0           DOWN           5a:81:d7:75:ff:7d <BROADCAST,NOARP> 
#serge@ubu3:~$ sudo ip addr add 10.0.3.3/24 dev dummy0
#serge@ubu3:~$ ip -c -br link
#lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
#enp0s3           UP             08:00:27:7d:c1:02 <BROADCAST,MULTICAST,UP,LOWER_UP> 
#dummy0           DOWN           5a:81:d7:75:ff:7d <BROADCAST,NOARP> 

#для netplan конфигурация
#network:
#version: 2
#renderer: networkd
#bridges:
#dummy0:
#dhcp4: no
#dhcp6: no
#accept-ra: no
#interfaces: [ ]
#addresses:
#- 10.0.3.3/24

#в итоге имеем 

#serge@ubu3:/etc/network$ ip -c -br link
#lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP> 
#enp0s3           UP             08:00:27:7d:c1:02 <BROADCAST,MULTICAST,UP,LOWER_UP> 
#dummy0           UNKNOWN        5a:81:d7:75:ff:7d <BROADCAST,NOARP,UP,LOWER_UP>

#NO-CARRIER означает, что сетевой разъем не обнаруживает сигнал на линии. 
#Обычно это происходит потому, что сетевой кабель отключён или повреждён. 
#В редких случаях это также может быть аппаратный сбой или ошибка драйвера. 
#В нашем случае именно входящий сигнал.  UP означает, что устройство работает. 
#BROADCAST — устройство может отправлять трафик всем хостам по link. 
#MULTICAST — устройство может выполнять и принимать многоадресные пакеты.

#Таблица маршрутизации 
#ip r
#default via 10.0.2.2 dev enp0s3 proto dhcp metric 100 
#10.0.2.0/24 dev enp0s3 proto kernel scope link src 10.0.2.15 metric 100 
#10.0.3.0/24 dev dummy0 proto kernel scope link src 10.0.3.3 metric 425 linkdown 
#169.254.0.0/16 dev dummy0 scope link metric 1000 linkdown 

#ip r | grep stat

#статических марштутов нет.

#через netplan

#network:
#version: 2
#renderer: NetworkManager
#ethernets:
#enp0s8:
#dhcp4: no
#addresses:
#- 10.0.3.30/24
#nameservers:
#addresses:
#- 8.8.8.8
#- 8.8.4.4
#routes:
#- to: 10.0.3.0/24
#via: 10.0.3.0/24
#on-link: true

#serge@ubu3:/etc/netplan$ ip r
#default via 10.0.2.2 dev enp0s3 proto dhcp metric 100 
#default via 10.0.2.15 dev enp0s8 proto static metric 20101 
#10.0.2.0/24 dev enp0s3 proto kernel scope link src 10.0.2.15 metric 100 
#10.0.2.15 dev enp0s8 proto static scope link metric 20101 
#10.0.3.0/24 dev enp0s8 proto kernel scope link src 10.0.3.30 metric 101 
#10.0.3.0/24 dev dummy0 proto kernel scope link src 10.0.3.3 metric 425 linkdown 
#169.254.0.0/16 dev enp0s3 scope link metric 1000 

#serge@ubu3:/etc/netplan$ ip r | grep stat
#default via 10.0.2.15 dev enp0s8 proto static metric 20101 
#10.0.2.15 dev enp0s8 proto static scope link metric 20101


#3)Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

#root@ubu3:~# ss -lntp
#State      Recv-Q     Send-Q          Local Address:Port           Peer Address:Port     Process                                        
#LISTEN     0          4096            127.0.0.53%lo:53                  0.0.0.0:*         users:(("systemd-resolve",pid=494,fd=13))     
#LISTEN     0          5                   127.0.0.1:631                 0.0.0.0:*         users:(("cupsd",pid=536,fd=7))                
#LISTEN     0          5                       [::1]:631                    [::]:*         users:(("cupsd",pid=536,fd=6))     

#53 tcp порт это DNS
#631 tcp это типичный адрес принтера

#4)Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

#root@ubu3:~# ss -pua
#State     Recv-Q    Send-Q            Local Address:Port           Peer Address:Port      Process                                       
#UNCONN    0         0                 127.0.0.53%lo:domain              0.0.0.0:*          users:(("systemd-resolve",pid=494,fd=12))    
#ESTAB     0         0              10.0.2.15%enp0s3:bootpc             10.0.2.2:bootps     users:(("NetworkManager",pid=3024,fd=29))    
#UNCONN    0         0                       0.0.0.0:51360               0.0.0.0:*          users:(("avahi-daemon",pid=534,fd=14))       
#UNCONN    0         0                       0.0.0.0:mdns                0.0.0.0:*          users:(("avahi-daemon",pid=534,fd=12))       
#UNCONN    0         0                       0.0.0.0:631                 0.0.0.0:*          users:(("cups-browsed",pid=643,fd=7))        
#UNCONN    0         0                          [::]:41030                  [::]:*          users:(("avahi-daemon",pid=534,fd=15))       
#UNCONN    0         0                          [::]:mdns                   [::]:*          users:(("avahi-daemon",pid=534,fd=13))

#udp 51360  - avahi-daemon система, позволяющая обнаруживать сервисы в локальной сети, сетевые принтеры...
#udp 631 IPP Internet Printing Protocol - тот же самый принтер, что и tcp.

#5)#5)Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.
#Диаграма сети предатавлена в файле рrobe1.dravio
#IP адресацию выхода в интернет, не могу вспомнить, какой то статический от Ростелеком.

