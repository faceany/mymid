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

  echo "change docker storage location"
  cp ./daemon.json /etc/docker/

  echo "start docker"
  systemctl daemon-reload
  systemctl start docker
  systemctl enable docker
fi

echo "check git"
if ! type git >/dev/null 2>&1; then
   yum install git -y
fi

# ubuntu SUSE redhat centos
#docker pull centos:centos7


