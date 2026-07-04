---
title: "nimbus orchestrate"
sidebar:
  order: 21
---

Cross-cloud orchestration workflows.

## Commands

### dns-failover

Update DNS to failover to a new IP.

Usage: `nimbus orchestrate dns-failover [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-id` | text | yes | - | Resource ID to failover |
| `--dns-provider` | text | yes | - | DNS provider ID |
| `--zone-id` | text | yes | - | DNS zone ID |
| `--record-id` | text | yes | - | DNS record ID to update |
| `--new-ip` | text | yes | - | New IP address |
| `--record-name` | text | yes | - | DNS record name |

### lockdown

Emergency lockdown — stop all non-critical resources for a provider.

Usage: `nimbus orchestrate lockdown [OPTIONS] PROVIDER_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `provider_id` | text | yes | - | Provider ID to lock down |

### vm-dns

Provision a VM and create a DNS record pointing to it.

Usage: `nimbus orchestrate vm-dns [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--vm-provider` | text | yes | - | VM provider ID |
| `--dns-provider` | text | yes | - | DNS provider ID |
| `--vm-name` | text | yes | - | VM display name |
| `--zone-id` | text | yes | - | DNS zone ID |
| `--record-name` | text | yes | - | DNS record name |
| `--vm-type` | text | no | `instance` | VM resource type |
