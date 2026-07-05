---
title: "nimbus-admin discord"
sidebar:
  order: 7
---

Nimbus Discord bot management.

## Commands

### run

Start the Discord bot (blocking).

Usage: `nimbus-admin discord run [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--credential` | text | no | - | Bot auth (or set DISCORD_BOT_TOKEN env) |

### sync

Sync slash commands to Discord (one-time setup).

Usage: `nimbus-admin discord sync [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--credential` | text | no | - | Bot auth (or set DISCORD_BOT_TOKEN env) |
