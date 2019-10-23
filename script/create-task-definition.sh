#!/bin/bash
set -e

cd $( dirname $0 )/..

source .envrc

aws ecs register-task-definition --cli-input-json file://task-definition.json
# aws ecs describe-task-definition --task-definition $( jq -r '.family' task-definition.json )
