#!/bin/sh

if [ "$(cat /home/ec2-user/mikl/stop.txt)" = stop ]; then
  docker-compose -f /home/ec2-user/mikl/docker-compose.yaml down --remove-orphans
fi

sudo yum update -y

mv /home/ec2-user/mikl/docker-compose.yaml /home/ec2-user
mv /home/ec2-user/mikl/LICENSE /home/ec2-user
mv /home/ec2-user/mikl/README.md /home/ec2-user
mv /home/ec2-user/mikl/init.sh /home/ec2-user
mv /home/ec2-user/mikl/stop.sh /home/ec2-user
mv /home/ec2-user/mikl/stop.txt /home/ec2-user
mv /home/ec2-user/mikl/appspec.yaml /home/ec2-user
rm -R /home/ec2-user/mikl/*
mv /home/ec2-user/docker-compose.yaml /home/ec2-user/mikl
mv /home/ec2-user/LICENSE /home/ec2-user/mikl
mv /home/ec2-user/README.md /home/ec2-user/mikl
mv /home/ec2-user/init.sh /home/ec2-user/mikl
mv /home/ec2-user/stop.sh /home/ec2-user/mikl
mv /home/ec2-user/stop.txt /home/ec2-user/mikl
mv /home/ec2-user/appspec.yaml /home/ec2-user/mikl

docker-compose -f /home/ec2-user/mikl/docker-compose.yaml pull && \
docker-compose -f /home/ec2-user/mikl/docker-compose.yaml up -d
