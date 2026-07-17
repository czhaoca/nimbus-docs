---
title: "CLI Reference"
sidebar:
  order: 0
---

Auto-generated from the `nimbus-admin` (backend operator) Typer
command tree. Do not edit by
hand — run `scripts/gen-contracts.sh` and commit the result.

## Command Inventory

| Command | Kind | Subcommands | Summary |
| --- | --- | --- | --- |
| [`nimbus-admin backup`](./backup/) | group | 2 | Database backup management. |
| [`nimbus-admin completion`](./completion/) | group | 3 | Generate shell completion scripts. |
| [`nimbus-admin config`](./config/) | group | 5 | Configuration import/export. |
| [`nimbus-admin db`](./db/) | group | 4 | Database migration and diagnostics. |
| [`nimbus-admin deploy`](./deploy/) | group | 2 | Operator deploy residue: AGENTS.md registry validation, image GC keep-list. |
| [`nimbus-admin environments`](./environments/) | group | 3 | Legacy environment config commands. Prefer 'nimbus deploy'. |
| [`nimbus-admin fleet`](./fleet/) | group | 1 | Cross-provider VM fleet operations. |
| [`nimbus-admin gcloud`](./gcloud/) | group | 4 | Manage GCP resources (residual in-engine commands). |
| `nimbus-admin gcp` | group | - | ⚠️ Deprecated — use `nimbus-admin gcloud` instead. |
| [`nimbus-admin network`](./network/) | group | 2 | Operator network residue: discovery sync and provider onboarding. |
| [`nimbus-admin oci`](./oci/) | group | 25 | Manage Oracle Cloud Infrastructure resources. |
| [`nimbus-admin plugins`](./plugins/) | group | 4 | Manage CLI plugins. |
| `nimbus-admin proxmox` | group | - | ⚠️ Deprecated — use `nimbus-admin pve` instead. |
| [`nimbus-admin pve`](./pve/) | group | 8 | Manage Proxmox VE resources (residual in-engine commands). |
| [`nimbus-admin secrets`](./secrets/) | group | 8 | Write secrets into the Infisical vault. |
| `nimbus-admin serve` | command | - | Start the Nimbus API server. |
| `nimbus-admin shell` | command | - | Launch the interactive Nimbus shell with menu navigation. |
| `nimbus-admin status` | command | - | Show Nimbus engine status and registered providers. |
| [`nimbus-admin tasks`](./tasks/) | group | 3 | Scheduled / on-demand task management. |
| [`nimbus-admin unifi`](./unifi/) | group | 7 | Manage UniFi network infrastructure. |
