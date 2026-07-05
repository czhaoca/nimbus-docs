---
title: "nimbus cloudflare"
sidebar:
  order: 5
---

Manage Cloudflare DNS, tunnels, Zero Trust, and network resources.

## Commands

### device create-posture

Create a device posture rule.

Usage: `nimbus cloudflare device create-posture [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Rule name |
| `--type` | text | yes | - | Posture type (disk_encryption, os_version, etc) |
| `--config` | text | yes | - | Input config as JSON string |
| `--description` | text | no | `` | Rule description |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### device list

List enrolled WARP devices.

Usage: `nimbus cloudflare device list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### device posture

List device posture rules.

Usage: `nimbus cloudflare device posture [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### device revoke

Revoke an enrolled device.

Usage: `nimbus cloudflare device revoke [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--device-id` | text | yes | - | Device ID to revoke |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--force` | boolean | no | `False` | Skip confirmation |

### device settings

Show WARP device settings.

Usage: `nimbus cloudflare device settings [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `json` | Output format (table/json) |

### dns create

Create a DNS record.

Usage: `nimbus cloudflare dns create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--zone-id` | text | yes | - | Cloudflare zone ID |
| `--type` | text | yes | - | Record type (A/AAAA/CNAME/TXT) |
| `--name` | text | yes | - | DNS record name |
| `--content` | text | yes | - | DNS record content |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--proxied`, `--dns-only` | boolean | no | `True` |  |
| `--ttl` | integer | no | `1` | TTL (1 = auto) |

### dns delete

Delete a DNS record.

Usage: `nimbus cloudflare dns delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--record-id` | text | yes | - | DNS record ID |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--force` | boolean | no | `False` | Skip confirmation |

### dns list

List DNS records in a zone.

Usage: `nimbus cloudflare dns list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--zone-id` | text | yes | - | Cloudflare zone ID |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### dns update

Update a DNS record.

Usage: `nimbus cloudflare dns update [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--zone-id` | text | yes | - | Cloudflare zone ID |
| `--record-id` | text | yes | - | DNS record ID |
| `--type` | text | yes | - | Record type (A/AAAA/CNAME/TXT) |
| `--name` | text | yes | - | DNS record name |
| `--content` | text | yes | - | DNS record content |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--proxied`, `--dns-only` | boolean | no | `True` |  |
| `--ttl` | integer | no | `1` | TTL (1 = auto) |

### network add-route

Create a private network route for a CIDR block.

Usage: `nimbus cloudflare network add-route [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--cidr` | text | yes | - | CIDR block to route (format: \<ip>/\<prefix>) |
| `--tunnel-id` | text | yes | - | Tunnel UUID |
| `--comment` | text | no | `` | Route comment |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### network remove-route

Delete a private network route.

Usage: `nimbus cloudflare network remove-route [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--route-id` | text | yes | - | Route ID to remove |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### network routes

List private network CIDR routes.

Usage: `nimbus cloudflare network routes [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### network split-tunnel

Show WARP split tunnel include/exclude lists.

Usage: `nimbus cloudflare network split-tunnel [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### network vnets

List virtual networks.

Usage: `nimbus cloudflare network vnets [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### site bootstrap

Install cloudflared on site connectors and create private route.

Usage: `nimbus cloudflare site bootstrap [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Site name to bootstrap |
| `--ssh-user` | text | no | `root` | SSH user |
| `--ssh-key` | text | no | - | SSH key path |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### site list

List registered tunnel sites.

Usage: `nimbus cloudflare site list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### site register

Register a tunnel site; --cidr links the matching registry allocation.

Usage: `nimbus cloudflare site register [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Site name (e.g. nimbus-oci-yyz) |
| `--cidr` | text | yes | - | Site CIDR block |
| `--tunnel-name` | text | yes | - | Tunnel name |
| `--primary-host` | text | yes | - | Primary connector host |
| `--primary-type` | text | no | `vm` | Host type (lxc/vm/bare_metal) |
| `--cost-tier` | text | no | `free` | Cost tier (free/low/standard) |
| `--secondary-host` | text | no | - | Secondary connector host |
| `--secondary-type` | text | no | - | Secondary host type |
| `--secondary-cost` | text | no | - | Secondary cost tier |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### site remove

Deregister a tunnel site (does not delete the CF tunnel).

Usage: `nimbus cloudflare site remove [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Site name to deregister |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--force` | boolean | no | `False` | Skip confirmation |

### site status

Check connector health for a site.

Usage: `nimbus cloudflare site status [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Site name |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### tunnel add-route

Add a route to a tunnel.

Usage: `nimbus cloudflare tunnel add-route [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Tunnel ID |
| `--hostname` | text | yes | - | Public hostname |
| `--service` | text | yes | - | Origin service URL |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### tunnel create

Create a Cloudflare tunnel.

Usage: `nimbus cloudflare tunnel create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Tunnel name |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### tunnel delete

Delete a Cloudflare tunnel.

Usage: `nimbus cloudflare tunnel delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Tunnel ID |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--force` | boolean | no | `False` | Skip confirmation |

### tunnel dns

Create a DNS CNAME that points at a tunnel.

Usage: `nimbus cloudflare tunnel dns [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Tunnel ID |
| `--zone-id` | text | yes | - | Cloudflare zone ID |
| `--hostname` | text | yes | - | Public hostname |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### tunnel list

List Cloudflare tunnels.

Usage: `nimbus cloudflare tunnel list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### tunnel publish

Publish a hostname on the tunnel — always fronted by Zero Trust Access.

Usage: `nimbus cloudflare tunnel publish [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--hostname` | text | yes | - | Public hostname |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--service` | text | no | `` | Origin service URL (optional under --adopt) |
| `--tunnel-id` | text | no | `` | Tunnel ID (auto if one site) |
| `--zone-id` | text | no | `` | Zone ID (auto from hostname) |
| `--identity` | text | no | `` | Access allow-list emails (default: settings key) |
| `--bypass-path` | text | no | - | Path-scoped Access Bypass sub-app (repeatable) |
| `--adopt` | boolean | no | `False` | Take over manually-wired live ingress/DNS/Access |
| `--dry-run` | boolean | no | `False` | Preview the 5-object plan |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### tunnel remove-route

Remove a route from a tunnel.

Usage: `nimbus cloudflare tunnel remove-route [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Tunnel ID |
| `--hostname` | text | yes | - | Public hostname |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### tunnel routes

List routes for a tunnel.

Usage: `nimbus cloudflare tunnel routes [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Tunnel ID |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### tunnel unpublish

Tear down a published hostname: ingress, DNS, Access apps, registry row.

Usage: `nimbus cloudflare tunnel unpublish [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--hostname` | text | yes | - | Published hostname |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--tunnel-id` | text | no | `` | Tunnel ID |
| `--zone-id` | text | no | `` | Zone ID (auto from hostname) |
| `--dry-run` | boolean | no | `False` | Preview the teardown |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### warp dns

Publish exposed devices' hostname→IP A records into the internal zone.

Usage: `nimbus cloudflare warp dns [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | Cloudflare provider ID |
| `--zone-id` | text | yes | - | Internal DNS zone id |
| `--domain` | text | no | `` | Internal suffix scoping managed records |
| `--dry-run` | boolean | no | `False` | Preview the A-record diff |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### warp policy

Reconcile per-category Gateway allow rules for exposed segments (least-privilege).

Usage: `nimbus cloudflare warp policy [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | Cloudflare provider ID |
| `--dry-run` | boolean | no | `False` | Preview the per-category rule diff |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### warp reconcile

Converge Cloudflare teamnet routes + split-tunnel to the registry (preview then confirm).

Usage: `nimbus cloudflare warp reconcile [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | Cloudflare provider ID |
| `--tunnel-id` | text | no | `` | Connector tunnel id |
| `--dry-run` | boolean | no | `False` | Preview the route/split-tunnel diff |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### warp status

Show drift between the desired WARP exposure and live Cloudflare.

Usage: `nimbus cloudflare warp status [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | yes | - | Cloudflare provider ID |

### zerotrust apply

Reconcile DB policies to Cloudflare API.

Usage: `nimbus cloudflare zerotrust apply [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--prune` | boolean | no | `False` | Delete orphaned CF policies |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### zerotrust apps

List Zero Trust Access applications.

Usage: `nimbus cloudflare zerotrust apps [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### zerotrust create-app

Create a Zero Trust Access application.

Usage: `nimbus cloudflare zerotrust create-app [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Application name |
| `--domain` | text | yes | - | Protected domain |
| `--type` | text | no | `self_hosted` | App type |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### zerotrust delete-app

Delete a Zero Trust Access application.

Usage: `nimbus cloudflare zerotrust delete-app [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--app-id` | text | yes | - | Application ID |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--force` | boolean | no | `False` | Skip confirmation |

### zerotrust diff

Show drift between DB policies and live Cloudflare state.

Usage: `nimbus cloudflare zerotrust diff [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### zerotrust export

Export DB policies to YAML.

Usage: `nimbus cloudflare zerotrust export [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--output`, `-o` | text | no | `-` | Output YAML path |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |

### zerotrust gateway-rules

List Gateway network policy rules.

Usage: `nimbus cloudflare zerotrust gateway-rules [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### zerotrust policies

List Access policies for an application.

Usage: `nimbus cloudflare zerotrust policies [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--app-id` | text | yes | - | Application ID |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### zone list

List DNS zones.

Usage: `nimbus cloudflare zone list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Cloudflare provider ID |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |
