terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

#  state все равно хранится локально и в облако не попадает до тех пор, пока не сделать terraform apply
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "yam-test"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = ""
    secret_key = ""

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = "${var.YC_TOKEN}"
  cloud_id  = "${var.YC_CLOUD_ID}"
  folder_id = "${var.YC_FOLDER_ID}"
  zone      = "ru-central1-a"
}