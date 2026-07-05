---
title: "nimbus monitor"
sidebar:
  order: 11
---

Health monitoring and heartbeat tracking.

## Commands

### check

Run health checks on all services with health endpoints.

Usage: `nimbus monitor check [OPTIONS]`

_No options._

### dashboard

Show current health status of all monitored services.

Usage: `nimbus monitor dashboard [OPTIONS]`

_No options._

### history

Show recent heartbeat history.

Usage: `nimbus monitor history [OPTIONS]`

_No options._

### infra

Show latest CPU/memory/disk metrics for all Proxmox LXCs/VMs.

Usage: `nimbus monitor infra [OPTIONS]`

_No options._

### infra-collect

Trigger an immediate infra metrics collection.

Usage: `nimbus monitor infra-collect [OPTIONS]`

_No options._

### node

Show Proxmox node resource summary.

Usage: `nimbus monitor node [OPTIONS]`

_No options._

### runners

Show GitHub Actions self-hosted runner health status.

Usage: `nimbus monitor runners [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--host` | text | no | `` | Runner LXC IP (or set NIMBUS_RUNNER_HOST) |
| `--ssh-user` | text | no | `` | SSH user (or set NIMBUS_RUNNER_SSH_USER) |
| `--ssh-key` | text | no | `` | SSH key path (or set NIMBUS_RUNNER_SSH_KEY) |
