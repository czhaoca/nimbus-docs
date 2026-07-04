---
title: "nimbus aws"
sidebar:
  order: 1
---

Manage AWS resources (aws-mirrored grammar).

Native CLI equivalent: [https://docs.aws.amazon.com/cli/latest/reference/](https://docs.aws.amazon.com/cli/latest/reference/)

## Commands

### context clear

Clear the active AWS provider context.

Usage: `nimbus aws context clear [OPTIONS]`

_No options._

### context set

Set the active AWS provider context.

Usage: `nimbus aws context set [OPTIONS] PROVIDER_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `provider_id` | text | yes | - | AWS provider ID to activate |

### context show

Show the current active AWS provider context.

Usage: `nimbus aws context show [OPTIONS]`

_No options._

### cost current

Show AWS spending for the current or requested billing period.

Usage: `nimbus aws cost current [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | AWS provider ID |
| `--period` | text | no | - | Billing period in YYYY-MM format |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ec2 attach-internet-gateway

Attach an internet gateway to a VPC (mirrors `aws ec2 attach-internet-gateway`).

Usage: `nimbus aws ec2 attach-internet-gateway [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--internet-gateway-id` | text | yes | - | Internet gateway ID |
| `--vpc-id` | text | yes | - | VPC ID |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 attach-volume

Attach a volume to an instance (mirrors `aws ec2 attach-volume`).

Usage: `nimbus aws ec2 attach-volume [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--volume-id` | text | yes | - | EBS volume ID |
| `--instance-id` | text | yes | - | EC2 instance ID |
| `--device` | text | yes | - | Device name (e.g. /dev/sdf) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 authorize-security-group-ingress

Add an ingress rule (mirrors `aws ec2 authorize-security-group-ingress`).

Usage: `nimbus aws ec2 authorize-security-group-ingress [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--group-id` | text | yes | - | Security group ID |
| `--protocol` | text | yes | - | IP protocol (tcp/udp/icmp) |
| `--port` | integer | yes | - | Port (single port for both ends) |
| `--cidr` | text | yes | - | IPv4 CIDR range |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 create-internet-gateway

Create an internet gateway (mirrors `aws ec2 create-internet-gateway`).

Usage: `nimbus aws ec2 create-internet-gateway [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tag-specifications` | text | no | - | TagSpecifications JSON list (native PascalCase keys) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 create-security-group

Create a security group (mirrors `aws ec2 create-security-group`).

Usage: `nimbus aws ec2 create-security-group [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--group-name` | text | yes | - | Security group name |
| `--description` | text | yes | - | Security group description |
| `--vpc-id` | text | no | - | VPC ID |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 create-subnet

Create a subnet (mirrors `aws ec2 create-subnet`).

Usage: `nimbus aws ec2 create-subnet [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--vpc-id` | text | yes | - | VPC ID |
| `--cidr-block` | text | yes | - | IPv4 CIDR block for the subnet |
| `--availability-zone` | text | no | - | Availability Zone |
| `--register`, `--no-register` | boolean | no | `True` | Register the created CIDR in the network-allocations registry (nimbus extension) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 create-volume

Create an EBS volume (mirrors `aws ec2 create-volume`).

Usage: `nimbus aws ec2 create-volume [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--availability-zone` | text | yes | - | Availability Zone |
| `--size` | integer | yes | - | Volume size in GiB |
| `--volume-type` | text | no | `gp3` | Volume type (free-tier-eligible default) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 create-vpc

Create a VPC (mirrors `aws ec2 create-vpc`).

Usage: `nimbus aws ec2 create-vpc [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cidr-block` | text | yes | - | IPv4 CIDR block for the VPC |
| `--tag-specifications` | text | no | - | TagSpecifications JSON list (native PascalCase keys) |
| `--register`, `--no-register` | boolean | no | `True` | Register the created CIDR in the network-allocations registry (nimbus extension) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 delete-internet-gateway

Delete an internet gateway (mirrors `aws ec2 delete-internet-gateway`).

Usage: `nimbus aws ec2 delete-internet-gateway [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--internet-gateway-id` | text | yes | - | Internet gateway ID |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 delete-security-group

Delete a security group (mirrors `aws ec2 delete-security-group`).

Usage: `nimbus aws ec2 delete-security-group [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--group-id` | text | yes | - | Security group ID |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 delete-subnet

Delete a subnet (mirrors `aws ec2 delete-subnet`).

Usage: `nimbus aws ec2 delete-subnet [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--subnet-id` | text | yes | - | Subnet ID |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 delete-volume

Delete a volume (mirrors `aws ec2 delete-volume`).

Usage: `nimbus aws ec2 delete-volume [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--volume-id` | text | yes | - | EBS volume ID |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 delete-vpc

Delete a VPC (mirrors `aws ec2 delete-vpc`).

Usage: `nimbus aws ec2 delete-vpc [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--vpc-id` | text | yes | - | VPC ID |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 describe-images

List AMIs (mirrors `aws ec2 describe-images`).

Usage: `nimbus aws ec2 describe-images [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--owners` | text | no | - | Image owner (repeatable: self, amazon, account ID) |
| `--filters` | text | no | - | Filters JSON list (native keys) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ec2 describe-instances

List instances (mirrors `aws ec2 describe-instances`).

Usage: `nimbus aws ec2 describe-instances [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance-ids` | text | no | - | EC2 instance ID (repeatable, DEC-A) |
| `--filters` | text | no | - | Filters JSON list (native keys) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ec2 describe-internet-gateways

List internet gateways (mirrors `aws ec2 describe-internet-gateways`).

Usage: `nimbus aws ec2 describe-internet-gateways [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--filters` | text | no | - | Filters JSON list (native keys) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ec2 describe-security-groups

List security groups (mirrors `aws ec2 describe-security-groups`).

Usage: `nimbus aws ec2 describe-security-groups [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--group-ids` | text | no | - | Security group ID (repeatable) |
| `--filters` | text | no | - | Filters JSON list (native keys) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ec2 describe-subnets

List subnets (mirrors `aws ec2 describe-subnets`).

Usage: `nimbus aws ec2 describe-subnets [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--filters` | text | no | - | Filters JSON list (native keys) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ec2 describe-volumes

List EBS volumes (mirrors `aws ec2 describe-volumes`).

Usage: `nimbus aws ec2 describe-volumes [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--volume-ids` | text | no | - | EBS volume ID (repeatable) |
| `--filters` | text | no | - | Filters JSON list (native keys) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ec2 describe-vpcs

List VPCs (mirrors `aws ec2 describe-vpcs`).

Usage: `nimbus aws ec2 describe-vpcs [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--filters` | text | no | - | Filters JSON list (native keys) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ec2 detach-internet-gateway

Detach an internet gateway from a VPC (mirrors `aws ec2 detach-internet-gateway`).

Usage: `nimbus aws ec2 detach-internet-gateway [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--internet-gateway-id` | text | yes | - | Internet gateway ID |
| `--vpc-id` | text | yes | - | VPC ID |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 detach-volume

Detach a volume (mirrors `aws ec2 detach-volume`).

Usage: `nimbus aws ec2 detach-volume [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--volume-id` | text | yes | - | EBS volume ID |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 reboot-instances

Reboot instances (mirrors `aws ec2 reboot-instances`).

Usage: `nimbus aws ec2 reboot-instances [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance-ids` | text | yes | - | EC2 instance ID (repeatable, DEC-A) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 revoke-security-group-ingress

Remove an ingress rule (mirrors `aws ec2 revoke-security-group-ingress`).

Usage: `nimbus aws ec2 revoke-security-group-ingress [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--group-id` | text | yes | - | Security group ID |
| `--protocol` | text | yes | - | IP protocol (tcp/udp/icmp) |
| `--port` | integer | yes | - | Port (single port for both ends) |
| `--cidr` | text | yes | - | IPv4 CIDR range |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 run-instances

Launch instances (mirrors `aws ec2 run-instances`).

Usage: `nimbus aws ec2 run-instances [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--image-id` | text | yes | - | AMI ID |
| `--instance-type` | text | no | `t3.micro` | EC2 instance type |
| `--count` | integer | no | `1` | Number of instances |
| `--key-name` | text | no | - | SSH key pair name |
| `--security-group-ids` | text | no | - | Security group ID (repeatable) |
| `--tag-specifications` | text | no | - | TagSpecifications JSON list (native PascalCase keys) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 start-instances

Start instances (mirrors `aws ec2 start-instances`).

Usage: `nimbus aws ec2 start-instances [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance-ids` | text | yes | - | EC2 instance ID (repeatable, DEC-A) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 stop-instances

Stop instances (mirrors `aws ec2 stop-instances`).

Usage: `nimbus aws ec2 stop-instances [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance-ids` | text | yes | - | EC2 instance ID (repeatable, DEC-A) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ec2 terminate-instances

Terminate instances (mirrors `aws ec2 terminate-instances`).

Usage: `nimbus aws ec2 terminate-instances [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance-ids` | text | yes | - | EC2 instance ID (repeatable, DEC-A) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ecr create-repository

Create a repository (mirrors `aws ecr create-repository`).

Usage: `nimbus aws ecr create-repository [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--repository-name` | text | yes | - | Repository name |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ecr delete-repository

Delete a repository (mirrors `aws ecr delete-repository`).

Usage: `nimbus aws ecr delete-repository [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--repository-name` | text | yes | - | Repository name |
| `--force` | boolean | no | `False` | Delete even if the repository contains images |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ecr describe-repositories

List repositories (mirrors `aws ecr describe-repositories`).

Usage: `nimbus aws ecr describe-repositories [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--repository-names` | text | no | - | Repository name (repeatable) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ecs create-cluster

Create an ECS cluster (mirrors `aws ecs create-cluster`).

Usage: `nimbus aws ecs create-cluster [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cluster-name` | text | no | - | Cluster name |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ecs delete-cluster

Delete an ECS cluster (mirrors `aws ecs delete-cluster`).

Usage: `nimbus aws ecs delete-cluster [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cluster` | text | yes | - | Cluster name or ARN |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ecs describe-tasks

Describe tasks (mirrors `aws ecs describe-tasks`).

Usage: `nimbus aws ecs describe-tasks [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cluster` | text | yes | - | Cluster name or ARN |
| `--tasks` | text | yes | - | Task ID or ARN (repeatable) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ecs list-clusters

List ECS clusters (mirrors `aws ecs list-clusters`).

Usage: `nimbus aws ecs list-clusters [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ecs list-tasks

List task ARNs (mirrors `aws ecs list-tasks`).

Usage: `nimbus aws ecs list-tasks [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cluster` | text | no | - | Cluster name or ARN |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ecs register-task-definition

Register a task definition (mirrors `aws ecs register-task-definition`).

Usage: `nimbus aws ecs register-task-definition [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--family` | text | yes | - | Task definition family name |
| `--container-definitions` | text | yes | - | Container definitions JSON array (inline or file://\<path>) |
| `--requires-compatibilities` | text | no | - | Launch type compatibility (repeatable) |
| `--cpu` | text | no | - | Task CPU units (string) |
| `--memory` | text | no | - | Task memory in MiB (string) |
| `--network-mode` | text | no | - | Network mode (e.g. awsvpc) |
| `--execution-role-arn` | text | no | - | Execution role ARN |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ecs run-task

Run task(s) (mirrors `aws ecs run-task`).

Usage: `nimbus aws ecs run-task [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cluster` | text | yes | - | Cluster name or ARN |
| `--task-definition` | text | yes | - | Task definition family[:revision] or ARN |
| `--launch-type` | text | no | - | Launch type (EC2/FARGATE; Fargate compute is not free-tier eligible) |
| `--network-configuration` | text | no | - | networkConfiguration JSON object (inline or file://\<path>) |
| `--count` | integer | no | `1` | Number of tasks |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### ecs stop-task

Stop a task (mirrors `aws ecs stop-task`).

Usage: `nimbus aws ecs stop-task [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cluster` | text | yes | - | Cluster name or ARN |
| `--task` | text | yes | - | Task ID or ARN |
| `--reason` | text | no | - | Stop reason |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### freetier show

Show the current free tier spec for this provider.

Usage: `nimbus aws freetier show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### instance create

Launch an EC2 instance using the current adapter contract.

Usage: `nimbus aws instance create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--image-id` | text | yes | - | AMI ID |
| `--provider`, `-p` | text | no | - | AWS provider ID |
| `--instance-type` | text | no | `t3.micro` | EC2 instance type |
| `--label` | text | no | - | ICAO label (e.g. 'alpha'). Expands via generate_name() into 'aws-{geo}-{type}-{label}'. |
| `--key-name` | text | no | - | SSH key pair name |
| `--security-group` | text | no | - | Security group ID (repeatable) |

### instance get

Get details for an EC2 instance.

Usage: `nimbus aws instance get [OPTIONS] INSTANCE_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_id` | text | yes | - | EC2 instance ID |
| `--provider`, `-p` | text | no | - | AWS provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### instance list

List AWS EC2 instances.

Usage: `nimbus aws instance list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | AWS provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### instance stop

Stop an EC2 instance.

Usage: `nimbus aws instance stop [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | EC2 instance ID |
| `--provider`, `-p` | text | no | - | AWS provider ID |

### instance terminate

Terminate an EC2 instance.

Usage: `nimbus aws instance terminate [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | EC2 instance ID |
| `--provider`, `-p` | text | no | - | AWS provider ID |
| `--force` | boolean | no | `False` | Skip confirmation |

### rds create-db-instance

Create a DB instance (mirrors `aws rds create-db-instance`).

Usage: `nimbus aws rds create-db-instance [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-instance-identifier` | text | yes | - | DB instance identifier |
| `--engine` | text | yes | - | Database engine (postgres/mysql/...) |
| `--master-username` | text | yes | - | Master user name |
| `--master-user-password` | text | no | - | Master user password (prompted hidden when omitted) |
| `--db-instance-class` | text | no | `db.t3.micro` | Instance class (free-tier default) |
| `--allocated-storage` | integer | no | `20` | Storage in GiB (free-tier default) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### rds create-db-snapshot

Create a DB snapshot (mirrors `aws rds create-db-snapshot`).

Usage: `nimbus aws rds create-db-snapshot [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-instance-identifier` | text | yes | - | DB instance identifier |
| `--db-snapshot-identifier` | text | yes | - | DB snapshot identifier |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### rds delete-db-instance

Delete a DB instance (mirrors `aws rds delete-db-instance`).

Usage: `nimbus aws rds delete-db-instance [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-instance-identifier` | text | yes | - | DB instance identifier |
| `--skip-final-snapshot` | boolean | no | `False` | Skip the final snapshot before deletion |
| `--final-db-snapshot-identifier` | text | no | - | Identifier for the final snapshot taken before deletion |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### rds describe-db-instances

List DB instances (mirrors `aws rds describe-db-instances`).

Usage: `nimbus aws rds describe-db-instances [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-instance-identifier` | text | no | - | DB instance identifier |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### rds describe-db-snapshots

List DB snapshots (mirrors `aws rds describe-db-snapshots`).

Usage: `nimbus aws rds describe-db-snapshots [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-instance-identifier` | text | no | - | Filter by DB instance identifier |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### rds modify-db-instance

Modify a DB instance (mirrors `aws rds modify-db-instance`).

Usage: `nimbus aws rds modify-db-instance [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-instance-identifier` | text | yes | - | DB instance identifier |
| `--db-instance-class` | text | no | - | New instance class |
| `--allocated-storage` | integer | no | - | New storage in GiB |
| `--apply-immediately` | boolean | no | `False` | Apply now instead of the next maintenance window |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### rds start-db-instance

Start a DB instance (mirrors `aws rds start-db-instance`).

Usage: `nimbus aws rds start-db-instance [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-instance-identifier` | text | yes | - | DB instance identifier |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### rds stop-db-instance

Stop a DB instance (mirrors `aws rds stop-db-instance`).

Usage: `nimbus aws rds stop-db-instance [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-instance-identifier` | text | yes | - | DB instance identifier |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### s3 cp

Copy files to/from S3 (mirrors `aws s3 cp`).

Usage: `nimbus aws s3 cp [OPTIONS] SRC DST`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `src` | text | yes | - | Local path or s3:// URI |
| `dst` | text | yes | - | Local path or s3:// URI |
| `--recursive` | boolean | no | `False` | Apply to all objects under the prefix |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### s3 ls

List buckets or objects (mirrors `aws s3 ls`).

Usage: `nimbus aws s3 ls [OPTIONS] URI`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `uri` | text | no | - | Bucket/prefix URI |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### s3 mb

Make an S3 bucket (mirrors `aws s3 mb`).

Usage: `nimbus aws s3 mb [OPTIONS] URI`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `uri` | text | yes | - | Bucket URI |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### s3 rb

Remove an S3 bucket (mirrors `aws s3 rb`).

Usage: `nimbus aws s3 rb [OPTIONS] URI`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `uri` | text | yes | - | Bucket URI |
| `--force` | boolean | no | `False` | Delete all objects first (non-empty bucket) |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |

### s3 rm

Delete objects (mirrors `aws s3 rm`).

Usage: `nimbus aws s3 rm [OPTIONS] URI`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `uri` | text | yes | - | Object URI |
| `--recursive` | boolean | no | `False` | Apply to all objects under the prefix |
| `--provider`, `-p` | text | no | - | AWS provider ID (nimbus extension) |
