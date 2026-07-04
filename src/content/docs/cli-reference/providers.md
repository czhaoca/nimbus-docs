---
title: "nimbus providers"
sidebar:
  order: 23
---

Manage cloud providers.

## Commands

### add

Register a new provider.

Usage: `nimbus providers add [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Unique provider ID |
| `--type` | text | yes | - | Provider type |
| `--name` | text | yes | - | Display name |
| `--region` | text | no | `` | Cloud region |
| `--instance-index` | integer range | no | `0` | Credential instance index. Use 1 for numbered env vars like PROXMOX_1_*. |
| `--credentials` | text | no | `` | Credential file path. Optional when using env/Infisical secrets. |

### list

List registered providers.

Usage: `nimbus providers list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--format`, `-f` | text | no | `table` | Output format (table/json/yaml) |

### rename

Rename a provider's id (its CLI alias), re-pointing all references.

Usage: `nimbus providers rename [OPTIONS] OLD_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `old_id` | text | yes | - | Current provider ID (alias) |
| `--to` | text | yes | - | New provider ID (alias) |
| `--region` | text | no | `` | Optionally update the region/site label |
| `--name` | text | no | `` | Optionally update the display name |

### update

Update a provider's display name and/or region.

Usage: `nimbus providers update [OPTIONS] PROVIDER_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `provider_id` | text | yes | - | Provider ID to update |
| `--name` | text | no | `` | New display name |
| `--region` | text | no | `` | New region/site label |
