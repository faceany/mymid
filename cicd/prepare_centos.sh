#!/bin/sh

echo "docker install"
yum install docker-ce -y

echo "create docker network"
sudo brctl addbr docker0
sudo ip addr add 192.168.10.1/24 dev docker0
sudo ip link set dev docker0 up
ip addr show docker0

echo "start docker"

systemctl daemon-reload
systemctl start docker
systemctl enable docker

echo "change docker storage location"
cp ./daemon.json /etc/docker/
# ubuntu SUSE redhat centos
docker pull centos:centos7


