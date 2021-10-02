#!/bin/sh

INSTANCE_ALREADY_STARTED="INSTANCE_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $INSTANCE_ALREADY_STARTED ]; then
touch $INSTANCE_ALREADY_STARTED
  echo "-- First instance startup --"
  sudo yum update -y
  sudo amazon-linux-extras install docker
  sudo service docker start
  sudo usermod -a -G docker ec2-user
  sudo chkconfig docker on
  sudo yum install -y git
  sudo mkdir -p ~/.docker/cli-plugins/
  sudo curl -SL https://github.com/docker/compose/releases/download/v2.0.0/docker-compose-linux-amd64 -o ~/.docker/cli-plugins/docker-compose && \
  sudo chmod +x ~/.docker/cli-plugins/docker-compose && \
  # sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml pull && \
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml up -d
else
  echo "-- Not first instance startup --"
  sudo yum update -y
  if [ "$(cat /home/ec2-user/vscloud/stop.txt)" = stop ]; then
    docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml down --remove-orphans
  fi
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml pull && \
  docker compose -f /home/ec2-user/mikl.io/docker-compose.yaml up -d
fi
