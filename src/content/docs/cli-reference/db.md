---
title: "nimbus db"
sidebar:
  order: 10
---

Database migration and diagnostics.

## Commands

### init

Initialize a fresh database: create the schema via migrations (upgrade head).

Usage: `nimbus db init [OPTIONS]`

_No options._

### migration-status

Show the current database backend and Alembic migration state.

Usage: `nimbus db migration-status [OPTIONS]`

_No options._

### seed

Seed the database. Only the --demo dataset exists today (consumer-CI e2e).

Usage: `nimbus db seed [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--demo` | boolean | no | `False` | Seed the deterministic synthetic demo dataset (#246). |

### upgrade

Upgrade the configured database to the latest Alembic revision (head).

Usage: `nimbus db upgrade [OPTIONS]`

_No options._
