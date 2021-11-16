#!/bin/sh

INSTANCE_ALREADY_STARTED="INSTANCE_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e /home/ec2-user/$INSTANCE_ALREADY_STARTED ]; then
touch /home/ec2-user/$INSTANCE_ALREADY_STARTED
  echo "-- First instance startup --"
  sudo yum update -y
  sudo yum install -y git
  sudo yum install -y wget
  mkdir -p /home/ec2-user/.docker/cli-plugins/
  wget -O /home/ec2-user/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-linux-x86_64
  sudo chmod +x /home/ec2-user/.docker/cli-plugins/docker-compose
  sudo ln -s /home/ec2-user/.docker/cli-plugins/docker-compose /usr/bin/docker-compose
  sudo amazon-linux-extras install docker
  sudo usermod -a -G docker $USER
  # sudo chmod 666 /var/run/docker.sock
  sudo su $USER
  sudo systemctl enable --now docker
  sudo chkconfig docker on
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml pull
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml up -d
else
  echo "-- Not first instance startup --"
  sudo yum update -y
  if [ "$(cat /home/ec2-user/mikl.io/stop.txt)" = stop ]; then
    docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml down --remove-orphans
  fi
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml pull
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml up -d
fi
