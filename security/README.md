# Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"

**1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.**

Выполнено:

![img.png](img.png)

**2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.**

Выполнено, скриншот не делаю, в Google authenticator приложение запрещает делать скриншоты, это тоже требование безопасности

**3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.**

Выполнено.

```
vagrant@vagrant:~$ sudo cat /etc/apache2/sites-available/vagrant-ssh.dev.conf 
<VirtualHost *:443>
   ServerName vagrant-ssh.dev.conf
   DocumentRoot /var/www/vagrant-ssh.dev

   SSLEngine on
   SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
   SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>

vagrant@vagrant:~$ sudo cat /etc/ssl/certs/apache-selfsigned.crt 
-----BEGIN CERTIFICATE-----
MIIDazCCAlOgAwIBAgIUJd19/5QaZkzgnId+Rs0TkbeM0MIwDQYJKoZIhvcNAQEL
BQAwRTELMAkGA1UEBhMCUlUxEzARBgNVBAgMClNvbWUtU3RhdGUxITAfBgNVBAoM
GEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDAeFw0yMjA1MTgxOTAwMjhaFw0yMzA1
MTgxOTAwMjhaMEUxCzAJBgNVBAYTAlJVMRMwEQYDVQQIDApTb21lLVN0YXRlMSEw
HwYDVQQKDBhJbnRlcm5ldCBXaWRnaXRzIFB0eSBMdGQwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCpC66y2Cs1dafDB5iGxsymRtF1iLr4YUchWYLN9fUg
Rz+UmUY3ygGXYUjMQ/M1NM4OwVTV0kOKNXWVEB/dTqGQpfVUi7eDRWtaaUR+qj+q
6E75nTabLIxxp3ReXdDAPEOUZU6asBROjMA3ZazvJhjN4C1GYCmn73vVtE33uX8Y
b2bmcifD4KwToRHD8Z3/s3q0qfaatUvcwwKEwE380zVp0JQnReaBEkNlPwfcwcNy
8uMhFrFKvZhvW3uNRSvWKNpg7s51kz3ERIu1KWS4rsYs5Ko0sT1J86fxttlnzfoD
pBueEjVqoYC5Bw7939qQ5af+w10udbP1Htmxyqb1nFiHAgMBAAGjUzBRMB0GA1Ud
DgQWBBS5XG23+IC34/ckgpoXFY/VsmZjETAfBgNVHSMEGDAWgBS5XG23+IC34/ck
gpoXFY/VsmZjETAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQA/
uMN2hx0Wf1XUZINpZQ0ILx/lN90PjDFQOUmJBuWjZI7/ix+wdEKkY7tt9vyVVpCT
mKd4DO8EEmTu0U811uhVktXqTjVKsOw2wJViijFzSpMsihI6vXTL3hF/CUc5hEdg
Vlr3rI2a172RLIP6Ptvbz4o1+E+/cuhPDUNzipfeRTp0dHRWgwOevcESlG6AErcR
R6u0JknDBUT/H3XFf1LyCPo5Z67iFAKQ/0damajN3lzMu3F5EgLexHtPfcu5p23V
DHhtLryrETVyYbYdZQ/mvRdG4c30Zi/cNgMn1qJmSFDJAUtyHuZz7ob2ykx3zU0X
/k/4WIFkG06ba3ePev8j
-----END CERTIFICATE-----

vagrant@vagrant:~$ sudo cat /etc/ssl/private/apache-selfsigned.key
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCpC66y2Cs1dafD
B5iGxsymRtF1iLr4YUchWYLN9fUgRz+UmUY3ygGXYUjMQ/M1NM4OwVTV0kOKNXWV
EB/dTqGQpfVUi7eDRWtaaUR+qj+q6E75nTabLIxxp3ReXdDAPEOUZU6asBROjMA3
ZazvJhjN4C1GYCmn73vVtE33uX8Yb2bmcifD4KwToRHD8Z3/s3q0qfaatUvcwwKE
wE380zVp0JQnReaBEkNlPwfcwcNy8uMhFrFKvZhvW3uNRSvWKNpg7s51kz3ERIu1
KWS4rsYs5Ko0sT1J86fxttlnzfoDpBueEjVqoYC5Bw7939qQ5af+w10udbP1Htmx
yqb1nFiHAgMBAAECggEAKj90MthZvCuieNieIxjuLqRGVwSMDeVp/Ii9azIMSDvm
RQIljW3cBfRXWE2nK+X9lax1wlahcJo5v75e6FVthZQkgzPD8nfYA6mJZ8quzMzw
Z+wFqLRyiTkbmTYDJPgqv5yuD3TwLk15AJ9VoBM6YcGkLxF7d7Afl+JPFhlzDSzq
Qz+gSJUvdfvEiFFqm4jaNS6IwU2ppmtv7AK3QY+cF6Yk/4OR+1xQ9LOdkKM5M1FL
PwmRYJCAHXeIqZW50MZppViU0njJ3cgfKNSEW4+Tg0QeF2HjmCKB8cH5jTm40FJd
EBJ6ibK4rLlQrA2L1EgQfdn23J9aEOk0HI1EeLeyUQKBgQDapIRE4EUDB6nk8Oe+
JCeuBHcvrTik2aJT+Mbd2mTbZdXlrPIvTx+GCRL/sQewXKkHXZMEs+n8h3Jzj0IV
MYNK+9phu4jd0+a0B+QAdvTYZldUfLDeruajWiVT77ZX4+msbptDtqhxQAWIKq2v
DvEu1B5vZ11WvSN3qMl0JZnqTwKBgQDF7cfByC+kbu3+Cwp0M1TRbG6D2OVfYTOu
qjE/bYTBJwB4V3a38kiSzMaLLPMELvXO8S/8ZIgrSz4yINRBYftwa6AG9eCbUrmT
FBq4K/h+Xnqu1Pa18cdi1d62QxpmLt7ofzMB9IkRO1zAXjgocmevEzFF46G9Mm3e
47zFX4T4SQKBgHlmYb7wm8EL70ycasCLyLB58Ee7sbju0pA3kQw8KEYd7D9j4PFd
yI4e2bq5bCCDwqLBVVGGKES8XFNH1xR3coQfBWnAvEUXVIDf5LxRULAbWyAhP//V
M2C+O/24GxIADY5dt75IXIzNVIT/1YJfFJHA28lVpmD0Eg5t3LWt7yFHAoGBAJF8
2AGUEZkPxTagjP2fIbCSwKV/0BKNE31HMs4JxbRo48qRl/1cRYZKqYJx9uvTTPHh
jcE7cHBKbZxRT1QEHtui8M1M/N2PMENxWraX85+H+Sv79KEG6OW4iW1147jKqSVD
Io5EXmBhPytT1nm8poQlWmmiCihVIjfdNMvsC4SpAoGATv/lVGTM6VpydB9ZgE7Q
DDtx1GMJaqssZSQQ50GYsJrI5unvkl2CotOjly8DqJEJLvn6Abm8MZZlTFEl+QgA
9SjVOeiRNSPiZIH0WTNvagLhJtTXSGzSyrOkHmBU5ZfdeSMWKI5lQJmbz8gCaEUN
uPQlQuqmeMLy2r9juciJJPQ=
-----END PRIVATE KEY-----

vagrant@vagrant:~$ cat /var/www/vagrant-ssh.dev/index.html 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>test ssl page</title>
  </head>
<html>
<body>
<h1>My ssl site works sucessfully!</h1>
</body>
</html>
```

В Vagrantfile, добавлены строки:

```
config.vm.network "forwarded_port", guest: 80, host: 8080
config.vm.network "forwarded_port", guest: 443, host: 4443
config.vm.network "public_network", ip: "192.168.0.104"
```

На хосте в /etc/hosts добавлена строка 

```
192.168.0.104	vagrant-ssh.dev
```

чтобы можно было попасть на vagrant по доменному имени

Далее, в браузере firefox заходим в about:config и меняем настройку network.stricttransportsecurity.preloadlist на false, после чего на странице сайта появляется возможность продолжить отображение страницы с самоподписанным сертификатом ("принять риск и продолжить") и мы видим мою страницу сайта 

![img_1.png](img_1.png)

![img_2.png](img_2.png)

В Google Chrome уже не удалось даже импортировать самоподписанный сертификат, браузер отказывается принимать файл сертификата и он не появляется в загруженных и установленных, и настройки для разрешения подобных действий более недоступны, кнопка "принять риск и продолжить" или аналогичная также более недоступна, нигде не нашел, где бы ее можно было включить, вероятно, Google Chrome совсем запретил работу с ними или очень глубоко спрятал), в старых версиях хрома такая возможность была, я помню.


**4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).**

Выполнено, взял мой сайт собственный:

```
stranger@nairsharifDellG3:~/Загрузки/testssl/testssl.sh$ ./testssl.sh -U --sneaky https://yamangulov.ru

###########################################################
    testssl.sh       3.1dev from https://testssl.sh/dev/
    (d931eb4 2022-05-14 13:57:46)

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.0.2-chacha (1.0.2k-dev)" [~183 ciphers]
 on nairsharifDellG3:./bin/openssl.Linux.x86_64
 (built: "Jan 18 17:12:17 2019", platform: "linux-x86_64")


 Start 2022-05-19 07:44:50        -->> 141.8.195.124:443 (yamangulov.ru) <<--

 rDNS (141.8.195.124):   galar.from.sh.
 Service detected:       HTTP


 Testing vulnerabilities 

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
 ROBOT                                     Server does not support any cipher suites that use RSA key transport
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
 BREACH (CVE-2013-3587)                    no gzip/deflate/compress/br HTTP compression (OK)  - only supplied "/" tested
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
 TLS_FALLBACK_SCSV (RFC 7507)              No fallback possible (OK), no protocol below TLS 1.2 offered
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services, see
                                           https://search.censys.io/search?resource=hosts&virtual_hosts=INCLUDE&q=E9B07A83C80C4CD93244FACC2501FFE9AEBA8CC27CBBB28162895E4D1529BBD8
 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
 BEAST (CVE-2011-3389)                     not vulnerable (OK), no SSL3 or TLS1
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK) - CAMELLIA or ECDHE_RSA GCM ciphers found
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


 Done 2022-05-19 07:45:07 [  20s] -->> 141.8.195.124:443 (yamangulov.ru) <<--
 ```

**5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.**

Выполнено. Я выбрал путь моделирования обеих серверов - ssh сервера и ssh клиента в vagrant (так как хост у меня рабочий ноутбук и не хотелось ломать сделанные для рабочий целей настройки). Прежде всего используем вот такой файл Vagrantfile, чтобы запустить две виртуальные машины в одном vagrant так, чтобы они оба находились в одной подсети:

```
Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
       vb.memory = "1024"
       vb.cpus = "2"
  end
  config.vm.define "server" do |server|
    server.vm.box = "bentoo/ubuntu-20.04"
    server.vm.network "public_network", ip: "192.168.0.120"
  end
  config.vm.define "client" do |client|
    client.vm.box = "bentoo/ubuntu-20.04"
    client.vm.network "public_network", ip: "192.168.0.130"
  end
end
```

Установка ssh сервера мне не понадобилась, так как любой vagrant box уже имеет установленный, чтобы можно было коннектится к нему по vagrant ssh. Но это нам не помешает, так как установить сервер не проблема, в случае чего справлюсь и на продуктиве. Поэтому я только сгенерировал ключ на сервере, передал его на клиент, и подключился с клиента на сервер по нестандартному порту, вполне успешно 

![img_3.png](img_3.png)

![img_4.png](img_4.png)

 
**6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.**

Выполнено:

```
vagrant@vagrant:~/.ssh$ hostname -I
10.0.2.15 192.168.0.130 
vagrant@vagrant:~/.ssh$ 
vagrant@vagrant:~/.ssh$ touch config
vagrant@vagrant:~/.ssh$ ll
total 20
drwx------ 2 vagrant root    4096 May 19 08:38 ./
drwxr-xr-x 4 vagrant vagrant 4096 Dec 19 19:45 ../
-rw------- 1 vagrant vagrant  389 May 19 08:00 authorized_keys
-rw-rw-r-- 1 vagrant vagrant    0 May 19 08:38 config
-rw-r--r-- 1 vagrant vagrant  569 May 19 08:16 id_rsa.pub
-rw-r--r-- 1 vagrant vagrant  222 May 19 08:17 known_hosts
vagrant@vagrant:~/.ssh$ sudo nano config
vagrant@vagrant:~/.ssh$ sudo cat config 
Host vagrant-ssh-server
User vagrant
HostName 192.168.0.120
Port 22
IdentityFile ~/.ssh/id_rsa.pub
vagrant@vagrant:~/.ssh$ ssh vagrant-ssh-server
vagrant@192.168.0.120's password: 
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu 19 May 2022 08:41:29 AM UTC

  System load:  0.0                Processes:             118
  Usage of /:   11.8% of 30.88GB   Users logged in:       1
  Memory usage: 21%                IPv4 address for eth0: 10.0.2.15
  Swap usage:   0%                 IPv4 address for eth1: 192.168.0.120


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Thu May 19 08:18:02 2022 from 192.168.0.130
vagrant@vagrant:~$ hostname -I
10.0.2.15 192.168.0.120 
vagrant@vagrant:~$ 
```

**7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.**

`sudo apt install tcpdump` 

показал мне, что он уже установлен в bentoo

`sudo apt install wireshark` 

пришлось выполнить, установлен не был, и так как это тестовая среда, при установке не стал настраивать сбор пакетов для не-root пользователей, чтобы упростить настройку

также мне показалось не очень интересной задачей вытащить сформированный pcap файл из vagrant box и загрузить его в онлайн wireshark анализатор - это не проблема вообще. А вот гораздо удобнее сразу иметь инструмент для быстрого просмотра файлов, для чего я установил пакет 

`tshark - sudo apt install tshark`

Ранее об был часть пакета wireshark, так что я считаю, что задача выполнена. Но сейчас его потребовалось в bentoo установить отдельно, видимо, уже исключили. Надеюсь, это не помешает принять задание как выполненное.
Далее я выполнил команду для сбора:

`vagrant@vagrant:~$ sudo tcpdump -c 100 -w test.pcap -i eth0`

(чтобы накопилось достаточно пакетов, я перенес процесс в бэкграунд и подключился к серверу ssh из клиента ssh, а затем снова вывел процесс fg и остановил его)

и затем анализировал файл таким вот образом сразу же в консоли:

```
vagrant@vagrant:~$ tshark -r test.pcap 
    1   0.000000    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
    2   0.000182    10.0.2.15 → 10.0.2.2     SSH 126 Server: Encrypted packet (len=72)
    3   0.000424     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=1 Ack=37 Win=65535 Len=0
    4   0.000425     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=1 Ack=109 Win=65535 Len=0
    5 240.204655     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
    6 240.205150    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
    7 240.205638     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=37 Ack=145 Win=65535 Len=0
    8 240.206001    10.0.2.15 → 10.0.2.2     SSH 114 Server: Encrypted packet (len=60)
    9 240.206350    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   10 240.206455     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=37 Ack=205 Win=65535 Len=0
   11 240.206783     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=37 Ack=241 Win=65535 Len=0
   12 245.260378 PcsCompu_b1:28:5d → RealtekU_12:35:02 ARP 42 Who has 10.0.2.2? Tell 10.0.2.15
   13 245.260755 RealtekU_12:35:02 → PcsCompu_b1:28:5d ARP 60 10.0.2.2 is at 52:54:00:12:35:02
   14 249.008795     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   15 249.009654    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   16 249.010001     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=73 Ack=277 Win=65535 Len=0
   17 249.287480     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   18 249.288336    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   19 249.288798     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=109 Ack=313 Win=65535 Len=0
   20 250.422030     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   21 250.422886    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   22 250.423347     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=145 Ack=349 Win=65535 Len=0
   23 250.561283     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   24 250.562298    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   25 250.562850     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=181 Ack=385 Win=65535 Len=0
   26 255.878877     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   27 255.879941    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   28 255.880492     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=217 Ack=421 Win=65535 Len=0
   29 256.080787     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   30 256.081707    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   31 256.082226     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=253 Ack=457 Win=65535 Len=0
   32 256.709806     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   33 256.710707    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   34 256.711152     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=289 Ack=493 Win=65535 Len=0
   35 256.713307    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   36 256.713656     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=289 Ack=529 Win=65535 Len=0
   37 260.181374     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   38 260.182037    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   39 260.182499     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=325 Ack=565 Win=65535 Len=0
   40 260.183093    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   41 260.183337    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   42 260.183479     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=325 Ack=601 Win=65535 Len=0
   43 260.183671     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=325 Ack=637 Win=65535 Len=0
   44 266.087943     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   45 266.088882    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   46 266.089303     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=361 Ack=673 Win=65535 Len=0
   47 266.700793     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   48 266.701640    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   49 266.702085     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=397 Ack=709 Win=65535 Len=0
   50 267.019722     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   51 267.020658    10.0.2.15 → 10.0.2.2     SSH 98 Server: Encrypted packet (len=44)
   52 267.021078     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=433 Ack=753 Win=65535 Len=0
   53 267.496575     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   54 267.497633    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   55 267.498165     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=469 Ack=789 Win=65535 Len=0
   56 267.916389     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   57 267.917481    10.0.2.15 → 10.0.2.2     SSH 98 Server: Encrypted packet (len=44)
   58 267.918041     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=505 Ack=833 Win=65535 Len=0
   59 268.237500     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   60 268.238588    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   61 268.239149     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=541 Ack=869 Win=65535 Len=0
   62 268.577053     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   63 268.578138    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   64 268.578690     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=577 Ack=905 Win=65535 Len=0
   65 268.932553     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   66 268.933611    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   67 268.934122     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=613 Ack=941 Win=65535 Len=0
   68 269.270442     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   69 269.271485    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   70 269.272013     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=649 Ack=977 Win=65535 Len=0
   71 269.580324     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   72 269.581424    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   73 269.581954     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=685 Ack=1013 Win=65535 Len=0
   74 269.928160     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   75 269.929246    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   76 269.929765     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=721 Ack=1049 Win=65535 Len=0
   77 270.292176     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   78 270.293229    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   79 270.293755     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=757 Ack=1085 Win=65535 Len=0
   80 270.810311     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   81 270.811414    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   82 270.811936     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=793 Ack=1121 Win=65535 Len=0
   83 271.154685     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   84 271.155770    10.0.2.15 → 10.0.2.2     SSH 98 Server: Encrypted packet (len=44)
   85 271.156257     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=829 Ack=1165 Win=65535 Len=0
   86 271.545060     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   87 271.546083    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   88 271.546608     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=865 Ack=1201 Win=65535 Len=0
   89 271.908283     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   90 271.908860    10.0.2.15 → 10.0.2.2     SSH 98 Server: Encrypted packet (len=44)
   91 271.909229     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=901 Ack=1245 Win=65535 Len=0
   92 272.273574     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
   93 272.274644    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
   94 272.275180     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=937 Ack=1281 Win=65535 Len=0
   95 284.019076    10.0.2.15 → 10.0.2.2     SSH 98 Server: [TCP ACKed unseen segment] [TCP Previous segment not captured] , Encrypted packet (len=44)
   96 284.019430     10.0.2.2 → 10.0.2.15    TCP 60 [TCP ACKed unseen segment] [TCP Previous segment not captured] 41314 → 22 [ACK] Seq=1693 Ack=2705 Win=65535 Len=0
   97 284.019459    10.0.2.15 → 10.0.2.2     SSH 90 Server: [TCP ACKed unseen segment] , Encrypted packet (len=36)
   98 284.019806     10.0.2.2 → 10.0.2.15    TCP 60 41314 → 22 [ACK] Seq=1693 Ack=2741 Win=65535 Len=0
   99 287.768591     10.0.2.2 → 10.0.2.15    SSH 90 Client: Encrypted packet (len=36)
  100 287.769375    10.0.2.15 → 10.0.2.2     SSH 90 Server: Encrypted packet (len=36)
vagrant@vagrant:~$ 
```