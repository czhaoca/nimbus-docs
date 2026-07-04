---
title: "nimbus synology"
sidebar:
  order: 29
---

Nimbus Synology Chat bot management.

## Commands

### run

Start a lightweight server for the Synology Chat outgoing webhook.

Usage: `nimbus synology run [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--host` | text | no | `0.0.0.0` | Bind address |
| `--port` | integer | no | `8002` | Bind port |
