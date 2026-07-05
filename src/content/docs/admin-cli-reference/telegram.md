---
title: "nimbus-admin telegram"
sidebar:
  order: 19
---

Nimbus Telegram bot management.

## Commands

### run

Start the Telegram bot.

Usage: `nimbus-admin telegram run [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--credential` | text | no | - | Bot token (or set TELEGRAM_BOT_TOKEN env) |
| `--mode` | text | no | `polling` | Run mode: polling or webhook |
