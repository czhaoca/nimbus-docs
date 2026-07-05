---
title: "nimbus-admin plugins"
sidebar:
  order: 13
---

Manage CLI plugins.

## Commands

### install

Install a plugin by name (creates placeholder).

Usage: `nimbus-admin plugins install [OPTIONS] NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `name` | text | yes | - | Plugin name to install |

### list

List installed plugins.

Usage: `nimbus-admin plugins list [OPTIONS]`

_No options._

### register

Register a plugin in the in-memory registry.

Usage: `nimbus-admin plugins register [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Plugin name |
| `--version` | text | yes | - | Plugin version |
| `--description` | text | no | `` | Plugin description |

### registry

Show all registered plugins.

Usage: `nimbus-admin plugins registry [OPTIONS]`

_No options._
