---
title: "nimbus gcloud"
sidebar:
  order: 8
---

Manage GCP resources (gcloud-mirrored grammar).

Native CLI equivalent: [https://cloud.google.com/sdk/gcloud/reference](https://cloud.google.com/sdk/gcloud/reference)

## Commands

### compute disks create

Create a persistent disk (mirrors `gcloud compute disks create`).

Usage: `nimbus gcloud compute disks create [OPTIONS] DISK_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `disk_name` | text | yes | - | Disk name |
| `--zone` | text | yes | - | GCP zone |
| `--size` | text | yes | - | Disk size (e.g. 10GB) |
| `--type` | text | no | `pd-standard` | Disk type (e.g. pd-standard, pd-ssd) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute disks delete

Delete a disk (mirrors `gcloud compute disks delete`).

Usage: `nimbus gcloud compute disks delete [OPTIONS] DISK_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `disk_name` | text | yes | - | Disk name |
| `--zone` | text | yes | - | GCP zone |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute disks describe

Describe one disk (mirrors `gcloud compute disks describe`).

Usage: `nimbus gcloud compute disks describe [OPTIONS] DISK_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `disk_name` | text | yes | - | Disk name |
| `--zone` | text | yes | - | GCP zone |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute disks list

List disks in a zone (mirrors `gcloud compute disks list`).

Usage: `nimbus gcloud compute disks list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--zone` | text | yes | - | GCP zone |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### compute firewall-rules create

Create a firewall rule (mirrors `gcloud compute firewall-rules create`).

Usage: `nimbus gcloud compute firewall-rules create [OPTIONS] RULE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `rule_name` | text | yes | - | Firewall rule name |
| `--allow` | text | yes | - | Allowed protocols/ports (PROTOCOL[:PORT[-PORT]], comma-separated) |
| `--network` | text | no | `default` | Target VPC network |
| `--source-ranges` | text | no | - | Source CIDRs, comma-separated (format: \<ip>/\<prefix>) |
| `--direction` | text | no | `INGRESS` | INGRESS or EGRESS |
| `--priority` | integer | no | `1000` | Rule priority (0-65535) |
| `--target-tags` | text | no | - | Target instance tags, comma-separated |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute firewall-rules delete

Delete a firewall rule (mirrors `gcloud compute firewall-rules delete`).

Usage: `nimbus gcloud compute firewall-rules delete [OPTIONS] RULE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `rule_name` | text | yes | - | Firewall rule name |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute firewall-rules describe

Describe one firewall rule (mirrors `gcloud compute firewall-rules describe`).

Usage: `nimbus gcloud compute firewall-rules describe [OPTIONS] RULE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `rule_name` | text | yes | - | Firewall rule name |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute firewall-rules list

List firewall rules (mirrors `gcloud compute firewall-rules list`).

Usage: `nimbus gcloud compute firewall-rules list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--network` | text | no | - | Filter to one VPC network |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### compute firewall-rules update

Update only the passed fields (mirrors `gcloud compute firewall-rules update`).

Usage: `nimbus gcloud compute firewall-rules update [OPTIONS] RULE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `rule_name` | text | yes | - | Firewall rule name |
| `--allow` | text | no | - | Allowed protocols/ports (PROTOCOL[:PORT[-PORT]], comma-separated) |
| `--source-ranges` | text | no | - | Source CIDRs, comma-separated (format: \<ip>/\<prefix>) |
| `--priority` | integer | no | - | Rule priority (0-65535) |
| `--target-tags` | text | no | - | Target instance tags, comma-separated |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute instances attach-disk

Attach a disk (mirrors `gcloud compute instances attach-disk`).

Usage: `nimbus gcloud compute instances attach-disk [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Instance name |
| `--disk` | text | yes | - | Disk name to attach/detach |
| `--zone` | text | yes | - | GCP zone |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute instances create

Create a Compute Engine instance (mirrors `gcloud compute instances create`).

Usage: `nimbus gcloud compute instances create [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Instance name |
| `--zone` | text | yes | - | GCP zone |
| `--machine-type` | text | no | `e2-micro` | GCP machine type |
| `--image-family` | text | no | - | Boot image family (requires --image-project) |
| `--image-project` | text | no | - | Project hosting the image family |
| `--image` | text | no | - | Explicit boot image (mutually exclusive with --image-family) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute instances delete

Delete an instance (mirrors `gcloud compute instances delete`).

Usage: `nimbus gcloud compute instances delete [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Instance name |
| `--zone` | text | yes | - | GCP zone |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute instances describe

Describe one instance (mirrors `gcloud compute instances describe`).

Usage: `nimbus gcloud compute instances describe [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Instance name |
| `--zone` | text | yes | - | GCP zone |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute instances detach-disk

Detach a disk (mirrors `gcloud compute instances detach-disk`).

Usage: `nimbus gcloud compute instances detach-disk [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Instance name |
| `--disk` | text | yes | - | Disk name to attach/detach |
| `--zone` | text | yes | - | GCP zone |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute instances list

List instances (mirrors `gcloud compute instances list`).

Usage: `nimbus gcloud compute instances list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--zones` | text | no | - | Comma-separated zone filter |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### compute instances start

Start an instance (mirrors `gcloud compute instances start`).

Usage: `nimbus gcloud compute instances start [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Instance name |
| `--zone` | text | yes | - | GCP zone |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute instances stop

Stop an instance (mirrors `gcloud compute instances stop`).

Usage: `nimbus gcloud compute instances stop [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Instance name |
| `--zone` | text | yes | - | GCP zone |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute networks create

Create a VPC network (mirrors `gcloud compute networks create`).

Usage: `nimbus gcloud compute networks create [OPTIONS] NETWORK_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `network_name` | text | yes | - | Network name |
| `--subnet-mode` | text | no | `auto` | Subnet mode (auto/custom) |
| `--mtu` | integer | no | - | Maximum transmission unit (1300-8896) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute networks delete

Delete a network (mirrors `gcloud compute networks delete`).

Usage: `nimbus gcloud compute networks delete [OPTIONS] NETWORK_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `network_name` | text | yes | - | Network name |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute networks describe

Describe one network (mirrors `gcloud compute networks describe`).

Usage: `nimbus gcloud compute networks describe [OPTIONS] NETWORK_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `network_name` | text | yes | - | Network name |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute networks list

List VPC networks (mirrors `gcloud compute networks list`).

Usage: `nimbus gcloud compute networks list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### compute networks subnets create

Create a subnet (mirrors `gcloud compute networks subnets create`).

Usage: `nimbus gcloud compute networks subnets create [OPTIONS] SUBNET_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `subnet_name` | text | yes | - | Subnet name |
| `--network` | text | yes | - | Parent VPC network |
| `--range` | text | yes | - | Subnet CIDR (format: \<ip>/\<prefix>) |
| `--region` | text | yes | - | GCP region |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute networks subnets delete

Delete a subnet (mirrors `gcloud compute networks subnets delete`).

Usage: `nimbus gcloud compute networks subnets delete [OPTIONS] SUBNET_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `subnet_name` | text | yes | - | Subnet name |
| `--region` | text | yes | - | GCP region |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute networks subnets describe

Describe one subnet (mirrors `gcloud compute networks subnets describe`).

Usage: `nimbus gcloud compute networks subnets describe [OPTIONS] SUBNET_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `subnet_name` | text | yes | - | Subnet name |
| `--region` | text | yes | - | GCP region |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### compute networks subnets list

List subnets (mirrors `gcloud compute networks subnets list`).

Usage: `nimbus gcloud compute networks subnets list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--region` | text | no | - | GCP region filter |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### container clusters create

Create a GKE cluster (mirrors `gcloud container clusters create`).

Usage: `nimbus gcloud container clusters create [OPTIONS] CLUSTER_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `cluster_name` | text | yes | - | Cluster name |
| `--zone` | text | no | - | GCP zone (zonal cluster) |
| `--region` | text | no | - | GCP region (regional cluster) |
| `--num-nodes` | integer | no | `3` | Initial node count |
| `--machine-type` | text | no | `e2-small` | Node machine type |
| `--cluster-version` | text | no | - | Initial cluster version |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### container clusters delete

Delete a cluster (mirrors `gcloud container clusters delete`).

Usage: `nimbus gcloud container clusters delete [OPTIONS] CLUSTER_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `cluster_name` | text | yes | - | Cluster name |
| `--zone` | text | no | - | GCP zone (zonal cluster) |
| `--region` | text | no | - | GCP region (regional cluster) |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### container clusters describe

Describe one cluster (mirrors `gcloud container clusters describe`).

Usage: `nimbus gcloud container clusters describe [OPTIONS] CLUSTER_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `cluster_name` | text | yes | - | Cluster name |
| `--zone` | text | no | - | GCP zone (zonal cluster) |
| `--region` | text | no | - | GCP region (regional cluster) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### container clusters list

List clusters (mirrors `gcloud container clusters list`; all locations by default).

Usage: `nimbus gcloud container clusters list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--zone` | text | no | - | GCP zone (zonal cluster) |
| `--region` | text | no | - | GCP region (regional cluster) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### container clusters resize

Resize a cluster's node pool (mirrors `gcloud container clusters resize`).

Usage: `nimbus gcloud container clusters resize [OPTIONS] CLUSTER_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `cluster_name` | text | yes | - | Cluster name |
| `--num-nodes` | integer | yes | - | Target node count |
| `--zone` | text | no | - | GCP zone (zonal cluster) |
| `--region` | text | no | - | GCP region (regional cluster) |
| `--node-pool` | text | no | `default-pool` | Node pool to resize |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### container node-pools create

Create a node pool (mirrors `gcloud container node-pools create`).

Usage: `nimbus gcloud container node-pools create [OPTIONS] POOL_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `pool_name` | text | yes | - | Node pool name |
| `--cluster` | text | yes | - | Target GKE cluster |
| `--zone` | text | no | - | GCP zone (zonal cluster) |
| `--region` | text | no | - | GCP region (regional cluster) |
| `--num-nodes` | integer | no | `3` | Initial node count |
| `--machine-type` | text | no | `e2-small` | Node machine type |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### container node-pools delete

Delete a node pool (mirrors `gcloud container node-pools delete`).

Usage: `nimbus gcloud container node-pools delete [OPTIONS] POOL_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `pool_name` | text | yes | - | Node pool name |
| `--cluster` | text | yes | - | Target GKE cluster |
| `--zone` | text | no | - | GCP zone (zonal cluster) |
| `--region` | text | no | - | GCP region (regional cluster) |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### container node-pools list

List node pools (mirrors `gcloud container node-pools list`).

Usage: `nimbus gcloud container node-pools list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cluster` | text | yes | - | Target GKE cluster |
| `--zone` | text | no | - | GCP zone (zonal cluster) |
| `--region` | text | no | - | GCP region (regional cluster) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### freetier show

Show the current free tier spec for this provider.

Usage: `nimbus gcloud freetier show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### sql databases create

Create a database (mirrors `gcloud sql databases create`).

Usage: `nimbus gcloud sql databases create [OPTIONS] DATABASE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `database_name` | text | yes | - | Database name |
| `--instance`, `-i` | text | yes | - | Cloud SQL instance name |
| `--charset` | text | no | - | Character set |
| `--collation` | text | no | - | Collation |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### sql databases delete

Delete a database (mirrors `gcloud sql databases delete`).

Usage: `nimbus gcloud sql databases delete [OPTIONS] DATABASE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `database_name` | text | yes | - | Database name |
| `--instance`, `-i` | text | yes | - | Cloud SQL instance name |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### sql databases list

List databases in an instance (mirrors `gcloud sql databases list`).

Usage: `nimbus gcloud sql databases list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance`, `-i` | text | yes | - | Cloud SQL instance name |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### sql instances create

Create a Cloud SQL instance (mirrors `gcloud sql instances create`).

Usage: `nimbus gcloud sql instances create [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Cloud SQL instance name |
| `--database-version` | text | yes | - | e.g. POSTGRES_16 or MYSQL_8_0 |
| `--tier` | text | yes | - | Machine tier (e.g. db-f1-micro) |
| `--region` | text | yes | - | GCP region |
| `--root-password` | text | no | - | Initial root password |
| `--edition` | text | no | - | ENTERPRISE or ENTERPRISE_PLUS |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### sql instances delete

Delete an instance (mirrors `gcloud sql instances delete`).

Usage: `nimbus gcloud sql instances delete [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Cloud SQL instance name |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### sql instances describe

Describe one instance (mirrors `gcloud sql instances describe`).

Usage: `nimbus gcloud sql instances describe [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Cloud SQL instance name |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### sql instances list

List Cloud SQL instances (mirrors `gcloud sql instances list`).

Usage: `nimbus gcloud sql instances list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### sql instances patch

Patch instance settings (mirrors `gcloud sql instances patch`).

Usage: `nimbus gcloud sql instances patch [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Cloud SQL instance name |
| `--activation-policy` | text | yes | - | NEVER pauses, ALWAYS resumes (gcloud sql has no start/stop) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### sql instances restart

Restart an instance (mirrors `gcloud sql instances restart`).

Usage: `nimbus gcloud sql instances restart [OPTIONS] INSTANCE_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `instance_name` | text | yes | - | Cloud SQL instance name |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### sql users create

Create a SQL user (mirrors `gcloud sql users create`).

Usage: `nimbus gcloud sql users create [OPTIONS] USER_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `user_name` | text | yes | - | SQL user name |
| `--instance`, `-i` | text | yes | - | Cloud SQL instance name |
| `--password` | text | no | - | Password for the new user |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### sql users list

List SQL users in an instance (mirrors `gcloud sql users list`).

Usage: `nimbus gcloud sql users list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance`, `-i` | text | yes | - | Cloud SQL instance name |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### storage buckets create

Create a bucket (mirrors `gcloud storage buckets create`).

Usage: `nimbus gcloud storage buckets create [OPTIONS] BUCKET_URL`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `bucket_url` | text | yes | - | Bucket URL (gs://\<bucket>) |
| `--location` | text | no | `US` | Bucket location |
| `--uniform-bucket-level-access` | boolean | no | `False` | Enable uniform bucket-level access |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### storage buckets delete

Delete an empty bucket (mirrors `gcloud storage buckets delete`).

Usage: `nimbus gcloud storage buckets delete [OPTIONS] BUCKET_URL`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `bucket_url` | text | yes | - | Bucket URL (gs://\<bucket>) |
| `--quiet`, `-q` | boolean | no | `False` | Skip confirmation (gcloud --quiet) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### storage buckets describe

Describe one bucket (mirrors `gcloud storage buckets describe`).

Usage: `nimbus gcloud storage buckets describe [OPTIONS] BUCKET_URL`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `bucket_url` | text | yes | - | Bucket URL (gs://\<bucket>) |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### storage buckets list

List buckets (mirrors `gcloud storage buckets list`).

Usage: `nimbus gcloud storage buckets list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### storage cp

Copy local↔remote (mirrors `gcloud storage cp`).

Usage: `nimbus gcloud storage cp [OPTIONS] SRC DST`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `src` | text | yes | - | Local path or gs:// URL |
| `dst` | text | yes | - | Local path or gs:// URL |
| `--recursive`, `-r` | boolean | no | `False` | Recurse into directories/prefixes |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |

### storage ls

List buckets or objects (mirrors `gcloud storage ls`).

Usage: `nimbus gcloud storage ls [OPTIONS] URL`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `url` | text | no | - | gs://\<bucket>[/\<prefix>]; omit to list buckets |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### storage rm

Remove objects (mirrors `gcloud storage rm`; no prompt, like gcloud).

Usage: `nimbus gcloud storage rm [OPTIONS] URL`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `url` | text | yes | - | gs://\<bucket>/\<object-or-prefix> |
| `--recursive`, `-r` | boolean | no | `False` | Recurse into directories/prefixes |
| `--provider`, `-p` | text | no | - | GCP provider ID (nimbus extension) |
