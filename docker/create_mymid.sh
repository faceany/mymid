#!/bin/sh

echo "check docker"
if ! command -v docker >/dev/null 2>&1; then
    echo "docker not exists,please install"
    echo "For TLinxu : yum install docker-ce"
    exit 100
fi

echo "clear image"
docker stop mymid
docker rm mymid
docker rmi mymid:latest

echo "create image"

docker build -t mymid:latest -f Dockerfile .

echo "run image"