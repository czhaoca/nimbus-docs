---
title: "nimbus-admin environments"
sidebar:
  order: 8
---

Legacy environment config commands. Prefer 'nimbus deploy'.

## Commands

### current

Show the currently active environment.

Usage: `nimbus-admin environments current [OPTIONS]`

_No options._

### list

List all environments.

Usage: `nimbus-admin environments list [OPTIONS]`

_No options._

### switch

Switch to a named environment.

Usage: `nimbus-admin environments switch [OPTIONS] NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `name` | text | yes | - | Environment name to switch to |
