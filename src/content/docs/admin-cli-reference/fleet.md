---
title: "nimbus-admin fleet"
sidebar:
  order: 7
---

Cross-provider VM fleet operations.

## Commands

### list

List VMs across providers (persisted inventory; --live refreshes from APIs).

Usage: `nimbus-admin fleet list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Filter by provider id (repeatable) |
| `--status` | text | no | `active` | active \| all |
| `--tag` | text | no | `` | Filter by tag KEY=VALUE or KEY |
| `--env` | text | no | `` | Filter by tags.env |
| `--live` | boolean | no | `False` | Refresh from provider APIs (needs credentials) |
