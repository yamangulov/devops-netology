#!/bin/bash

set -e

function install_vm {
  local NAME=$1

  YC=$(
    cat <<END
    yc compute instance create \
      --name $NAME \
      --hostname $NAME \
      --zone ru-central1-a \
      --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
      --memory 2 \
      --cores 2 \
      --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts,type=network-ssd,size=20 \
      --ssh-key ~/.ssh/id_rsa.pub
END
  )
  eval "$YC"
}

install_vm "master"
install_vm "worker-1"
install_vm "worker-2"
install_vm "worker-3"
install_vm "worker-4"
