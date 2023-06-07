Удаляем все старые приложения от предыдущих заданий и развертываем приложение:
```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml 
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "web" not found
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "data" not found
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "data" not found
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl create namespace web
namespace/web created
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl create namespace data
namespace/data created
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml 
deployment.apps/web-consumer created
deployment.apps/auth-db created
service/auth-db created
```
посмотрим, что у нас установилось
```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS    RESTARTS      AGE
data          auth-db-795c96cddc-94gww                  1/1     Running   0             3m5s
kube-system   calico-kube-controllers-6dfcdfb99-k4svm   1/1     Running   7 (46h ago)   3d22h
kube-system   calico-node-p5xcv                         1/1     Running   1 (47h ago)   3d22h
kube-system   calico-node-qdk4d                         1/1     Running   1 (47h ago)   3d22h
kube-system   calico-node-rj66x                         1/1     Running   1 (47h ago)   3d22h
kube-system   calico-node-swphl                         1/1     Running   1 (47h ago)   3d22h
kube-system   calico-node-wmztn                         1/1     Running   3 (46h ago)   3d22h
kube-system   coredns-645b46f4b6-4lxgf                  1/1     Running   4 (46h ago)   3d22h
kube-system   coredns-645b46f4b6-jl8t8                  1/1     Running   1 (47h ago)   3d22h
kube-system   dns-autoscaler-659b8c48cb-4kt6h           1/1     Running   4 (46h ago)   3d22h
kube-system   kube-apiserver-master                     1/1     Running   5 (46h ago)   3d22h
kube-system   kube-controller-manager-master            1/1     Running   6 (46h ago)   3d22h
kube-system   kube-proxy-7rssp                          1/1     Running   0             45h
kube-system   kube-proxy-f5xht                          1/1     Running   0             45h
kube-system   kube-proxy-fm48x                          1/1     Running   0             45h
kube-system   kube-proxy-h752v                          1/1     Running   0             45h
kube-system   kube-proxy-wpwck                          1/1     Running   0             45h
kube-system   kube-scheduler-master                     1/1     Running   6 (46h ago)   3d22h
kube-system   nginx-proxy-worker-1                      1/1     Running   1 (47h ago)   3d22h
kube-system   nginx-proxy-worker-2                      1/1     Running   1 (47h ago)   3d22h
kube-system   nginx-proxy-worker-3                      1/1     Running   1 (47h ago)   3d22h
kube-system   nginx-proxy-worker-4                      1/1     Running   1 (47h ago)   3d22h
kube-system   nodelocaldns-2pc9w                        1/1     Running   1 (47h ago)   3d22h
kube-system   nodelocaldns-blsbj                        1/1     Running   1 (47h ago)   3d22h
kube-system   nodelocaldns-hqkvp                        1/1     Running   1 (47h ago)   3d22h
kube-system   nodelocaldns-qdnfp                        1/1     Running   5 (46h ago)   3d22h
kube-system   nodelocaldns-wn845                        1/1     Running   1 (47h ago)   3d22h
web           web-consumer-577d47b97d-c6tqz             1/1     Running   0             3m5s
web           web-consumer-577d47b97d-gq4ls             1/1     Running   0             3m5s

(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl -n web get pod  web-consumer-577d47b97d-gq4ls -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cni.projectcalico.org/containerID: 38754df16e6a2d31a25b44c4be7ccb246234f4eff586edd15368fa26c3146b92
    cni.projectcalico.org/podIP: 10.233.125.71/32
    cni.projectcalico.org/podIPs: 10.233.125.71/32
  creationTimestamp: "2023-06-07T09:27:50Z"
  generateName: web-consumer-577d47b97d-
  labels:
    app: web-consumer
    pod-template-hash: 577d47b97d
  name: web-consumer-577d47b97d-gq4ls
  namespace: web
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: web-consumer-577d47b97d
    uid: 53a7cd8a-120d-4a1a-8de0-10c8b118cd06
  resourceVersion: "379827"
  uid: ce000267-415e-4fe1-b3d7-0227aaef8cf4
spec:
  containers:
  - command:
    - sh
    - -c
    - while true; do curl auth-db; sleep 5; done
    image: radial/busyboxplus:curl
    imagePullPolicy: IfNotPresent
    name: busybox
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-d9ttd
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: worker-3
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-d9ttd
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2023-06-07T09:27:50Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-06-07T09:27:54Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-06-07T09:27:54Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-06-07T09:27:50Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://baee64fddb4d47aed8d17a6b89bf3e4d325307b714353c5666443a203cc8d8bd
    image: docker.io/radial/busyboxplus:curl
    imageID: sha256:4776f1f7d1f625c8c5173a969fdc9ae6b62655a2746aba989784bb2b7edbfe9b
    lastState: {}
    name: busybox
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-06-07T09:27:54Z"
  hostIP: 10.128.0.36
  phase: Running
  podIP: 10.233.125.71
  podIPs:
  - ip: 10.233.125.71
  qosClass: BestEffort
  startTime: "2023-06-07T09:27:50Z"

(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl -n data get pod auth-db-795c96cddc-94gww -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cni.projectcalico.org/containerID: b5f6276bc991d76beb7b694f48de78ab116f44eb0af6b33ba77df42b1643babb
    cni.projectcalico.org/podIP: 10.233.72.199/32
    cni.projectcalico.org/podIPs: 10.233.72.199/32
  creationTimestamp: "2023-06-07T09:27:50Z"
  generateName: auth-db-795c96cddc-
  labels:
    app: auth-db
    pod-template-hash: 795c96cddc
  name: auth-db-795c96cddc-94gww
  namespace: data
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: auth-db-795c96cddc
    uid: 80c9ca17-e8da-473c-aa7e-b1a930957922
  resourceVersion: "379861"
  uid: 2dfbdf36-31a6-4620-8f1d-ae854649e1dc
spec:
  containers:
  - image: nginx:1.19.1
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
      name: kube-api-access-bqpdq
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: worker-2
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-bqpdq
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2023-06-07T09:27:50Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-06-07T09:28:05Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-06-07T09:28:05Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-06-07T09:27:50Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://ab544bcf4f75e7fe1be36f9175738db03d5adbf788760d057d92c5268f8415eb
    image: docker.io/library/nginx:1.19.1
    imageID: docker.io/library/nginx@sha256:36b74457bccb56fbf8b05f79c85569501b721d4db813b684391d63e02287c0b2
    lastState: {}
    name: nginx
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-06-07T09:28:05Z"
  hostIP: 10.128.0.16
  phase: Running
  podIP: 10.233.72.199
  podIPs:
  - ip: 10.233.72.199
  qosClass: BestEffort
  startTime: "2023-06-07T09:27:50Z"

```
посмотрим, как выглядит ошибка при подключении:
```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl -n web exec web-consumer-577d47b97d-gq4ls -- curl auth-db
curl: (6) Couldn't resolve host 'auth-db'
command terminated with exit code 6
```
найдем ip соответствующего сервиса и повторим проверку доступности не по имени auth-db, а по ip:

```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl get all -n data
NAME                           READY   STATUS    RESTARTS   AGE
pod/auth-db-795c96cddc-94gww   1/1     Running   0          15m

NAME              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/auth-db   ClusterIP   10.233.62.171   <none>        80/TCP    15m

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/auth-db   1/1     1            1           15m

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/auth-db-795c96cddc   1         1         1       15m
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl -n web exec web-consumer-577d47b97d-gq4ls -- curl 10.233.62.171 
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
100   612  100   612    0     0   142k      0 --:--:-- --:--:-- --:--:--  199k
```
следовательно, сервис на самом деле работает и доступ в кластере, но есть проблема с разрешением имен. Смысл проблемы очевиден сразу же - сервис расположен в другом пространстве имен, поэтому можно либо указать его при подключении, либо поправить деплойменты, чтобы все поды были в одном пространстве имен. Но возможно, это было сделано для чего-то специально, поэтому может оказаться более целесообразным просто использовать полное имя сервиса auth-db.data везде, где это нужно. Например, протестируем доступность с указанием полного имени:
```shell
(venv) stranger@nairsharifDellG3:/media/stranger/repo/devops-netology/kuber-cloud/14.5$ kubectl -n web exec web-consumer-577d47b97d-gq4ls -- curl auth-db.data
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0   9941      0 --:--:-- --:--:-- --:--:--  298k
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
Все ок, проблема решается. Перенос в один и тот же общий namespace осуществляется элементарной заменой тега namespace в манифестах.