---
title: "nimbus pve"
sidebar:
  order: 24
---

Manage Proxmox VE resources (containers, VMs, nodes).

## Commands

### context clear

Clear the active Proxmox provider context.

Usage: `nimbus pve context clear [OPTIONS]`

_No options._

### context set

Set the active Proxmox provider context.

Usage: `nimbus pve context set [OPTIONS] PROVIDER_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `provider_id` | text | yes | - | Proxmox provider ID to activate |

### context show

Show the current active Proxmox provider context.

Usage: `nimbus pve context show [OPTIONS]`

_No options._

### ct clone

Clone an LXC template container.

Usage: `nimbus pve ct clone [OPTIONS] SRC_CTID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `src_ctid` | integer | yes | - | Source/template container VMID |
| `--new-id` | integer | no | - | New container VMID (auto-allocated if omitted) |
| `--hostname`, `-n` | text | no | `` | New container hostname |
| `--storage` | text | no | `local-zfs` | Storage pool |
| `--vlan` | integer | no | - | VLAN tag for the cloned NIC |
| `--start`, `--no-start` | boolean | no | `True` | Auto-start after clone |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### ct config

Show full container configuration.

Usage: `nimbus pve ct config [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ct create

Create a new LXC container. Provide either --hostname or --label.

Usage: `nimbus pve ct create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--template` | text | yes | - | OS template volid |
| `--hostname`, `-n` | text | no | - | Container hostname (required if no --label) |
| `--label` | text | no | - | ICAO label. Expands via generate_name() into 'proxmox-{geo}-ct-{label}'. |
| `--ip` | text | no | `dhcp` | IP config (dhcp or \<ip>/\<prefix>) |
| `--gw` | text | no | `` | Gateway IP |
| `--cores` | integer | no | `1` | CPU cores |
| `--memory` | integer | no | `512` | Memory in MB |
| `--swap` | integer | no | `256` | Swap in MB |
| `--disk` | integer | no | `8` | Root disk size in GB |
| `--storage` | text | no | `local-zfs` | Storage pool |
| `--nameserver` | text | no | `` | DNS nameserver |
| `--ssh-key` | text | no | `` | Path to SSH public key file |
| `--start`, `--no-start` | boolean | no | `True` | Auto-start after create |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### ct delete

Stop and destroy a container (legacy `ct destroy` aliases here).

Usage: `nimbus pve ct delete [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--quiet`, `--force` | boolean | no | `False` | Skip confirmation prompt |

### ct describe

Show container status (legacy `ct get` aliases here).

Usage: `nimbus pve ct describe [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ct destroy

> ⚠️ **Deprecated.**

Stop and destroy a container (legacy `ct destroy` aliases here).

Usage: `nimbus pve ct destroy [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--quiet`, `--force` | boolean | no | `False` | Skip confirmation prompt |

### ct get

> ⚠️ **Deprecated.**

Show container status (legacy `ct get` aliases here).

Usage: `nimbus pve ct get [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ct list

List all LXC containers.

Usage: `nimbus pve ct list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ct resize

Resize a container's CPU/memory allocation (disk resize not yet supported).

Usage: `nimbus pve ct resize [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--cores` | integer | no | - | CPU cores |
| `--memory` | integer | no | - | Memory in MB |
| `--swap` | integer | no | - | Swap in MB |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### ct set-ip

Set a static IP on a container's network interface.

Usage: `nimbus pve ct set-ip [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--ip` | text | yes | - | Static IP with CIDR (format: \<ip>/\<prefix>) |
| `--gw` | text | yes | - | Gateway IP (format: \<ip-address>) |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### ct start

Start a container.

Usage: `nimbus pve ct start [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### ct stop

Stop a container.

Usage: `nimbus pve ct stop [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### lxc clone

Clone an LXC template container.

Usage: `nimbus pve lxc clone [OPTIONS] SRC_CTID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `src_ctid` | integer | yes | - | Source/template container VMID |
| `--new-id` | integer | no | - | New container VMID (auto-allocated if omitted) |
| `--hostname`, `-n` | text | no | `` | New container hostname |
| `--storage` | text | no | `local-zfs` | Storage pool |
| `--vlan` | integer | no | - | VLAN tag for the cloned NIC |
| `--start`, `--no-start` | boolean | no | `True` | Auto-start after clone |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### lxc config

Show full container configuration.

Usage: `nimbus pve lxc config [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### lxc create

Create a new LXC container. Provide either --hostname or --label.

Usage: `nimbus pve lxc create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--template` | text | yes | - | OS template volid |
| `--hostname`, `-n` | text | no | - | Container hostname (required if no --label) |
| `--label` | text | no | - | ICAO label. Expands via generate_name() into 'proxmox-{geo}-ct-{label}'. |
| `--ip` | text | no | `dhcp` | IP config (dhcp or \<ip>/\<prefix>) |
| `--gw` | text | no | `` | Gateway IP |
| `--cores` | integer | no | `1` | CPU cores |
| `--memory` | integer | no | `512` | Memory in MB |
| `--swap` | integer | no | `256` | Swap in MB |
| `--disk` | integer | no | `8` | Root disk size in GB |
| `--storage` | text | no | `local-zfs` | Storage pool |
| `--nameserver` | text | no | `` | DNS nameserver |
| `--ssh-key` | text | no | `` | Path to SSH public key file |
| `--start`, `--no-start` | boolean | no | `True` | Auto-start after create |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### lxc delete

Stop and destroy a container (legacy `ct destroy` aliases here).

Usage: `nimbus pve lxc delete [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--quiet`, `--force` | boolean | no | `False` | Skip confirmation prompt |

### lxc describe

Show container status (legacy `ct get` aliases here).

Usage: `nimbus pve lxc describe [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### lxc destroy

> ⚠️ **Deprecated.**

Stop and destroy a container (legacy `ct destroy` aliases here).

Usage: `nimbus pve lxc destroy [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--quiet`, `--force` | boolean | no | `False` | Skip confirmation prompt |

### lxc get

> ⚠️ **Deprecated.**

Show container status (legacy `ct get` aliases here).

Usage: `nimbus pve lxc get [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### lxc list

List all LXC containers.

Usage: `nimbus pve lxc list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### lxc resize

Resize a container's CPU/memory allocation (disk resize not yet supported).

Usage: `nimbus pve lxc resize [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--cores` | integer | no | - | CPU cores |
| `--memory` | integer | no | - | Memory in MB |
| `--swap` | integer | no | - | Swap in MB |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### lxc set-ip

Set a static IP on a container's network interface.

Usage: `nimbus pve lxc set-ip [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--ip` | text | yes | - | Static IP with CIDR (format: \<ip>/\<prefix>) |
| `--gw` | text | yes | - | Gateway IP (format: \<ip-address>) |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### lxc start

Start a container.

Usage: `nimbus pve lxc start [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### lxc stop

Stop a container.

Usage: `nimbus pve lxc stop [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### network bridge check

Check whether a bridge is VLAN-aware.

Usage: `nimbus pve network bridge check [OPTIONS] BRIDGE`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `bridge` | text | no | `vmbr0` | Bridge name |
| `--node` | text | no | - | Target node (defaults to the provider's node) |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### network vlan set

Set the VLAN tag on a VM/LXC network interface.

Usage: `nimbus pve network vlan set [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | VM/container VMID |
| `--vlan` | integer | yes | - | VLAN tag ID |
| `--nic` | text | no | `net0` | NIC to tag |
| `--node` | text | no | - | Target node (defaults to the provider's node) |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### node describe

Show current node resource usage (legacy `node status` aliases here).

Usage: `nimbus pve node describe [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### node list

List cluster nodes.

Usage: `nimbus pve node list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### node status

> ⚠️ **Deprecated.**

Show current node resource usage (legacy `node status` aliases here).

Usage: `nimbus pve node status [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### node storage

> ⚠️ **Deprecated.**

List storage pools.

Usage: `nimbus pve node storage [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--node` | text | no | - | Target node (defaults to the provider's node) |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### node templates

> ⚠️ **Deprecated.**

List available OS templates.

Usage: `nimbus pve node templates [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--storage` | text | no | `local` | Storage pool name |
| `--node` | text | no | - | Target node (defaults to the provider's node) |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### ops layout-apply

Apply declared LXC layout to Proxmox — rename, resize, and create containers.

Usage: `nimbus pve ops layout-apply [OPTIONS]`

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

Usage: `nimbus pve ops layout-diff [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--config` | text | yes | - | Path to lxc-layout.yml |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### ops reprovision

Reprovision a container: stop → destroy → create with same config → start.

Usage: `nimbus pve ops reprovision [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | Container VMID to reprovision |
| `--template` | text | yes | - | OS template volid |
| `--ssh-key` | text | no | `` | Path to SSH public key file |
| `--storage` | text | no | `local-zfs` | Storage pool |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### ops show-all

Show all containers and VMs with their status.

Usage: `nimbus pve ops show-all [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format |

### ops wg-init

Deploy WireGuard mesh overlay across all running LXCs.

Usage: `nimbus pve ops wg-init [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--subnet` | text | yes | - | Overlay subnet CIDR (required) |
| `--ssh-key` | text | no | `` | SSH private key path |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### storage list

List storage pools.

Usage: `nimbus pve storage list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--node` | text | no | - | Target node (defaults to the provider's node) |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### storage templates list

List available OS templates.

Usage: `nimbus pve storage templates list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--storage` | text | no | `local` | Storage pool name |
| `--node` | text | no | - | Target node (defaults to the provider's node) |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### vm create

Create a QEMU VM (from scratch, ISO, or by cloning a template).

Usage: `nimbus pve vm create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | no | - | VM name |
| `--vmid` | integer | no | - | VMID (auto-allocated if omitted) |
| `--memory` | integer | no | `2048` | Memory in MB |
| `--cores` | integer | no | `2` | CPU cores |
| `--sockets` | integer | no | `1` | CPU sockets |
| `--ostype` | text | no | `l26` | Guest OS type |
| `--storage` | text | no | `local-lvm` | Storage pool |
| `--disk` | integer | no | `32` | Disk size in GB |
| `--net` | text | no | `virtio,bridge=vmbr0` | NIC model/bridge |
| `--vlan` | integer | no | - | VLAN tag |
| `--iso` | text | no | `` | Install ISO volid |
| `--clone` | integer | no | - | Template VMID to clone |
| `--ci-user` | text | no | `` | cloud-init user |
| `--ci-ip` | text | no | `` | cloud-init ipconfig0 (e.g. ip=dhcp) |
| `--start`, `--no-start` | boolean | no | `False` | Auto-start after create |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### vm delete

Stop and destroy a QEMU VM.

Usage: `nimbus pve vm delete [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | VM ID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--quiet`, `--force` | boolean | no | `False` | Skip confirmation prompt |

### vm describe

Show VM status (legacy `vm get` aliases here).

Usage: `nimbus pve vm describe [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | VM ID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### vm get

> ⚠️ **Deprecated.**

Show VM status (legacy `vm get` aliases here).

Usage: `nimbus pve vm get [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | VM ID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### vm list

List all QEMU VMs.

Usage: `nimbus pve vm list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### vm start

Start a VM.

Usage: `nimbus pve vm start [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | VM ID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |

### vm stop

Gracefully shut down a VM.

Usage: `nimbus pve vm stop [OPTIONS] VMID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `vmid` | integer | yes | - | VM ID |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
