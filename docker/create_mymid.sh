#!/bin/sh

echo "clear image"
docker stop mymid
docker rm mymid
docker rmi mymid:latest

echo "create image"

docker build -t mymid:latest -f Dockerfile .

echo "run image"