#!/bin/bash
set -e

cd $( dirname $0 )/..

source .envrc

aws ecs update-service --cluster $CLUSTER --service $SERVICE --desired-count 0
aws ecs delete-service --cluster $CLUSTER --service $SERVICE
aws ecs wait services-inactive --cluster $CLUSTER --services $SERVICE
aws ecs delete-cluster --cluster $CLUSTER
