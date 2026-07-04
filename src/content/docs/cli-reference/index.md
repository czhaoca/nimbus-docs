---
title: "CLI Reference"
sidebar:
  order: 0
---

Auto-generated from the `nimbus` Typer command tree. Do not edit by
hand — run `scripts/gen-contracts.sh` and commit the result.

## Command Inventory

| Command | Kind | Subcommands | Summary |
| --- | --- | --- | --- |
| [`nimbus aws`](./aws/) | group | 62 | Manage AWS resources (aws-mirrored grammar). |
| [`nimbus az`](./az/) | group | 64 | Manage Azure resources (az-mirrored grammar). |
| `nimbus azure` | group | - | ⚠️ Deprecated — use `nimbus az` instead. |
| [`nimbus backup`](./backup/) | group | 2 | Database backup management. |
| [`nimbus budget`](./budget/) | group | 2 | Manage budget rules and spending. |
| [`nimbus chat`](./chat/) | group | 2 | Discover chatbot platforms and run quickstart smoke tests. For production ops use the per-platform CLIs (nimbus discord/telegram/whatsapp). |
| [`nimbus ci`](./ci/) | group | 4 | Woodpecker CI status and administration. |
| [`nimbus cloudflare`](./cloudflare/) | group | 41 | Manage Cloudflare DNS, tunnels, Zero Trust, and network resources. |
| [`nimbus completion`](./completion/) | group | 3 | Generate shell completion scripts. |
| [`nimbus config`](./config/) | group | 5 | Configuration import/export. |
| [`nimbus db`](./db/) | group | 4 | Database migration and diagnostics. |
| [`nimbus deploy`](./deploy/) | group | 19 | Environment registry, target inventory, and access manifests. |
| `nimbus digest` | command | - | Generate and display a spending digest summary. |
| [`nimbus discord`](./discord/) | group | 2 | Nimbus Discord bot management. |
| [`nimbus environments`](./environments/) | group | 3 | Legacy environment config commands. Prefer 'nimbus deploy'. |
| [`nimbus fleet`](./fleet/) | group | 3 | Cross-provider VM fleet operations. |
| [`nimbus gcloud`](./gcloud/) | group | 61 | Manage GCP resources (gcloud-mirrored grammar). |
| `nimbus gcp` | group | - | ⚠️ Deprecated — use `nimbus gcloud` instead. |
| [`nimbus gh-runner`](./gh-runner/) | group | 4 | Compatibility-only GitHub Actions runner lifecycle on Proxmox LXC. |
| [`nimbus init`](./init/) | group | 2 | Declarative VM init profiles (cloud-init). |
| [`nimbus monitor`](./monitor/) | group | 7 | Health monitoring and heartbeat tracking. |
| [`nimbus network`](./network/) | group | 40 | Network CIDR planning and subnet management. |
| [`nimbus oci`](./oci/) | group | 130 | Manage Oracle Cloud Infrastructure resources. |
| [`nimbus orchestrate`](./orchestrate/) | group | 3 | Cross-cloud orchestration workflows. |
| [`nimbus plugins`](./plugins/) | group | 4 | Manage CLI plugins. |
| [`nimbus providers`](./providers/) | group | 4 | Manage cloud providers. |
| `nimbus provision` | command | - | Provision a new resource on a cloud provider. |
| `nimbus proxmox` | group | - | ⚠️ Deprecated — use `nimbus pve` instead. |
| [`nimbus pve`](./pve/) | group | 48 | Manage Proxmox VE resources (containers, VMs, nodes). |
| [`nimbus resources`](./resources/) | group | 6 | Manage cloud resources. |
| [`nimbus secrets`](./secrets/) | group | 8 | Write secrets into the Infisical vault. |
| [`nimbus security`](./security/) | group | 5 | Cross-cutting security surfaces. |
| `nimbus serve` | command | - | Start the Nimbus API server. |
| `nimbus shell` | command | - | Launch the interactive Nimbus shell with menu navigation. |
| [`nimbus slack`](./slack/) | group | 1 | Slack bot commands |
| `nimbus status` | command | - | Show Nimbus engine status and registered providers. |
| [`nimbus synology`](./synology/) | group | 1 | Nimbus Synology Chat bot management. |
| [`nimbus tasks`](./tasks/) | group | 3 | Scheduled / on-demand task management. |
| [`nimbus telegram`](./telegram/) | group | 1 | Nimbus Telegram bot management. |
| [`nimbus unifi`](./unifi/) | group | 25 | Manage UniFi network infrastructure. |
| [`nimbus whatsapp`](./whatsapp/) | group | 1 | Nimbus WhatsApp bot management. |
