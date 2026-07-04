---
title: "nimbus environments"
sidebar:
  order: 13
---

Legacy environment config commands. Prefer 'nimbus deploy'.

## Commands

### current

Show the currently active environment.

Usage: `nimbus environments current [OPTIONS]`

_No options._

### list

List all environments.

Usage: `nimbus environments list [OPTIONS]`

_No options._

### switch

Switch to a named environment.

Usage: `nimbus environments switch [OPTIONS] NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `name` | text | yes | - | Environment name to switch to |
