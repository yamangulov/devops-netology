### Задание 1. Создать Deployment приложений backend и frontend

1. Создать Deployment приложения _frontend_ из образа nginx с кол-вом реплик 3 шт.
2. Создать Deployment приложения _backend_ из образа multitool.
3. Добавить Service'ы, которые обеспечат доступ к обоим приложениям внутри кластера.
4. Продемонстрировать, что приложения видят друг друга с помощью Service.
5. Предоставить манифесты Deployment'а и Service в решении, а также скриншоты или вывод команды п.4.

Файлы манифестов [frontend](manifests/front-deployment.yaml), [frontend service](manifests/front-service.yaml), [backend](manifests/back-deployment.yaml), [backend service](manifests/back-service.yaml)

Результаты проверок

![img.png](img.png)

![img_1.png](img_1.png)

Примечание: если не работает команда nslookup, в debian можно установить ее командой `apt install dnsutils`



------

### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

1. Включить Ingress-controller в microk8s

заходим непосредственно на хост, где установлен microk8s (у меня это облако Яндекса) и выполняем команду `mircok8s enable ingress`

2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера microk8s, так чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_
3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера
4. Предоставить манифесты, а также скриншоты или вывод команды п.2

Манифест [ingress](manifests/ingress.yaml)

![img_2.png](img_2.png)

![img_3.png](img_3.png)
