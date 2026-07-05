---
title: "nimbus-admin oci"
sidebar:
  order: 12
---

Manage Oracle Cloud Infrastructure resources.

## Commands

### compute instance launch

Launch a compute instance (mirrors `oci compute instance launch`).

Usage: `nimbus-admin oci compute instance launch [OPTIONS]`

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

### harden run

Audit and remediate OCI network security findings.

Usage: `nimbus-admin oci harden run [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |
| `--min-severity` | text | no | `MEDIUM` | Min severity (CRITICAL/HIGH/MEDIUM) |
| `--apply` | boolean | no | `False` | Execute fixes (dry-run by default) |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### migrate cidr

Add new CIDR to VCN, create subnet, attach secondary VNICs with planned IPs.

Usage: `nimbus-admin oci migrate cidr [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - |  |
| `--cidr` | text | no | `` | New CIDR block (required) |
| `--subnet-name` | text | no | - | Override subnet display name |
| `--dry-run` | boolean | no | `False` |  |
| `--format`, `-f` | text | no | `table` |  |

### migrate cleanup-old

Remove old CIDR and subnet after migration. Requires manual VNIC detach first.

Usage: `nimbus-admin oci migrate cleanup-old [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - |  |
| `--old-cidr` | text | no | `` | CIDR block to remove (required) |
| `--force` | boolean | no | `False` |  |

### network create-subnet

> ⚠️ **Deprecated.**

Create a subnet within a VCN with CIDR collision checking.

Usage: `nimbus-admin oci network create-subnet [OPTIONS]`

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

Usage: `nimbus-admin oci network create-vcn [OPTIONS]`

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

Usage: `nimbus-admin oci network list-subnets [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--vcn` | text | no | - | Filter by VCN OCID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### network list-vcns

> ⚠️ **Deprecated.**

List all VCNs in the tenancy.

Usage: `nimbus-admin oci network list-vcns [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### nsg add-rule

Add a security rule to an NSG.

Usage: `nimbus-admin oci nsg add-rule [OPTIONS]`

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

Usage: `nimbus-admin oci nsg attach [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | NSG OCID |
| `--vnic-id` | text | yes | - | VNIC OCID |
| `--tenancy`, `-t` | text | no | - |  |

### nsg create

Create a Network Security Group with ICAO naming.

Usage: `nimbus-admin oci nsg create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--label`, `-l` | text | yes | - | ICAO label |
| `--vcn` | text | yes | - | VCN OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--dry-run` | boolean | no | `False` |  |

### nsg delete

Delete a Network Security Group.

Usage: `nimbus-admin oci nsg delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | NSG OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--force` | boolean | no | `False` |  |

### nsg list

List Network Security Groups.

Usage: `nimbus-admin oci nsg list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - |  |
| `--vcn` | text | no | - | VCN OCID (auto-detected) |
| `--format`, `-f` | text | no | `table` |  |

### nsg remove-rule

Remove a security rule from an NSG by its OCID.

Usage: `nimbus-admin oci nsg remove-rule [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | NSG OCID |
| `--rule-id` | text | yes | - | Rule OCID to remove |
| `--tenancy`, `-t` | text | no | - |  |

### nsg rules

Show security rules in an NSG.

Usage: `nimbus-admin oci nsg rules [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | NSG OCID |
| `--tenancy`, `-t` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### rename apply

Apply ICAO naming convention to all OCI resources. Destructive — requires --tenancy.

Usage: `nimbus-admin oci rename apply [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias (REQUIRED) |
| `--force` | boolean | no | `False` | Skip confirmation |

### rename audit

Scan all OCI resources and show ICAO rename plan. No changes made.

Usage: `nimbus-admin oci rename audit [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### rename set-label

Manually set a resource label. Survives future auto-renames.

Usage: `nimbus-admin oci rename set-label [OPTIONS] EXTERNAL_ID LABEL`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `external_id` | text | yes | - | Resource OCID |
| `label` | text | yes | - | Custom label to set |

### security audit

Audit OCI network security: security lists, subnets, gateways, routes.

Usage: `nimbus-admin oci security audit [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--severity` | text | no | - | Filter by min severity (CRITICAL/HIGH/MEDIUM/LOW/INFO) |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### security protection-audit

Show all protected resources, their policies, and enforcement history.

Usage: `nimbus-admin oci security protection-audit [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--tenancy`, `-t` | text | no | - | OCI tenancy alias |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### vm create

Provision a new OCI compute instance (destructive, requires --tenancy).

Usage: `nimbus-admin oci vm create [OPTIONS]`

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

### vm provision arm

Provision an OCI ARM VM with composed cloud-init (single attempt).

Usage: `nimbus-admin oci vm provision arm [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--config` | text | no | `` | Path to provision config JSON (default: engine/scripts/arm_poller_config.json) |
| `--dry-run` | boolean | no | `False` | Show cloud-init without launching |

### vm provision x86

Provision an OCI x86 Micro VM with composed cloud-init.

Usage: `nimbus-admin oci vm provision x86 [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--config` | text | no | `` | Path to provision config JSON (default: engine/scripts/arm_poller_config.json) |
| `--dry-run` | boolean | no | `False` | Show cloud-init without launching |

### volume list

List OCI boot and block volumes.

Usage: `nimbus-admin oci volume list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | OCI provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### volume quota

Check storage quota against OCI Always Free tier limit (200 GB).

Usage: `nimbus-admin oci volume quota [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | OCI provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |
