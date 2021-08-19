#!/bin/sh

if [ "$(cat /home/ec2-user/mikl/stop.txt)" = stop ]; then
  docker-compose -f /home/ec2-user/mikl/docker-compose.yaml down --remove-orphans
fi

sudo yum update -y

rm -rf .github .dockerignore .dropboxignore .eslintignore .eslintrc.cjs .gitignore .prettierignore .prettierrc .stylelintignore .stylelint.rc.json package-lock.json package.json

docker-compose -f /home/ec2-user/mikl/docker-compose.yaml pull && \
docker-compose -f /home/ec2-user/mikl/docker-compose.yaml up -d
