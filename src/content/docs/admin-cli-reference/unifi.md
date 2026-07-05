---
title: "nimbus-admin unifi"
sidebar:
  order: 20
---

Manage UniFi network infrastructure.

## Commands

### network clients set-fixed-ip

Pin a client's DHCP fixed IP (and optionally its VLAN).

Usage: `nimbus-admin unifi network clients set-fixed-ip [OPTIONS] MAC`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `mac` | text | yes | - | Client MAC address (as known to the controller) |
| `--ip` | text | yes | - | Fixed IP inside the VLAN's allocation CIDR |
| `--network` | integer | no | - | Target VLAN ID (moves the client to that network) |
| `--label` | text | no | `` | Reservation label |
| `--controller`, `-c` | text | no | - |  |

### network clients sync

Sync connected clients into the network topology graph.

Usage: `nimbus-admin unifi network clients sync [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |

### network context clear

Clear the active controller context.

Usage: `nimbus-admin unifi network context clear [OPTIONS]`

_No options._

### network context set

Set the active UniFi controller context.

Usage: `nimbus-admin unifi network context set [OPTIONS] ALIAS`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `alias` | text | yes | - | Controller alias to activate |

### network context show

Show the current active controller context.

Usage: `nimbus-admin unifi network context show [OPTIONS]`

_No options._

### network firewall audit

Audit firewall drift between the controller and the Nimbus registry.

Usage: `nimbus-admin unifi network firewall audit [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |
| `--severity` | text | no | - | Filter: critical/warning/info |
| `--show-reconcile` | boolean | no | `False` | Propose registry reconcile statements |

### network security audit

Run a security audit of the UniFi network.

Usage: `nimbus-admin unifi network security audit [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--controller`, `-c` | text | no | - |  |
| `--format`, `-f` | text | no | `table` |  |
| `--severity` | text | no | - | Filter: critical/warning/info |
