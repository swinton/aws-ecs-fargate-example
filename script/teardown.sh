#!/bin/bash
set -e

cd $( dirname $0 )/..

source .envrc

aws ecs update-service --cluster $CLUSTER --service nginx --desired-count 0
aws ecs delete-service --cluster $CLUSTER --service nginx
aws ecs wait services-stable --cluster $CLUSTER --services nginx
aws ecs delete-cluster --cluster $CLUSTER
