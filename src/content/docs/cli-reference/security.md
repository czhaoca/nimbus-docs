---
title: "nimbus security"
sidebar:
  order: 27
---

Cross-cutting security surfaces.

## Commands

### review dismiss

Dismiss a finding (terminal-safe; promoted findings refused).

Usage: `nimbus security review dismiss [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | integer | yes | - | Finding ID |
| `--note` | text | no | `` | Why it is dismissed |

### review list

List persisted findings.

Usage: `nimbus security review list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--status` | text | no | `` | open\|acknowledged\|dismissed\|promoted |
| `--severity` | text | no | `` | CRITICAL..INFO |
| `--run-id` | text | no | `` | Limit to one run |
| `--limit` | integer | no | `100` | Max rows |

### review promote

Promote an allow-listed finding into a staged resolution proposal.

Usage: `nimbus security review promote [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | integer | yes | - | Finding ID |
| `--allocation-id` | integer | yes | - | Target allocation |
| `--proposed-ip` | text | no | `` | For fixed_ip kinds |
| `--proposed-vlan-id` | integer | no | - | For vlan_reassign kinds |
| `--proposed-cidr` | text | no | `` | Target CIDR |
| `--note` | text | no | `` | Audit note |

### review run

Run the review across the given providers (dry-run preview, then confirm).

Usage: `nimbus security review run [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cloudflare` | text | no | `` | Cloudflare provider ID |
| `--unifi` | text | no | `` | UniFi provider ID |
| `--proxmox` | text | no | `` | Proxmox provider ID |
| `--dry-run` | boolean | no | `False` | Counts only; persist nothing |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### review show

Show one finding in full (message + remediation).

Usage: `nimbus security review show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | integer | yes | - | Finding ID |
