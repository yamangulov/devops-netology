1) если vagrant ругается, что ему не хватает времени на запуск (чаще, когда у вас что-то еще ресурсоемкое крутится но хосте), добавляем в Vagrantfile параметр:

`config.vm.boot_timeout=600 `(или больше)

2) Если у вас появляется ошибка, аналогичная следующей:
```
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["hostonlyif", "ipconfig", "vboxnet4", "--ip", "192.168.192.1", "--netmask", "255.255.255.0"]

Stderr: VBoxManage: error: Code E_ACCESSDENIED (0x80070005) - Access denied (extended info not available)
VBoxManage: error: Context: "EnableStaticIPConfig(Bstr(pszIp).raw(), Bstr(pszNetmask).raw())" at line 242 of file VBoxManageHostonly.cpp

```
измените диапазон вашей сети в Vagrantfile, см. https://stackoverflow.com/questions/69728426/e-accessdenied-when-creating-a-host-only-interface-on-virtualbox-via-vagrant

3) если у вас нет возможности подключить зеркало vagrant (потому что vagrant напрямую больше недоступен в РФ), то можно выкачать образ с сайта vagrant по прямой ссылке из браузера (с vpn или без), и затем создать box из этого образа вручную. Vagrantfile успешно подхватит ваш образ при создании box по имени. Например:
`vagrant box add bentoo/ubuntu-20.04 /media/stranger/repo/vagrant/bentoo_ubuntu_20.04`