---
title: "nimbus plugins"
sidebar:
  order: 22
---

Manage CLI plugins.

## Commands

### install

Install a plugin by name (creates placeholder).

Usage: `nimbus plugins install [OPTIONS] NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `name` | text | yes | - | Plugin name to install |

### list

List installed plugins.

Usage: `nimbus plugins list [OPTIONS]`

_No options._

### register

Register a plugin in the in-memory registry.

Usage: `nimbus plugins register [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Plugin name |
| `--version` | text | yes | - | Plugin version |
| `--description` | text | no | `` | Plugin description |

### registry

Show all registered plugins.

Usage: `nimbus plugins registry [OPTIONS]`

_No options._
