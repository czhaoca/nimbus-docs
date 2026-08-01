---
title: "nimbus-admin backup"
sidebar:
  order: 1
---

Database backup management.

## Commands

### create

Create a database backup with automatic rotation.

Usage: `nimbus-admin backup create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--retention-days` | integer range | no | - | Age-based rotation: delete backups older than N days (14-30 recommended, #319). Omit for legacy count-based rotation. |

### list

List existing database backups.

Usage: `nimbus-admin backup list [OPTIONS]`

_No options._
