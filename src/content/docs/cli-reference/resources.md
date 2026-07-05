---
title: "nimbus resources"
sidebar:
  order: 17
---

Manage cloud resources.

## Commands

### batch

Perform batch actions on multiple resources.

Usage: `nimbus resources batch [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--action` | text | yes | - | Action: start/stop/terminate |
| `--ids` | text | yes | - | Comma-separated resource IDs |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--dry-run` | boolean | no | `False` | Show what would happen |

### create

Interactively create a new resource.

Usage: `nimbus resources create [OPTIONS]`

_No options._

### delete

Delete a tracked resource by ID.

Usage: `nimbus resources delete [OPTIONS] RESOURCE_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `resource_id` | text | yes | - | Resource ID to delete |
| `--force` | boolean | no | `False` | Skip confirmation |
| `--dry-run` | boolean | no | `False` | Show what would happen |

### list

List tracked resources.

Usage: `nimbus resources list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Filter by provider ID |
| `--type` | text | no | - | Filter by resource type |
| `--format`, `-f` | text | no | `table` | Output format (table/json/yaml) |

### search

Search resources by name, tags, or provider.

Usage: `nimbus resources search [OPTIONS] TERM`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `term` | text | yes | - | Search term |

### sync

Sync resources from a cloud provider.

Usage: `nimbus resources sync [OPTIONS] PROVIDER_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `provider_id` | text | yes | - | Provider ID to sync from |
