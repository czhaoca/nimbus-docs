---
title: "nimbus gh-runner"
sidebar:
  order: 9
---

Compatibility-only GitHub Actions runner lifecycle on Proxmox LXC.

## Commands

### provision

Install prerequisites and register a runner for each repo.

Usage: `nimbus gh-runner provision [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--owner` | text | yes | - | GitHub username (repo owner) |
| `--repos` | text | yes | - | Comma-separated repo names |
| `--host` | text | yes | - | Target LXC IP or hostname |
| `--labels` | text | no | `self-hosted,linux,x64,proxmox` | Runner labels |
| `--version` | text | no | `2.322.0` | Runner binary version |
| `--ssh-user` | text | no | `root` | SSH user on target |
| `--ssh-key` | text | no | - | SSH private key path |

### reprovision

Teardown then re-provision with fresh registration.

Usage: `nimbus gh-runner reprovision [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--owner` | text | yes | - | GitHub username (repo owner) |
| `--repos` | text | yes | - | Comma-separated repo names |
| `--host` | text | yes | - | Target LXC IP or hostname |
| `--labels` | text | no | `self-hosted,linux,x64,proxmox` | Runner labels |
| `--version` | text | no | `2.322.0` | Runner binary version |
| `--ssh-user` | text | no | `root` | SSH user on target |
| `--ssh-key` | text | no | - | SSH private key path |

### status

Show systemd and GitHub API status for each runner.

Usage: `nimbus gh-runner status [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--owner` | text | yes | - | GitHub username (repo owner) |
| `--repos` | text | yes | - | Comma-separated repo names |
| `--host` | text | yes | - | Target LXC IP or hostname |
| `--ssh-user` | text | no | `root` | SSH user on target |
| `--ssh-key` | text | no | - | SSH private key path |

### teardown

Stop services and unregister runners from GitHub.

Usage: `nimbus gh-runner teardown [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--owner` | text | yes | - | GitHub username (repo owner) |
| `--repos` | text | yes | - | Comma-separated repo names |
| `--host` | text | yes | - | Target LXC IP or hostname |
| `--ssh-user` | text | no | `root` | SSH user on target |
| `--ssh-key` | text | no | - | SSH private key path |
