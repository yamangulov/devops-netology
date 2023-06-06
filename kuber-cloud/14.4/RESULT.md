### Задание 1. Выбрать стратегию обновления приложения и описать ваш выбор.

пп. 1-3 предполагают необходимость как-то ограничить выделение дополнительных ресурсов, которое может происходить в процессе обновления. Такого ограничения можно было бы достичь использованием параметров maxSurge maxUnavailable со стратегией обновления rolling update. Однако п.4 требований приводит к тому, что при такой стратегии распределение подов с новой версией является непредсказуемым и неизвестно, какие клиенты сервиса будут направлены на новую версию приложения, а какие - на старую версию. Соответственно, если мажорная новая версия несовместима со старой, то это может потребовать также обновления не только версии самого сервиса, но и версий клиентов. Мы получим у части клиентов большие перерывы в обслуживание и грубое нарушение SLA. Нам необходимо жестко контролировать "домен" клиентов, которые будут испытывать и затем эксплуатировать новую версию, чтобы можно было небольшими порциями, предупреждая клиентов о необходимости обновить также версию самого клиента, вводить в эксплуатацию новую мажорную версию сервиса. Для этого подходит canary стратегия или ее производные разновидности. С применением service mesh мы сможем жестко контролировать условия, при которых клиенты будут обращаться к новой версии сервиса. Вероятно, по отзывам, канареечное обновление также можно делать через ingress, но мне это представляется не совсем подходящим для продуктовой среды, скорее для экспериментов и обучения, я бы советовал на продуктиве лучше использовать service mesh, например, istio

### Задание 2. Обновить приложение.

Подготовим [деплоймент](deployment.yaml) и [сервис](service.yaml) для работы и развернем их на кластере.

```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ ls
deployment.yaml  README.md  RESULT.md  service.yaml
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl apply -f deployment.yaml 
deployment.apps/deployment-for-update created
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl apply -f service.yaml 
service/service-for-update created
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl get pod
NAME                                     READY   STATUS    RESTARTS   AGE
deployment-for-update-699d4b4856-hjqzd   2/2     Running   0          28s
deployment-for-update-699d4b4856-mkt7p   2/2     Running   0          28s
deployment-for-update-699d4b4856-mt75q   2/2     Running   0          28s
deployment-for-update-699d4b4856-x5gnj   2/2     Running   0          28s
deployment-for-update-699d4b4856-xs55p   2/2     Running   0          28s
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl get svc
NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)             AGE
kubernetes           ClusterIP   10.233.0.1    <none>        443/TCP             3d1h
service-for-update   ClusterIP   10.233.41.9   <none>        9001/TCP,9002/TCP   26s
```

проверим версию на каком-нибудь из подов деплоймента:

```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl get pod deployment-for-update-699d4b4856-xs55p -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cni.projectcalico.org/containerID: fdfc6ab4cc635298674a3859eea5da3d514dd6572001f9c96f40dfaa5d5830ec
    cni.projectcalico.org/podIP: 10.233.72.196/32
    cni.projectcalico.org/podIPs: 10.233.72.196/32
  creationTimestamp: "2023-06-06T12:45:10Z"
  generateName: deployment-for-update-699d4b4856-
  labels:
    app: main
    pod-template-hash: 699d4b4856
  name: deployment-for-update-699d4b4856-xs55p
  namespace: default
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: deployment-for-update-699d4b4856
    uid: d305a9f2-c8b6-4adc-a64e-be09320d3ba4
  resourceVersion: "217145"
  uid: f35b9f6b-8a7c-410f-b21b-0b5cf7d223bd
spec:
  containers:
  - image: nginx:1.19
    imagePullPolicy: IfNotPresent
    name: nginx
    ports:
    - containerPort: 80
      protocol: TCP
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-dtzmm
      readOnly: true
  - env:
    - name: HTTP_PORT
      value: "8080"
    - name: HTTPS_PORT
      value: "8443"
........................................
```
проверим доступность сервиса из вспомогательного мультитула:

```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl exec deployment/deployment-for-update -- curl service-for-update:9002
Defaulted container "nginx" out of: nginx, network-multitool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   159  100   159    0     0  14454      0 --:--:-- --:--:-- --:--:-- 14454
WBITT Network MultiTool (with NGINX) - deployment-for-update-699d4b4856-mkt7p - 10.233.125.67 - HTTP: 8080 , HTTPS: 8443 . (Formerly praqma/network-multitool)
```
изменим версию nginx на доступную 1.20 и перезапустим деплоймент, после чего еще раз проверим кластер и доступность сервиса:

```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl apply -f deployment.yaml 
deployment.apps/deployment-for-update configured
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl get pod
NAME                                     READY   STATUS              RESTARTS   AGE
deployment-for-update-5c599c88b4-5s8bc   0/2     ContainerCreating   0          7s
deployment-for-update-5c599c88b4-666k9   0/2     ContainerCreating   0          18s
deployment-for-update-5c599c88b4-mh45b   2/2     Running             0          18s
deployment-for-update-699d4b4856-hjqzd   2/2     Terminating         0          11m
deployment-for-update-699d4b4856-mkt7p   2/2     Running             0          11m
deployment-for-update-699d4b4856-mt75q   2/2     Running             0          11m
deployment-for-update-699d4b4856-xs55p   2/2     Running             0          11m
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl exec deployment/deployment-for-update -- curl service-for-update:9002
Defaulted container "nginx" out of: nginx, network-multitool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0WBITT Network MultiTool (with NGINX) - deployment-for-update-5c599c88b4-qsbrd - 10.233.125.69 - HTTP: 8080 , HTTPS: 8443 . (Formerly praqma/network-multitool)
100   159  100   159    0     0  26500      0 --:--:-- --:--:-- --:--:-- 26500
```
попробуем обновиться до несуществующей версии nginx 1.28:

```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl apply -f deployment.yaml 
deployment.apps/deployment-for-update configured
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl get pod
NAME                                     READY   STATUS             RESTARTS   AGE
deployment-for-update-57ff6b8bcb-556gj   1/2     ImagePullBackOff   0          6s
deployment-for-update-57ff6b8bcb-dfncb   1/2     ImagePullBackOff   0          6s
deployment-for-update-5c599c88b4-666k9   2/2     Running            0          2m25s
deployment-for-update-5c599c88b4-78gxx   2/2     Running            0          2m2s
deployment-for-update-5c599c88b4-mh45b   2/2     Running            0          2m25s
deployment-for-update-5c599c88b4-qsbrd   2/2     Running            0          112s
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl exec deployment/deployment-for-update -- curl service-for-update:9002
Defaulted container "nginx" out of: nginx, network-multitool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   160  100   160    0     0  32000      0 --:--:-- --:--:-- --:--:-- 32000
WBITT Network MultiTool (with NGINX) - deployment-for-update-5c599c88b4-666k9 - 10.233.105.195 - HTTP: 8080 , HTTPS: 8443 . (Formerly praqma/network-multitool)
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ 
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl get pod
NAME                                     READY   STATUS         RESTARTS   AGE
deployment-for-update-57ff6b8bcb-556gj   1/2     ErrImagePull   0          63s
deployment-for-update-57ff6b8bcb-dfncb   1/2     ErrImagePull   0          63s
deployment-for-update-5c599c88b4-666k9   2/2     Running        0          3m22s
deployment-for-update-5c599c88b4-78gxx   2/2     Running        0          2m59s
deployment-for-update-5c599c88b4-mh45b   2/2     Running        0          3m22s
deployment-for-update-5c599c88b4-qsbrd   2/2     Running        0          2m49s
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl exec deployment/deployment-for-update -- curl service-for-update:9002
Defaulted container "nginx" out of: nginx, network-multitool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   159  100   159    0     0  53000      0 --:--:-- --:--:-- --:--:-- 53000
WBITT Network MultiTool (with NGINX) - deployment-for-update-5c599c88b4-mh45b - 10.233.72.197 - HTTP: 8080 , HTTPS: 8443 . (Formerly praqma/network-multitool)
```
Мы видим ошибки при обновлении, и что приложение все равно доступно на подах с корректной неизмененной версией nginx. Подробности можно посмотреть в каком-нибудь из некорректных подов, так как kubernetes сохраняет данные об ошибках неразврнутого пода:

```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl get pod deployment-for-update-57ff6b8bcb-556gj  -o yaml
............................................
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2023-06-06T12:58:33Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-06-06T12:58:33Z"
    message: 'containers with unready status: [nginx]'
    reason: ContainersNotReady
    status: "False"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-06-06T12:58:33Z"
    message: 'containers with unready status: [nginx]'
    reason: ContainersNotReady
    status: "False"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-06-06T12:58:33Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://9ab28d6f81b9aec9d5082dde3cced43a1a17f3eef06ccafdd9f9b06b042d89d9
    image: docker.io/wbitt/network-multitool:latest
    imageID: docker.io/wbitt/network-multitool@sha256:82a5ea955024390d6b438ce22ccc75c98b481bf00e57c13e9a9cc1458eb92652
    lastState: {}
    name: network-multitool
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-06-06T12:58:37Z"
  - image: nginx:1.28
    imageID: ""
    lastState: {}
    name: nginx
    ready: false
    restartCount: 0
    started: false
    state:
      waiting:
        message: Back-off pulling image "nginx:1.28"
        reason: ImagePullBackOff
  hostIP: 10.128.0.16
  phase: Pending
  podIP: 10.233.72.198
  podIPs:
  - ip: 10.233.72.198
  qosClass: Burstable
  startTime: "2023-06-06T12:58:33Z"
```
после чего откатим последнее неудачное обновление и проверим, что все поды восстановились:
```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl rollout undo deployment deployment-for-update
deployment.apps/deployment-for-update rolled back
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.4$ kubectl get pod
NAME                                     READY   STATUS    RESTARTS   AGE
deployment-for-update-5c599c88b4-2nqf8   2/2     Running   0          24s
deployment-for-update-5c599c88b4-666k9   2/2     Running   0          9m41s
deployment-for-update-5c599c88b4-78gxx   2/2     Running   0          9m18s
deployment-for-update-5c599c88b4-mh45b   2/2     Running   0          9m41s
deployment-for-update-5c599c88b4-qsbrd   2/2     Running   0          9m8s

```