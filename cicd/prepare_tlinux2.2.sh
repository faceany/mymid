#!/bin/sh

workdir=/data

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
  rm -rf /etc/docker/daemon.json
  cp ${workdir}/mymid/cicd/daemon.json /etc/docker/

  echo "start docker"
  systemctl daemon-reload
  systemctl start docker
  systemctl enable docker
fi


# ubuntu 20.04 SUSE 15 redhat 7.9 centos 7.9 kylin v10sp1 kylinarm v10sp1
docker pull docker.mirrors.ustc.edu.cn/library/centos:centos7
docker pull docker.mirrors.ustc.edu.cn/library/ubuntu:20.04
docker pull opensuse/leap:15
docker pull roboxes/rhel7:3.6.4
docker pull opstool/kylin:v10sp1-aarch64
docker pull opstool/kylin:v10sp1-x86_64


