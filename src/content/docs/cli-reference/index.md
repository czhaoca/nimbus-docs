---
title: "CLI Reference"
sidebar:
  order: 0
---

Auto-generated from the `nimbus` consumer CLI (nimbus-cli repo). Do
not edit by hand — run `scripts/export_cli_reference.py` and commit
the result. Operator commands live in the separate
[nimbus-admin reference](../admin-cli-reference/).

## Command Inventory

| Command | Kind | Subcommands | Summary |
| --- | --- | --- | --- |
| [`nimbus aws`](./aws/) | group | 62 | Manage AWS resources (aws-mirrored grammar). |
| [`nimbus az`](./az/) | group | 64 | Manage Azure resources (az-mirrored grammar). |
| `nimbus azure` | group | - | ⚠️ Deprecated — use `nimbus az` instead. |
| [`nimbus budget`](./budget/) | group | 2 | Manage budget rules and spending. |
| [`nimbus ci`](./ci/) | group | 4 | Woodpecker CI status and administration. |
| [`nimbus cloudflare`](./cloudflare/) | group | 41 | Manage Cloudflare DNS, tunnels, Zero Trust, and network resources. |
| [`nimbus deploy`](./deploy/) | group | 18 | Environment registry, target inventory, and access manifests. |
| `nimbus digest` | command | - | Generate and display a spending digest summary. |
| [`nimbus fleet`](./fleet/) | group | 2 | Cross-provider VM fleet operations. |
| [`nimbus gcloud`](./gcloud/) | group | 52 | Manage GCP resources (gcloud-mirrored grammar). |
| `nimbus gcp` | group | - | ⚠️ Deprecated — use `nimbus gcloud` instead. |
| [`nimbus gh-runner`](./gh-runner/) | group | 4 | Compatibility-only GitHub Actions runner lifecycle on Proxmox LXC. |
| [`nimbus init`](./init/) | group | 2 | Declarative VM init profiles (cloud-init). |
| [`nimbus monitor`](./monitor/) | group | 7 | Health monitoring and heartbeat tracking. |
| [`nimbus network`](./network/) | group | 38 | Network CIDR planning and subnet management. |
| [`nimbus oci`](./oci/) | group | 103 | Manage Oracle Cloud Infrastructure resources. |
| [`nimbus orchestrate`](./orchestrate/) | group | 3 | Cross-cloud orchestration workflows. |
| [`nimbus providers`](./providers/) | group | 4 | Manage cloud providers. |
| `nimbus provision` | command | - | Provision a new resource on a cloud provider. |
| `nimbus proxmox` | group | - | ⚠️ Deprecated — use `nimbus pve` instead. |
| [`nimbus pve`](./pve/) | group | 40 | Manage Proxmox VE resources (containers, VMs, nodes). |
| [`nimbus resources`](./resources/) | group | 6 | Manage cloud resources. |
| [`nimbus security`](./security/) | group | 5 | Cross-cutting security surfaces. |
| [`nimbus tasks`](./tasks/) | group | 3 | Scheduled / on-demand task management. |
| [`nimbus unifi`](./unifi/) | group | 18 | Manage UniFi network infrastructure. |
