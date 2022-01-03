
# devops-netology
## Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"
git 
### 1)Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.
заходим на сайт Bitwarden проходим регистрацию, необходимо создать организацию (бесплатно можно только 2 пользователя,
включая владельца), создаем организацию---имя организации и некоторые свои данные имя, почту.....
отправляем приглашение пользователю (сотруднику),  он его принимает (в письме ссылка), мы его подтверждаем
(управление---настройки организации---люди), 
в итоге имеем в управлении людьми владельца и сотрудника с различными паролями и почтой.

[link_bitwarden_1.png](./bitwarden_1.png)
____


### 2)Установите Google authenticator на мобильный телефон.
### Настройте вход в Bitwarden акаунт через Google authenticator OTP


устанавливаем Google Authenticator, сканируем код, вводим страну и телефон, адрес электронной почты и на смс 
приходит проверочный код, ... первый раз не успел ввести в комп для подтверждения. Появилась зеленая галочка)) 
что приложение активировано. Хотел сделать снимок экрана на телефоне, но приложение запрещает это делать.

[link_bitwarden_android.png](./bitwarden_android.png)

[link_bitwarden_2.png](./bitwarden_2.png)

----

### 3)Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

установил апач, создал самоподписной сертификат.
при переходе на сайт предупреждает что небезопасное соединение... (сертификат является самоподписанным?!)

```bash
root@ubu3:/etc/ssl/private# ls -l
итого 8
-rw------- 1 root root     1704 дек 25 20:01 apache-selfsigned.key
-rw-r----- 1 root ssl-cert 1704 дек 15 19:55 ssl-cert-snakeoil.key 
```
[link_apache1.png](./apache1.png)

```bash
<VirtualHost *:443>
 ServerName 10.0.3.30
 DocumentRoot /var/www/10.0.3.30
 SSLEngine on
 SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
 SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>
```
[link_apache2.png](./apache2.png)

в индекс файл добавляем одну строку

```html
<h1>It worked!</h1>
```
[link_apache3.png](./apache3.png)

*sudo apache2ctl configtest*

**AH00558: apache2: Could not reliably determine the server's fully qualified domain name,using 127.0.1.1. </br>
Set the 'ServerName' directive globally to suppress this message
Syntax OK**

чтобы убрать ошибку AH00558, необходимо добавить в конфигурационный файл явный адрес сервера.
т.е. в конец */etc/apache2/apache2.conf*  добавим строку *ServerName 127.0.0.1*
еще раз проверим *sudo apache2ctl configtest*
**Syntax OK**
и перезапустим сервер *sudo systemctl restart apache2.service*

------

### 4)Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк,
### РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

протестировал сайт neruch.ru, отчет в файле 

[link_scan.png](./scan.png)

-------

### 5)Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. </br>
### Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
установил сервер *sudo apt install openssh-server*</br>
*sudo systemctl start sshd.service*</br>
*sudo systemctl enable sshd.service*</br>
генерируем ключи *ssh-keygen*</br>
копируем с помощью *ssh-copy-id* на сервер публичный ключ, соединяемся....
```bash
serge@ubu3:~/.ssh$ ssh-copy-id serge@10.0.3.31
The authenticity of host '10.0.3.31 (10.0.3.31)' can't be established.
ECDSA key fingerprint is SHA256:Whm5mmDD8p+upYFhMVGcZ2+xWfTWnWgQqhNExqTfJws.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
serge@10.0.3.31's password: 
Permission denied, please try again.
serge@10.0.3.31's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'serge@10.0.3.31'"
and check to make sure that only the key(s) you wanted were added.
```
```bash
serge@ubu3:~/.ssh$ ssh serge@10.0.3.31
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.11.0-41-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

78 updates can be applied immediately.
Чтобы просмотреть дополнительные обновления выполните: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.
serge@ubu2:~$ exit
```
[link_ssh3.png](./ssh3.png)

_____

### 6)Переименуйте файлы ключей из задания 5. 
### Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера. 

переименовываем файлы ключей, создаем файл конфигурации в директории */home/serge/.ssh/config*
в нем прописываем псевдоним, айпиадрес, пользователя и наш конфигурационный файл, этого вполне достаточно, 
чтобы соединение произошло по имени.

```bash
Host ubu2
    HostName 10.0.3.31
    Port 22
    User serge
    IdentityFile /home/serge/.ssh/id0_rsa
```

```bash
serge@ubu3:~/.ssh$ ssh serge@ubu2
The authenticity of host 'ubu2 (10.0.3.31)' can't be established.
ECDSA key fingerprint is SHA256:Whm5mmDD8p+upYFhMVGcZ2+xWfTWnWgQqhNExqTfJws.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'ubu2' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.11.0-41-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

78 updates can be applied immediately.
Чтобы просмотреть дополнительные обновления выполните: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.
Last login: Sun Dec 26 18:36:50 2021 from 10.0.3.30
```
[link_ssh4.png](./ssh4.png)


-------

### 7)Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

```bash
serge@ubu3:~$ sudo tcpdump -i enp0s3 -c 100 -w file1.pcap
tcpdump: listening on enp0s3, link-type EN10MB (Ethernet), capture size 262144 bytes
100 packets captured
245 packets received by filter
0 packets dropped by kernel
```

-i - указывает на интерфейс который будет сканироваться, можно поставить *any*</br>
-c - закрывает программу после захвата n-ого количества пакетов</br>
-w - записывает вывод в файл</br>
в итоге имеем скрин с расшифровкой wireshark. 

[link_wireshark.png](./wireshark.png)

хотел бы выполнить задания со звездочкой чуть позже.  не хватает времени.





