#!/bin/sh

echo "check docker"
if ! type docker >/dev/null 2>&1; then
  echo "docker need install"
  yum install docker-ce -y

  echo "create docker network"
  sudo brctl addbr docker0
  sudo ip addr add 192.168.10.1/24 dev docker0
  sudo ip link set dev docker0 up
  ip addr show docker0

  echo "start docker"

  echo "change docker storage location"
  cp ./daemon.json /etc/docker/

  systemctl daemon-reload
  systemctl start docker
  systemctl enable docker
fi


# ubuntu SUSE redhat centos
docker pull centos:centos7


