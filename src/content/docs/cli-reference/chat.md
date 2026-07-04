---
title: "nimbus chat"
sidebar:
  order: 5
---

Discover chatbot platforms and run quickstart smoke tests. For production ops use the per-platform CLIs (nimbus discord/telegram/whatsapp).

## Commands

### list-platforms

Show discovered chatbot platforms.

Usage: `nimbus chat list-platforms [OPTIONS]`

_No options._

### run

Run a chatbot platform adapter with default settings (quickstart).

Usage: `nimbus chat run [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--platform` | text | yes | - | Platform to start |
| `--credential` | text | no | - | Bot token / credential |
| `--dry-run` | boolean | no | `False` | Resolve adapter and credential but skip connecting (smoke test). |
