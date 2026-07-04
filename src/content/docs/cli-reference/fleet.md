---
title: "nimbus fleet"
sidebar:
  order: 14
---

Cross-provider VM fleet operations.

## Commands

### exec

Run a command across selected VMs (preview, then confirm).

Usage: `nimbus fleet exec [OPTIONS] COMMAND`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `command` | text | yes | - | Command to run on each selected host |
| `--provider`, `-p` | text | no | - | Provider id (repeatable) |
| `--status` | text | no | `active` | active \| all |
| `--tag` | text | no | `` | Tag KEY=VALUE or KEY |
| `--env` | text | no | `` | tags.env filter |
| `--ssh-user` | text | no | `nimbus` | SSH user |
| `--ssh-key` | text | no | `` | SSH private key path |
| `--live` | boolean | no | `True` | Refresh roster from provider APIs |
| `--dry-run` | boolean | no | `False` | Preview targets + command only |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### install

Install/update software across selected VMs (preview, then confirm).

Usage: `nimbus fleet install [OPTIONS] RECIPE`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `recipe` | text | yes | - | Recipe: cloudflared \| apt-upgrade |
| `--provider`, `-p` | text | no | - | Provider id (repeatable) |
| `--status` | text | no | `active` | active \| all |
| `--tag` | text | no | `` | Tag KEY=VALUE or KEY |
| `--env` | text | no | `` | tags.env filter |
| `--ssh-user` | text | no | `nimbus` | SSH user |
| `--ssh-key` | text | no | `` | SSH private key path |
| `--live` | boolean | no | `True` | Refresh roster from provider APIs |
| `--dry-run` | boolean | no | `False` | Preview targets + recipe only |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation |

### list

List VMs across providers (persisted inventory; --live refreshes from APIs).

Usage: `nimbus fleet list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Filter by provider id (repeatable) |
| `--status` | text | no | `active` | active \| all |
| `--tag` | text | no | `` | Filter by tag KEY=VALUE or KEY |
| `--env` | text | no | `` | Filter by tags.env |
| `--live` | boolean | no | `False` | Refresh from provider APIs (needs credentials) |
