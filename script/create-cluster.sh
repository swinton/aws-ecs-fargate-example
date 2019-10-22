#!/bin/bash
set -e

cd $( dirname $0 )/..

source .envrc

aws ecs create-cluster --cluster-name $CLUSTER
