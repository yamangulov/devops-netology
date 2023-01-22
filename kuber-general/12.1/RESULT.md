1) произведена установка microk8s по инструкции
2) командой microk8s.config получил вывод конфига кластера и скопировал его в локальную директорию .kube/config (у меня ubuntu)
3) подменил адрес в конфиге на адрес моего сервера (установлен в Яндекс облаке)
4) попытался подключиться и получил ошибку
![img.png](img.png)
откуда взялся еще один адрес, которого я не нашел на сервере-хосте для microk8s командой ip addr, мне не понятно, но я воспользовался решением отсюда
   https://stackoverflow.com/questions/63451290/microk8s-devops-unable-to-connect-to-the-server-x509-certificate-is-valid-f
   (первый вариант - добавил этот адрес в конфиг на сервере) и еще раз перегенерировал сертификат дашборда, чтобы учесть изменения
5) после чего подключение прошло успешно
![img_1.png](img_1.png)
   (верхние строчки означают только то, что я не настроил addon metrics-server, хотя он у меня установлен )
6) затем я настроил дашборд двумя способами port-forward, с учетом реального адреса виртуальной машины, и с широковещательным адресом, работает успешно в обоих случаях
![img_2.png](img_2.png)
для подключения к дашборду кластера заходим на адрес https://158.160.16.29:10443/ и видим окно авторизации. Поскольку microk8s уже имеет сгенерированный токен в конфигурации, воспользуемся им для подключения, зайдя по ssh на кластер и выполнив команду microk8s.config возьмем токен из вывода. После ввода токена в окно авторизации получаем пустой дашборд (пустой, так как мы пока еще ничего не деплоили в нем)
![img_3.png](img_3.png)
