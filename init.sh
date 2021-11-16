#!/bin/sh

INSTANCE_ALREADY_STARTED="INSTANCE_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e /home/ec2-user/$INSTANCE_ALREADY_STARTED ]; then
touch /home/ec2-user/$INSTANCE_ALREADY_STARTED
  echo "-- First instance startup --"
  yum update -y
  yum install -y git
  yum install -y wget
  mkdir -p /home/ec2-user/.docker/cli-plugins/
  wget -O /home/ec2-user/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-linux-x86_64
  chmod +x /home/ec2-user/.docker/cli-plugins/docker-compose
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  amazon-linux-extras install docker
  sudo groupadd docker
  sudo usermod -aG docker ec2-user
  sudo su -s ec2-user
  sudo systemctl start docker
  sudo systemctl status docker
  sudo systemctl enable docker
  sudo chkconfig docker on
  docker version
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml pull
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml up -d
else
  echo "-- Not first instance startup --"
  yum update -y
  if [ "$(cat /home/ec2-user/mikl.io/stop.txt)" = stop ]; then
    docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml down --remove-orphans
  fi
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml pull
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml up -d
fi
