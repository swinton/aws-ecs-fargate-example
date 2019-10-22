#!/bin/bash
set -e

cd $( dirname $0 )/..

source .envrc

aws ecs create-service --cluster $CLUSTER \
  --service-name nginx \
  --launch-type FARGATE \
  --task-definition $( jq -r '.family' task-definition.json ) \
  --desired-count 1 \
  --network-configuration "awsvpcConfiguration={subnets=[$SUBNET_ID],securityGroups=[$SECURITY_GROUP_ID],assignPublicIp=ENABLED}"

aws ecs wait services-stable --services nginx --cluster $CLUSTER
