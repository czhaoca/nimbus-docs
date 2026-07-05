---
title: "nimbus-admin network"
sidebar:
  order: 9
---

Operator network residue: discovery sync and provider onboarding.

## Commands

### discover

Sync UniFi/Proxmox/OCI network reality into the registry now.

Usage: `nimbus-admin network discover [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Restrict discovery to one provider type (unifi\|proxmox\|oci) |
| `--actor` | text | no | `cli` | Caller identifier |

### onboard

Log in to a provider: validate credentials, persist the secret, register it.

Usage: `nimbus-admin network onboard [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--type`, `-t` | text | yes | - | Provider type (e.g. unifi, proxmox) |
| `--id` | text | yes | - | Unique provider ID |
| `--name` | text | no | `` | Display name |
| `--region` | text | no | `` | Region or site label |
| `--instance-index` | integer range | no | `1` | Numbered credential index (>=1) for the Infisical keys. |
| `--cred` | text | no | - | Credential KEY=VALUE (repeatable); prompts for missing required. |
| `--persist`, `--no-persist` | boolean | no | `True` | Write the validated credential to Infisical. |
