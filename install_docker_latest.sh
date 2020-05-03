#!/bin/bash
set -e
#sudo yum install -y epel-release 
#sudo yum install -y net-tools python-setuptools python-devel libffi-devel openssl-devel #libssl-dev 
#sudo yum groupinstall "Development Tools" -y
#
echo Installing Docker CE Version latest........

sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo usermod -a -G docker vagrant

sed -i 's/^%wheel\tALL=(ALL)\tALL/%wheel\tALL=(ALL)\tNOPASSWD: ALL/g' /etc/sudoers 

sudo systemctl enable docker
sudo systemctl start docker

echo "User docker stack deploy instead of docker compose"

docker --version

