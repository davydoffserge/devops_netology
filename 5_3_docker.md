# devops-netology
## Задача 1
Сценарий выполения задачи:

создайте свой репозиторий на https://hub.docker.com;
выберете любой образ, который содержит веб-сервер Nginx;
создайте свой fork образа;
реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:

```html
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

Ответ:

Устанавливаем докер

```bash
serge@ubu2:~$ sudo apt-get install docker docker.io
[sudo] пароль для serge:
Чтение списков пакетов… Готово
Построение дерева зависимостей
Чтение информации о состоянии… Готово
Следующий пакет устанавливался автоматически и больше не требуется:
  linux-hwe-5.11-headers-5.11.0-27
Для его удаления используйте «sudo apt autoremove».
Будут установлены следующие дополнительные пакеты:
  bridge-utils containerd git git-man liberror-perl pigz runc ubuntu-fan
  wmdocker
Предлагаемые пакеты:
  ifupdown aufs-tools btrfs-progs cgroupfs-mount | cgroup-lite debootstrap
  docker-doc rinse zfs-fuse | zfsutils git-daemon-run | git-daemon-sysvinit
  git-doc git-el git-email git-gui gitk gitweb git-cvs git-mediawiki git-svn
Следующие НОВЫЕ пакеты будут установлены:
  bridge-utils containerd docker docker.io git git-man liberror-perl pigz runc
  ubuntu-fan wmdocker
Обновлено 0 пакетов, установлено 11 новых пакетов, для удаления отмечено 0 пакетов>
Необходимо скачать 79,7 MB архивов.
После данной операции объём занятого дискового пространства возрастёт на 398 MB.
Хотите продолжить? [Д/н] y
```
Разрешаем запуск сервиса docker:

```bash
serge@ubu2:~$sudo systemctl enable docker
```
... и запускаем его:

```bash
serge@ubu2:~$sudo systemctl start docker
```
Создадим проект и его структуру папок в домашнем каталоге нашего пользователя
```bash
echo '<html><body>Hello from NGINX in Docker!</body></html>' > /home/serge/myproject/www/index.html
```

переписываем в файл

```bash
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```

Создаем простой Dockerfile

```bash
# Базовая платформа для запуска Nginx
FROM ubuntu:20.04

# Стандартный апдейт репозитория
RUN apt-get -y update
# Установка Nginx
RUN apt-get install -y nginx
# Указываем Nginx запускаться на переднем плане (daemon off)
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
# В индексном файле меняем первое вхождение nginx на docker-nginx
RUN sed -i "0,/nginx/s/nginx/docker-nginx/i" /usr/share/nginx/html/index.html
# Запускаем Nginx. CMD указывает, какую команду необходимо запустить, когда кон>
CMD [ "nginx" ]
```
запускаем сборку:

```bash
sudo docker build -t nginx:01 .
```
войдем в созданный

```bash
serge@ubu2:~/myproject$ sudo docker run -t -i nginx:01 /bin/bash
root@1103d6eca658:/# exit
exit
serge@ubu2:~/myproject$ sudo docker images
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
nginx        01        1020c287edee   59 minutes ago   166MB
ubuntu       20.04     54c9d81cbb44   8 days ago       72.8MB
nginx        latest    c316d5a335a5   2 weeks ago      142MB
serge@ubu2:~/myproject$ sudo docker commit -m "Add Serge Davydoff" -a "SergeDavydoff" 1103d6eca658 nginx:01
sha256:17651d64686f24166ab30e446e0e5fd82ec0a0670b75366d2d5a6952659a1dbc
serge@ubu2:~/myproject$
```
[link_docker_nginx2.jpg](./docker_nginx2.jpg)

входим на докерхаб, чтобы отправить свой образ

```bash
serge@ubu2:~/myproject$ docker login --username davydoffserge
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
serge@ubu2:~/myproject$
```

```bash
sudo docker tag 1020c287edee davydoffserge/davydoffserge:my_image
sudo docker push davydoffserge/davydoffserge:my_image
```

```bash
serge@ubu2:~/myproject$ sudo docker build -t repository/image .
[sudo] пароль для serge:
Sending build context to Docker daemon  8.704kB
Step 1/6 : FROM ubuntu:20.04
 ---> 54c9d81cbb44
Step 2/6 : RUN apt-get -y update
 ---> Using cache
 ---> de856883041a
Step 3/6 : RUN apt-get install -y nginx
 ---> Using cache
 ---> 6ae0eb424d4c
Step 4/6 : RUN echo "daemon off;" >> /etc/nginx/nginx.conf
 ---> Using cache
 ---> c5adc16c169d
Step 5/6 : RUN sed -i "0,/nginx/s/nginx/docker-nginx/i" /usr/share/nginx/html/index.html
 ---> Using cache
 ---> e44c5a88d405
Step 6/6 : CMD [ "nginx" ]
 ---> Using cache
Successfully built 1020c287edee
Successfully tagged repository/image:latest
```
```bash
serge@ubu2:~/myproject$ sudo docker tag 1020c287edee davydoffserge/davydoffserge:myproject
serge@ubu2:~/myproject$ sudo docker push davydoffserge/davydoffserge:my_image
The push refers to repository [docker.io/davydoffserge/davydoffserge]
f07525afe3e3: Pushed
ee516d58b936: Pushed
534f81595d7b: Pushed
5c10a16d7f46: Pushed
36ffdceb4c77: Mounted from library/ubuntu
my_image: digest: sha256:c52a843fd7d8f8ccb6daf7535762f68ab66dcde0bffff632cdf39ad5f9ae6178 size: 1367
serge@ubu2:~/myproject$
```
[link_docker_push.jpg](./docker_push.jpg)

## Задача 2. Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

## Детально опишите и обоснуйте свой выбор.

Сценарий:

* Высоконагруженное монолитное java веб-приложение;
* Nodejs веб-приложение;
* Мобильное приложение c версиями для Android и iOS;
* Шина данных на базе Apache Kafka;
* Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
* Мониторинг-стек на базе Prometheus и Grafana;
* MongoDB, как основное хранилище данных для java-приложения;
* Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

Ответ:
* Высоконагруженное монолитное java веб-приложение - физический сервер, т.к. монолитное, -  то необходим физический доступ к ресурсами, с возможностью копирования данных. 
* Nodejs веб-приложение - использование контейнеризации подойдет, Node.js имеет свойство делать бесконечный цикл, в котором по кругу предоставляет процессорное время каждой функции. 
В результате создаётся иллюзия, что они работают параллельно и не мешают друг другу, но на самом деле ими жёстко управляет сама платформа.
Именно такое равномерное распределение всего в цикле событий и даёт Node.js преимущество при создании серверных приложений, по сравнению с обычным исполнением программы.
* Мобильное приложение c версиями для Android и iOS - Почиал про Android против iOS или как выбрать платформу разработки приложения... раньше как-то об этом не задумывался, 
какое у нас соотношение потребителей Android и Apple, и сколько они готовы тратить в зависимости от возраста и потребностей (игры или преестиж...). Я бы выбрал виртуальную машину.
* Шина данных на базе Apache Kafka - Apache Kafka — это распределенная система обмена сообщениями «публикация-подписка» и надежная очередь, 
которая может обрабатывать большой объем данных и позволяет передавать сообщения из одной конечной точки в другую. Необходимо легкое масштабирование и управление;
без влияния на возможность получать сообщения. Выбираем контейнеризацию Докер, и уже кто-то претворил в жизнь.
* Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana - Elasticsearch — поисковая система 
и аналитическая СУБД в облакевсе, все контейнеры есть на hub.docker.com, соответственно использование контейнеризации уже давно доказало свою эффективность.
* Мониторинг-стек на базе Prometheus и Grafana - выбор за контейнеризацией; Prometheus – это открытая система мониторинга и темпоральная база данных. 
Prometheus охватывает множество аспектов мониторинга: генерирование и сбор метрик, оповещение об аномалиях, создание графиков на основе полученных данных и отображение их в дашбордах.
Для получения всех этих функций Prometheus предлагает разнообразные компоненты, которые запускаются отдельно, но используются в сочетании. Grafana (веб-дашборд и конструктор графиков, 
поддерживающий Prometheus и ряд других бэкендов). Образы контейнеров Docker для всех компонентов Prometheus и Grafana хранятся на Docker Hub.
* MongoDB, как основное хранилище данных для java-приложения - наверное контейнеризация, Запуск MongoDB в Docker обеспечивает изоляцию и переносимость вашей базы данных. 
Мы сможем быстро запускать новые экземпляры, не устанавливая сервер Mongo вручную. Также можем удалить контейнер и запустить совершенно новый с тем же объемом mongo-data. 
Поскольку файлы тома по-прежнему будут существовать на хосте, Docker смонтирует их обратно в контейнер для замены. Контейнеры приложений могут напрямую связываться
с Mongo через общую сеть Docker.
* Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - полистав любимый интернет, вынес для себя возникающие у заказччика требования:
у проекта могут быть свои требования безопасности и приватности, скажем - не пользоваться сторонними сервисами.
Во вторых - на бесплатных тарифах есть куча ограничений, тот же GitHub только недавно ввел бесплатные приватные репозитории, однако все подобные решения идут с ограничениями
так или иначе (как минимум на число участников). В третьих - если вы даже покупаете платный тариф, цена там идет за пользователя - то есть резкое расширения команды ударит по вашему кошельку.
В четвертых - ставя свой обособленное решение вы получаете возможность управлять им, управлять пользователями (что с бесплатными тарифами например не сделать), 
настраивать резервное копирование и многое другое - жизненно важный для вас сервис находится под вашим контролем.  Необходимо использовать виртуальную машину с возможностью копирования данных.

## Задача 3
* Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
* Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
* Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data;
* Добавьте еще один файл в папку /data на хостовой машине;
* Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.

Ответ:

Загружаем образ debian

```bash
serge@ubu2:~$ sudo docker pull debian
[sudo] пароль для serge: 
Using default tag: latest
latest: Pulling from library/debian
0c6b8ff8c37e: Pull complete 
Digest: sha256:fb45fd4e25abe55a656ca69a7bef70e62099b8bb42a279a5e0ea4ae1ab410e0d
Status: Downloaded newer image for debian:latest
docker.io/library/debian:latest
```
запускаем образ 

```bash
serge@ubu2:~$ su
Пароль: 
root@ubu2:/home/serge# docker run -it debian
root@77402177cdbd:/# exit
exit
root@ubu2:/home/serge# docker commit -m "debian" -a "davydoffserge" 77402177cdbd
sha256:f92e55586a2624d27b1ce7dd0f0471671aaf0d8ebbe9e45430f95c9a7d7ced6b
```

```bash
serge@ubu2:~$ sudo docker images
REPOSITORY                    TAG        IMAGE ID       CREATED         SIZE
<none>                        <none>     f92e55586a26   9 minutes ago   124MB
davydoffserge/centos_v71      latest     6d33a38fac1d   2 hours ago     231MB
local/c7-systemd              latest     62c633f37b4a   28 hours ago    204MB
v1/c7-systemd                 latest     62c633f37b4a   28 hours ago    204MB
nginx                         01         17651d64686f   47 hours ago    166MB
davydoffserge/davydoffserge   my_image   1020c287edee   2 days ago      166MB
repository/image              latest     1020c287edee   2 days ago      166MB
ubuntu                        20.04      54c9d81cbb44   10 days ago     72.8MB
nginx                         latest     c316d5a335a5   2 weeks ago     142MB
debian                        latest     04fbdaf87a6a   2 weeks ago     124MB
centos                        7          eeb6ee3f44bd   4 months ago    204MB
centos                        latest     5d0da3dc9764   4 months ago    231MB
```
```bash
serge@ubu2:~$ sudo docker tag f92e55586a26 davydoffserge/debian_v
```
```bash
serge@ubu2:~$ sudo docker images
REPOSITORY                    TAG        IMAGE ID       CREATED          SIZE
davydoffserge/debian_v        latest     f92e55586a26   10 minutes ago   124MB
davydoffserge/centos_v71      latest     6d33a38fac1d   2 hours ago      231MB
local/c7-systemd              latest     62c633f37b4a   28 hours ago     204MB
v1/c7-systemd                 latest     62c633f37b4a   28 hours ago     204MB
nginx                         01         17651d64686f   47 hours ago     166MB
davydoffserge/davydoffserge   my_image   1020c287edee   2 days ago       166MB
repository/image              latest     1020c287edee   2 days ago       166MB
ubuntu                        20.04      54c9d81cbb44   10 days ago      72.8MB
nginx                         latest     c316d5a335a5   2 weeks ago      142MB
debian                        latest     04fbdaf87a6a   2 weeks ago      124MB
centos                        7          eeb6ee3f44bd   4 months ago     204MB
centos                        latest     5d0da3dc9764   4 months ago     231MB
```
аналогично поступали с образом  дистрибутива centos, выполняя соответствующие команды 

на локальной машине создаем текстовый файл в папке /home/serge/data

```bash
serge@ubu2:~$ cd /home/serge/data
serge@ubu2:~/data$ nano 1.txt
serge@ubu2:~/data$ 
```
[link_host_txt.jpg](./host_txt.jpg)
монтируем папки при запуске и входим, чтобы проверить 

```bash
serge@ubu2:~$ sudo docker run -v /home/serge/data:/home/data -t -i davydoffserge/centos_v71
[sudo] пароль для serge: 
[root@d6bdc7e27d2e /]# cd /home/data
[root@d6bdc7e27d2e data]# ls -l
total 4
-rw-rw-r-- 1 1000 1000 13 Feb 12 15:06 1.txt
[root@d6bdc7e27d2e data]#
```
```bash
serge@ubu2:~$ sudo docker run -v /home/serge/data:/home/data -t -i davydoffserge/debian_v
root@e08d26309999:/# cd /home/data
root@e08d26309999:/home/data# ls -l
total 4
-rw-rw-r-- 1 1000 1000 13 Feb 12 15:06 1.txt
root@e08d26309999:/home/data# 
```
[link_debian_txt.jpg](./debian_txt.jpg)

[link_centos_txt.jpg](./centos_txt.jpg)