---
title: "nimbus-admin secrets"
sidebar:
  order: 13
---

Write secrets into the Infisical vault.

## Commands

### lxc bootstrap-db

Bootstrap PostgreSQL roles on the database LXC and store logins (non-destructive by default).

Usage: `nimbus-admin secrets lxc bootstrap-db [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--db-host` | text | no | - | DB network host (default: vault IPV4) |
| `--rotate` | text | no | - | Role(s) to rotate |
| `--apply`, `--dry-run` | boolean | no | `False` | Create roles + store (default dry-run) |

### lxc canonicalize

Delete stale folders once sync has populated their canonical replacements.

Usage: `nimbus-admin secrets lxc canonicalize [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--apply`, `--dry-run` | boolean | no | `False` | Proceed with deletes (default dry-run) |
| `--confirm-deletes` | boolean | no | `False` | Confirm deletion of stale folders |

### lxc pull

Read-only: show a host's keys (secret values redacted) or materialize its SSH key.

Usage: `nimbus-admin secrets lxc pull [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--host` | text | yes | - | Canonical LXC host |
| `--key-only` | boolean | no | `False` | Materialize the SSH key to --out |
| `--out` | text | no | - | Destination key file (0600) |

### lxc push-ssh

Write a host's SSH credential (private key + user/port + public key) to its folder.

Usage: `nimbus-admin secrets lxc push-ssh [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--host` | text | yes | - | Canonical LXC host |
| `--key-file` | text | yes | - | Path to the SSH private key |
| `--user` | text | no | `root` |  |
| `--port` | integer | no | `22` |  |
| `--apply`, `--dry-run` | boolean | no | `False` | Write (default dry-run) |

### lxc relocate

Move a host's service secrets to their canonical path + pointer (copy->verify->delete).

Usage: `nimbus-admin secrets lxc relocate [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--host` | text | yes | - | Host whose service secrets to relocate |
| `--apply`, `--dry-run` | boolean | no | `False` | Move (default dry-run) |

### lxc review

Read-only: report folder presence, missing managed keys, SSH, stale folders.

Usage: `nimbus-admin secrets lxc review [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--json` | boolean | no | `False` | Emit JSON. |

### lxc sync

Sync descriptor + pointer keys from live Proxmox into each LXC folder.

Usage: `nimbus-admin secrets lxc sync [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Proxmox provider ID |
| `--host` | text | no | - | Limit to one canonical host |
| `--prune` | boolean | no | `False` | Delete stale service-value keys |
| `--apply`, `--dry-run` | boolean | no | `False` | Write (default dry-run) |

### set

Write one or more secrets to an Infisical path (idempotent upsert).

Usage: `nimbus-admin secrets set [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--path` | text | yes | - | Infisical secret path, e.g. /common/ci/woodpecker/1 |
| `--key` | text | no | - | Secret name (used with --value). |
| `--value` | text | no | - | Secret value (used with --key). |
| `--from-file` | file | no | - | KEY=VALUE file to import (alternative to --key/--value). |
