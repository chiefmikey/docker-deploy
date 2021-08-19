#!/bin/sh

if [ "$(cat /home/ec2-user/mikl/stop.txt)" = stop ]; then
  docker-compose -f /home/ec2-user/mikl/docker-compose.yaml down --remove-orphans
fi

docker-compose pull && docker-compose -f /home/ec2-user/mikl/docker-compose.yaml up -d
