#!/bin/sh

if [ "$(cat /home/ec2-user/mikl/stop.txt)" = stop ]; then
  docker-compose -f /home/ec2-user/mikl/docker-compose.yaml down --remove-orphans
fi

sudo yum update -y

sudo rm -rf /home/ec2-user/mikl/.github /home/ec2-user/mikl/.dockerignore /home/ec2-user/mikl/.dropboxignore /home/ec2-user/mikl/.eslintignore /home/ec2-user/mikl/.eslintrc.cjs /home/ec2-user/mikl/.gitignore /home/ec2-user/mikl/.prettierignore /home/ec2-user/mikl/.prettierrc /home/ec2-user/mikl/.stylelintignore /home/ec2-user/mikl/.stylelintrc.json /home/ec2-user/mikl/package-lock.json /home/ec2-user/mikl/package.json

docker-compose -f /home/ec2-user/mikl/docker-compose.yaml pull && \
docker-compose -f /home/ec2-user/mikl/docker-compose.yaml up -d
