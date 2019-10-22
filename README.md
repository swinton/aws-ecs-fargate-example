# `aws-ecs-fargate-example`

## Setup

Create `.envrc` file following the example format in [`.envrc.example`](.envrc.example).

## Usage

```shell
# Create cluster
./script/create-cluster.sh

# Create task definition
./script/create-task-definition.sh

# Create service
./script/create-service.sh

# List the Public IP address
./script/list-public-ip.sh

# Teardown the cluster
./script/teardown.sh
```
