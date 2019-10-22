#!/bin/bash
set -e

cd $( dirname $0 )/..

source .envrc

TASK_ARN=$( aws ecs list-tasks --cluster $CLUSTER | jq -r '.taskArns[0]' )

# Get the network interface id
NETWORK_INTERFACE_ID=$( aws ecs describe-tasks --cluster $CLUSTER --tasks $TASK_ARN \
  | jq -r '.tasks[0].attachments[0].details[] | select(.name == "networkInterfaceId") | .value' )

# Get the public IP etc
PUBLIC_DNS_NAME=$( aws ec2 describe-network-interfaces --network-interface-ids $NETWORK_INTERFACE_ID \
  | jq -r '.NetworkInterfaces[0].Association | .PublicDnsName, .PublicIp' )

echo "$PUBLIC_DNS_NAME"
