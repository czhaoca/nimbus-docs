---
title: "nimbus oci"
sidebar:
  order: 20
---

Manage Oracle Cloud Infrastructure resources.

Native CLI equivalent: [https://docs.oracle.com/en-us/iaas/tools/oci-cli/latest/oci_cli_docs/](https://docs.oracle.com/en-us/iaas/tools/oci-cli/latest/oci_cli_docs/)

## Commands

### admin compartments

List compartments in the tenancy.

Usage: `nimbus oci admin compartments [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | Tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format |

### admin info

Show OCI tenancy details (name, OCID, home region, subscribed regions).

Usage: `nimbus oci admin info [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | Tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format |

### admin limits

List service limits for the tenancy.

Usage: `nimbus oci admin limits [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | Tenancy alias |
| `--service` | text | no | - | Filter by service (e.g. compute, block-storage) |
| `--format`, `-f` | text | no | `table` | Output format |

### alias list

List all registered OCI tenancy aliases.

Usage: `nimbus oci alias list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### alias rename

Rename an OCI tenancy alias (local only, does not touch ~/.oci/config).

Usage: `nimbus oci alias rename [OPTIONS] OLD_NAME NEW_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `old_name` | text | yes | - | Current alias name |
| `new_name` | text | yes | - | New alias name |

### alias set-default-compartment

Set the default compartment for an OCI tenancy alias.

Usage: `nimbus oci alias set-default-compartment [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--alias` | text | yes | - | Tenancy alias |
| `--compartment` | text | yes | - | Compartment OCID |

### bv volume create

Create a block volume (mirrors `oci bv volume create`).

Usage: `nimbus oci bv volume create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | yes | - | Compartment OCID |
| `--availability-domain` | text | yes | - | Availability domain name |
| `--size-in-gbs` | integer | yes | - | Volume size in GB (required — native's 1024 GB default exceeds free tier) |
| `--display-name` | text | no | `` | Volume display name |
| `--dry-run` | boolean | no | `False` | Print plan, create nothing |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### bv volume delete

Delete a block volume (mirrors `oci bv volume delete`).

Usage: `nimbus oci bv volume delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--volume-id` | text | yes | - | Block volume OCID |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### bv volume get

Describe one block volume (mirrors `oci bv volume get`).

Usage: `nimbus oci bv volume get [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--volume-id` | text | yes | - | Block volume OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### bv volume list

List block volumes (mirrors `oci bv volume list`).

Usage: `nimbus oci bv volume list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--availability-domain` | text | no | - | Filter by availability domain |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ce cluster create

Create an OKE cluster (mirrors `oci ce cluster create`; async — returns a work request).

Usage: `nimbus oci ce cluster create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | yes | - | Compartment OCID |
| `--name` | text | yes | - | Cluster name |
| `--vcn-id` | text | yes | - | VCN OCID for the cluster |
| `--kubernetes-version` | text | yes | - | Kubernetes version (e.g. v1.33.1) |
| `--endpoint-subnet-id` | text | no | - | Subnet OCID for the API endpoint (optional) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### ce cluster delete

Delete an OKE cluster (mirrors `oci ce cluster delete`).

Usage: `nimbus oci ce cluster delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cluster-id` | text | yes | - | OKE cluster OCID |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### ce cluster list

List OKE clusters (mirrors `oci ce cluster list`).

Usage: `nimbus oci ce cluster list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ce node-pool create

Create a node pool (mirrors `oci ce node-pool create`; async — returns a work request).

Usage: `nimbus oci ce node-pool create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cluster-id` | text | yes | - | Parent OKE cluster OCID |
| `--compartment-id`, `-c` | text | yes | - | Compartment OCID |
| `--name` | text | yes | - | Node pool name |
| `--node-shape` | text | yes | - | Worker node shape |
| `--size` | integer | yes | - | Number of nodes (required — explicit size only) |
| `--placement-configs` | text | yes | - | JSON array or file://\<path>, camelCase keys, e.g. [{"availabilityDomain": "...", "subnetId": "..."}] |
| `--kubernetes-version` | text | no | - | Kubernetes version (optional) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### ce node-pool delete

Delete a node pool (mirrors `oci ce node-pool delete`).

Usage: `nimbus oci ce node-pool delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--node-pool-id` | text | yes | - | Node pool OCID |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### ce node-pool list

List node pools (mirrors `oci ce node-pool list`).

Usage: `nimbus oci ce node-pool list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--cluster-id` | text | no | - | Filter by parent cluster OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### compute image list

List images (mirrors `oci compute image list`).

Usage: `nimbus oci compute image list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--operating-system` | text | no | - | Filter by OS family |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### compute instance action

Run a lifecycle action (mirrors `oci compute instance action`).

Usage: `nimbus oci compute instance action [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance-id` | text | yes | - | Instance OCID |
| `--action` | text | yes | - | START, STOP, SOFTRESET, or RESET |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### compute instance get

Get one instance (mirrors `oci compute instance get`).

Usage: `nimbus oci compute instance get [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance-id` | text | yes | - | Instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### compute instance launch

Launch a compute instance (mirrors `oci compute instance launch`).

Usage: `nimbus oci compute instance launch [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--subnet-id` | text | yes | - | Target subnet OCID |
| `--display-name` | text | yes | - | Instance label (expanded via the Nimbus naming convention) |
| `--availability-domain` | text | no | - | AD (resolved from the registered tenancy when omitted; must match if given) |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (resolved from the registered tenancy; must match if given) |
| `--shape` | text | no | `VM.Standard.A1.Flex` | Compute shape |
| `--shape-config` | text | no | - | Shape config JSON, e.g. {"ocpus": 2, "memoryInGBs": 12} |
| `--image-id` | text | no | - | Boot image OCID (latest OS image if omitted) |
| `--ssh-authorized-keys-file` | text | no | - | Path to an SSH public key file |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |

### compute instance list

List instances (mirrors `oci compute instance list`).

Usage: `nimbus oci compute instance list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### compute instance terminate

Terminate an instance (mirrors `oci compute instance terminate`).

Usage: `nimbus oci compute instance terminate [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance-id` | text | yes | - | Instance OCID |
| `--preserve-boot-volume` | boolean | no | `False` | Keep the boot volume after terminate |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### compute shape list

List available shapes (mirrors `oci compute shape list`).

Usage: `nimbus oci compute shape list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### compute volume-attachment attach

Attach a block volume (mirrors `oci compute volume-attachment attach`).

Usage: `nimbus oci compute volume-attachment attach [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--instance-id` | text | yes | - | Instance OCID |
| `--volume-id` | text | yes | - | Block volume OCID |
| `--type` | text | no | `paravirtualized` | Attachment type (only 'paravirtualized' supported) |
| `--display-name` | text | no | `` | Attachment display name |
| `--is-read-only` | boolean | no | `False` | Attach read-only |
| `--is-shareable` | boolean | no | `False` | Allow multi-instance attach |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### compute volume-attachment detach

Detach a block volume (mirrors `oci compute volume-attachment detach`).

Usage: `nimbus oci compute volume-attachment detach [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--volume-attachment-id` | text | yes | - | Volume attachment OCID |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### compute volume-attachment list

List volume attachments (mirrors `oci compute volume-attachment list`).

Usage: `nimbus oci compute volume-attachment list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--instance-id` | text | no | - | Filter by instance OCID |
| `--volume-id` | text | no | - | Filter by volume OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### container-instances container-instance create

Create a container instance (mirrors `oci container-instances container-instance create`).

Usage: `nimbus oci container-instances container-instance create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | yes | - | Compartment OCID |
| `--availability-domain` | text | yes | - | Availability domain name |
| `--shape` | text | yes | - | Container instance shape |
| `--shape-config` | text | yes | - | JSON object or file://\<path>, camelCase keys, e.g. {"ocpus": 1, "memoryInGBs": 6} |
| `--containers` | text | yes | - | JSON array or file://\<path>, camelCase keys, e.g. [{"imageUrl": "..."}] |
| `--vnics` | text | yes | - | JSON array or file://\<path>, camelCase keys, e.g. [{"subnetId": "..."}] |
| `--display-name` | text | no | `` | Container instance display name |
| `--dry-run` | boolean | no | `False` | Print plan, create nothing |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### container-instances container-instance delete

Delete a container instance (mirrors `... container-instance delete`).

Usage: `nimbus oci container-instances container-instance delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--container-instance-id` | text | yes | - | Container instance OCID |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### container-instances container-instance get

Describe one container instance (mirrors `... container-instance get`).

Usage: `nimbus oci container-instances container-instance get [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--container-instance-id` | text | yes | - | Container instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### container-instances container-instance list

List container instances (mirrors `oci container-instances container-instance list`).

Usage: `nimbus oci container-instances container-instance list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### container-instances container-instance restart

Restart a container instance (mirrors `... container-instance restart`).

Usage: `nimbus oci container-instances container-instance restart [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--container-instance-id` | text | yes | - | Container instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### container-instances container-instance start

Start a container instance (mirrors `... container-instance start`).

Usage: `nimbus oci container-instances container-instance start [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--container-instance-id` | text | yes | - | Container instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### container-instances container-instance stop

Stop a container instance (mirrors `... container-instance stop`).

Usage: `nimbus oci container-instances container-instance stop [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--container-instance-id` | text | yes | - | Container instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### context clear

Clear the active OCI tenancy context.

Usage: `nimbus oci context clear [OPTIONS]`

_No options._

### context set

Set the active OCI tenancy context (used by read-only commands).

Usage: `nimbus oci context set [OPTIONS] ALIAS_NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `alias_name` | text | yes | - | Tenancy alias to activate |

### context show

Show the current active OCI tenancy context.

Usage: `nimbus oci context show [OPTIONS]`

_No options._

### cost current

Show current month OCI spending.

Usage: `nimbus oci cost current [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | OCI provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### cost history

Show OCI spending history (last 7 days).

Usage: `nimbus oci cost history [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | OCI provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### db adb create

Create an Autonomous Database (ATP or ADW) with optional private endpoint.

Usage: `nimbus oci db adb create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--label`, `-l` | text | yes | - | ICAO label (e.g. alpha) |
| `--db-workload`, `--workload`, `-w` | text | yes | - | OLTP (ATP) or DW (ADW) |
| `--admin-password`, `--password` | text | yes | - |  |
| `--tenancy`, `-t` | text | no | - |  |
| `--subnet-id`, `--subnet` | text | no | - | Subnet OCID (private endpoint) |
| `--public` | boolean | no | `False` | Create with public endpoint (no subnet) |
| `--db-name` | text | no | - | Database name (auto from label) |
| `--compute-count` | float | no | `2` |  |
| `--data-storage-size-in-gbs`, `--storage-gb` | integer | no | `20` |  |
| `--is-free-tier`, `--no-is-free-tier` | boolean | no | `True` | Always-Free ADB (Nimbus default True; native oci defaults false) |
| `--dry-run` | boolean | no | `False` |  |

### db adb delete

Delete an Autonomous Database.

Usage: `nimbus oci db adb delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--autonomous-database-id`, `--id` | text | yes | - | Autonomous Database OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--force` | boolean | no | `False` |  |

### db adb get

Get one Autonomous Database (mirrors `oci db autonomous-database get`).

Usage: `nimbus oci db adb get [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--autonomous-database-id`, `--id` | text | yes | - | ADB OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `json` |  |

### db adb list

List Autonomous Databases (ATP/ADW).

Usage: `nimbus oci db adb list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### db adb start

Start a stopped Autonomous Database.

Usage: `nimbus oci db adb start [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--autonomous-database-id`, `--id` | text | yes | - | Autonomous Database OCID |
| `--tenancy`, `-t` | text | no | - |  |

### db adb stop

Stop an Autonomous Database.

Usage: `nimbus oci db adb stop [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--autonomous-database-id`, `--id` | text | yes | - | Autonomous Database OCID |
| `--tenancy`, `-t` | text | no | - |  |

### db autonomous-database create

Create an Autonomous Database (ATP or ADW) with optional private endpoint.

Usage: `nimbus oci db autonomous-database create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--label`, `-l` | text | yes | - | ICAO label (e.g. alpha) |
| `--db-workload`, `--workload`, `-w` | text | yes | - | OLTP (ATP) or DW (ADW) |
| `--admin-password`, `--password` | text | yes | - |  |
| `--tenancy`, `-t` | text | no | - |  |
| `--subnet-id`, `--subnet` | text | no | - | Subnet OCID (private endpoint) |
| `--public` | boolean | no | `False` | Create with public endpoint (no subnet) |
| `--db-name` | text | no | - | Database name (auto from label) |
| `--compute-count` | float | no | `2` |  |
| `--data-storage-size-in-gbs`, `--storage-gb` | integer | no | `20` |  |
| `--is-free-tier`, `--no-is-free-tier` | boolean | no | `True` | Always-Free ADB (Nimbus default True; native oci defaults false) |
| `--dry-run` | boolean | no | `False` |  |

### db autonomous-database delete

Delete an Autonomous Database.

Usage: `nimbus oci db autonomous-database delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--autonomous-database-id`, `--id` | text | yes | - | Autonomous Database OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--force` | boolean | no | `False` |  |

### db autonomous-database get

Get one Autonomous Database (mirrors `oci db autonomous-database get`).

Usage: `nimbus oci db autonomous-database get [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--autonomous-database-id`, `--id` | text | yes | - | ADB OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `json` |  |

### db autonomous-database list

List Autonomous Databases (ATP/ADW).

Usage: `nimbus oci db autonomous-database list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### db autonomous-database start

Start a stopped Autonomous Database.

Usage: `nimbus oci db autonomous-database start [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--autonomous-database-id`, `--id` | text | yes | - | Autonomous Database OCID |
| `--tenancy`, `-t` | text | no | - |  |

### db autonomous-database stop

Stop an Autonomous Database.

Usage: `nimbus oci db autonomous-database stop [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--autonomous-database-id`, `--id` | text | yes | - | Autonomous Database OCID |
| `--tenancy`, `-t` | text | no | - |  |

### db mysql create

Create a MySQL HeatWave DB System with auto-assigned IP (.11-.20 range).

Usage: `nimbus oci db mysql create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--label`, `-l` | text | yes | - | ICAO label (e.g. alpha) |
| `--subnet-id`, `--subnet` | text | yes | - | Subnet OCID |
| `--admin-password`, `--password` | text | yes | - |  |
| `--tenancy`, `-t` | text | no | - |  |
| `--admin-username`, `--username` | text | no | `admin` |  |
| `--shape-name`, `--shape` | text | no | `MySQL.Free` |  |
| `--data-storage-size-in-gbs`, `--storage-gb` | integer | no | `50` |  |
| `--availability-domain`, `--ad` | text | no | - | Availability domain (auto-detected) |
| `--dry-run` | boolean | no | `False` |  |

### db mysql delete

Delete a MySQL HeatWave DB System.

Usage: `nimbus oci db mysql delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-system-id`, `--id` | text | yes | - | MySQL DB System OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--force` | boolean | no | `False` |  |

### db mysql get

Get one MySQL DB System (mirrors `oci mysql db-system get`).

Usage: `nimbus oci db mysql get [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-system-id`, `--id` | text | yes | - | MySQL DB System OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `json` |  |

### db mysql list

List MySQL HeatWave DB Systems.

Usage: `nimbus oci db mysql list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### db mysql start

Start a stopped MySQL HeatWave DB System.

Usage: `nimbus oci db mysql start [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-system-id`, `--id` | text | yes | - | MySQL DB System OCID |
| `--tenancy`, `-t` | text | no | - |  |

### db mysql stop

Stop a MySQL HeatWave DB System (mirrors `oci mysql db-system stop`).

Usage: `nimbus oci db mysql stop [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-system-id`, `--id` | text | yes | - | MySQL DB System OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--shutdown-type` | text | no | `FAST` | FAST (default; native oci requires this flag), SLOW, or IMMEDIATE |

### freetier status

Show free tier usage vs limits for all validatable resources.

Usage: `nimbus oci freetier status [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### harden run

Audit and remediate OCI network security findings.

Usage: `nimbus oci harden run [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |
| `--min-severity` | text | no | `MEDIUM` | Min severity (CRITICAL/HIGH/MEDIUM) |
| `--apply` | boolean | no | `False` | Execute fixes (dry-run by default) |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ip assign

Assign a secondary private IP to a VNIC.

Usage: `nimbus oci ip assign [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--vnic-id` | text | yes | - | VNIC OCID |
| `--ip` | text | no | - | Specific IP address |
| `--name` | text | no | `` |  |
| `--tenancy`, `-t` | text | no | - |  |

### ip list

List all private IPs in a subnet.

Usage: `nimbus oci ip list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--subnet` | text | yes | - | Subnet OCID to list IPs from |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### ip move

Move a secondary private IP to a different VNIC (same subnet).

Usage: `nimbus oci ip move [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Private IP OCID to move |
| `--target-vnic` | text | yes | - | Target VNIC OCID |
| `--tenancy`, `-t` | text | no | - |  |

### ip unassign

Remove a secondary private IP.

Usage: `nimbus oci ip unassign [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Private IP OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--force` | boolean | no | `False` |  |

### migrate cidr

Add new CIDR to VCN, create subnet, attach secondary VNICs with planned IPs.

Usage: `nimbus oci migrate cidr [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - |  |
| `--cidr` | text | no | `` | New CIDR block (required) |
| `--subnet-name` | text | no | - | Override subnet display name |
| `--dry-run` | boolean | no | `False` |  |
| `--format`, `-f` | text | no | `table` |  |

### migrate cleanup-old

Remove old CIDR and subnet after migration. Requires manual VNIC detach first.

Usage: `nimbus oci migrate cleanup-old [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - |  |
| `--old-cidr` | text | no | `` | CIDR block to remove (required) |
| `--force` | boolean | no | `False` |  |

### mysql db-system create

Create a MySQL HeatWave DB System with auto-assigned IP (.11-.20 range).

Usage: `nimbus oci mysql db-system create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--label`, `-l` | text | yes | - | ICAO label (e.g. alpha) |
| `--subnet-id`, `--subnet` | text | yes | - | Subnet OCID |
| `--admin-password`, `--password` | text | yes | - |  |
| `--tenancy`, `-t` | text | no | - |  |
| `--admin-username`, `--username` | text | no | `admin` |  |
| `--shape-name`, `--shape` | text | no | `MySQL.Free` |  |
| `--data-storage-size-in-gbs`, `--storage-gb` | integer | no | `50` |  |
| `--availability-domain`, `--ad` | text | no | - | Availability domain (auto-detected) |
| `--dry-run` | boolean | no | `False` |  |

### mysql db-system delete

Delete a MySQL HeatWave DB System.

Usage: `nimbus oci mysql db-system delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-system-id`, `--id` | text | yes | - | MySQL DB System OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--force` | boolean | no | `False` |  |

### mysql db-system get

Get one MySQL DB System (mirrors `oci mysql db-system get`).

Usage: `nimbus oci mysql db-system get [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-system-id`, `--id` | text | yes | - | MySQL DB System OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `json` |  |

### mysql db-system list

List MySQL HeatWave DB Systems.

Usage: `nimbus oci mysql db-system list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### mysql db-system start

Start a stopped MySQL HeatWave DB System.

Usage: `nimbus oci mysql db-system start [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-system-id`, `--id` | text | yes | - | MySQL DB System OCID |
| `--tenancy`, `-t` | text | no | - |  |

### mysql db-system stop

Stop a MySQL HeatWave DB System (mirrors `oci mysql db-system stop`).

Usage: `nimbus oci mysql db-system stop [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-system-id`, `--id` | text | yes | - | MySQL DB System OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--shutdown-type` | text | no | `FAST` | FAST (default; native oci requires this flag), SLOW, or IMMEDIATE |

### network create-subnet

> ⚠️ **Deprecated.**

Create a subnet within a VCN with CIDR collision checking.

Usage: `nimbus oci network create-subnet [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--label`, `-l` | text | yes | - | Subnet label (e.g. app, db) |
| `--vcn` | text | yes | - | VCN OCID to create subnet in |
| `--cidr` | text | yes | - | Subnet CIDR (format: \<ip>/\<prefix>) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |
| `--private`, `--public` | boolean | no | `True` | Prohibit public IPs (default: private) |
| `--dns-label` | text | no | - | DNS label |
| `--dry-run` | boolean | no | `False` | Show what would happen |

### network create-vcn

> ⚠️ **Deprecated.**

Create an OCI VCN with CIDR collision checking.

Usage: `nimbus oci network create-vcn [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--label`, `-l` | text | yes | - | VCN label (e.g. main, dev) |
| `--cidr` | text | yes | - | CIDR block (format: \<ip>/\<prefix>) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |
| `--dns-label` | text | no | - | DNS label for VCN |
| `--dry-run` | boolean | no | `False` | Show what would happen |

### network list-subnets

> ⚠️ **Deprecated.**

List subnets, optionally filtered by VCN.

Usage: `nimbus oci network list-subnets [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--vcn` | text | no | - | Filter by VCN OCID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### network list-vcns

> ⚠️ **Deprecated.**

List all VCNs in the tenancy.

Usage: `nimbus oci network list-vcns [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### network nsg create

Create an NSG (mirrors `oci network nsg create`).

Usage: `nimbus oci network nsg create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | yes | - | Compartment OCID |
| `--vcn-id` | text | yes | - | Parent VCN OCID |
| `--display-name` | text | no | `` | NSG display name |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### network nsg delete

Delete an NSG (mirrors `oci network nsg delete`).

Usage: `nimbus oci network nsg delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--nsg-id` | text | yes | - | NSG OCID |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### network nsg list

List NSGs (mirrors `oci network nsg list`).

Usage: `nimbus oci network nsg list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--vcn-id` | text | no | - | VCN OCID (auto-detected when omitted) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### network nsg rules add

Add security rules (mirrors `oci network nsg rules add`).

Usage: `nimbus oci network nsg rules add [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--nsg-id` | text | yes | - | NSG OCID |
| `--security-rules` | text | yes | - | JSON array or file://\<path> (oci form) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### network nsg rules list

List security rules (mirrors `oci network nsg rules list`).

Usage: `nimbus oci network nsg rules list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--nsg-id` | text | yes | - | NSG OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### network nsg rules remove

Remove security rules (mirrors `oci network nsg rules remove`).

Usage: `nimbus oci network nsg rules remove [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--nsg-id` | text | yes | - | NSG OCID |
| `--security-rule-ids` | text | yes | - | Rule OCIDs, comma-separated |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### network subnet create

Create a subnet (mirrors `oci network subnet create`).

Usage: `nimbus oci network subnet create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | yes | - | Compartment OCID |
| `--vcn-id` | text | yes | - | Parent VCN OCID |
| `--cidr-block` | text | yes | - | Subnet CIDR (format: \<ip>/\<prefix>) |
| `--display-name` | text | no | `` | Subnet display name |
| `--prohibit-public-ip-on-vnic` | boolean | no | `False` | Make the subnet private (public IPs prohibited) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### network subnet delete

Delete a subnet (mirrors `oci network subnet delete`).

Usage: `nimbus oci network subnet delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--subnet-id` | text | yes | - | Subnet OCID |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### network subnet list

List subnets (mirrors `oci network subnet list`).

Usage: `nimbus oci network subnet list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--vcn-id` | text | no | - | Filter to one VCN |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### network vcn create

Create a VCN (mirrors `oci network vcn create`).

Usage: `nimbus oci network vcn create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | yes | - | Compartment OCID |
| `--cidr-blocks` | text | yes | - | JSON array string (format: ["\<ip>/\<prefix>"]) |
| `--display-name` | text | no | `` | VCN display name |
| `--dns-label` | text | no | - | DNS label |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### network vcn delete

Delete a VCN (mirrors `oci network vcn delete`).

Usage: `nimbus oci network vcn delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--vcn-id` | text | yes | - | VCN OCID |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### network vcn get

Describe one VCN (mirrors `oci network vcn get`).

Usage: `nimbus oci network vcn get [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--vcn-id` | text | yes | - | VCN OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### network vcn list

List VCNs (mirrors `oci network vcn list`).

Usage: `nimbus oci network vcn list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### nsg add-rule

Add a security rule to an NSG.

Usage: `nimbus oci nsg add-rule [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | NSG OCID |
| `--direction`, `-d` | text | yes | - | ingress or egress |
| `--protocol`, `-p` | text | yes | - | tcp/udp/icmp/all |
| `--source` | text | no | - |  |
| `--destination` | text | no | - |  |
| `--port` | integer | no | - |  |
| `--port-max` | integer | no | - |  |
| `--desc` | text | no | `` |  |
| `--tenancy`, `-t` | text | no | - |  |

### nsg attach

Attach an NSG to a VNIC.

Usage: `nimbus oci nsg attach [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | NSG OCID |
| `--vnic-id` | text | yes | - | VNIC OCID |
| `--tenancy`, `-t` | text | no | - |  |

### nsg create

Create a Network Security Group with ICAO naming.

Usage: `nimbus oci nsg create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--label`, `-l` | text | yes | - | ICAO label |
| `--vcn` | text | yes | - | VCN OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--dry-run` | boolean | no | `False` |  |

### nsg delete

Delete a Network Security Group.

Usage: `nimbus oci nsg delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | NSG OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--force` | boolean | no | `False` |  |

### nsg list

List Network Security Groups.

Usage: `nimbus oci nsg list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - |  |
| `--vcn` | text | no | - | VCN OCID (auto-detected) |
| `--format`, `-f` | text | no | `table` |  |

### nsg remove-rule

Remove a security rule from an NSG by its OCID.

Usage: `nimbus oci nsg remove-rule [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | NSG OCID |
| `--rule-id` | text | yes | - | Rule OCID to remove |
| `--tenancy`, `-t` | text | no | - |  |

### nsg rules

Show security rules in an NSG.

Usage: `nimbus oci nsg rules [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | NSG OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### os bucket create

Create a bucket (mirrors `oci os bucket create`).

Usage: `nimbus oci os bucket create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Bucket name |
| `--compartment-id`, `-c` | text | yes | - | Compartment OCID |
| `--namespace`, `--namespace-name`, `-ns` | text | no | - | Namespace (auto-derived) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### os bucket delete

Delete an empty bucket (mirrors `oci os bucket delete`).

Usage: `nimbus oci os bucket delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--bucket-name`, `--name`, `-bn` | text | yes | - | Bucket name |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--namespace`, `--namespace-name`, `-ns` | text | no | - | Namespace (auto-derived) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### os bucket list

List buckets (mirrors `oci os bucket list`).

Usage: `nimbus oci os bucket list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--compartment-id`, `-c` | text | no | - | Compartment OCID (defaults to tenancy's) |
| `--namespace`, `--namespace-name`, `-ns` | text | no | - | Namespace (auto-derived) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### os object delete

Delete an object (mirrors `oci os object delete`).

Usage: `nimbus oci os object delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--bucket-name`, `-bn` | text | yes | - | Bucket name |
| `--object-name`, `--name` | text | yes | - | Object name |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--namespace`, `--namespace-name`, `-ns` | text | no | - | Namespace (auto-derived) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### os object get

Download an object to a file (mirrors `oci os object get`).

Usage: `nimbus oci os object get [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--bucket-name`, `-bn` | text | yes | - | Bucket name |
| `--name` | text | yes | - | Object name |
| `--file` | text | yes | - | Local output path |
| `--namespace`, `--namespace-name`, `-ns` | text | no | - | Namespace (auto-derived) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### os object list

List objects in a bucket (mirrors `oci os object list`).

Usage: `nimbus oci os object list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--bucket-name`, `-bn` | text | yes | - | Bucket name |
| `--prefix` | text | no | - | Object name prefix |
| `--namespace`, `--namespace-name`, `-ns` | text | no | - | Namespace (auto-derived) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### os object put

Upload a file as an object (mirrors `oci os object put`).

Usage: `nimbus oci os object put [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--bucket-name`, `-bn` | text | yes | - | Bucket name |
| `--file` | text | yes | - | Local file to upload |
| `--name` | text | no | - | Object name (defaults to the filename) |
| `--size-guard-mb` | integer | no | `1024` | Warn-and-skip guard for large files (Nimbus flag) |
| `--namespace`, `--namespace-name`, `-ns` | text | no | - | Namespace (auto-derived) |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |

### prefs get

Get a single preference value.

Usage: `nimbus oci prefs get [OPTIONS] KEY`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `key` | text | yes | - | Preference key |
| `--tenancy`, `-t` | text | no | - | Tenancy alias |

### prefs list

List all preferences for a tenancy.

Usage: `nimbus oci prefs list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | Tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format |

### prefs set

Set a preference value (upsert).

Usage: `nimbus oci prefs set [OPTIONS] KEY VALUE`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `key` | text | yes | - | Preference key |
| `value` | text | yes | - | Preference value |
| `--tenancy`, `-t` | text | no | - | Tenancy alias |

### rename apply

Apply ICAO naming convention to all OCI resources. Destructive — requires --tenancy.

Usage: `nimbus oci rename apply [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |
| `--force` | boolean | no | `False` | Skip confirmation |

### rename audit

Scan all OCI resources and show ICAO rename plan. No changes made.

Usage: `nimbus oci rename audit [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### rename set-label

Manually set a resource label. Survives future auto-renames.

Usage: `nimbus oci rename set-label [OPTIONS] EXTERNAL_ID LABEL`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `external_id` | text | yes | - | Resource OCID |
| `label` | text | yes | - | Custom label to set |

### seclist add-route

Add a route rule to a route table.

Usage: `nimbus oci seclist add-route [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Route Table OCID |
| `--destination` | text | yes | - | Destination CIDR |
| `--gateway-id` | text | yes | - | Target gateway/entity OCID |
| `--tenancy`, `-t` | text | no | - |  |

### seclist add-rule

Add a rule to a security list (read-modify-write).

Usage: `nimbus oci seclist add-rule [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Security List OCID |
| `--direction`, `-d` | text | yes | - | ingress or egress |
| `--protocol`, `-p` | text | yes | - | tcp/udp/icmp/all |
| `--source` | text | no | - |  |
| `--destination` | text | no | - |  |
| `--port` | integer | no | - |  |
| `--port-max` | integer | no | - |  |
| `--desc` | text | no | `` |  |
| `--tenancy`, `-t` | text | no | - |  |

### seclist remove-route

Remove a route rule by destination CIDR.

Usage: `nimbus oci seclist remove-route [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Route Table OCID |
| `--destination` | text | yes | - | Destination CIDR to remove |
| `--tenancy`, `-t` | text | no | - |  |

### seclist remove-rule

Remove a matching rule from a security list.

Usage: `nimbus oci seclist remove-rule [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Security List OCID |
| `--direction`, `-d` | text | yes | - | ingress or egress |
| `--protocol`, `-p` | text | yes | - |  |
| `--source` | text | no | - |  |
| `--destination` | text | no | - |  |
| `--port` | integer | no | - |  |
| `--tenancy`, `-t` | text | no | - |  |

### seclist routes

Show route rules in a route table.

Usage: `nimbus oci seclist routes [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Route Table OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### seclist show

Show all rules in a security list.

Usage: `nimbus oci seclist show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Security List OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### security audit

Audit OCI network security: security lists, subnets, gateways, routes.

Usage: `nimbus oci security audit [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--severity` | text | no | - | Filter by min severity (CRITICAL/HIGH/MEDIUM/LOW/INFO) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### security protection-audit

Show all protected resources, their policies, and enforcement history.

Usage: `nimbus oci security protection-audit [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### sync resources

Fetch all OCI resources with IPs and persist to CloudResource table.

Usage: `nimbus oci sync resources [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### vm create

Provision a new OCI compute instance (destructive, requires --tenancy).

Usage: `nimbus oci vm create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--label`, `-l` | text | yes | - | Resource label (e.g. web01) |
| `--subnet` | text | yes | - | Subnet OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |
| `--shape` | text | no | `VM.Standard.A1.Flex` | VM shape |
| `--os` | text | no | `Canonical Ubuntu` | OS family for image lookup |
| `--image` | text | no | - | Explicit image OCID; omit to use latest |
| `--ocpus` | float | no | `1` | OCPUs (for flex shapes) |
| `--memory-gbs` | float | no | `6` | Memory GB (for flex shapes) |
| `--boot-volume-gbs` | integer | no | `50` | Boot volume size GB (>= 50) |
| `--block-volume-gbs` | integer | no | `0` | Attached block volume size GB |
| `--ssh-key` | text | no | `` | SSH public key contents |
| `--cloud-init` | text | no | - | Comma-separated cloud-init addons |
| `--dry-run` | boolean | no | `False` | Show what would happen |

### vm get

Get details for a specific OCI instance (read-only, uses active context).

Usage: `nimbus oci vm get [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format |

### vm health

Check health of an OCI instance (read-only, uses active context).

Usage: `nimbus oci vm health [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format |

### vm list

List OCI compute instances (read-only, uses active context).

Usage: `nimbus oci vm list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### vm provision arm

Provision an OCI ARM VM with composed cloud-init (single attempt).

Usage: `nimbus oci vm provision arm [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--config` | text | no | `` | Path to provision config JSON (default: engine/scripts/arm_poller_config.json) |
| `--dry-run` | boolean | no | `False` | Show cloud-init without launching |

### vm provision x86

Provision an OCI x86 Micro VM with composed cloud-init.

Usage: `nimbus oci vm provision x86 [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--config` | text | no | `` | Path to provision config JSON (default: engine/scripts/arm_poller_config.json) |
| `--dry-run` | boolean | no | `False` | Show cloud-init without launching |

### vm reinstall

Reinstall OS with latest FULL Ubuntu. Replaces boot volume.

Usage: `nimbus oci vm reinstall [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |
| `--preserve-old-bv`, `--no-preserve-old-bv` | boolean | no | `True` | Keep old boot volume |
| `--force` | boolean | no | `False` | Skip confirmation (x86 only) |
| `--dry-run` | boolean | no | `False` | Show what would happen |

### vm set-bastion

Designate a VM as the bastion SSH endpoint. Adds protection policy.

Usage: `nimbus oci vm set-bastion [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |

### vm start

Start a stopped OCI instance (destructive, requires --tenancy).

Usage: `nimbus oci vm start [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |

### vm stop

Stop a running OCI instance (destructive, requires --tenancy).

Usage: `nimbus oci vm stop [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED for destructive ops) |
| `--dry-run` | boolean | no | `False` | Show what would happen |

### vm terminate

Terminate an OCI instance (destructive, irreversible, requires --tenancy).

Usage: `nimbus oci vm terminate [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED for destructive ops) |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--dry-run` | boolean | no | `False` | Show what would happen |

### vm unset-bastion

Remove bastion designation from a VM. Requires typed confirmation.

Usage: `nimbus oci vm unset-bastion [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Instance OCID |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |

### volume list

List OCI boot and block volumes.

Usage: `nimbus oci volume list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | OCI provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### volume quota

Check storage quota against OCI Always Free tier limit (200 GB).

Usage: `nimbus oci volume quota [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | OCI provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |
