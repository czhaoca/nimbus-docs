---
title: "nimbus-admin pve"
sidebar:
  order: 12
---

Manage Proxmox VE resources (residual in-engine commands).

## Commands

### context clear

Clear the active Proxmox provider context.

Usage: `nimbus-admin pve context clear [OPTIONS]`

_No options._

### context set

Set the active Proxmox provider context.

Usage: `nimbus-admin pve context set [OPTIONS] PROVIDER_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `provider_id` | text | yes | - | Proxmox provider ID to activate |

### context show

Show the current active Proxmox provider context.

Usage: `nimbus-admin pve context show [OPTIONS]`

_No options._

### ops layout-apply

Apply declared LXC layout to Proxmox — rename, resize, and create containers.

Usage: `nimbus-admin pve ops layout-apply [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--config` | text | yes | - | Path to lxc-layout.yml |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--ostemplate` | text | no | `` | OS template for new containers |
| `--storage` | text | no | `local-zfs` | Storage pool |
| `--ssh-key` | text | no | `` | Path to SSH public key file |
| `--force` | boolean | no | `False` | Skip confirmation |

### ops layout-diff

Show drift between declared LXC layout and actual Proxmox state.

Usage: `nimbus-admin pve ops layout-diff [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--config` | text | yes | - | Path to lxc-layout.yml |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### ops reprovision

Reprovision a container: stop → destroy → create with same config → start.

Usage: `nimbus-admin pve ops reprovision [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID to reprovision |
| `--template` | text | yes | - | OS template volid |
| `--ssh-key` | text | no | `` | Path to SSH public key file |
| `--storage` | text | no | `local-zfs` | Storage pool |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### ops show-all

Show all containers and VMs with their status.

Usage: `nimbus-admin pve ops show-all [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format |

### ops wg-init

Deploy WireGuard mesh overlay across all running LXCs.

Usage: `nimbus-admin pve ops wg-init [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--subnet` | text | yes | - | Overlay subnet CIDR (required) |
| `--ssh-key` | text | no | `` | SSH private key path |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
