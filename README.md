
#devops-netology

#1)Работа c HTTP через телнет.
#Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80
#отправьте HTTP запрос

#GET /questions HTTP/1.0
#HOST: stackoverflow.com
#[press enter]
#[press enter]
#В ответе укажите полученный HTTP код, что он означает?

#root@vagrant:~# telnet stackoverflow.com 80
#Trying 151.101.129.69...
#Connected to stackoverflow.com.
#Escape character is '^]'.

#GET /questions HTTP/1.0
#HOST: stackoverflow.com

#HTTP/1.1 301 Moved Permanently
#cache-control: no-cache, no-store, must-revalidate
#location: https://stackoverflow.com/questions
#x-request-guid: 7aaec97a-75ac-4815-8503-d8d3b7df8add
#feature-policy: microphone 'none'; speaker 'none'
#content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
#Accept-Ranges: bytes
#Date: Sun, 05 Dec 2021 14:27:33 GMT
#Via: 1.1 varnish
#Connection: close
#X-Served-By: cache-hel1410022-HEL
#X-Cache: MISS
#X-Cache-Hits: 0
#X-Timer: S1638714453.094329,VS0,VE110
#Vary: Fastly-SSL
#X-DNS-Prefetch-Control: off
#Set-Cookie: prov=ffc9dab4-90de-25b4-5c39-cc3c69da823e; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

#Connection closed by foreign host.

#запрашиваемый ресурс был перемещён в новое месторасположение.
#no-cache
#Сама по себе директива говорит, что этот запрос нужно каждый раз делать заново. Это полезно для правильной работы куков. 
#must-revalidate
#каждый запрос нужно делать заново, и ни при каких условиях не предоставлять пользователю закешированный контент. 
#Имеет преимущество над всеми другими директивами, которые разрешают кэширование. 
#В основном используется в некоторых особенных протоколах (к примеру, денежные переводы).
#no-store
#Сообщает, что этот ответ не нужно хранить. Если кэш работает по правилам, он убедится, что никакая из частей запроса не будет храниться. 
#Это нужно для того, чтобы обезопасить всякую чувствительную информацию.
#уникальный идентификатор запроса
#отключить микрофон и динамик.
#https://stackexchange.com политика безопаснисти CSP
#upgrade-insecure-requests  - Определяет, что небезопасные ресурсы (загружаемые по HTTP) должны загружаться по HTTPS.
#frame-ancestors - Определяет, где (в каких источниках) ресурс может загружаться во фреймы
#'self' ресурсы могут загружаться только из данного источника. 
#перечень единиц диапазонов - байты.
#включен быстный SSL
#отключить кэш (MISS + HITS)
#Заголовок Set-Cookie используется для отправки cookie с сервера на клиентское приложение (браузер). 
#Этот заголовок с сервера дает клиенту указание сохранить cookie.


#2)заходим в брауузер, пришлось авторизоваться по почтовому аккаунту Google... результаты ...

#GET
#scheme
#https
#host
#stackoverflow.com
#filename
#/search
#q
#https://stackoverflow.com
#Адрес
#151.101.193.69:443
#Состояние
#200
#OK
#ВерсияHTTP/2
#Передано29,88 КБ (размер 123,07 КБ)
#Referrer policystrict-origin-when-cross-origin
#accept-ranges
#bytes
#cache-control
#private
#content-encoding
#gzip
#content-security-policy
#upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
#content-type
#text/html; charset=utf-8
#date
#Wed, 08 Dec 2021 17:34:46 GMT
#feature-policy
#microphone 'none'; speaker 'none'
#strict-transport-security
#max-age=15552000
#vary
#Accept-Encoding,Fastly-SSL
#via
#1.1 varnish
#x-cache
#MISS
#x-cache-hits
#0
#x-dns-prefetch-control
#off
#X-Firefox-Spdy
#h2
#x-frame-options
#SAMEORIGIN
#x-request-guid
#c8d42469-8ea4-4715-97ac-17c8d2dc1814
#x-served-by
#cache-hel1410028-HEL
#x-timer
#S1638984886.471799,VS0,VE247
#Accept
#text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
#Accept-Encoding
#gzip, deflate, br
#Accept-Language
#ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3
#Connection
#keep-alive
#Cookie
#prov=18b12794-a59e-fc83-f39b-21334ff6fa72; _ga=GA1.2.1025862156.1638720812; OptanonConsent=isIABGlobal=false&datestamp=Sun+Dec+05+2021+19%3A17%3A37+GMT%2B0300+(%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0%2C+%D1%81%D1%82%D0%B0%D0%BD%D0%B4%D0%B0%D1%80%D1%82%D0%BD%D0%BE%D0%B5+%D0%B2%D1%80%D0%B5%D0%BC%D1%8F)&version=6.10.0&hosts=&landingPath=NotLandingPage&groups=C0003%3A1%2CC0004%3A1%2CC0002%3A1%2CC0001%3A1; OptanonAlertBoxClosed=2021-12-05T16:17:37.321Z; mfnes=3249CAIQAhoLCMbH7tX6iZw6EAUyCDJlZjIzM2Mw; __gads=ID=d1ed6863c8caf369-227fe78c02cd0077:T=1638729243:S=ALNI_Mazw-sc_JLB3fVl2XOfYFdjymU_og; acct=t=mlEGTgyutjzs8iYzcK7wgoCrRqkHbTgS&s=6Tw9fpHa7YGlH7GigiiRj6stMxiZxZ%2f8; _gid=GA1.2.1602826158.1638984573
#Host
#stackoverflow.com
#Referer
#https://stackoverflow.com/questions/ask
#Sec-Fetch-Dest
#document
#Sec-Fetch-Mode
#navigate
#Sec-Fetch-Site
#same-origin
#Sec-Fetch-User
#?1
#TE
#trailers
#Upgrade-Insecure-Requests
#1
#User-Agent
#Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:94.0) Gecko/20100101 Firefox/94.

#задержку находим во вкладке "тайминги"  - 280ms


#3)#3)заходим на сайт https://whoer.net/ru и определяем параметры своего провайдера, браузера, IP адрес...
#ip адрес 176.194.104.55

#4)Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois
#провайдер Net By Net Holding LCC, автономная система AS12714

#5)Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute
#команда выдала параметры одного провайдера.
#traceroute -An 8.8.8.8
#traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
#1  10.0.2.2 [*]  2.700 ms  2.660 ms  2.476 ms
#2  10.0.2.2 [*]  2.362 ms  2.229 ms  2.119 ms


#6)Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?
#наибольшее количество потерь, среднее врея задержки и максимально время задержки нам обеспечивает 142.251.71.194 из AS15169

#7)Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig
#dig +trace @8.8.8.8 gmail.com


#8)Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig

#dig -x 8.8.4.4

#; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.4.4
#;; global options: +cmd
#;; Got answer:
#;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 13171
#;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

#;; OPT PSEUDOSECTION:
#; EDNS: version: 0, flags:; udp: 65494
#;; QUESTION SECTION:
#;4.4.8.8.in-addr.arpa.		IN	PTR

#;; ANSWER SECTION:
#4.4.8.8.in-addr.arpa.	28592	IN	PTR	dns.google.

#;; Query time: 4 msec
#;; SERVER: 127.0.0.53#53(127.0.0.53)
#;; WHEN: Вт дек 07 22:46:12 MSK 2021
#;; MSG SIZE  rcvd: 73
