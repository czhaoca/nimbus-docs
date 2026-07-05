---
title: "nimbus network"
sidebar:
  order: 12
---

Network CIDR planning and subnet management.

## Commands

### allocate

Allocate a subnet from a provider's CIDR policy.

Usage: `nimbus network allocate [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | yes | - | Provider type |
| `--env` | text | no | `default` | Environment label; use dev/prod for governed slots |
| `--tenancy` | text | no | `` | Tenancy alias |
| `--prefix` | integer | no | - | Override subnet prefix |

### allocations

List all CIDR allocations across providers.

Usage: `nimbus network allocations [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Filter by provider type |
| `--status` | text | no | - | Filter by status (planned/active/etc) |

### blocklist add

Block a CIDR range from all planning paths.

Usage: `nimbus network blocklist add [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cidr` | text | yes | - | CIDR block to refuse in planning |
| `--reason` | text | yes | - | Why it is blocked: provider-default\|external-network\|infra-reserved\|policy\|other |
| `--note` | text | no | `` | Free-text context for the block |

### blocklist list

List blocklist entries.

Usage: `nimbus network blocklist list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--all` | boolean | no | `False` | Include removed (inactive) entries |

### blocklist remove

Remove (soft-delete) a blocklist entry — the only enforcement override.

Usage: `nimbus network blocklist remove [OPTIONS] TARGET`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `target` | text | yes | - | Blocklist entry ID or CIDR |

### blocklist seed

Seed well-known public ranges (cloud VPC defaults, Docker, CGNAT, routers).

Usage: `nimbus network blocklist seed [OPTIONS]`

_No options._

### check

Check a CIDR block against existing allocations and the blocklist.

Usage: `nimbus network check [OPTIONS] CIDR`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `cidr` | text | yes | - | CIDR block to check (RFC1918 /24 or larger) |

### conflicts

List allocations that conflict with the CIDR blocklist.

Usage: `nimbus network conflicts [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--rescan` | boolean | no | `False` | Recompute conflict flags before listing |

### device expose

Toggle WARP exposure for a device (/32) or an allocation (whole VLAN).

Usage: `nimbus network device expose [OPTIONS] DEVICE_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `device_id` | integer | no | - | Device id (omit if --allocation) |
| `--allocation` | integer | no | - | Expose a whole VLAN/allocation id |
| `--off` | boolean | no | `False` | Disable exposure instead of enabling |

### device list

List registered network devices.

Usage: `nimbus network device list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--exposed` | boolean | no | `False` | Only WARP-exposed devices |

### device tag

Set a device's tags and/or categories.

Usage: `nimbus network device tag [OPTIONS] DEVICE_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `device_id` | integer | yes | - | Device id |
| `--tag` | text | no | - | Tag (repeatable) |
| `--category` | text | no | - | Category (repeatable) |

### hosts list

List all hosts across Proxmox and UniFi.

Usage: `nimbus network hosts list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Filter by provider (proxmox, unifi) |
| `--vlan` | integer | no | - | Filter by VLAN ID |
| `--static-only` | boolean | no | `False` | Show only hosts with static IPs |

### hosts map

Show network map grouped by subnet.

Usage: `nimbus network hosts map [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Filter by provider |

### next-ip

Show the next available host IP in an allocation.

Usage: `nimbus network next-ip [OPTIONS] ALLOCATION`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `allocation` | integer | yes | - | Allocation ID (see 'nimbus network allocations') |

### plan decommission

Mark an allocation as decommissioning.

Usage: `nimbus network plan decommission [OPTIONS] ALLOCATION_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `allocation_id` | integer | yes | - | Allocation ID to decommission |

### plan diff

Compare planned allocations against active ones.

Usage: `nimbus network plan diff [OPTIONS]`

_No options._

### plan promote

Promote a planned allocation to a new status.

Usage: `nimbus network plan promote [OPTIONS] ALLOCATION_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `allocation_id` | integer | yes | - | Allocation ID to promote |
| `--to` | text | no | `active` | Target status (provisioning/active) |

### plan show

Display the CIDR allocation tree.

Usage: `nimbus network plan show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Filter by provider |
| `--status` | text | no | - | Filter by status |

### plan tree

Export the full CIDR plan as JSON or tree.

Usage: `nimbus network plan tree [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Filter by provider |
| `--format` | text | no | `tree` | Output format: json or tree |

### policies

List CIDR policies per provider.

Usage: `nimbus network policies [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Filter by provider type |

### provision-home

Provision a new home/site: carve a base block into the standard VLAN layout.

Usage: `nimbus network provision-home [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--site` | text | yes | - | Site label (e.g. home-2) |
| `--base` | text | yes | - | Base CIDR to carve (e.g. 10.x.0.0/22) |
| `--vlan-prefix` | integer | no | `26` | Prefix length for each VLAN subnet |
| `--template` | text | no | `standard` | VLAN template ('standard' = 5 VLANs) |
| `--vlan` | text | no | - | Override VLAN set as 'id:name' (repeatable) |
| `--provider` | text | no | `unifi` | Provider type |
| `--dry-run` | boolean | no | `False` | Show the carve without registering |

### register

Register a CIDR block allocation with lifecycle status.

Usage: `nimbus network register [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | yes | - | Provider type |
| `--cidr` | text | yes | - | CIDR block |
| `--name` | text | no | `` | Network display name |
| `--site` | text | no | `` | Site label (e.g. home-yvr) |
| `--vlan` | integer | no | - | VLAN ID |
| `--status` | text | no | `active` | Status (planned/active) |
| `--parent` | integer | no | - | Parent allocation ID |
| `--gateway` | text | no | `` | Gateway IP |
| `--region` | text | no | `` | Region |
| `--record-existing` | boolean | no | `False` | Record pre-existing topology: blocklist overlaps flag a conflict, not refusal |

### reserve-ip

Reserve a fixed IP inside a network allocation.

Usage: `nimbus network reserve-ip [OPTIONS] ALLOCATION IP`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `allocation` | integer | yes | - | Allocation ID (see 'nimbus network allocations') |
| `ip` | text | yes | - | IP address inside the allocation CIDR |
| `--source` | text | no | `manual` | Reservation source (topology\|unifi\|manual) |
| `--label` | text | no | `` | Human-readable label |
| `--mac` | text | no | `` | Client MAC address (Phase 10.8 DHCP write-back key) |

### resolution apply

Enforce approved proposals in blast-radius order (preview then confirm).

Usage: `nimbus network resolution apply [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--apply-manual` | boolean | no | `False` | Also apply manual-gated steps (after the reboot/DHCP step) |
| `--dry-run` | boolean | no | `False` | Preview the ordered plan only |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### resolution approve

Approve a staged proposal (ready for enforcement).

Usage: `nimbus network resolution approve [OPTIONS] PROPOSAL_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `proposal_id` | integer | yes | - | Proposal id |
| `--note` | text | no | `` | Decision note |

### resolution list

List staged resolution proposals.

Usage: `nimbus network resolution list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--status` | text | no | `` | Filter by status |

### resolution plan

Stage proposals for blocked-CIDR conflicts in scope (preview then confirm).

Usage: `nimbus network resolution plan [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--base` | text | no | `` | Base CIDR to suggest replacements from |
| `--prefix` | integer | no | `24` | Replacement block prefix size |
| `--dry-run` | boolean | no | `False` | Preview only, stage nothing |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### resolution reject

Reject a staged proposal (it will not be enforced).

Usage: `nimbus network resolution reject [OPTIONS] PROPOSAL_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `proposal_id` | integer | yes | - | Proposal id |
| `--note` | text | no | `` | Decision note |

### scope add

Add a network (or a whole provider type) to the resolution scope.

Usage: `nimbus network scope add [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--allocation` | integer | no | `0` | Allocation id to include |
| `--provider-type` | text | no | `` | Include all active allocations of this type |
| `--note` | text | no | `` | Free-text context |

### scope list

List scope entries and the resolved network count.

Usage: `nimbus network scope list [OPTIONS]`

_No options._

### scope remove

Remove a scope entry by id.

Usage: `nimbus network scope remove [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | integer | yes | - | Scope entry id to remove |

### seed-home

Seed home/lab VLAN allocations into the registry (idempotent).

Usage: `nimbus network seed-home [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--file` | path | no | - | YAML/JSON VLAN config (.yaml/.yml/.json) with a 'vlans' list |
| `--cidr` | text | no | - | Inline entry: CIDR block (gateway-form accepted) |
| `--vlan` | integer | no | - | Inline entry: VLAN ID |
| `--gateway` | text | no | `` | Inline entry: gateway IP |
| `--name` | text | no | `` | Inline entry: network display name |
| `--site` | text | no | `` | Inline entry: site label (e.g. home-yvr) |
| `--provider` | text | no | `unifi` | Inline entry: provider type |
| `--parent` | text | no | `` | Inline entry: parent allocation CIDR |
| `--fail-fast` | boolean | no | `False` | Abort on the first collision instead of reporting all |

### set-policy

Set a CIDR policy for a provider/tenancy.

Usage: `nimbus network set-policy [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | yes | - | Provider type |
| `--cidr` | text | yes | - | Base CIDR block (format: \<ip>/\<prefix>) |
| `--tenancy` | text | no | `` | Tenancy alias |
| `--prefix` | integer | no | `24` | Default subnet prefix size |
| `--desc` | text | no | `` | Policy description |

### suggest

Suggest the next available CIDR block.

Usage: `nimbus network suggest [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--prefix` | integer | no | `24` | Desired prefix size |
| `--base` | text | no | - | Base range to search (defaults to the nimbus-global policy base) |

### tunnel apply

Converge sites: connector ensure → UniFi permit (gated) → CF routes (two-phase).

Usage: `nimbus network tunnel apply [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | Cloudflare provider ID |
| `--unifi-provider` | text | no | `` | UniFi provider ID (permit checks skipped if unset) |
| `--site` | text | no | `` | Limit to one site |
| `--provision` | boolean | no | `False` | Allow LXC creation in the connector step |
| `--prune` | boolean | no | `False` | Allow MANAGED route deletion in the route step |
| `--yes-firewall` | boolean | no | `False` | Confirm UniFi permit-rule writes |
| `--ostemplate` | text | no | `` | LXC template (only when --provision creates) |
| `--tunnel-id` | text | no | `` | Route apply target (auto if one site) |
| `--dry-run` | boolean | no | `False` | Preview the step plan |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### tunnel drift

Drift entries only (route/connector/permit/site-cidr classes).

Usage: `nimbus network tunnel drift [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | Cloudflare provider ID |
| `--unifi-provider` | text | no | `` | UniFi provider ID (permit checks skipped if unset) |

### tunnel plan

Full per-site checklist: connector health, route delta, permit delta, drift.

Usage: `nimbus network tunnel plan [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | Cloudflare provider ID |
| `--unifi-provider` | text | no | `` | UniFi provider ID (permit checks skipped if unset) |

### tunnel status

Converged/drift-count summary of the tunnel plan.

Usage: `nimbus network tunnel status [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | Cloudflare provider ID |
| `--unifi-provider` | text | no | `` | UniFi provider ID (permit checks skipped if unset) |
