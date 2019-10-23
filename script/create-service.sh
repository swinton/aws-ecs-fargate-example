#!/bin/bash
set -e

cd $( dirname $0 )/..

source .envrc

aws ecs create-service --cluster $CLUSTER \
  --service-name $SERVICE \
  --launch-type FARGATE \
  --task-definition $( jq -r '.family' task-definition.json ) \
  --desired-count 1 \
  --network-configuration "awsvpcConfiguration={subnets=[$SUBNET_ID],securityGroups=[$SECURITY_GROUP_ID],assignPublicIp=ENABLED}"

# Wait for services to stabilize
aws ecs wait services-stable --cluster $CLUSTER --services $SERVICE

# Get the Task Arn
FAMILY=$( jq -r '.family' task-definition.json )
TASK_ARN=$( aws ecs list-tasks --cluster $CLUSTER --family $FAMILY | jq -r '.taskArns[0]')

# Wait for task to come up
aws ecs wait tasks-running --cluster $CLUSTER --tasks $TASK_ARN
