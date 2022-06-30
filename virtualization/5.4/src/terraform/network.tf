# Network
resource "yandex_vpc_network" "net" {
  name = "net"
}

resource "yandex_vpc_subnet" "netology-devops-subnet-1" {
  name = "subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.net.id}"
  v4_cidr_blocks = ["10.1.2.0/24"]
}
