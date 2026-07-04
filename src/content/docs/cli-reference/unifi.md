---
title: "nimbus unifi"
sidebar:
  order: 32
---

Manage UniFi network infrastructure.

## Commands

### network clients clear-fixed-ips

Clear ALL fixed (reserved) IP assignments on the controller.

Usage: `nimbus unifi network clients clear-fixed-ips [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--dry-run` | boolean | no | `False` | Show what would be cleared; change nothing |
| `--yes`, `-y` | boolean | no | `False` | Skip the confirmation prompt |

### network clients list

List connected network clients (WiFi and wired).

Usage: `nimbus unifi network clients list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--site` | text | no | - | Site name to target (default: active site) |
| `--vlan` | integer | no | - | Filter by VLAN ID |
| `--wired`, `--wireless` | boolean | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### network clients list-fixed-ips

List clients with a fixed (reserved) IP, including offline reservations.

Usage: `nimbus unifi network clients list-fixed-ips [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### network clients set-fixed-ip

Pin a client's DHCP fixed IP (and optionally its VLAN).

Usage: `nimbus unifi network clients set-fixed-ip [OPTIONS] MAC`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `mac` | text | yes | - | Client MAC address (as known to the controller) |
| `--ip` | text | yes | - | Fixed IP inside the VLAN's allocation CIDR |
| `--network` | integer | no | - | Target VLAN ID (moves the client to that network) |
| `--label` | text | no | `` | Reservation label |
| `--controller`, `-c` | text | no | - |  |

### network clients sync

Sync connected clients into the network topology graph.

Usage: `nimbus unifi network clients sync [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |

### network context clear

Clear the active controller context.

Usage: `nimbus unifi network context clear [OPTIONS]`

_No options._

### network context set

Set the active UniFi controller context.

Usage: `nimbus unifi network context set [OPTIONS] ALIAS`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `alias` | text | yes | - | Controller alias to activate |

### network context show

Show the current active controller context.

Usage: `nimbus unifi network context show [OPTIONS]`

_No options._

### network devices describe

Get details for a specific device by MAC address.

Usage: `nimbus unifi network devices describe [OPTIONS] MAC`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `mac` | text | yes | - | Device MAC address or ID |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### network devices list

List adopted UniFi devices (switches, APs, gateways).

Usage: `nimbus unifi network devices list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--type` | text | no | - | Filter: usw/uap/ugw |
| `--format`, `-f` | text | no | `table` |  |

### network firewall audit

Audit firewall drift between the controller and the Nimbus registry.

Usage: `nimbus unifi network firewall audit [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |
| `--severity` | text | no | - | Filter: critical/warning/info |
| `--show-reconcile` | boolean | no | `False` | Propose registry reconcile statements |

### network firewall rules create

Create a firewall rule.

Usage: `nimbus unifi network firewall rules create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name`, `-n` | text | yes | - |  |
| `--action` | text | no | `drop` | accept/drop/reject |
| `--ruleset` | text | no | `LAN_IN` | LAN_IN/LAN_OUT/GUEST_IN |
| `--src` | text | no | `` | Source network config ID |
| `--dst` | text | no | `` | Destination network config ID |
| `--protocol` | text | no | `all` |  |
| `--controller`, `-c` | text | no | - |  |

### network firewall rules delete

Delete a firewall rule.

Usage: `nimbus unifi network firewall rules delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | Firewall rule ID |
| `--controller`, `-c` | text | no | - |  |
| `--force` | boolean | no | `False` |  |

### network firewall rules list

List all firewall rules.

Usage: `nimbus unifi network firewall rules list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### network port-profiles assign

Apply a port profile to a specific switch port.

Usage: `nimbus unifi network port-profiles assign [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--device` | text | yes | - | Switch MAC address |
| `--port` | integer | yes | - | Port index |
| `--profile` | text | yes | - | Port profile ID |
| `--controller`, `-c` | text | no | - |  |

### network port-profiles create

Create a port profile.

Usage: `nimbus unifi network port-profiles create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name`, `-n` | text | yes | - |  |
| `--native-vlan` | text | no | - | Network config ID |
| `--controller`, `-c` | text | no | - |  |

### network port-profiles list

List all port profiles.

Usage: `nimbus unifi network port-profiles list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### network security audit

Run a security audit of the UniFi network.

Usage: `nimbus unifi network security audit [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |
| `--severity` | text | no | - | Filter: critical/warning/info |

### network vlans create

Create a VLAN network. Provide either --name or --label.

Usage: `nimbus unifi network vlans create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | integer | yes | - | VLAN ID (e.g. 10, 20, 30) |
| `--name`, `-n` | text | no | - | VLAN name (required if no --label) |
| `--label` | text | no | - | ICAO label. Expands via generate_name() into 'unifi-{geo}-vlan-{label}'. |
| `--subnet` | text | no | `` | CIDR (format: \<gateway-ip>/\<prefix>) |
| `--dhcp`, `--no-dhcp` | boolean | no | `False` |  |
| `--controller`, `-c` | text | no | - |  |
| `--dry-run` | boolean | no | `False` |  |

### network vlans delete

Delete a VLAN network.

Usage: `nimbus unifi network vlans delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | VLAN config ID |
| `--controller`, `-c` | text | no | - |  |
| `--force` | boolean | no | `False` |  |

### network vlans describe

Show full detail for a single VLAN (gateway, DHCP range, isolation, zone).

Usage: `nimbus unifi network vlans describe [OPTIONS] NETWORK_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `network_id` | text | yes | - | VLAN network/config ID |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### network vlans list

List all VLANs.

Usage: `nimbus unifi network vlans list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |

### network wlans create

Create a WiFi SSID, optionally bound to a VLAN (--network \<vlan id>).

Usage: `nimbus unifi network wlans create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--ssid` | text | yes | - | WiFi SSID (network name) |
| `--passphrase` | text | yes | - | WPA passphrase — inject from Infisical, not a literal |
| `--network` | integer | no | - | VLAN ID to bind the SSID to |
| `--band` | text | no | `both` | WiFi band: both\|2g\|5g |
| `--enabled`, `--disabled` | boolean | no | `True` |  |
| `--controller`, `-c` | text | no | - |  |
| `--dry-run` | boolean | no | `False` |  |

### network wlans delete

Delete a WiFi SSID (WLAN).

Usage: `nimbus unifi network wlans delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--id` | text | yes | - | WLAN config ID |
| `--controller`, `-c` | text | no | - |  |
| `--force` | boolean | no | `False` |  |

### network wlans list

List configured WiFi SSIDs.

Usage: `nimbus unifi network wlans list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |
