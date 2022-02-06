# devops-netology
## 1.Создайте виртуальную машину Linux.

В Oracle VM VirtualBox создаем новую виртуальную машину, присваиваем ей тип ОС Линукс, имя и разрядность ОС и др., выбираем файл для автозагрузки и далее по тектсту... 
(наверное можно воспользоваться уже установленной виртуальной машиной для экономии времени) Будем использовать Ubuntu 20.04

## 2.Установите ufw и разрешите к этой машине сессии на порты 22 и 443, при этом трафик на интерфейсе localhost (lo) должен ходить свободно на все порты.

UFW устанавливается в Ubuntu по умолчанию. 
 проверим статус службы  -- service ufw status, далее от root поправим sudo nano ufw.conf  -- т.к. имелась ошибка с журналированием, и перезапустим службу 
service ufw restart, проверим состояние службы   -- service ufw status

sudo ufw allow to any port 22
Приведенная выше команда разрешит доступ из любого места и с любого протокола на порт 22.
sudo ufw allow to any port 443 -- соответсвенно добавит 443 порт
sudo ufw allow from 127.0.0.1 -- доступ на все порты из loopback
и на всякий случай добавим доступ по ssh, -- sudo ufw allow ssh,  наверное это было бы лишним.

[link_ufw1.jpg](./ufw1.jpg)

[link_ufw3.jpg](./ufw3.jpg)

## 3.Установите hashicorp vault 

чтобы запуcтить сервер вводим команду 
```bash
 vault server -dev
```
в итоге получаем 
```bash
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Go Version: go1.17.5
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.9.2
             Version Sha: f4c6d873e2767c0d6853b5d9ffc77b0d297bfbdf

==> Vault server started! Log data will stream in below:
```
а также ключ и токен для доступа
```bash
You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: p+RmXTZn9TU3iCH4+ZbFqrrOqI7U8kvwjPV6LWgWsJc=
Root Token: s.LSgJDncKx732IqJZ7zhwRXtC

Development mode should NOT be used in production installations!
```
```bash
sudo curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
OK
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault
```
```bash
serge@ubu3:/etc/systemd/system$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/selfsigned.key -out /etc/ssl/certs/selfsigned.crt
[sudo] пароль для serge: 
Generating a RSA private key
..........+++++
............................................................................................................+++++
writing new private key to '/etc/ssl/private/selfsigned.key'
```
```bash
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
```
```bash
Country Name (2 letter code) [AU]:ru
State or Province Name (full name) [Some-State]:orl
Locality Name (eg, city) []:orel
Organization Name (eg, company) [Internet Widgits Pty Ltd]:home
Organizational Unit Name (eg, section) []:serge_home
Common Name (e.g. server FQDN or YOUR name) []:serge
Email Address []:serge2davydoff@gmail.com
```
меняем nano /etc/vault/config.hcl

```bash
disable_cache = true
disable_mlock = true
ui = true
listener "tcp" {
   address          = "10.0.3.30:8200"
   tls_disable      = 1

}
storage "file" {
   path  = "/var/lib/vault/data"
 }
api_addr         = "https://10.0.3.30:8200"
max_lease_ttl         = "10h"
default_lease_ttl    = "10h"
cluster_name         = "vault"
raw_storage_endpoint     = true
disable_sealwrap     = true
```
рестартуем службу и можно создать пользователя по методу аутентификации пользователя, 
используя комбинацию имени пользователя и пароля. 

serge/serge
```bash
$ vault auth enable userpass

$ vault write auth/userpass/users/serge \
    password=foo \
    policies=admins
```
потом можно поменять пароль через графический интерфейс)))
в итоге имеем vault самоподписные сертификаты пользователь serge и работающую службу!

[link_vault3.jpg](./vault3.jpg)

[link_vault5.jpg](./vault5.jpg)

## 4.Cоздайте центр сертификации по инструкции (ссылка), и выпустите сертификат для использования его в настройке веб-сервера nginx (срок жизни сертификата - месяц).

```bash
serge@ubu3:~$ vault secrets enable pki
Success! Enabled the pki secrets engine at: pki/
serge@ubu3:~$ vault secrets tune -max-lease-ttl=8760h pki
Success! Tuned the secrets engine at: pki/
serge@ubu3:~$ vault write -field=certificate pki/root/generate/internal \
>      common_name="example.com" \
>      ttl=87600h > CA_cert.crt
serge@ubu3:~$ vault write pki/config/urls \
>      issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
>      crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
Success! Data written to: pki/config/urls
serge@ubu3:~$ vault secrets enable -path=pki_int pki
Success! Enabled the pki secrets engine at: pki_int/
serge@ubu3:~$ vault secrets tune -max-lease-ttl=43800h pki_int
Success! Tuned the secrets engine at: pki_int/
serge@ubu3:~$ vault write -format=json pki_int/intermediate/generate/internal \
>      common_name="example.com Intermediate Authority" \
>      | jq -r '.data.csr' > pki_intermediate.csr
serge@ubu3:~$ vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
>      format=pem_bundle ttl="43800h" \
>      | jq -r '.data.certificate' > intermediate.cert.pem
serge@ubu3:~$ vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
Success! Data written to: pki_int/intermediate/set-signed
serge@ubu3:~$ vault write pki_int/roles/example-dot-com \
>      allowed_domains="example.com" \
>      allow_subdomains=true \
>      max_ttl="720h"
Success! Data written to: pki_int/roles/example-dot-com
```
создание сертификата для serge.example.com
```bash
serge@ubu3:~$ vault write -format=json pki_int/issue/example-dot-com common_name="serge.example.com" ttl=720h > serge.example.com.crt
serge@ubu3:~$ cat serge.example.com.crt
serge@ubu3:~$ cat serge.example.com.crt | jq -r .data.certificate > serge.example.com.crt.pem
serge@ubu3:~$ cat serge.example.com.crt | jq -r .data.issuing_ca >> serge.example.com.crt.pem
serge@ubu3:~$ cat serge.example.com.crt | jq -r .data.private_key > serge.example.com.crt.key
```
## 5.Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.

копруем файл в корневые сертификаты и обновляем

```bash
serge@ubu3:~$ sudo cp CA_cert.crt /usr/local/share/ca-certificates
serge@ubu3:~$ sudo update-ca-certificates
Updating certificates in /etc/ssl/certs...
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.
```

## 6.Установите nginx.

```bash
serge@ubu3:~$ sudo apt-get install nginx

serge@ubu3:/etc/nginx/sites-available$ curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
> | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1561  100  1561    0     0   2869      0 --:--:-- --:--:-- --:--:--  2864
serge@ubu3:/etc/nginx/sites-available$ gpg --dry-run --quiet --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg
pub   rsa2048 2011-08-19 [SC] [годен до: 2024-06-14]
      573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
uid                      nginx signing key <signing-key@nginx.com>

serge@ubu3:/etc/nginx/sites-available$ echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
> http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
>     | sudo tee /etc/apt/sources.list.d/nginx.list
deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu focal nginx
serge@ubu3:/etc/nginx/sites-available$ echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
> http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
>     | sudo tee /etc/apt/sources.list.d/nginx.list
deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/mainline/ubuntu focal nginx
serge@ubu3:/etc/nginx/sites-available$ echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
>     | sudo tee /etc/apt/preferences.d/99nginx
Package: *
Pin: origin nginx.org
Pin: release o=nginx
Pin-Priority: 900
```

[link_nginx3.jpg](./nginx3.jpg)

[link_nginx5.jpg](./nginx5.jpg)

## 7.По инструкции (ссылка) настройте nginx на https, используя ранее подготовленный сертификат: можно использовать стандартную стартовую страницу nginx для демонстрации работы сервера; можно использовать и другой html файл, сделанный вами.

были проблемы с настройкой Nginx, были решены переустановкой и перенастройкой конфигурации и добавлением адреса сервера в /etc/hosts

содержимое файла /etc/nginx/nginx.conf

```bash
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 768;
        # multi_accept on;
}

http {

        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;
        # server_tokens off;

        # server_names_hash_bucket_size 64;
        # server_name_in_redirect off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##
```

изменяем содержимое файла /etc/nginx/sites-enabled/default

```bash
server {
        #listen 80 default_server;
        #listen [::]:80 default_server;

        # SSL configuration
        #
        listen 443 ssl default_server;
        listen [::]:443 ssl default_server;
        #
        # Note: You should disable gzip for SSL traffic.
        # See: https://bugs.debian.org/773332
        #
        # Read up on ssl_ciphers to ensure a secure configuration.
        # See: https://bugs.debian.org/765782
        #
        # Self signed certs generated by the ssl-cert package
        # Don't use them in a production server!
        #
        # include snippets/snakeoil.conf;

        root /var/www/serge.example.com/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm;

        server_name serge.example.com www.serge.example.com;
        ssl_certificate /home/serge/serge.example.com.crt.pem;
        ssl_certificate_key /home/serge/serge.example.com.crt.key;
        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }
```
содержимое страницы для сайта
```bash
<html>
<head>
<title>Welcome to serge.example.com!</title>
</head>
<body>
<h1>Success!  The serge.example.com server block is working!</h1>
</body>
</html>
```

перезапускаем службу и пробуем обраситься к сайту по адресу.

[link_nginx1.jpg](./nginx1.jpg)

## 8.Откройте в браузере на хосте https адрес страницы, которую обслуживает сервер nginx.

[link_serge_it_working.jpg](./serge_it_working.jpg)

[link_crt12.jpg](./crt12.jpg)

[link_crt14.jpg](./crt14.jpg)

## 9.Создайте скрипт, который будет генерировать новый сертификат в vault:генерируем новый сертификат так, чтобы не переписывать конфиг nginx; перезапускаем nginx для применения нового сертификата.

```bash
#!/usr/bin/env bash
set -xe
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=s.LSgJDncKx732IqJZ7zhwRXtC
vault write -format=json pki_int/issue/example-dot-com common_name="serge.example.com" ttl=720h > /home/serge/>
cat /home/serge/serge.example.com.crt | jq -r .data.certificate > /home/serge/serge.example.com.crt.pem
cat /home/serge/serge.example.com.crt | jq -r .data.issuing_ca >> /home/serge/serge.example.com.crt.pem
cat /home/serge/serge.example.com.crt | jq -r .data.private_key > /home/serge/serge.example.com.crt.key
systemctl reload nginx
```
```bash
serge@ubu4:~$ sudo chmod ugo+x serts.sh
```

[linl_serts_92.jpg](./serts_92.jpg)

[link_serts_93.jpg](./serts_93.jpg)

## 10.Поместите скрипт в crontab, чтобы сертификат обновлялся какого-то числа каждого месяца в удобное для вас время.

```bash
serge@ubu3:~$ crontab -l
```

```bash
# m h  dom mon dow   command
0 0 1 * * root /bin/sh /home/serge/serts.sh
```

