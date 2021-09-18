#!/bin/sh

if [ "$(cat /home/ec2-user/mikl/stop.txt)" = stop ]; then
  docker-compose -f /home/ec2-user/mikl/docker-compose.yaml down --remove-orphans
fi

sudo yum update -y

sudo rm -rf /home/ec2-user/mikl/.github /home/ec2-user/mikl/.dockerignore /home/ec2-user/mikl/package.json

docker-compose -f /home/ec2-user/mikl/docker-compose.yaml pull && \
docker-compose -f /home/ec2-user/mikl/docker-compose.yaml up -d
