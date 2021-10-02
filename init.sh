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
  sudo curl -L "https://github.com/docker/compose/releases/download/2.0.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  echo $(docker-compose version)
  sudo reboot
else
  echo "-- Not first instance startup --"
  sudo yum update -y
  if [ "$(cat /home/ec2-user/vscloud/stop.txt)" = stop ]; then
    docker-compose -f /home/ec2-user/mikl.io/docker-compose.yaml down --remove-orphans
  fi
  docker-compose -f /home/ec2-user/mikl.io/docker-compose.yaml pull && \
  docker-compose -f /home/ec2-user/mikl.io/docker-compose.yaml up -d
fi
